-- +migrate Up

ALTER TABLE history_operation_participants ADD COLUMN payment boolean DEFAULT NULL;
ALTER TABLE history_operation_participants ADD COLUMN successful boolean DEFAULT NULL;
ALTER TABLE history_transaction_participants ADD COLUMN successful boolean DEFAULT NULL;

-- +migrate Down

ALTER TABLE history_operation_participants DROP COLUMN payment;
ALTER TABLE history_operation_participants DROP COLUMN successful;
ALTER TABLE history_transaction_participants DROP COLUMN successful;