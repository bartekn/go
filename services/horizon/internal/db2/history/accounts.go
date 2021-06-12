package history

import (
	"context"

	sq "github.com/Masterminds/squirrel"
	"github.com/guregu/null"
	"github.com/lib/pq"

	"github.com/stellar/go/services/horizon/internal/db2"
	"github.com/stellar/go/support/db"
	"github.com/stellar/go/support/errors"
	"github.com/stellar/go/xdr"
)

// IsAuthRequired returns true if the account has the "AUTH_REQUIRED" option
// turned on.
func (account AccountEntry) IsAuthRequired() bool {
	return xdr.AccountFlags(account.Flags).IsAuthRequired()
}

// IsAuthRevocable returns true if the account has the "AUTH_REVOCABLE" option
// turned on.
func (account AccountEntry) IsAuthRevocable() bool {
	return xdr.AccountFlags(account.Flags).IsAuthRevocable()
}

// IsAuthImmutable returns true if the account has the "AUTH_IMMUTABLE" option
// turned on.
func (account AccountEntry) IsAuthImmutable() bool {
	return xdr.AccountFlags(account.Flags).IsAuthImmutable()
}

// IsAuthClawbackEnabled returns true if the account has the "AUTH_CLAWBACK_ENABLED" option
// turned on.
func (account AccountEntry) IsAuthClawbackEnabled() bool {
	return xdr.AccountFlags(account.Flags).IsAuthClawbackEnabled()
}

func (q *Q) CountAccounts(ctx context.Context) (int, error) {
	sql := sq.Select("count(*)").From("accounts")

	var count int
	if err := q.Get(ctx, &count, sql); err != nil {
		return 0, errors.Wrap(err, "could not run select query")
	}

	return count, nil
}

func (q *Q) GetAccountByID(ctx context.Context, id string) (AccountEntry, error) {
	var account AccountEntry
	sql := selectAccounts.Where(sq.Eq{"account_id": id})
	err := q.Get(ctx, &account, sql)
	return account, err
}

func (q *Q) GetAccountsByIDs(ctx context.Context, ids []string) ([]AccountEntry, error) {
	var accounts []AccountEntry
	sql := selectAccounts.Where(map[string]interface{}{"accounts.account_id": ids})
	err := q.Select(ctx, &accounts, sql)
	return accounts, err
}

type AccountObj struct {
	AccountID            string
	InflationDestination string
	HomeDomain           xdr.String32
	Balance              xdr.Int64
	BuyingLiabilities    xdr.Int64
	SellingLiabilities   xdr.Int64
	SequenceNumber       xdr.SequenceNumber
	NumSubEntries        xdr.Uint32
	Flags                xdr.Uint32
	LastModifiedLedger   xdr.Uint32
	NumSponsored         xdr.Uint32
	NumSponsoring        xdr.Uint32
	MasterWeight         uint8
	ThresholdLow         uint8
	ThresholdMedium      uint8
	ThresholdHigh        uint8
	Sponsor              null.String
}

func accountToMap(entry xdr.LedgerEntry) AccountObj {
	account := entry.Data.MustAccount()
	liabilities := account.Liabilities()

	var inflationDestination = ""
	if account.InflationDest != nil {
		inflationDestination = account.InflationDest.Address()
	}

	return AccountObj{
		AccountID:            account.AccountId.Address(),
		Balance:              account.Balance,
		BuyingLiabilities:    liabilities.Buying,
		SellingLiabilities:   liabilities.Selling,
		SequenceNumber:       account.SeqNum,
		NumSubEntries:        account.NumSubEntries,
		InflationDestination: inflationDestination,
		Flags:                account.Flags,
		HomeDomain:           account.HomeDomain,
		MasterWeight:         account.MasterKeyWeight(),
		ThresholdLow:         account.ThresholdLow(),
		ThresholdMedium:      account.ThresholdMedium(),
		ThresholdHigh:        account.ThresholdHigh(),
		LastModifiedLedger:   entry.LastModifiedLedgerSeq,
		Sponsor:              ledgerEntrySponsorToNullString(entry),
		NumSponsored:         account.NumSponsored(),
		NumSponsoring:        account.NumSponsoring(),
	}
}

// UpsertAccounts upserts a batch of accounts in the accounts table.
// There's currently no limit of the number of accounts this method can
// accept other than 2GB limit of the query string length what should be enough
// for each ledger with the current limits.
func (q *Q) UpsertAccounts(ctx context.Context, accounts []xdr.LedgerEntry) error {
	var accountID = make([]string, 0, len(accounts))
	var inflationDestination = make([]string, 0, len(accounts))
	var homeDomain = make([]xdr.String32, 0, len(accounts))
	var balance = make([]xdr.Int64, 0, len(accounts))
	var buyingLiabilities = make([]xdr.Int64, 0, len(accounts))
	var sellingLiabilities = make([]xdr.Int64, 0, len(accounts))
	var sequenceNumber = make([]xdr.SequenceNumber, 0, len(accounts))
	var numSubEntries = make([]xdr.Uint32, 0, len(accounts))
	var flags = make([]xdr.Uint32, 0, len(accounts))
	var lastModifiedLedger = make([]xdr.Uint32, 0, len(accounts))
	var numSponsored = make([]xdr.Uint32, 0, len(accounts))
	var numSponsoring = make([]xdr.Uint32, 0, len(accounts))
	var masterWeight = make([]uint8, 0, len(accounts))
	var thresholdLow = make([]uint8, 0, len(accounts))
	var thresholdMedium = make([]uint8, 0, len(accounts))
	var thresholdHigh = make([]uint8, 0, len(accounts))
	var sponsor = make([]null.String, 0, len(accounts))

	for _, entry := range accounts {
		if entry.Data.Type != xdr.LedgerEntryTypeAccount {
			return errors.Errorf("Invalid entry type: %d", entry.Data.Type)
		}

		m := accountToMap(entry)
		accountID = append(accountID, m.AccountID)
		balance = append(balance, m.Balance)
		buyingLiabilities = append(buyingLiabilities, m.BuyingLiabilities)
		sellingLiabilities = append(sellingLiabilities, m.SellingLiabilities)
		sequenceNumber = append(sequenceNumber, m.SequenceNumber)
		numSubEntries = append(numSubEntries, m.NumSubEntries)
		inflationDestination = append(inflationDestination, m.InflationDestination)
		flags = append(flags, m.Flags)
		homeDomain = append(homeDomain, m.HomeDomain)
		masterWeight = append(masterWeight, m.MasterWeight)
		thresholdLow = append(thresholdLow, m.ThresholdLow)
		thresholdMedium = append(thresholdMedium, m.ThresholdMedium)
		thresholdHigh = append(thresholdHigh, m.ThresholdHigh)
		lastModifiedLedger = append(lastModifiedLedger, m.LastModifiedLedger)
		sponsor = append(sponsor, m.Sponsor)
		numSponsored = append(numSponsored, m.NumSponsored)
		numSponsoring = append(numSponsoring, m.NumSponsoring)
	}

	sql := `
	WITH r AS
		(SELECT
			unnest(?::text[]),   /* account_id */
			unnest(?::bigint[]), /*	balance */
			unnest(?::bigint[]), /*	buying_liabilities */
			unnest(?::bigint[]), /*	selling_liabilities */
			unnest(?::bigint[]), /*	sequence_number */
			unnest(?::int[]),    /*	num_subentries */
			unnest(?::text[]),   /*	inflation_destination */
			unnest(?::int[]),    /*	flags */
			unnest(?::text[]),   /*	home_domain */
			unnest(?::int[]),    /*	master_weight */
			unnest(?::int[]),    /*	threshold_low */
			unnest(?::int[]),    /*	threshold_medium */
			unnest(?::int[]),    /*	threshold_high */
			unnest(?::int[]),    /*	last_modified_ledger */
			unnest(?::text[]),   /*	sponsor */
			unnest(?::int[]),    /*	num_sponsored */
			unnest(?::int[])     /*	num_sponsoring */
		)
	INSERT INTO accounts ( 
		account_id,
		balance,
		buying_liabilities,
		selling_liabilities,
		sequence_number,
		num_subentries,
		inflation_destination,
		flags,
		home_domain,
		master_weight,
		threshold_low,
		threshold_medium,
		threshold_high,
		last_modified_ledger,
		sponsor,
		num_sponsored,
		num_sponsoring
	)
	SELECT * from r 
	ON CONFLICT (account_id) DO UPDATE SET 
		account_id = excluded.account_id,
		balance = excluded.balance,
		buying_liabilities = excluded.buying_liabilities,
		selling_liabilities = excluded.selling_liabilities,
		sequence_number = excluded.sequence_number,
		num_subentries = excluded.num_subentries,
		inflation_destination = excluded.inflation_destination,
		flags = excluded.flags,
		home_domain = excluded.home_domain,
		master_weight = excluded.master_weight,
		threshold_low = excluded.threshold_low,
		threshold_medium = excluded.threshold_medium,
		threshold_high = excluded.threshold_high,
		last_modified_ledger = excluded.last_modified_ledger,
		sponsor = excluded.sponsor,
		num_sponsored = excluded.num_sponsored,
		num_sponsoring = excluded.num_sponsoring`

	_, err := q.ExecRaw(
		context.WithValue(ctx, &db.QueryTypeContextKey, db.UpsertQueryType),
		sql,
		pq.Array(accountID),
		pq.Array(balance),
		pq.Array(buyingLiabilities),
		pq.Array(sellingLiabilities),
		pq.Array(sequenceNumber),
		pq.Array(numSubEntries),
		pq.Array(inflationDestination),
		pq.Array(flags),
		pq.Array(homeDomain),
		pq.Array(masterWeight),
		pq.Array(thresholdLow),
		pq.Array(thresholdMedium),
		pq.Array(thresholdHigh),
		pq.Array(lastModifiedLedger),
		pq.Array(sponsor),
		pq.Array(numSponsored),
		pq.Array(numSponsoring),
	)
	return err
}

// RemoveAccount deletes a row in the accounts table.
// Returns number of rows affected and error.
func (q *Q) RemoveAccount(ctx context.Context, accountID string) (int64, error) {
	sql := sq.Delete("accounts").Where(sq.Eq{"account_id": accountID})
	result, err := q.Exec(ctx, sql)
	if err != nil {
		return 0, err
	}

	return result.RowsAffected()
}

// AccountsForAsset returns a list of `AccountEntry` rows who are trustee to an
// asset
func (q *Q) AccountsForAsset(ctx context.Context, asset xdr.Asset, page db2.PageQuery) ([]AccountEntry, error) {
	var assetType, code, issuer string
	asset.MustExtract(&assetType, &code, &issuer)

	sql := sq.
		Select("accounts.*").
		From("accounts").
		Join("trust_lines ON accounts.account_id = trust_lines.account_id").
		Where(map[string]interface{}{
			"trust_lines.asset_type":   int32(asset.Type),
			"trust_lines.asset_issuer": issuer,
			"trust_lines.asset_code":   code,
		})

	sql, err := page.ApplyToUsingCursor(sql, "trust_lines.account_id", page.Cursor)
	if err != nil {
		return nil, errors.Wrap(err, "could not apply query to page")
	}

	var results []AccountEntry
	if err := q.Select(ctx, &results, sql); err != nil {
		return nil, errors.Wrap(err, "could not run select query")
	}

	return results, nil
}

func selectBySponsor(table, sponsor string, page db2.PageQuery) (sq.SelectBuilder, error) {
	sql := sq.
		Select("account_id").
		From(table).
		Where(map[string]interface{}{
			"sponsor": sponsor,
		})

	sql, err := page.ApplyToUsingCursor(sql, "account_id", page.Cursor)
	if err != nil {
		return sql, errors.Wrap(err, "could not apply query to page")
	}
	return sql, err
}

func selectUnionBySponsor(tables []string, sponsor string, page db2.PageQuery) (sq.SelectBuilder, error) {
	var selectIDs sq.SelectBuilder
	for i, table := range tables {
		sql, err := selectBySponsor(table, sponsor, page)
		if err != nil {
			return sql, errors.Wrap(err, "could not construct account id query")
		}
		sql = sql.Prefix("(").Suffix(")")

		if i == 0 {
			selectIDs = sql
			continue
		}

		sqlStr, args, err := sql.ToSql()
		if err != nil {
			return sql, errors.Wrap(err, "could not construct account id query")
		}
		selectIDs = selectIDs.Suffix("UNION "+sqlStr, args...)
	}

	return sq.
		Select("accounts.*").
		FromSelect(selectIDs, "accountSet").
		Join("accounts ON accounts.account_id = accountSet.account_id").
		OrderBy("accounts.account_id " + page.Order).
		Limit(page.Limit), nil
}

// AccountsForSponsor return all the accounts where `sponsor`` is sponsoring the account entry or
// any of its subentries (trust lines, signers, data, or account entry)
func (q *Q) AccountsForSponsor(ctx context.Context, sponsor string, page db2.PageQuery) ([]AccountEntry, error) {
	sql, err := selectUnionBySponsor(
		[]string{"accounts", "accounts_data", "accounts_signers", "trust_lines"},
		sponsor,
		page,
	)
	if err != nil {
		return nil, errors.Wrap(err, "could not construct accounts query")
	}

	var results []AccountEntry
	if err := q.Select(ctx, &results, sql); err != nil {
		return nil, errors.Wrap(err, "could not run select query")
	}

	return results, nil
}

// AccountEntriesForSigner returns a list of `AccountEntry` rows for a given signer
func (q *Q) AccountEntriesForSigner(ctx context.Context, signer string, page db2.PageQuery) ([]AccountEntry, error) {
	sql := sq.
		Select("accounts.*").
		From("accounts").
		Join("accounts_signers ON accounts.account_id = accounts_signers.account_id").
		Where(map[string]interface{}{
			"accounts_signers.signer": signer,
		})

	sql, err := page.ApplyToUsingCursor(sql, "accounts_signers.account_id", page.Cursor)
	if err != nil {
		return nil, errors.Wrap(err, "could not apply query to page")
	}

	var results []AccountEntry
	if err := q.Select(ctx, &results, sql); err != nil {
		return nil, errors.Wrap(err, "could not run select query")
	}

	return results, nil
}

var selectAccounts = sq.Select(`
	account_id,
	balance,
	buying_liabilities,
	selling_liabilities,
	sequence_number,
	num_subentries,
	inflation_destination,
	flags,
	home_domain,
	master_weight,
	threshold_low,
	threshold_medium,
	threshold_high,
	last_modified_ledger,
	sponsor,
	num_sponsored,
	num_sponsoring
`).From("accounts")
