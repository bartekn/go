package cmd

import (
	"database/sql"
	"log"
	"os"
	"strconv"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
	"github.com/stellar/go/services/horizon/internal/db2/schema"
)

// type reingestType int

// const (
// 	byAll reingestType = iota
// 	byRange
// 	bySeq
// 	byOutdated
// )

var dbCmd = &cobra.Command{
	Use:   "db [command]",
	Short: "commands to manage horizon's postgres db",
}

var dbInitCmd = &cobra.Command{
	Use:   "init",
	Short: "install schema",
	Long:  "init initializes the postgres database used by horizon.",
	Run: func(cmd *cobra.Command, args []string) {
		db, err := sql.Open("postgres", viper.GetString("db-url"))
		if err != nil {
			log.Fatal(err)
		}

		numMigrationsRun, err := schema.Migrate(db, schema.MigrateUp, 0)
		if err != nil {
			log.Fatal(err)
		}

		if numMigrationsRun == 0 {
			log.Println("No migrations applied.")
		} else {
			log.Printf("Successfully applied %d migrations.\n", numMigrationsRun)
		}
	},
}

var dbMigrateCmd = &cobra.Command{
	Use:   "migrate [up|down|redo] [COUNT]",
	Short: "migrate schema",
	Long:  "performs a schema migration command",
	Run: func(cmd *cobra.Command, args []string) {
		// Allow invokations with 1 or 2 args.  All other args counts are erroneous.
		if len(args) < 1 || len(args) > 2 {
			cmd.Usage()
			os.Exit(1)
		}

		dir := schema.MigrateDir(args[0])
		count := 0

		// If a second arg is present, parse it to an int and use it as the count
		// argument to the migration call.
		if len(args) == 2 {
			var err error
			count, err = strconv.Atoi(args[1])
			if err != nil {
				log.Println(err)
				cmd.Usage()
				os.Exit(1)
			}
		}

		db, err := sql.Open("postgres", viper.GetString("db-url"))
		if err != nil {
			log.Fatal(err)
		}
		pingDB(db)

		numMigrationsRun, err := schema.Migrate(db, dir, count)
		if err != nil {
			log.Fatal(err)
		}

		if numMigrationsRun == 0 {
			log.Println("No migrations applied.")
		} else {
			log.Printf("Successfully applied %d migrations.\n", numMigrationsRun)
		}
	},
}

var dbReapCmd = &cobra.Command{
	Use:   "reap",
	Short: "reaps (i.e. removes) any reapable history data",
	Long:  "reap removes any historical data that is earlier than the configured retention cutoff",
	Run: func(cmd *cobra.Command, args []string) {
		err := initApp().DeleteUnretainedHistory()
		if err != nil {
			log.Fatal(err)
		}
	},
}

var dbReingestCmd = &cobra.Command{
	Use:   "reingest [Ledger sequence numbers (leave it empty for reingesting from the very beginning)]",
	Short: "reingest all ledgers or ledgers specified by individual sequence numbers",
	Long:  "reingest runs the ingestion pipeline over every ledger or ledgers specified by individual sequence numbers",
	Run: func(cmd *cobra.Command, args []string) {
		// TODO
		// if len(args) == 0 {
		// 	reingest(byAll)
		// } else {
		// 	argsInt32 := make([]int32, 0, len(args))
		// 	for _, arg := range args {
		// 		seq, err := strconv.Atoi(arg)
		// 		if err != nil {
		// 			cmd.Usage()
		// 			log.Fatalf(`Invalid sequence number "%s"`, arg)
		// 		}
		// 		argsInt32 = append(argsInt32, int32(seq))
		// 	}

		// 	reingest(bySeq, argsInt32...)
		// }
	},
}

var dbReingestRangeCmd = &cobra.Command{
	Use:   "range [Start sequence number] [End sequence number]",
	Short: "reingests ledgers within a range",
	Long:  "reingests ledgers between X and Y sequence number (closed intervals)",
	Run: func(cmd *cobra.Command, args []string) {
		// TODO
		// if len(args) != 2 {
		// 	cmd.Usage()
		// 	os.Exit(1)
		// }

		// argsInt32 := make([]int32, 0, len(args))
		// for _, arg := range args {
		// 	seq, err := strconv.Atoi(arg)
		// 	if err != nil {
		// 		cmd.Usage()
		// 		log.Fatalf(`Invalid sequence number "%s"`, arg)
		// 	}
		// 	argsInt32 = append(argsInt32, int32(seq))
		// }

		// reingest(byRange, argsInt32...)
	},
}

func init() {
	rootCmd.AddCommand(dbCmd)
	dbCmd.AddCommand(
		dbInitCmd,
		dbMigrateCmd,
		dbReapCmd,
		dbReingestCmd,
	)
	dbReingestCmd.AddCommand(dbReingestRangeCmd)
}
