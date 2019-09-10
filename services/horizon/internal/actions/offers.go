package actions

import (
	"context"
	"net/http"
	"net/url"

	"github.com/stellar/go/protocols/horizon"
	"github.com/stellar/go/services/horizon/internal/db2/history"
	"github.com/stellar/go/services/horizon/internal/resourceadapter"
	"github.com/stellar/go/support/errors"
	"github.com/stellar/go/support/render/hal"
)

// Just an example, not part of this file in the final version:
type BaseAction interface {
	// Ideally all below would be an annotation however Golang
	// does not have a support for annotations so we use methods instead.
	Method() string             // GET, POST, ...
	Route() string              // ex. `/operation/{id}`
	RequiresNewIngestion() bool // if true add a middleware
	Streamable() bool           // is streamable if true
	// Other methods that will be helpful with rendeing
}

type ObjectAction interface {
	BaseAction
	GetObject(url url.URL) (hal.Pageable, error)
}

type PageAction interface {
	BaseAction
	GetPage(url url.URL) ([]hal.Pageable, error)
}

// This is just for an example. If our action is custom (we don't
// return []hal.Pageable or hal.Pageable), Handler/Action can implement
// http.Handler so it will be responsible for full rendering of the response.
// I think we currently have 3-4 actions like this in Horizon.
type CustomAction interface {
	BaseAction
	http.Handler
}

// Above: Just an example, not part of this file in the final version
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

// GetOffersHandler is the http handler for the /offers endpoint.
// Implements BaseAction and PageAction.
type GetOffersHandler struct {
	// We can build helper structs to embed here to prevent Method()
	// duplication. Ex: `util.GetHandler` that implements:
	// Method() string { return http.MethodGet }
	HistoryQ *history.Q
}

func (handler GetOffersHandler) Method() string {
	return http.MethodGet
}

func (handler GetOffersHandler) Route() string {
	return "/offers"
}

func (handler GetOffersHandler) Streamable() bool {
	return true
}

// This probably belongs to protocols/horizon
type GetOffersParams struct {
	Cursor int64 `name:"cursor", validate:"cursor"`
	Limit  int   `name:"limit", validate:"limit"`
	Order  Order `name:"order", validate:"order"`
}

func (handler GetOffersHandler) GetPage(url url.URL) ([]hal.Pageable, error) {
	var params horizon.GetOffersParams
	// util.ParseQuery is using reflection to fill GetOffersParams using
	// struct tags. This is automating code like:
	// `seller, err := GetString(r, "seller")`
	// and can be part of a shared package so any app can use it.
	err := util.ParseQuery(&params, url)
	if err != nil {
		return nil, errors.Wrap(err, "error parsing a query")
	}

	records, err := handler.HistoryQ.GetOffers(history.OffersQuery{
		PageQuery: params.PageQuery,
		SellerID:  params.SellerID,
		Selling:   params.Selling,
		Buying:    params.Buying,
	})

	if err != nil {
		return nil, err
	}

	return buildOffersResponse(ctx, handler.HistoryQ, records)
}

// This is not a method on GetOffersHandler so other actions rendering
// offers (ex. offers for account) can use it.
func buildOffersResponse(ctx context.Context, historyQ *history.Q, records []history.Offer) ([]horizon.Offer, error) {
	ledgerCache := history.LedgerCache{}
	for _, record := range records {
		ledgerCache.Queue(int32(record.LastModifiedLedger))
	}

	err := ledgerCache.Load(historyQ)

	if err != nil {
		return nil, errors.Wrap(err, "failed to load ledger batch")
	}

	var offers []horizon.Offer
	for _, record := range records {
		var offerResponse horizon.Offer

		ledger, found := ledgerCache.Records[int32(record.LastModifiedLedger)]
		ledgerPtr := &ledger
		if !found {
			ledgerPtr = nil
		}

		resourceadapter.PopulateHistoryOffer(ctx, &offerResponse, record, ledgerPtr)
		offers = append(offers, offerResponse)
	}

	return offers, nil
}
