package ledgerbackend

import (
	"bufio"
	"context"
	"fmt"
	"io"
	"io/ioutil"
	"math/rand"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"strings"
	"time"

	"github.com/pkg/errors"
	"github.com/sirupsen/logrus"

	"github.com/stellar/go/support/log"
	"gopkg.in/tomb.v1"
)

type stellarCoreRunnerInterface interface {
	catchup(from, to uint32) error
	runFrom(from uint32, hash string) error
	getMetaPipe() io.Reader
	getTomb() *tomb.Tomb
	close() error
}

type stellarCoreRunnerMode int

const (
	stellarCoreRunnerModeOnline stellarCoreRunnerMode = iota
	stellarCoreRunnerModeOffline
)

// stellarCoreRunner is a helper for starting stellar-core. Should be used only
// once, for multiple runs create separate instances.
type stellarCoreRunner struct {
	executablePath    string
	configAppendPath  string
	networkPassphrase string
	historyURLs       []string
	httpPort          uint
	mode              stellarCoreRunnerMode

	// tomb is used to handle cmd go routine termination. Err() value can be one
	// of the following:
	//   - nil: process exit without error, not user initiated (this can be an
	//       error in layers above if they expect more data but process is done),
	//   - context.Canceled: process killed after user request,
	//   - not nil: process exit with an error.
	//
	// tomb is created when a new cmd go routine starts.
	tomb *tomb.Tomb

	cmd *exec.Cmd

	// There's a gotcha! When cmd.Wait() signal was received it doesn't mean that
	// all ledgers have been read from meta pipe. Turns out that OS actually
	// maintains a buffer. So don't rely on this. Keep reading until EOF is
	// returned.
	metaPipe io.Reader
	tempDir  string
	nonce    string

	log *log.Entry
}

func newStellarCoreRunner(config CaptiveCoreConfig, mode stellarCoreRunnerMode) (*stellarCoreRunner, error) {
	r := rand.New(rand.NewSource(time.Now().UnixNano()))
	// Create temp dir
	random := rand.New(rand.NewSource(time.Now().UnixNano()))
	tempDir := filepath.Join(os.TempDir(), fmt.Sprintf("captive-stellar-core-%x", random.Uint64()))
	err := os.MkdirAll(tempDir, 0755)
	if err != nil {
		return nil, errors.Wrap(err, "error creating subprocess tmpdir")
	}

	coreLogger := config.Log
	if coreLogger == nil {
		coreLogger = log.New()
		coreLogger.Logger.SetOutput(os.Stdout)
		coreLogger.SetLevel(logrus.InfoLevel)
	}

	runner := &stellarCoreRunner{
		executablePath:    config.BinaryPath,
		configAppendPath:  config.ConfigAppendPath,
		networkPassphrase: config.NetworkPassphrase,
		historyURLs:       config.HistoryArchiveURLs,
		httpPort:          config.HTTPPort,
		mode:              mode,
		tempDir:           tempDir,
		nonce:             fmt.Sprintf("captive-stellar-core-%x", r.Uint64()),
		log:               coreLogger,
	}

	if err := runner.writeConf(); err != nil {
		return nil, errors.Wrap(err, "error writing configuration")
	}

	return runner, nil
}

func (r *stellarCoreRunner) generateConfig() (string, error) {
	if r.mode == stellarCoreRunnerModeOnline && r.configAppendPath == "" {
		return "", errors.New("stellar-core append config file path cannot be empty in online mode")
	}
	lines := []string{
		"# Generated file -- do not edit",
		"NODE_IS_VALIDATOR=false",
		"DISABLE_XDR_FSYNC=true",
		fmt.Sprintf(`NETWORK_PASSPHRASE="%s"`, r.networkPassphrase),
		fmt.Sprintf(`BUCKET_DIR_PATH="%s"`, filepath.Join(r.tempDir, "buckets")),
		fmt.Sprintf(`HTTP_PORT=%d`, r.httpPort),
	}

	if r.mode == stellarCoreRunnerModeOffline {
		// In offline mode, there is no need to connect to peers
		lines = append(lines, "RUN_STANDALONE=true")
		// We don't need consensus when catching up
		lines = append(lines, "UNSAFE_QUORUM=true")
	}

	if r.mode == stellarCoreRunnerModeOffline && r.configAppendPath == "" {
		// Add a fictional quorum -- necessary to convince core to start up;
		// but not used at all for our purposes. Pubkey here is just random.
		lines = append(lines,
			"[QUORUM_SET]",
			"THRESHOLD_PERCENT=100",
			`VALIDATORS=["GCZBOIAY4HLKAJVNJORXZOZRAY2BJDBZHKPBHZCRAIUR5IHC2UHBGCQR"]`)
	}

	result := strings.ReplaceAll(strings.Join(lines, "\n"), "\\", "\\\\")
	if r.configAppendPath != "" {
		appendConfigContents, err := ioutil.ReadFile(r.configAppendPath)
		if err != nil {
			return "", errors.Wrap(err, "reading quorum config file")
		}
		result = result + "\n" + string(appendConfigContents) + "\n\n"
	}

	lines = []string{}
	for i, val := range r.historyURLs {
		lines = append(lines, fmt.Sprintf("[HISTORY.h%d]", i))
		lines = append(lines, fmt.Sprintf(`get="curl -sf %s/{0} -o {1}"`, val))
	}
	result += strings.Join(lines, "\n")

	return result, nil
}

func (r *stellarCoreRunner) getConfFileName() string {
	return filepath.Join(r.tempDir, "stellar-core.conf")
}

func (r *stellarCoreRunner) getLogLineWriter() io.Writer {
	rd, wr := io.Pipe()
	br := bufio.NewReader(rd)

	// Strip timestamps from log lines from captive stellar-core. We emit our own.
	dateRx := regexp.MustCompile(`^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3} `)
	go func() {
		levelRx := regexp.MustCompile(`\[(\w+) ([A-Z]+)\] (.*)`)
		for {
			line, err := br.ReadString('\n')
			if err != nil {
				break
			}
			line = dateRx.ReplaceAllString(line, "")
			line = strings.TrimSpace(line)

			if line == "" {
				continue
			}

			matches := levelRx.FindStringSubmatch(line)
			if len(matches) >= 4 {
				// Extract the substrings from the log entry and trim it
				category, level := matches[1], matches[2]
				line = matches[3]

				levelMapping := map[string]func(string, ...interface{}){
					"FATAL":   r.log.Errorf,
					"ERROR":   r.log.Errorf,
					"WARNING": r.log.Warnf,
					"INFO":    r.log.Infof,
				}

				if writer, ok := levelMapping[strings.ToUpper(level)]; ok {
					writer("%s: %s", category, line)
				} else {
					r.log.Info(line)
				}
			} else {
				r.log.Info(line)
			}
		}
	}()
	return wr
}

// Makes the temp directory and writes the config file to it; called by the
// platform-specific captiveStellarCore.Start() methods.
func (r *stellarCoreRunner) writeConf() error {
	conf, err := r.generateConfig()
	if err != nil {
		return err
	}
	r.log.Debugf("captive core config file contents:\n%s", conf)
	return ioutil.WriteFile(r.getConfFileName(), []byte(conf), 0644)
}

func (r *stellarCoreRunner) createCmd(params ...string) (*exec.Cmd, error) {
	allParams := append([]string{"--conf", r.getConfFileName()}, params...)
	cmd := exec.Command(r.executablePath, allParams...)
	cmd.Dir = r.tempDir
	cmd.Stdout = r.getLogLineWriter()
	cmd.Stderr = r.getLogLineWriter()
	return cmd, nil
}

func (r *stellarCoreRunner) runCmd(params ...string) error {
	cmd, err := r.createCmd(params...)
	if err != nil {
		return errors.Wrapf(err, "could not create `stellar-core %v` cmd", params)
	}

	if err = cmd.Start(); err != nil {
		return errors.Wrapf(err, "could not start `stellar-core %v` cmd", params)
	}

	if err = cmd.Wait(); err != nil {
		return errors.Wrapf(err, "error waiting for `stellar-core %v` subprocess", params)
	}
	return nil
}

func (r *stellarCoreRunner) catchup(from, to uint32) error {
	if r.tomb != nil {
		return errors.New("runner already started")
	}
	if err := r.runCmd("new-db"); err != nil {
		return errors.Wrap(err, "error waiting for `stellar-core new-db` subprocess")
	}

	rangeArg := fmt.Sprintf("%d/%d", to, to-from+1)
	cmd, err := r.createCmd(
		"catchup", rangeArg,
		"--metadata-output-stream", r.getPipeName(),
		"--replay-in-memory",
	)
	if err != nil {
		return errors.Wrap(err, "error creating `stellar-core catchup` subprocess")
	}
	r.cmd = cmd
	r.tomb = new(tomb.Tomb)
	r.metaPipe, err = r.start()
	if err != nil {
		return errors.Wrap(err, "error starting `stellar-core catchup` subprocess")
	}

	return nil
}

func (r *stellarCoreRunner) runFrom(from uint32, hash string) error {
	if r.tomb != nil {
		return errors.New("runner already started")
	}
	var err error
	r.cmd, err = r.createCmd(
		"run",
		"--in-memory",
		"--start-at-ledger", fmt.Sprintf("%d", from),
		"--start-at-hash", hash,
		"--metadata-output-stream", r.getPipeName(),
	)
	if err != nil {
		return errors.Wrap(err, "error creating `stellar-core run` subprocess")
	}
	r.tomb = new(tomb.Tomb)
	r.metaPipe, err = r.start()
	if err != nil {
		return errors.Wrap(err, "error starting `stellar-core run` subprocess")
	}

	return nil
}

func (r *stellarCoreRunner) getMetaPipe() io.Reader {
	return r.metaPipe
}

func (r *stellarCoreRunner) getTomb() *tomb.Tomb {
	return r.tomb
}

func (r *stellarCoreRunner) close() error {
	var err1, err2 error

	if r.tomb != nil {
		// Kill tomb with context.Canceled. Kill will be called again in start()
		// when process exit is handled but the error value will not be overwritten.
		r.tomb.Kill(context.Canceled)
	}

	if r.processIsAlive() {
		err1 = r.cmd.Process.Kill()
	}

	if r.tomb != nil {
		r.tomb.Wait()
	}
	r.tomb = nil
	r.cmd = nil

	err2 = os.RemoveAll(r.tempDir)
	r.tempDir = ""

	if err1 != nil {
		return errors.Wrap(err1, "error killing subprocess")
	}
	if err2 != nil {
		return errors.Wrap(err2, "error removing subprocess tmpdir")
	}

	return nil
}
