package cmd

import (
	"go/types"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
	"github.com/stellar/go/exp/orderbook"
	"github.com/stellar/go/services/horizon/internal/expingest"
	support "github.com/stellar/go/support/config"
	"github.com/stellar/go/support/db"
	"github.com/stellar/go/support/historyarchive"
	"github.com/stellar/go/support/log"
)

var ingestCmd = &cobra.Command{
	Use:   "expingest",
	Short: "ingestion related commands",
}

var ingestVerifyFrom, ingestVerifyTo uint32

var ingestVerifyCmdOpts = []*support.ConfigOption{
	&support.ConfigOption{
		Name:        "from",
		ConfigKey:   &ingestVerifyFrom,
		OptType:     types.Uint32,
		Required:    true,
		FlagDefault: uint32(0),
		Usage:       "first ledger of the range to ingest",
	},
	&support.ConfigOption{
		Name:        "to",
		ConfigKey:   &ingestVerifyTo,
		OptType:     types.Uint32,
		Required:    true,
		FlagDefault: uint32(0),
		Usage:       "last ledger of the range to ingest",
	},
}

var ingestVerifyCmd = &cobra.Command{
	Use:   "verify-state",
	Short: "runs ingestion pipeline within a range",
	Long:  "runs ingestion pipeline between X and Y sequence number (inclusive)",
	Run: func(cmd *cobra.Command, args []string) {
		for _, co := range ingestVerifyCmdOpts {
			co.Require()
			co.SetValue()
		}

		initRootConfig()

		coreSession, err := db.Open("postgres", config.StellarCoreDatabaseURL)
		if err != nil {
			log.Fatalf("cannot open Core DB: %v", err)
		}

		horizonSession, err := db.Open("postgres", config.DatabaseURL)
		if err != nil {
			log.Fatalf("cannot open Horizon DB: %v", err)
		}

		if !historyarchive.IsCheckpoint(ingestVerifyFrom) || !historyarchive.IsCheckpoint(ingestVerifyTo) {
			log.Fatal("`from` and `to` must be checkpoint ledgers")
		}

		ingestConfig := expingest.Config{
			CoreSession:       coreSession,
			HistorySession:    horizonSession,
			HistoryArchiveURL: config.HistoryArchiveURLs[0],
			OrderBookGraph:    orderbook.NewOrderBookGraph(),
		}

		err = expingest.VerifyStateRange(ingestVerifyFrom, ingestVerifyTo, ingestConfig)
		if err != nil {
			log.Fatal(err)
		}

		log.Info("Range successfully verified!")
	},
}

func init() {
	for _, co := range ingestVerifyCmdOpts {
		err := co.Init(ingestVerifyCmd)
		if err != nil {
			log.Fatal(err.Error())
		}
	}

	viper.BindPFlags(ingestVerifyCmd.PersistentFlags())

	rootCmd.AddCommand(ingestCmd)
	ingestCmd.AddCommand(ingestVerifyCmd)
}
