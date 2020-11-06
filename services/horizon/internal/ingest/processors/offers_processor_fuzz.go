// +build gofuzz

package processors

import (
	"github.com/stellar/go/ingest/io"
	"github.com/stellar/go/services/horizon/internal/db2/history"
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
