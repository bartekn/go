package ingest

import (
	"context"
	"fmt"
	"io"
	"sync"
	"time"

	"github.com/stellar/go/gxdr"
	"github.com/stellar/go/historyarchive"
	"github.com/stellar/go/support/errors"
	"github.com/stellar/go/xdr"
)

// readResult is the result of reading a bucket value
type readResult struct {
	entryChange xdr.LedgerEntryChange
	e           error
}

// CheckpointChangeReader is a ChangeReader which returns Changes from a history archive
// snapshot. The Changes produced by a CheckpointChangeReader reflect the state of the Stellar
// network at a particular checkpoint ledger sequence.
type CheckpointChangeReader struct {
	ctx        context.Context
	has        *historyarchive.HistoryArchiveState
	archive    historyarchive.ArchiveInterface
	tempStore  tempSet
	sequence   uint32
	readChan   chan readResult
	streamOnce sync.Once
	closeOnce  sync.Once
	done       chan bool

	ledgerKeyPool sync.Pool

	// This should be set to true in tests only
	disableBucketListHashValidation bool
	sleep                           func(time.Duration)
}

// Ensure CheckpointChangeReader implements ChangeReader
var _ ChangeReader = &CheckpointChangeReader{}

// tempSet is an interface that must be implemented by stores that
// hold temporary set of objects for state reader. The implementation
// does not need to be thread-safe.
type tempSet interface {
	Open() error
	// Add adds key to the store.
	Add(key *ledgerKey) error
	// Exist returns value true if the value is found in the store.
	// If the value has not been set, it should return false.
	Exist(key *ledgerKey) (bool, error)
	Close() error
}

const (
	// maxStreamRetries defines how many times should we retry when there are errors in
	// the xdr stream returned by GetXdrStreamForHash().
	maxStreamRetries = 3
	msrBufferSize    = 2000000

	// preloadedEntries defines a number of bucket entries to preload from a
	// bucket in a single run. This is done to allow preloading keys from
	// temp set.
	// preloadedEntries = 20000

	sleepDuration = time.Second
)

// NewCheckpointChangeReader constructs a new CheckpointChangeReader instance.
//
// The ledger sequence must be a checkpoint ledger. By default (see
// `historyarchive.ConnectOptions.CheckpointFrequency` for configuring this),
// its next sequence number would have to be a multiple of 64, e.g.
// sequence=100031 is a checkpoint ledger, since: (100031+1) mod 64 == 0
func NewCheckpointChangeReader(
	ctx context.Context,
	archive historyarchive.ArchiveInterface,
	sequence uint32,
) (*CheckpointChangeReader, error) {
	manager := archive.GetCheckpointManager()

	// The nth ledger is a checkpoint ledger iff: n+1 mod f == 0, where f is the
	// checkpoint frequency (64 by default).
	if !manager.IsCheckpoint(sequence) {
		return nil, errors.Errorf(
			"%d is not a checkpoint ledger, try %d or %d "+
				"(in general, try n where n+1 mod %d == 0)",
			sequence, manager.PrevCheckpoint(sequence),
			manager.NextCheckpoint(sequence),
			manager.GetCheckpointFrequency())
	}

	has, err := archive.GetCheckpointHAS(sequence)
	if err != nil {
		return nil, errors.Wrapf(err, "unable to get checkpoint HAS at ledger sequence %d", sequence)
	}

	tempStore := &memoryTempSet{}
	err = tempStore.Open()
	if err != nil {
		return nil, errors.Wrap(err, "unable to get open temp store")
	}

	return &CheckpointChangeReader{
		ctx:        ctx,
		has:        &has,
		archive:    archive,
		tempStore:  tempStore,
		sequence:   sequence,
		readChan:   make(chan readResult, msrBufferSize),
		streamOnce: sync.Once{},
		closeOnce:  sync.Once{},
		done:       make(chan bool),
		sleep:      time.Sleep,
		ledgerKeyPool: sync.Pool{
			New: func() interface{} {
				return new(ledgerKey)
			},
		},
	}, nil
}

func (r *CheckpointChangeReader) bucketExists(hash historyarchive.Hash) (bool, error) {
	duration := sleepDuration
	var exists bool
	var err error
	for attempts := 0; ; attempts++ {
		exists, err = r.archive.BucketExists(hash)
		if err == nil {
			return exists, nil
		}
		if attempts >= maxStreamRetries {
			break
		}
		r.sleep(duration)
		duration *= 2
	}
	return exists, err
}

// streamBuckets is internal method that streams buckets from the given HAS.
//
// Buckets should be processed from oldest to newest, `snap` and then `curr` at
// each level. The correct value of ledger entry is the latest seen
// `INITENTRY`/`LIVEENTRY` except the case when there's a `DEADENTRY` later
// which removes the entry.
//
// We can implement trivial algorithm (processing from oldest to newest buckets)
// but it requires to keep map of all entries in memory and stream what's left
// when all buckets are processed.
//
// However, we can modify this algorithm to work from newest to oldest ledgers:
//
//   1. For each `INITENTRY`/`LIVEENTRY` we check if we've seen the key before
//      (stored in `tempStore`). If the key hasn't been seen, we write that bucket
//      entry to the stream and add it to the `tempStore` (we don't mark `INITENTRY`,
//      see the inline comment or CAP-20).
//   2. For each `DEADENTRY` we keep track of removed bucket entries in
//      `tempStore` map.
//
// In such algorithm we just need to store a set of keys that require much less space.
// The memory requirements will be lowered when CAP-0020 is live and older buckets are
// rewritten. Then, we will only need to keep track of `DEADENTRY`.
func (r *CheckpointChangeReader) streamBuckets() {
	defer func() {
		err := r.tempStore.Close()
		if err != nil {
			r.readChan <- r.error(errors.New("Error closing tempStore"))
		}

		r.closeOnce.Do(r.close)
		close(r.readChan)
	}()

	var buckets []historyarchive.Hash
	for i := 0; i < len(r.has.CurrentBuckets); i++ {
		b := r.has.CurrentBuckets[i]
		for _, hashString := range []string{b.Curr, b.Snap} {
			hash, err := historyarchive.DecodeHash(hashString)
			if err != nil {
				r.readChan <- r.error(errors.Wrap(err, "Error decoding bucket hash"))
				return
			}

			if hash.IsZero() {
				continue
			}

			buckets = append(buckets, hash)
		}
	}

	for i, hash := range buckets {
		exists, err := r.bucketExists(hash)
		if err != nil {
			r.readChan <- r.error(
				errors.Wrapf(err, "error checking if bucket exists: %s", hash),
			)
			return
		}

		if !exists {
			r.readChan <- r.error(
				errors.Errorf("bucket hash does not exist: %s", hash),
			)
			return
		}

		oldestBucket := i == len(buckets)-1
		if shouldContinue := r.streamBucketContents(hash, oldestBucket); !shouldContinue {
			break
		}
	}
}

type ledgerKey struct {
	Type gxdr.LedgerEntryType
	// Account, Trustline, Data
	AccountId gxdr.Uint256
	// Trustline
	AssetCode4  gxdr.AssetCode4
	AssetCode12 gxdr.AssetCode12
	Issuer      gxdr.Uint256
	// Offer
	SellerId gxdr.Uint256
	OfferId  gxdr.Int64
	// Data
	DataName gxdr.String64
	// ClaimableBalance
	BalanceId gxdr.Hash
}

func (l *ledgerKey) Reset() {
	l.Type = 0
	for i := 0; i < len(l.AccountId); i++ {
		l.AccountId[i] = 0
	}
	for i := 0; i < len(l.AssetCode4); i++ {
		l.AssetCode4[i] = 0
	}
	for i := 0; i < len(l.AssetCode12); i++ {
		l.AssetCode12[i] = 0
	}
	for i := 0; i < len(l.Issuer); i++ {
		l.Issuer[i] = 0
	}
	for i := 0; i < len(l.SellerId); i++ {
		l.SellerId[i] = 0
	}
	l.OfferId = 0
	l.DataName = ""
	for i := 0; i < len(l.BalanceId); i++ {
		l.BalanceId[i] = 0
	}
}

type oldLedgerKey struct {
	Type xdr.LedgerEntryType
	// Account, Trustline, Data
	AccountId xdr.Uint256
	// Trustline
	AssetCode4  xdr.AssetCode4
	AssetCode12 xdr.AssetCode12
	Issuer      xdr.Uint256
	// Offer
	SellerId xdr.Uint256
	OfferId  xdr.Int64
	// Data
	DataName xdr.String64
	// ClaimableBalance
	BalanceId xdr.Hash
}

func (l *oldLedgerKey) Reset() {
	l.Type = 0
	for i := 0; i < len(l.AccountId); i++ {
		l.AccountId[i] = 0
	}
	for i := 0; i < len(l.AssetCode4); i++ {
		l.AssetCode4[i] = 0
	}
	for i := 0; i < len(l.AssetCode12); i++ {
		l.AssetCode12[i] = 0
	}
	for i := 0; i < len(l.Issuer); i++ {
		l.Issuer[i] = 0
	}
	for i := 0; i < len(l.SellerId); i++ {
		l.SellerId[i] = 0
	}
	l.OfferId = 0
	l.DataName = ""
	for i := 0; i < len(l.BalanceId); i++ {
		l.BalanceId[i] = 0
	}
}

func xdrLedgerKeyToLedgerKey(key *xdr.LedgerKey, newKey *oldLedgerKey) {
	newKey.Reset()

	newKey.Type = key.Type
	switch key.Type {
	case xdr.LedgerEntryTypeAccount:
		newKey.AccountId = *key.Account.AccountId.Ed25519
	case xdr.LedgerEntryTypeTrustline:
		newKey.AccountId = *key.TrustLine.AccountId.Ed25519
		switch key.TrustLine.Asset.Type {
		case xdr.AssetTypeAssetTypeCreditAlphanum4:
			newKey.AssetCode4 = key.TrustLine.Asset.AlphaNum4.AssetCode
			newKey.Issuer = *key.TrustLine.Asset.AlphaNum4.Issuer.Ed25519
		case xdr.AssetTypeAssetTypeCreditAlphanum12:
			newKey.AssetCode12 = key.TrustLine.Asset.AlphaNum12.AssetCode
			newKey.Issuer = *key.TrustLine.Asset.AlphaNum12.Issuer.Ed25519
		}
	case xdr.LedgerEntryTypeOffer:
		newKey.SellerId = *key.Offer.SellerId.Ed25519
		newKey.OfferId = key.Offer.OfferId
	case xdr.LedgerEntryTypeData:
		newKey.AccountId = *key.Data.AccountId.Ed25519
		newKey.DataName = key.Data.DataName
	case xdr.LedgerEntryTypeClaimableBalance:
		newKey.BalanceId = *key.ClaimableBalance.BalanceId.V0
	default:
		panic(errors.Errorf("Invalid LedgerEntryType=%d", key.Type))
	}
}

func gxdrLedgerEntryToLedgerKey(entry *gxdr.LedgerEntry, newKey *ledgerKey) {
	newKey.Reset()

	newKey.Type = entry.Data.Type
	switch entry.Data.Type {
	case gxdr.ACCOUNT:
		newKey.AccountId = *entry.Data.Account().AccountID.Ed25519()
	case gxdr.TRUSTLINE:
		trustLine := entry.Data.TrustLine()
		newKey.AccountId = *trustLine.AccountID.Ed25519()
		switch trustLine.Asset.Type {
		case gxdr.ASSET_TYPE_CREDIT_ALPHANUM4:
			newKey.AssetCode4 = trustLine.Asset.AlphaNum4().AssetCode
			newKey.Issuer = *trustLine.Asset.AlphaNum4().Issuer.Ed25519()
		case gxdr.ASSET_TYPE_CREDIT_ALPHANUM12:
			newKey.AssetCode12 = trustLine.Asset.AlphaNum12().AssetCode
			newKey.Issuer = *trustLine.Asset.AlphaNum12().Issuer.Ed25519()
		}
	case gxdr.OFFER:
		newKey.SellerId = *entry.Data.Offer().SellerID.Ed25519()
		newKey.OfferId = entry.Data.Offer().OfferID
	case gxdr.DATA:
		newKey.AccountId = *entry.Data.Data().AccountID.Ed25519()
		newKey.DataName = entry.Data.Data().DataName
	case gxdr.CLAIMABLE_BALANCE:
		newKey.BalanceId = *entry.Data.ClaimableBalance().BalanceID.V0()
	default:
		panic(errors.Errorf("Invalid LedgerEntryType=%d", entry.Data.Type))
	}
}

func gxdrLedgerKeyToLedgerKey(key *gxdr.LedgerKey, newKey *ledgerKey) {
	newKey.Reset()

	newKey.Type = key.Type
	switch key.Type {
	case gxdr.ACCOUNT:
		newKey.AccountId = *key.Account().AccountID.Ed25519()
	case gxdr.TRUSTLINE:
		newKey.AccountId = *key.TrustLine().AccountID.Ed25519()
		switch key.TrustLine().Asset.Type {
		case gxdr.ASSET_TYPE_CREDIT_ALPHANUM4:
			newKey.AssetCode4 = key.TrustLine().Asset.AlphaNum4().AssetCode
			newKey.Issuer = *key.TrustLine().Asset.AlphaNum4().Issuer.Ed25519()
		case gxdr.ASSET_TYPE_CREDIT_ALPHANUM12:
			newKey.AssetCode12 = key.TrustLine().Asset.AlphaNum12().AssetCode
			newKey.Issuer = *key.TrustLine().Asset.AlphaNum12().Issuer.Ed25519()
		}
	case gxdr.OFFER:
		newKey.SellerId = *key.Offer().SellerID.Ed25519()
		newKey.OfferId = key.Offer().OfferID
	case gxdr.DATA:
		newKey.AccountId = *key.Data().AccountID.Ed25519()
		newKey.DataName = key.Data().DataName
	case gxdr.CLAIMABLE_BALANCE:
		newKey.BalanceId = *key.ClaimableBalance().BalanceID.V0()
	default:
		panic(errors.Errorf("Invalid LedgerEntryType=%d", key.Type))
	}
}

// readBucketEntry will attempt to read a bucket entry from `stream`.
// If any errors are encountered while reading from `stream`, readBucketEntry will
// retry the operation using a new *historyarchive.XdrStream.
// The total number of retries will not exceed `maxStreamRetries`.
func (r *CheckpointChangeReader) readBucketEntry(stream *historyarchive.XdrStream, hash historyarchive.Hash) (
	gxdr.BucketEntry,
	error,
) {
	var entry gxdr.BucketEntry
	var err error
	currentPosition := stream.BytesRead()

	for attempts := 0; ; attempts++ {
		if r.ctx.Err() != nil {
			err = r.ctx.Err()
			break
		}
		if err == nil {
			err = stream.ReadOneGxdr(&entry)
			if err == nil || err == io.EOF {
				break
			}
		}
		if attempts >= maxStreamRetries {
			break
		}

		stream.Close()

		var retryStream *historyarchive.XdrStream
		retryStream, err = r.newXDRStream(hash)
		if err != nil {
			err = errors.Wrap(err, "Error creating new xdr stream")
			continue
		}

		*stream = *retryStream

		_, err = stream.Discard(currentPosition)
		if err != nil {
			err = errors.Wrap(err, "Error discarding from xdr stream")
			continue
		}
	}

	return entry, err
}

func (r *CheckpointChangeReader) newXDRStream(hash historyarchive.Hash) (
	*historyarchive.XdrStream,
	error,
) {
	rdr, e := r.archive.GetXdrStreamForHash(hash)
	if e == nil && !r.disableBucketListHashValidation {
		// Calling SetExpectedHash will enable validation of the stream hash. If hashes
		// don't match, rdr.Close() will return an error.
		rdr.SetExpectedHash(hash)
	}

	return rdr, e
}

var (
	entriesAdded int
)

// streamBucketContents pushes value onto the read channel, returning false when the channel needs to be closed otherwise true
func (r *CheckpointChangeReader) streamBucketContents(hash historyarchive.Hash, oldestBucket bool) bool {
	rdr, e := r.newXDRStream(hash)
	if e != nil {
		r.readChan <- r.error(
			errors.Wrapf(e, "cannot get xdr stream for hash '%s'", hash.String()),
		)
		return false
	}

	defer func() {
		err := rdr.Close()
		if err != nil {
			r.readChan <- r.error(errors.Wrap(err, "Error closing xdr stream"))
			// Stop streaming from the rest of the files.
			r.Close()
		}
	}()

	// bucketProtocolVersion is a protocol version read from METAENTRY or 0 when no METAENTRY.
	// No METAENTRY means that bucket originates from before protocol version 11.
	bucketProtocolVersion := uint32(0)

	n := -1
	// var batch []gxdr.BucketEntry
	// lastBatch := false

LoopBucketEntry:
	for {
		// Preload entries for faster retrieve from temp store.
		// if len(batch) == 0 {
		// 	if lastBatch {
		// 		return true
		// 	}

		// 	for i := 0; i < preloadedEntries; i++ {
		// 		var entry gxdr.BucketEntry
		// 		entry, e = r.readBucketEntry(rdr, hash)
		// 		if e != nil {
		// 			if e == io.EOF {
		// 				if len(batch) == 0 {
		// 					// No entries loaded for this batch, nothing more to process
		// 					return true
		// 				}
		// 				lastBatch = true
		// 				break
		// 			}
		// 			r.readChan <- r.error(
		// 				errors.Wrapf(e, "Error on XDR record %d of hash '%s'", n, hash.String()),
		// 			)
		// 			return false
		// 		}

		// 		batch = append(batch, entry)
		// 	}
		// }

		// var entry gxdr.BucketEntry
		// entry, batch = batch[0], batch[1:]

		entry, e := r.readBucketEntry(rdr, hash)
		if e != nil {
			if e == io.EOF {
				// if len(batch) == 0 {
				// 	// No entries loaded for this batch, nothing more to process
				// 	return true
				// }
				// lastBatch = true
				// break
				return true
			}
			r.readChan <- r.error(
				errors.Wrapf(e, "Error on XDR record %d of hash '%s'", n, hash.String()),
			)
			return false
		}

		n++

		key := r.ledgerKeyPool.Get().(*ledgerKey)

		switch entry.Type {
		case gxdr.METAENTRY:
			if n != 0 {
				r.readChan <- r.error(
					errors.Errorf(
						"METAENTRY not the first entry (n=%d) in the bucket hash '%s'",
						n, hash.String(),
					),
				)
				return false
			}
			// We can't use MustMetaEntry() here. Check:
			// https://github.com/golang/go/issues/32560
			bucketProtocolVersion = uint32(entry.MetaEntry().LedgerVersion)
			continue LoopBucketEntry
		case gxdr.LIVEENTRY, gxdr.INITENTRY:
			liveEntry := entry.LiveEntry()
			gxdrLedgerEntryToLedgerKey(liveEntry, key)
		case gxdr.DEADENTRY:
			gxdrLedgerKeyToLedgerKey(entry.DeadEntry(), key)
		default:
			r.readChan <- r.error(
				errors.Errorf("Unknown BucketEntryType=%d: %d@%s", entry.Type, n, hash.String()),
			)
			return false
		}

		switch entry.Type {
		case gxdr.LIVEENTRY, gxdr.INITENTRY:
			if entry.Type == gxdr.INITENTRY && bucketProtocolVersion < 11 {
				r.readChan <- r.error(
					errors.Errorf("Read INITENTRY from version <11 bucket: %d@%s", n, hash.String()),
				)
				return false
			}

			seen, err := r.tempStore.Exist(key)
			r.ledgerKeyPool.Put(key)
			if err != nil {
				r.readChan <- r.error(errors.Wrap(err, "Error reading from tempStore"))
				return false
			}

			if !seen {
				newLiveEntry := entry.LiveEntry()
				oldLiveEntry := xdr.LedgerEntry{}
				gxdr.Convert(newLiveEntry, &oldLiveEntry)
				if err != nil {
					r.readChan <- r.error(errors.Wrap(err, "Error converting"))
					return false
				}

				// Return LEDGER_ENTRY_STATE changes only now.
				entryChange := xdr.LedgerEntryChange{
					Type:  xdr.LedgerEntryChangeTypeLedgerEntryState,
					State: &oldLiveEntry,
				}
				r.readChan <- readResult{entryChange, nil}
				entriesAdded++

				// We don't update `tempStore` for INITENTRY because CAP-20 says:
				// > a bucket entry marked INITENTRY implies that either no entry
				// > with the same ledger key exists in an older bucket, or else
				// > that the (chronologically) preceding entry with the same ledger
				// > key was DEADENTRY.
				if entry.Type == gxdr.LIVEENTRY {
					// We skip adding entries from the last bucket to tempStore because:
					// 1. Ledger keys are unique within a single bucket.
					// 2. This is the last bucket we process so there's no need to track
					//    seen last entries in this bucket.
					if oldestBucket {
						continue
					}
					err := r.tempStore.Add(key)
					r.ledgerKeyPool.Put(key)
					if err != nil {
						r.readChan <- r.error(errors.Wrap(err, "Error updating to tempStore"))
						return false
					}
				}
			}
		case gxdr.DEADENTRY:
			err := r.tempStore.Add(key)
			r.ledgerKeyPool.Put(key)
			if err != nil {
				r.readChan <- r.error(errors.Wrap(err, "Error writing to tempStore"))
				return false
			}
		default:
			r.readChan <- r.error(
				errors.Errorf("Unexpected entry type %d: %d@%s", entry.Type, n, hash.String()),
			)
			return false
		}

		select {
		case <-r.done:
			// Close() called: stop processing buckets.
			return false
		default:
			continue
		}
	}

	panic("Shouldn't happen")
}

// Read returns a new ledger entry change on each call, returning io.EOF when the stream ends.
func (r *CheckpointChangeReader) Read() (Change, error) {
	r.streamOnce.Do(func() {
		go r.streamBuckets()
		go func() {
			prev := 0
			secondsWait := 0
			secondsBusy := 0
			for {
				time.Sleep(time.Second)
				read := entriesAdded
				if read != 2887375 {
					if read == prev {
						secondsWait++
					} else {
						secondsBusy++
					}
				}
				prev = read
				fmt.Println("chan len", len(r.readChan), "entriesAdded", entriesAdded, "busy", secondsBusy, "wait", secondsWait)
			}
		}()
	})

	// blocking call. anytime we consume from this channel, the background goroutine will stream in the next value
	result, ok := <-r.readChan
	if !ok {
		// when channel is closed then return io.EOF
		return Change{}, io.EOF
	}

	if result.e != nil {
		return Change{}, errors.Wrap(result.e, "Error while reading from buckets")
	}
	return Change{
		Type: result.entryChange.EntryType(),
		Post: result.entryChange.State,
	}, nil
}

func (r *CheckpointChangeReader) error(err error) readResult {
	return readResult{xdr.LedgerEntryChange{}, err}
}

func (r *CheckpointChangeReader) close() {
	close(r.done)
}

// Close should be called when reading is finished.
func (r *CheckpointChangeReader) Close() error {
	r.closeOnce.Do(r.close)
	return nil
}
