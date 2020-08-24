package history

import (
	"github.com/stellar/go/support/db"
	"github.com/stellar/go/xdr"
)

// OperationParticipantBatchInsertBuilder is used to insert a transaction's operations into the
// history_operations table
type OperationParticipantBatchInsertBuilder interface {
	Add(operationID, accountID int64, successful bool, opType xdr.OperationType) error
	Exec() error
}

// operationParticipantBatchInsertBuilder is a simple wrapper around db.BatchInsertBuilder
type operationParticipantBatchInsertBuilder struct {
	builder db.BatchInsertBuilder
}

// NewOperationParticipantBatchInsertBuilder constructs a new TransactionBatchInsertBuilder instance
func (q *Q) NewOperationParticipantBatchInsertBuilder(maxBatchSize int) OperationParticipantBatchInsertBuilder {
	return &operationParticipantBatchInsertBuilder{
		builder: db.BatchInsertBuilder{
			Table:        q.GetTable("history_operation_participants"),
			MaxBatchSize: maxBatchSize,
		},
	}
}

// Add adds an operation participant to the batch
func (i *operationParticipantBatchInsertBuilder) Add(
	operationID, accountID int64, successful bool, opType xdr.OperationType,
) error {
	payment := isPaymentFamilyOperation(opType)
	return i.builder.Row(map[string]interface{}{
		"history_operation_id": operationID,
		"history_account_id":   accountID,
		"successful":           successful,
		"payment":              payment,
	})
}

func (i *operationParticipantBatchInsertBuilder) Exec() error {
	return i.builder.Exec()
}
