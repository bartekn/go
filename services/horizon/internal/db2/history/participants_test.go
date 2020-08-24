package history

import (
	"testing"

	sq "github.com/Masterminds/squirrel"
	"github.com/stellar/go/services/horizon/internal/test"
)

type transactionParticipant struct {
	TransactionID int64 `db:"history_transaction_id"`
	AccountID     int64 `db:"history_account_id"`
	Successful    bool  `db:"successful"`
}

func getTransactionParticipants(tt *test.T, q *Q) []transactionParticipant {
	var participants []transactionParticipant
	sql := sq.Select("history_transaction_id", "history_account_id", "successful").
		From("history_transaction_participants").
		OrderBy("(history_transaction_id, history_account_id) asc")

	err := q.Select(&participants, sql)
	if err != nil {
		tt.T.Fatal(err)
	}

	return participants
}

func TestTransactionParticipantsBatch(t *testing.T) {
	tt := test.Start(t)
	defer tt.Finish()
	test.ResetHorizonDB(t, tt.HorizonDB)
	q := &Q{tt.HorizonSession()}

	batch := q.NewTransactionParticipantsBatchInsertBuilder(0)

	transactionID := int64(1)
	otherTransactionID := int64(2)
	accountID := int64(100)

	for i := int64(0); i < 3; i++ {
		successful := true
		if i%2 == 0 {
			successful = false
		}
		tt.Assert.NoError(batch.Add(transactionID, accountID+i, successful))
	}

	tt.Assert.NoError(batch.Add(otherTransactionID, accountID, true))
	tt.Assert.NoError(batch.Exec())

	participants := getTransactionParticipants(tt, q)
	tt.Assert.Equal(
		[]transactionParticipant{
			transactionParticipant{TransactionID: 1, AccountID: 100, Successful: false},
			transactionParticipant{TransactionID: 1, AccountID: 101, Successful: true},
			transactionParticipant{TransactionID: 1, AccountID: 102, Successful: false},
			transactionParticipant{TransactionID: 2, AccountID: 100, Successful: true},
		},
		participants,
	)
}
