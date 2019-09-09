package actions

import (
	"context"
	"net/http"

	"github.com/stellar/go/protocols/horizon"
	"github.com/stellar/go/services/horizon/internal/db2"
	"github.com/stellar/go/services/horizon/internal/db2/history"
	"github.com/stellar/go/services/horizon/internal/render/sse"
	"github.com/stellar/go/services/horizon/internal/resourceadapter"
	"github.com/stellar/go/support/errors"
	"github.com/stellar/go/support/render/hal"
	"github.com/stellar/go/support/render/httpjson"
	"github.com/stellar/go/support/render/problem"
	"github.com/stellar/go/xdr"
)

// GetOffersHandler is the http handler for the /offers endpoint
type GetOffersHandler struct {
	HistoryQ *history.Q
}

// ServeHTTP implements the http.Handler interface
func (handler GetOffersHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()
	pq, err := GetPageQuery(r)

	if err != nil {
		problem.Render(ctx, w, err)
		return
	}

	seller, err := GetString(r, "seller")

	if err != nil {
		problem.Render(ctx, w, err)
		return
	}

	var selling *xdr.Asset
	sellingAsset, found := MaybeGetAsset(r, "selling_")

	if found {
		selling = &sellingAsset
	}

	var buying *xdr.Asset
	buyingAsset, found := MaybeGetAsset(r, "buying_")

	if found {
		buying = &buyingAsset
	}

	query := history.OffersQuery{
		PageQuery: pq,
		SellerID:  seller,
		Selling:   selling,
		Buying:    buying,
	}

	offers, err := loadOffersQuery(ctx, handler.HistoryQ, query)

	if err != nil {
		problem.Render(ctx, w, err)
		return
	}

	httpjson.Render(
		w,
		buildOffersPage(ctx, query.PageQuery, offers),
		httpjson.HALJSON,
	)

}

// GetAccountOffersHandler is the http handler for the
// `/accounts/{account_id}/offers` endpoint when using experimental ingestion.
type GetAccountOffersHandler struct {
	HistoryQ      *history.Q
	StreamHandler StreamHandler
}

func (handler GetAccountOffersHandler) parseOffersQuery(w http.ResponseWriter, r *http.Request) (history.OffersQuery, error) {
	pq, err := GetPageQuery(r)
	if err != nil {
		return history.OffersQuery{}, err
	}

	seller, err := GetString(r, "account_id")
	if err != nil {
		return history.OffersQuery{}, err
	}

	query := history.OffersQuery{
		PageQuery: pq,
		SellerID:  seller,
	}

	return query, nil
}

// GetOffers loads and renders an account's offers page.
func (handler GetAccountOffersHandler) GetOffers(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()
	query, err := handler.parseOffersQuery(w, r)

	if err != nil {
		problem.Render(ctx, w, err)
		return
	}

	offers, err := loadOffersQuery(ctx, handler.HistoryQ, query)

	if err != nil {
		problem.Render(ctx, w, err)
		return
	}

	httpjson.Render(
		w,
		buildOffersPage(ctx, query.PageQuery, offers),
		httpjson.HALJSON,
	)
}

// StreamOffers loads and renders an account's offers via SSE.
func (handler GetAccountOffersHandler) StreamOffers(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()
	query, err := handler.parseOffersQuery(w, r)
	if err != nil {
		problem.Render(ctx, w, err)
		return
	}

	handler.StreamHandler.ServeStream(
		w,
		r,
		int(query.PageQuery.Limit),
		func() ([]sse.Event, error) {
			offers, err := loadOffersQuery(ctx, handler.HistoryQ, query)
			if err != nil {
				return nil, err
			}

			var events []sse.Event
			for _, offer := range offers {
				events = append(events, sse.Event{ID: offer.PagingToken(), Data: offer})
			}

			if len(events) > 0 {
				query.PageQuery.Cursor = events[len(events)-1].ID
			}

			return events, nil
		},
	)
}

func loadOffersQuery(ctx context.Context, historyQ *history.Q, query history.OffersQuery) ([]horizon.Offer, error) {
	records, err := historyQ.GetOffers(query)

	if err != nil {
		return []horizon.Offer{}, err
	}

	offers, err := buildOffersResponse(ctx, historyQ, records)

	return offers, err
}

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

func buildOffersPage(
	ctx context.Context,
	pageQuery db2.PageQuery,
	offers []horizon.Offer,
) hal.Page {
	page := hal.Page{
		Cursor: pageQuery.Cursor,
		Order:  pageQuery.Order,
		Limit:  pageQuery.Limit,
	}

	for _, offer := range offers {
		page.Add(offer)
	}

	page.FullURL = FullURL(ctx)
	page.PopulateLinks()
	return page
}
