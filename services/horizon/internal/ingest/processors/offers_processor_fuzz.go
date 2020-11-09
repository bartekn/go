// +build gofuzz

package processors

import (
	"math"

	"github.com/stellar/go/ingest/io"
	"github.com/stellar/go/services/horizon/internal/db2/history"
	"github.com/stellar/go/support/db"
	"github.com/stellar/go/xdr"
	"github.com/stretchr/testify/mock"
)

func FuzzOffersProcessor(data []byte) int {
	// Ignore malformed
	var lchanges xdr.LedgerEntryChanges
	err := xdr.SafeUnmarshal(data, &lchanges)
	if err != nil {
		return -1
	}

	changes := io.GetChangesFromLedgerEntryChanges(lchanges)

	// Ignore changes with no offer changes inside
	offersFound := false
	for _, change := range changes {
		if change.Type == xdr.LedgerEntryTypeOffer {
			offersFound = true
		}
	}
	if !offersFound {
		return -1
	}

	mockQ := &history.MockQOffers{}
	mockBatchInsertBuilder := &history.MockOffersBatchInsertBuilder{}

	mockBatchInsertBuilder.On("Exec").Return(nil)
	mockBatchInsertBuilder.On("Add", mock.Anything).Return(nil)

	mockQ.On("UpdateOffer", mock.Anything).Return(int64(1), nil)
	mockQ.On("RemoveOffer", mock.Anything, mock.Anything).Return(int64(1), nil)
	mockQ.On("NewOffersBatchInsertBuilder", mock.Anything).Return(mockBatchInsertBuilder).Once()

	processor := NewOffersProcessor(mockQ, 10)

	for _, change := range changes {
		err = processor.ProcessChange(change)
		if err != nil {
			panic(err)
		}
	}

	err = processor.Commit()
	if err != nil {
		panic(err)
	}

	return 1
}

func FuzzOffersProcessorDB(data []byte) int {
	// Ignore malformed
	var lchanges xdr.LedgerEntryChanges
	err := xdr.SafeUnmarshal(data, &lchanges)
	if err != nil {
		return -1
	}

	changes := io.GetChangesFromLedgerEntryChanges(lchanges)

	// Ignore changes with no offer changes inside
	offersFound := false
	for _, change := range changes {
		if change.Type == xdr.LedgerEntryTypeOffer {
			offersFound = true
		}
	}
	if !offersFound {
		return -1
	}

	horizonSession, err := db.Open("postgres", "postgres://localhost:5432/horizon?sslmode=disable")
	if err != nil {
		panic(err)
	}

	defer horizonSession.Close()

	_, err = horizonSession.ExecRaw("TRUNCATE offers")
	if err != nil {
		panic(err)
	}

	historyQ := &history.Q{horizonSession}
	processor := NewOffersProcessor(historyQ, 10)

	// Prepopulate DB to keep invariants (ex. DELETE on a row should actually remove a row).
	// Also check if offer valid (core would accept it).
	for _, change := range changes {
		if change.Type != xdr.LedgerEntryTypeOffer {
			continue
		}

		if change.Pre != nil && !checkValid(change.Pre) {
			return -1
		}

		if change.Post != nil && !checkValid(change.Post) {
			return -1
		}

		changeType := change.LedgerEntryChangeType()
		if changeType == xdr.LedgerEntryChangeTypeLedgerEntryUpdated &&
			change.Pre.Data.MustOffer().OfferId != change.Post.Data.MustOffer().OfferId {
			return -1
		}

		batch := historyQ.NewOffersBatchInsertBuilder(1)
		var err error

		if changeType == xdr.LedgerEntryChangeTypeLedgerEntryRemoved ||
			changeType == xdr.LedgerEntryChangeTypeLedgerEntryUpdated {
			row := processor.ledgerEntryToRow(change.Pre)
			err = batch.Add(row)
		}

		if err != nil {
			panic(err)
		}

		err = batch.Exec()
		if err != nil {
			panic(err)
		}
	}

	for _, change := range changes {
		err = processor.ProcessChange(change)
		if err != nil {
			panic(err)
		}
	}

	err = processor.Commit()
	if err != nil {
		panic(err)
	}

	return 1
}

func checkValid(entry *xdr.LedgerEntry) bool {
	if entry.LastModifiedLedgerSeq <= 0 {
		return false
	}

	if entry.LastModifiedLedgerSeq > math.MaxInt32 {
		return false
	}

	offer := entry.Data.MustOffer()

	if offer.Price.N < 0 {
		return false
	}

	if offer.Price.D <= 0 {
		return false
	}

	if offer.Amount < 0 {
		return false
	}

	if offer.Flags > math.MaxInt32 {
		return false
	}

	return true
}
