package processors

import (
	"context"
	stdio "io"
	"testing"

	"github.com/stellar/go/exp/ingest/io"
	"github.com/stellar/go/exp/support/pipeline"
	"github.com/stellar/go/xdr"
	"github.com/stretchr/testify/suite"
)

func TestContextFilterTestSuite(t *testing.T) {
	suite.Run(t, new(ContextFilterTestSuiteState))
}

type ContextFilterTestSuiteState struct {
	suite.Suite
	mockStateReader  *io.MockStateReader
	mockStateWriter  *io.MockStateWriter
	mockLedgerReader *io.MockLedgerReader
	mockLedgerWriter *io.MockLedgerWriter
}

func (s *ContextFilterTestSuiteState) SetupTest() {
	s.mockStateReader = &io.MockStateReader{}
	s.mockStateWriter = &io.MockStateWriter{}
	s.mockLedgerReader = &io.MockLedgerReader{}
	s.mockLedgerWriter = &io.MockLedgerWriter{}
}

func (s *ContextFilterTestSuiteState) setupState() {
	// Reader and Writer should be always closed and once
	s.mockStateReader.On("Close").Return(nil).Once()
	s.mockStateWriter.On("Close").Return(nil).Once()
}

func (s *ContextFilterTestSuiteState) setupLedger() {
	// Reader and Writer should be always closed and once
	s.mockLedgerReader.On("Close").Return(nil).Once()
	s.mockLedgerWriter.On("Close").Return(nil).Once()
}

func (s *ContextFilterTestSuiteState) TearDownTest() {
	s.mockStateReader.AssertExpectations(s.T())
	s.mockStateWriter.AssertExpectations(s.T())
	s.mockLedgerReader.AssertExpectations(s.T())
	s.mockLedgerWriter.AssertExpectations(s.T())
}

func (s *ContextFilterTestSuiteState) TestName() {
	filter := ContextFilter{
		Key: IngestUpdateDatabase,
	}
	s.Assert().Equal("ContextFilter (IngestUpdateDatabase)", filter.Name())
}

func (s *ContextFilterTestSuiteState) TestStateKeyNotPresent() {
	s.setupState()

	filter := ContextFilter{
		Key: IngestUpdateDatabase,
	}

	ctx := context.Background()
	err := filter.ProcessState(ctx, &pipeline.Store{}, s.mockStateReader, s.mockStateWriter)
	s.Assert().NoError(err)
}

func (s *ContextFilterTestSuiteState) TestStateKeyPresent() {
	s.setupState()

	filter := ContextFilter{
		Key: IngestUpdateDatabase,
	}

	entryChange := xdr.LedgerEntryChange{
		Type: xdr.LedgerEntryChangeTypeLedgerEntryState,
		State: &xdr.LedgerEntry{
			Data: xdr.LedgerEntryData{
				Type: xdr.LedgerEntryTypeAccount,
				Account: &xdr.AccountEntry{
					AccountId: xdr.MustAddress("GCCCU34WDY2RATQTOOQKY6SZWU6J5DONY42SWGW2CIXGW4LICAGNRZKX"),
					Signers: []xdr.Signer{
						xdr.Signer{
							Key:    xdr.MustSigner("GC3C4AKRBQLHOJ45U4XG35ESVWRDECWO5XLDGYADO6DPR3L7KIDVUMML"),
							Weight: 10,
						},
					},
				},
			},
		},
	}

	s.mockStateReader.On("Read").Return(entryChange, nil).Once()
	s.mockStateReader.On("Read").Return(xdr.LedgerEntryChange{}, stdio.EOF).Once()

	s.mockStateWriter.On("Write", entryChange).Return(nil).Once()

	ctx := context.WithValue(context.Background(), IngestUpdateDatabase, true)
	err := filter.ProcessState(ctx, &pipeline.Store{}, s.mockStateReader, s.mockStateWriter)
	s.Assert().NoError(err)
}

func (s *ContextFilterTestSuiteState) TestLedgerKeyNotPresent() {
	s.setupLedger()

	filter := ContextFilter{
		Key: IngestUpdateDatabase,
	}

	ctx := context.Background()
	err := filter.ProcessLedger(ctx, &pipeline.Store{}, s.mockLedgerReader, s.mockLedgerWriter)
	s.Assert().NoError(err)
}

func (s *ContextFilterTestSuiteState) TestLedgerKeyPresent() {
	s.setupLedger()

	filter := ContextFilter{
		Key: IngestUpdateDatabase,
	}

	transaction := io.LedgerTransaction{
		Meta: createTransactionMeta([]xdr.OperationMeta{
			xdr.OperationMeta{
				Changes: []xdr.LedgerEntryChange{
					xdr.LedgerEntryChange{
						Type: xdr.LedgerEntryChangeTypeLedgerEntryCreated,
						Created: &xdr.LedgerEntry{
							Data: xdr.LedgerEntryData{
								Type: xdr.LedgerEntryTypeAccount,
								Account: &xdr.AccountEntry{
									AccountId:  xdr.MustAddress("GC3C4AKRBQLHOJ45U4XG35ESVWRDECWO5XLDGYADO6DPR3L7KIDVUMML"),
									Thresholds: [4]byte{1, 1, 1, 1},
								},
							},
						},
					},
				},
			},
		}),
	}

	s.mockLedgerReader.On("Read").Return(transaction, nil).Once()
	s.mockLedgerReader.On("Read").Return(io.LedgerTransaction{}, stdio.EOF).Once()

	s.mockLedgerWriter.On("Write", transaction).Return(nil).Once()

	ctx := context.WithValue(context.Background(), IngestUpdateDatabase, true)
	err := filter.ProcessLedger(ctx, &pipeline.Store{}, s.mockLedgerReader, s.mockLedgerWriter)
	s.Assert().NoError(err)
}
