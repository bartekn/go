package history

import (
	"github.com/stellar/go/xdr"
	"github.com/stretchr/testify/mock"
)

// MockOperationParticipantBatchInsertBuilder OperationParticipantBatchInsertBuilder mock
type MockOperationParticipantBatchInsertBuilder struct {
	mock.Mock
}

// Add mock
func (m *MockOperationParticipantBatchInsertBuilder) Add(operationID int64, accountID int64, successful bool, opType xdr.OperationType) error {
	a := m.Called(operationID, accountID, successful, opType)
	return a.Error(0)
}

// Exec mock
func (m *MockOperationParticipantBatchInsertBuilder) Exec() error {
	a := m.Called()
	return a.Error(0)
}
