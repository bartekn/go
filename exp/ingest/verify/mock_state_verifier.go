package verify

import (
	"github.com/stellar/go/xdr"
	"github.com/stretchr/testify/mock"
)

var _ StateVerifierInterface = (*MockStateVerifier)(nil)

type MockStateVerifier struct {
	mock.Mock
}

func (m *MockStateVerifier) GetLedgerKeys(count int) ([]xdr.LedgerKey, error) {
	args := m.Called(count)
	return args.Get(0).([]xdr.LedgerKey), args.Error(1)
}

func (m *MockStateVerifier) Write(entry xdr.LedgerEntry) error {
	args := m.Called(entry)
	return args.Error(0)
}

func (m *MockStateVerifier) Verify(countAll int) error {
	args := m.Called(countAll)
	return args.Error(0)
}
