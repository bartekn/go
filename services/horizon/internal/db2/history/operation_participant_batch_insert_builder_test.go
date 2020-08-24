package history

import (
	"testing"

	sq "github.com/Masterminds/squirrel"
	"github.com/stellar/go/services/horizon/internal/test"
	"github.com/stellar/go/xdr"
)

func TestAddOperationParticipants(t *testing.T) {
	tt := test.Start(t)
	defer tt.Finish()
	test.ResetHorizonDB(t, tt.HorizonDB)
	q := &Q{tt.HorizonSession()}

	builder := q.NewOperationParticipantBatchInsertBuilder(1)
	err := builder.Add(240518172673, 1, false, xdr.OperationTypeManageBuyOffer)
	err = builder.Add(240518172674, 1, false, xdr.OperationTypePayment)
	err = builder.Add(240518172675, 1, true, xdr.OperationTypeManageSellOffer)
	err = builder.Add(240518172676, 1, true, xdr.OperationTypeCreateAccount)
	tt.Assert.NoError(err)

	err = builder.Exec()
	tt.Assert.NoError(err)

	type hop struct {
		OperationID int64 `db:"history_operation_id"`
		AccountID   int64 `db:"history_account_id"`
		Payment     bool  `db:"payment"`
		Successful  bool  `db:"successful"`
	}

	ops := []hop{}
	err = q.Select(&ops, sq.Select(
		"hopp.history_operation_id, hopp.history_account_id, hopp.payment, hopp.successful").
		From("history_operation_participants hopp"),
	)

	if tt.Assert.NoError(err) {
		tt.Assert.Len(ops, 4)

		var op hop

		op = ops[0]
		tt.Assert.Equal(int64(240518172673), op.OperationID)
		tt.Assert.Equal(int64(1), op.AccountID)
		tt.Assert.Equal(false, op.Successful)
		tt.Assert.Equal(false, op.Payment)

		op = ops[1]
		tt.Assert.Equal(int64(240518172674), op.OperationID)
		tt.Assert.Equal(int64(1), op.AccountID)
		tt.Assert.Equal(false, op.Successful)
		tt.Assert.Equal(true, op.Payment)

		op = ops[2]
		tt.Assert.Equal(int64(240518172675), op.OperationID)
		tt.Assert.Equal(int64(1), op.AccountID)
		tt.Assert.Equal(true, op.Successful)
		tt.Assert.Equal(false, op.Payment)

		op = ops[3]
		tt.Assert.Equal(int64(240518172676), op.OperationID)
		tt.Assert.Equal(int64(1), op.AccountID)
		tt.Assert.Equal(true, op.Successful)
		tt.Assert.Equal(true, op.Payment)
	}
}
