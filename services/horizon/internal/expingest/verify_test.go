package expingest

import (
	"database/sql"
	"testing"
	"time"

	"github.com/stellar/go/exp/ingest/adapters"
	"github.com/stellar/go/exp/ingest/io"
	"github.com/stellar/go/exp/ingest/verify"
	"github.com/stellar/go/services/horizon/internal/db2/history"
	"github.com/stellar/go/xdr"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
	"github.com/stretchr/testify/suite"
)

func TestAlreadyRunning(t *testing.T) {
	system := &System{}
	system.stateVerificationRunning = true
	err := system.verifyState()
	assert.NoError(t, err)
	assert.True(t, system.stateVerificationRunning)
}

func TestTransformEntryAccount(t *testing.T) {
	inflationDest := xdr.MustAddress("GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7")
	entry := xdr.LedgerEntry{
		Data: xdr.LedgerEntryData{
			Type: xdr.LedgerEntryTypeAccount,
			Account: &xdr.AccountEntry{
				AccountId:     xdr.MustAddress("GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7"),
				Balance:       1000,
				SeqNum:        1000,
				NumSubEntries: 1000,
				InflationDest: &inflationDest,
				Flags:         20,
				HomeDomain:    "stellar.org",
				Thresholds:    [4]byte{1, 2, 3, 4},
				Signers: []xdr.Signer{
					{
						Key:    xdr.MustSigner("GAIEKNJHOSMMCE2NDNNRAOQYXVHZH7U345IUABMBJE6QF3T3DVKDLH3K"),
						Weight: xdr.Uint32(2),
					},
					{
						Key:    xdr.MustSigner("GA7I72AGY4OJRFCB6QVPDPHPP2LRCRW67GWARQCP5GM4OA3GSR3ITXN5"),
						Weight: xdr.Uint32(3),
					},
				},
			},
		},
	}

	expected := xdr.LedgerEntry{
		Data: xdr.LedgerEntryData{
			Type: xdr.LedgerEntryTypeAccount,
			Account: &xdr.AccountEntry{
				AccountId:  xdr.MustAddress("GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7"),
				Thresholds: [4]byte{1, 0, 0, 0},
				// Sorted!
				Signers: []xdr.Signer{
					{
						Key:    xdr.MustSigner("GA7I72AGY4OJRFCB6QVPDPHPP2LRCRW67GWARQCP5GM4OA3GSR3ITXN5"),
						Weight: xdr.Uint32(3),
					},
					{
						Key:    xdr.MustSigner("GAIEKNJHOSMMCE2NDNNRAOQYXVHZH7U345IUABMBJE6QF3T3DVKDLH3K"),
						Weight: xdr.Uint32(2),
					},
				},
			},
		},
	}

	ignore, newEntry := transformEntry(entry)
	assert.False(t, ignore)
	assert.Equal(t, expected, newEntry)
}

func TestTransformEntryAccountNoSigners(t *testing.T) {
	entry := xdr.LedgerEntry{
		Data: xdr.LedgerEntryData{
			Type: xdr.LedgerEntryTypeAccount,
			Account: &xdr.AccountEntry{
				AccountId:  xdr.MustAddress("GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7"),
				Thresholds: [4]byte{0, 2, 3, 4},
				Signers:    []xdr.Signer{},
			},
		},
	}
	ignore, _ := transformEntry(entry)
	assert.True(t, ignore)
}

func TestTransformEntryOffer(t *testing.T) {
	entry := xdr.LedgerEntry{
		Data: xdr.LedgerEntryData{
			Type: xdr.LedgerEntryTypeOffer,
			Offer: &xdr.OfferEntry{
				SellerId: xdr.MustAddress("GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7"),
				OfferId:  10,
				Selling:  xdr.MustNewCreditAsset("USD", "GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7"),
				Buying:   xdr.MustNewNativeAsset(),
				Amount:   50,
				Price:    xdr.Price{N: 100, D: 200},
			},
		},
	}

	ignore, newEntry := transformEntry(entry)
	assert.False(t, ignore)
	// No changes
	assert.Equal(t, entry, newEntry)
}

func TestTransformEntryIgnore(t *testing.T) {
	entry := xdr.LedgerEntry{
		Data: xdr.LedgerEntryData{
			Type: xdr.LedgerEntryTypeTrustline,
		},
	}
	ignore, _ := transformEntry(entry)
	assert.True(t, ignore)

	entry = xdr.LedgerEntry{
		Data: xdr.LedgerEntryData{
			Type: xdr.LedgerEntryTypeData,
		},
	}
	ignore, _ = transformEntry(entry)
	assert.True(t, ignore)
}

type stateVerifierFactoryMock struct {
	mock.Mock
}

func (m *stateVerifierFactoryMock) buildStateVerifier(stateReader io.StateReader) verify.StateVerifierInterface {
	args := m.Called(stateReader)
	return args.Get(0).(verify.StateVerifierInterface)
}

func TestStateVerifySuite(t *testing.T) {
	suite.Run(t, new(StateVerifyTestSuite))
}

type StateVerifyTestSuite struct {
	suite.Suite
	stateVerifier            *stateVerifier
	mockIngestStateVerifier  *verify.MockStateVerifier
	mockStateVerifierFactory *stateVerifierFactoryMock
	mockHistoryQ             *mockDBQ
	mockHistoryAdapter       *adapters.MockHistoryArchiveAdapter
	mockStateReader          *io.MockStateReader
}

func (s *StateVerifyTestSuite) SetupTest() {
	s.mockHistoryQ = &mockDBQ{}
	s.mockHistoryAdapter = &adapters.MockHistoryArchiveAdapter{}
	s.mockIngestStateVerifier = &verify.MockStateVerifier{}
	s.mockStateVerifierFactory = &stateVerifierFactoryMock{}
	s.mockStateReader = &io.MockStateReader{}

	s.stateVerifier = &stateVerifier{
		verifierFactory: s.mockStateVerifierFactory,
		historyQ:        s.mockHistoryQ,
		historyAdapter:  s.mockHistoryAdapter,
		sleepFn: func(d time.Duration) {
			assert.Equal(s.T(), 40*time.Second, d)
		},
	}
}

func (s *StateVerifyTestSuite) TearDownTest() {
	s.mockHistoryQ.AssertExpectations(s.T())
	s.mockHistoryAdapter.AssertExpectations(s.T())
	s.mockIngestStateVerifier.AssertExpectations(s.T())
	s.mockStateVerifierFactory.AssertExpectations(s.T())
	s.mockStateReader.AssertExpectations(s.T())
}

// prepareMocks programs mocks with OK behaviour up to given level in
// the code. This limits code duplication in tests.
func (s *StateVerifyTestSuite) prepareMocks(level int) {
	if level >= 1 {
		s.mockHistoryQ.
			On("BeginTx", mock.AnythingOfType("*sql.TxOptions")).
			Return(nil).
			Once()

		s.mockHistoryQ.On("Rollback").Return(nil).Once()
	}
	if level >= 2 {
		s.mockHistoryQ.
			On("GetLastLedgerExpIngestNonBlocking").
			Return(uint32(63), nil).
			Once()
	}
	if level >= 3 {
		s.mockHistoryAdapter.
			On("GetLatestLedgerSequence").
			Return(uint32(63), nil).
			Once()
	}
	if level >= 4 {
		s.mockHistoryAdapter.
			On("GetState", uint32(63), &io.MemoryTempSet{}).
			Return(s.mockStateReader, nil).
			Once()

		s.mockStateReader.On("Close").Return(nil).Once()
	}
	if level >= 5 {
		s.mockStateVerifierFactory.
			On("buildStateVerifier", s.mockStateReader).
			Return(s.mockIngestStateVerifier).
			Once()
	}
}

func (s *StateVerifyTestSuite) TestErrorBeginTx() {
	s.mockHistoryQ.
		On("BeginTx", mock.AnythingOfType("*sql.TxOptions")).
		Run(func(args mock.Arguments) {
			opts := args.Get(0).(*sql.TxOptions)
			s.Assert().Equal(sql.LevelRepeatableRead, opts.Isolation)
			s.Assert().True(opts.ReadOnly)
		}).
		Return(assert.AnError).
		Once()

	err := s.stateVerifier.verify()
	s.Assert().Error(err)
	s.Assert().EqualError(err, "Error starting transaction: assert.AnError general error for testing")
}

func (s *StateVerifyTestSuite) TestErrorGetLastLedgerExpIngestNonBlocking() {
	s.prepareMocks(1)

	s.mockHistoryQ.
		On("GetLastLedgerExpIngestNonBlocking").
		Return(uint32(0), assert.AnError).
		Once()

	err := s.stateVerifier.verify()
	s.Assert().Error(err)
	s.Assert().EqualError(err, "Error running historyQ.GetLastLedgerExpIngestNonBlocking: assert.AnError general error for testing")
}

func (s *StateVerifyTestSuite) TestNotCheckpointLedger() {
	s.prepareMocks(1)

	s.mockHistoryQ.
		On("GetLastLedgerExpIngestNonBlocking").
		Return(uint32(42), nil).
		Once()

	err := s.stateVerifier.verify()
	s.Assert().Error(err)
	s.Assert().EqualError(err, "Ledger 42 is not a checkpoint ledger.")
}

func (s *StateVerifyTestSuite) TestGetLatestLedgerSequenceError() {
	s.prepareMocks(2)

	s.mockHistoryAdapter.
		On("GetLatestLedgerSequence").
		Return(uint32(0), assert.AnError).
		Once()

	err := s.stateVerifier.verify()
	s.Assert().Error(err)
	s.Assert().EqualError(err, "Error getting the latest ledger sequence: assert.AnError general error for testing")
}

func (s *StateVerifyTestSuite) TestOldLedger() {
	s.prepareMocks(1)

	s.mockHistoryQ.
		On("GetLastLedgerExpIngestNonBlocking").
		Return(uint32(63), nil).
		Once()

	s.mockHistoryAdapter.
		On("GetLatestLedgerSequence").
		Return(uint32(1000), nil).
		Once()

	err := s.stateVerifier.verify()
	// Should exit without error and verifying
	s.Assert().NoError(err)
}

func (s *StateVerifyTestSuite) TestGetStateError() {
	s.prepareMocks(3)

	s.mockHistoryAdapter.
		On("GetState", uint32(63), &io.MemoryTempSet{}).
		Return(&io.SingleLedgerStateReader{}, assert.AnError).
		Once()

	err := s.stateVerifier.verify()
	s.Assert().Error(err)
	s.Assert().EqualError(err, "Error running historyAdapter.GetState: assert.AnError general error for testing")
}

func (s *StateVerifyTestSuite) TestGetLedgerKeysError() {
	s.prepareMocks(5)

	s.mockIngestStateVerifier.
		On("GetLedgerKeys", verifyBatchSize).
		Return([]xdr.LedgerKey{}, assert.AnError).
		Once()

	err := s.stateVerifier.verify()
	s.Assert().Error(err)
	s.Assert().EqualError(err, "verifier.GetLedgerKeys error: assert.AnError general error for testing")
}

func (s *StateVerifyTestSuite) TestFull() {
	s.prepareMocks(5)

	accountKey := xdr.LedgerKey{}
	accountKey.SetAccount(xdr.MustAddress("GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7"))
	offerKey := xdr.LedgerKey{}
	offerKey.SetOffer(xdr.MustAddress("GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7"), 10)

	s.mockIngestStateVerifier.
		On("GetLedgerKeys", verifyBatchSize).
		Return([]xdr.LedgerKey{accountKey, offerKey}, nil).
		Once()

	s.mockHistoryQ.
		On("SignersForAccounts", []string{"GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7"}).
		Return([]history.AccountSigner{
			{
				Account: "GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7",
				Signer:  "GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7",
				Weight:  1,
			},
			{
				Account: "GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7",
				Signer:  "GAIEKNJHOSMMCE2NDNNRAOQYXVHZH7U345IUABMBJE6QF3T3DVKDLH3K",
				Weight:  2,
			},
			{
				Account: "GAIEKNJHOSMMCE2NDNNRAOQYXVHZH7U345IUABMBJE6QF3T3DVKDLH3K",
				Signer:  "GAIEKNJHOSMMCE2NDNNRAOQYXVHZH7U345IUABMBJE6QF3T3DVKDLH3K",
				Weight:  3,
			},
		}, nil).
		Once()

	s.mockIngestStateVerifier.
		On("Write", xdr.LedgerEntry{
			Data: xdr.LedgerEntryData{
				Type: xdr.LedgerEntryTypeAccount,
				Account: &xdr.AccountEntry{
					AccountId:  xdr.MustAddress("GAIEKNJHOSMMCE2NDNNRAOQYXVHZH7U345IUABMBJE6QF3T3DVKDLH3K"),
					Thresholds: [4]byte{3, 0, 0, 0},
					Signers:    []xdr.Signer{},
				},
			},
		}).
		Return(nil).
		Once()

	s.mockIngestStateVerifier.
		On("Write", xdr.LedgerEntry{
			Data: xdr.LedgerEntryData{
				Type: xdr.LedgerEntryTypeAccount,
				Account: &xdr.AccountEntry{
					AccountId:  xdr.MustAddress("GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7"),
					Thresholds: [4]byte{1, 0, 0, 0},
					Signers: []xdr.Signer{
						{
							Key:    xdr.MustSigner("GAIEKNJHOSMMCE2NDNNRAOQYXVHZH7U345IUABMBJE6QF3T3DVKDLH3K"),
							Weight: xdr.Uint32(2),
						},
					},
				},
			},
		}).
		Return(nil).
		Once()

	s.mockHistoryQ.
		On("GetOffersByIDs", []int64{10}).
		Return([]history.Offer{
			{
				OfferID:  10,
				SellerID: "GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7",
			},
		}, nil).
		Once()

	s.mockIngestStateVerifier.
		On("Write", xdr.LedgerEntry{
			Data: xdr.LedgerEntryData{
				Type: xdr.LedgerEntryTypeOffer,
				Offer: &xdr.OfferEntry{
					OfferId:  10,
					SellerId: xdr.MustAddress("GDQ4U7X4YNDD4D6WYU3JNMPAECNG2IZMQLT4CFAGRVW7XYHBLKI4UKS7"),
				},
			},
		}).
		Return(nil).
		Once()

	// Second iteration returns no keys
	s.mockIngestStateVerifier.
		On("GetLedgerKeys", verifyBatchSize).
		Return([]xdr.LedgerKey{}, nil).
		Once()

	s.mockHistoryQ.On("CountAccounts").Return(2, nil).Once()
	s.mockHistoryQ.On("CountOffers").Return(1, nil).Once()

	s.mockIngestStateVerifier.On("Verify", 3).Return(nil).Once()

	err := s.stateVerifier.verify()
	s.Assert().NoError(err)
}
