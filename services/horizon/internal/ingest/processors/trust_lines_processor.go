package processors

import (
	"context"
	"encoding/base64"
	"fmt"
	"sync"

	"github.com/stellar/go/ingest"
	"github.com/stellar/go/services/horizon/internal/db2/history"
	"github.com/stellar/go/support/errors"
	"github.com/stellar/go/xdr"
)

type TrustLinesProcessor struct {
	trustLinesQ   history.QTrustLines
	dbObjectsPool sync.Pool

	cache *ingest.ChangeCompactor
}

func NewTrustLinesProcessor(trustLinesQ history.QTrustLines) *TrustLinesProcessor {
	p := &TrustLinesProcessor{trustLinesQ: trustLinesQ}
	p.reset()
	p.dbObjectsPool = sync.Pool{
		New: func() interface{} {
			return new(history.TrustLine)
		},
	}
	return p
}

func (p *TrustLinesProcessor) reset() {
	p.cache = ingest.NewChangeCompactor()
}

func (p *TrustLinesProcessor) ProcessChange(ctx context.Context, change ingest.Change) error {
	if change.Type != xdr.LedgerEntryTypeTrustline {
		return nil
	}

	err := p.cache.AddChange(change)
	if err != nil {
		return errors.Wrap(err, "error adding to ledgerCache")
	}

	if p.cache.Size() > maxBatchSize {
		err = p.Commit(ctx)
		if err != nil {
			return errors.Wrap(err, "error in Commit")
		}
		p.reset()
	}

	return nil
}

func trustLineEntryToLedgerKeyString(entry *xdr.LedgerEntry) string {
	ledgerKey := entry.LedgerKey()
	key, err := ledgerKey.MarshalBinary()
	if err != nil {
		panic(errors.Wrap(err, "Error running MarshalBinaryCompress"))
	}

	return base64.StdEncoding.EncodeToString(key)
}

func (p *TrustLinesProcessor) entryToDBObject(entry *xdr.LedgerEntry, trustLine *history.TrustLine) {
	var assetType xdr.AssetType
	var assetCode, assetIssuer string
	entry.Data.TrustLine.Asset.MustExtract(&assetType, &assetCode, &assetIssuer)

	liabilities := entry.Data.TrustLine.Liabilities()

	// trustLine.LedgerKey = trustLineEntryToLedgerKeyString(entry)
	trustLine.AccountID = entry.Data.TrustLine.AccountId.Address()
	trustLine.AssetType = assetType
	trustLine.AssetIssuer = assetIssuer
	trustLine.AssetCode = assetCode
	// Faster without xdr.marshal
	trustLine.LedgerKey =
		fmt.Sprintf(
			"%s/%s/%s",
			trustLine.AccountID,
			trustLine.AssetIssuer,
			trustLine.AssetCode,
		)
	trustLine.Balance = int64(entry.Data.TrustLine.Balance)
	trustLine.Limit = int64(entry.Data.TrustLine.Limit)
	trustLine.BuyingLiabilities = int64(liabilities.Buying)
	trustLine.SellingLiabilities = int64(liabilities.Selling)
	trustLine.Flags = uint32(entry.Data.TrustLine.Flags)
	trustLine.LastModifiedLedger = uint32(entry.LastModifiedLedgerSeq)
	trustLine.Sponsor = ledgerEntrySponsorToNullString(entry)
}

func (p *TrustLinesProcessor) Commit(ctx context.Context) error {
	var batchUpsertTrustLines []*history.TrustLine

	changes := p.cache.GetChangesMap()
	for _, change := range changes {
		var rowsAffected int64
		var err error
		var action string
		var ledgerKey xdr.LedgerKey

		switch {
		case change.Post != nil:
			// Created and updated
			trustLine := p.dbObjectsPool.Get().(*history.TrustLine)
			p.entryToDBObject(change.Post, trustLine)

			if batchUpsertTrustLines == nil {
				batchUpsertTrustLines = make([]*history.TrustLine, 0, len(changes))
			}

			batchUpsertTrustLines = append(batchUpsertTrustLines, trustLine)
		case change.Pre != nil && change.Post == nil:
			// Removed
			action = "removing"
			trustLine := change.Pre.Data.MustTrustLine()
			err = ledgerKey.SetTrustline(trustLine.AccountId, trustLine.Asset)
			if err != nil {
				return errors.Wrap(err, "Error creating ledger key")
			}
			rowsAffected, err = p.trustLinesQ.RemoveTrustLine(ctx, *ledgerKey.TrustLine)
			if err != nil {
				return err
			}

			if rowsAffected != 1 {
				return ingest.NewStateError(errors.Errorf(
					"%d rows affected when %s trustline: %s %s",
					rowsAffected,
					action,
					ledgerKey.TrustLine.AccountId.Address(),
					ledgerKey.TrustLine.Asset.String(),
				))
			}
		default:
			return errors.New("Invalid io.Change: change.Pre == nil && change.Post == nil")
		}
	}

	// Upsert accounts
	if len(batchUpsertTrustLines) > 0 {
		err := p.trustLinesQ.UpsertTrustLines(ctx, batchUpsertTrustLines)
		if err != nil {
			return errors.Wrap(err, "errors in UpsertTrustLines")
		}

		// Release to sync.Pool
		for _, tline := range batchUpsertTrustLines {
			p.dbObjectsPool.Put(tline)
		}
	}

	return nil
}
