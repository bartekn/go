package io

import (
	"context"
	"fmt"
	stdio "io"

	"github.com/stellar/go/support/errors"
	"github.com/stellar/go/xdr"
)

var ErrNotFound = errors.New("not found")

// StateReader reads state data from history archive buckets for a single
// checkpoint ledger / HAS.
type StateReader interface {
	// GetSequence returns the checkpoint ledger sequence this reader is
	// reading.
	GetSequence() uint32
	// Read should return next ledger entry. If there are no more
	// entries it should return `io.EOF` error.
	Read() (xdr.LedgerEntryChange, error)
	// Close should be called when reading is finished. This is especially
	// helpful when there are still some entries available so reader can stop
	// streaming them.
	Close() error
}

// StateWriter interface placeholder
type StateWriter interface {
	// Write is used to pass ledger entry change to the next processor. It can return
	// `ErrClosedPipe` when the pipe between processors has been closed meaning
	// that next processor does not need more data. In such situation the current
	// processor can terminate as sending more entries to a `StateWriter`
	// does not make sense (will not be read).
	Write(xdr.LedgerEntryChange) error
	// Close should be called when there are no more entries
	// to write.
	Close() error
}

type StateProcessors []StateProcessor

// StateProcessor defines methods required for state processing.
type StateProcessor interface {
	Init() error
	ProcessState(Change) error
	Commit() error
}

// ProcessStateReader runs state processing on a set of processors using StateReader.
// If ctx WithCancel is passed the processing will stop and the function will return
// context.Canceled.
func (processors StateProcessors) ProcessStateReader(ctx context.Context, r StateReader) error {
	// Init stage
	for _, processor := range processors {
		err := processor.Init()
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error in Init in %T", processor))
		}

		select {
		case <-ctx.Done():
			return context.Canceled
		default:
			continue
		}
	}

	// Process stage
	for {
		entryChange, err := r.Read()
		if err != nil {
			if err == stdio.EOF {
				break
			} else {
				return errors.Wrap(err, "Error reading from state reader")
			}
		}

		// Double check the type
		if entryChange.Type != xdr.LedgerEntryChangeTypeLedgerEntryCreated {
			return errors.Wrap(err, "DatabaseProcessor requires LedgerEntryChangeTypeLedgerEntryState changes only")
		}

		change := Change{
			Type: entryChange.Created.Data.Type,
			Post: entryChange.Created,
		}

		for _, processor := range processors {
			err := processor.ProcessState(change)
			if err != nil {
				return errors.Wrap(err, fmt.Sprintf("Error in ProcessState in %T", processor))
			}

			select {
			case <-ctx.Done():
				return context.Canceled
			default:
				continue
			}
		}
	}

	// Commit stage
	for _, processor := range processors {
		err := processor.Commit()
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error in Commit in %T", processor))
		}

		select {
		case <-ctx.Done():
			return context.Canceled
		default:
			continue
		}
	}

	return nil
}

// ProcessLedgerReader runs state processing on a set of processors using LedgerReader.
// Meta changes returned by LedgerReader must be processes in a correct order so it's
// better to use this helper unless you need some special processing of low-level
// meta structures.
// If ctx WithCancel is passed the processing will stop and the function will return
// context.Canceled.
func (processors StateProcessors) ProcessLedgerReader(ctx context.Context, r LedgerReader) error {
	// Init stage
	for _, processor := range processors {
		err := processor.Init()
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error in Init in %T", processor))
		}

		select {
		case <-ctx.Done():
			return context.Canceled
		default:
			continue
		}
	}

	// Fee meta before everything else
	for {
		transaction, err := r.Read()
		if err != nil {
			if err == stdio.EOF {
				break
			} else {
				return errors.Wrap(err, "Error reading from ledger reader")
			}
		}

		for _, change := range transaction.GetFeeChanges() {
			for _, processor := range processors {
				err := processor.ProcessState(change)
				if err != nil {
					return errors.Wrap(err, fmt.Sprintf("Error in ProcessState in %T", processor))
				}

				select {
				case <-ctx.Done():
					return context.Canceled
				default:
					continue
				}
			}
		}
	}

	// Rewind reader to process meta from the first transaction.
	err := r.Rewind()
	if err != nil {
		return errors.Wrap(err, "Error rewinding ledger reader")
	}

	// Tx meta
	for {
		transaction, err := r.Read()
		if err != nil {
			if err == stdio.EOF {
				break
			} else {
				return errors.Wrap(err, "Error reading from ledger reader")
			}
		}

		changes, err := transaction.GetChanges()
		if err != nil {
			return errors.Wrap(err, "Error getting transaction changes")
		}

		for _, change := range changes {
			for _, processor := range processors {
				err := processor.ProcessState(change)
				if err != nil {
					return errors.Wrap(err, fmt.Sprintf("Error in ProcessState in %T", processor))
				}

				select {
				case <-ctx.Done():
					return context.Canceled
				default:
					continue
				}
			}
		}
	}

	// Upgrades
	for {
		change, err := r.ReadUpgradeChange()
		if err != nil {
			if err == stdio.EOF {
				break
			} else {
				return err
			}
		}

		for _, processor := range processors {
			err := processor.ProcessState(change)
			if err != nil {
				return errors.Wrap(err, fmt.Sprintf("Error in ProcessState in %T", processor))
			}

			select {
			case <-ctx.Done():
				return context.Canceled
			default:
				continue
			}
		}
	}

	// Commit stage
	for _, processor := range processors {
		err := processor.Commit()
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error in Commit in %T", processor))
		}
	}

	return nil
}

// LedgerReader provides convenient, streaming access to the transactions within a ledger.
// If processing meta, please use StateProcessors.ProcessLedgerReader method instead of
// processing this once.
type LedgerReader interface {
	GetSequence() uint32
	GetHeader() xdr.LedgerHeaderHistoryEntry
	// Read should return the next transaction. If there are no more
	// transactions it should return `io.EOF` error.
	Read() (LedgerTransaction, error)
	// Rewind rewinds reader to the beginning. The next Read() will return the
	// first transaction in the ledger (or `io.EOF` if no transactions).
	Rewind() error
	// Read should return the next ledger entry change from ledger upgrades. If
	// there are no more changes it should return `io.EOF` error.
	// Ledger upgrades MUST be processed AFTER all transactions and only ONCE.
	// If app is tracking state in more than one store, all of them need to
	// be updated with upgrade changes.
	// Values returned by this method must not be modified.
	ReadUpgradeChange() (Change, error)
	// Close should be called when reading is finished. This is especially
	// helpful when there are still some transactions available so reader can stop
	// streaming them.
	Close() error
}

type UpgradeChangesContainer interface {
	GetUpgradeChanges() []Change
}

// LedgerWriter provides convenient, streaming access to the transactions within a ledger.
type LedgerWriter interface {
	// Write is used to pass a transaction to the next processor. It can return
	// `io.ErrClosedPipe` when the pipe between processors has been closed meaning
	// that next processor does not need more data. In such situation the current
	// processor can terminate as sending more transactions to a `LedgerWriter`
	// does not make sense (will not be read).
	Write(LedgerTransaction) error
	// Close should be called when reading is finished. This is especially
	// helpful when there are still some transactions available so the reader can stop
	// streaming them.
	Close() error
}

// LedgerTransaction represents the data for a single transaction within a ledger.
type LedgerTransaction struct {
	Index    uint32
	Envelope xdr.TransactionEnvelope
	Result   xdr.TransactionResultPair
	// FeeChanges and Meta are low level values.
	// Use LedgerTransaction.GetChanges() for higher level access to ledger
	// entry changes.
	FeeChanges xdr.LedgerEntryChanges
	Meta       xdr.TransactionMeta
}

type TransactionProcessors []TransactionProcessor

// TransactionProcessor defines methods required for transaction processing.
type TransactionProcessor interface {
	Init() error
	ProcessTransaction(LedgerTransaction) error
	Commit() error
}

// ProcessLedgerReader runs processing on a set of processors using LedgeReader.
// If ctx WithCancel is passed the processing will stop and the function will return
// context.Canceled.
func (processors TransactionProcessors) ProcessLedgerReader(ctx context.Context, r LedgerReader) error {
	// Init stage
	for _, processor := range processors {
		err := processor.Init()
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error in Init in %T", processor))
		}

		select {
		case <-ctx.Done():
			return context.Canceled
		default:
			continue
		}
	}

	// Process stage
	for {
		transaction, err := r.Read()
		if err != nil {
			if err == stdio.EOF {
				break
			} else {
				return errors.Wrap(err, "Error reading from state reader")
			}
		}

		for _, processor := range processors {
			err := processor.ProcessTransaction(transaction)
			if err != nil {
				return errors.Wrap(err, fmt.Sprintf("Error in ProcessTransaction in %T", processor))
			}

			select {
			case <-ctx.Done():
				return context.Canceled
			default:
				continue
			}
		}
	}

	// Commit stage
	for _, processor := range processors {
		err := processor.Commit()
		if err != nil {
			return errors.Wrap(err, fmt.Sprintf("Error in Commit in %T", processor))
		}

		select {
		case <-ctx.Done():
			return context.Canceled
		default:
			continue
		}
	}

	return nil
}
