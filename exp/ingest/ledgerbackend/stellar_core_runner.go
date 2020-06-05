package ledgerbackend

import (
	"fmt"
	"io"
	"io/ioutil"
	"math/rand"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"time"

	"github.com/pkg/errors"
)

type stellarCoreRunnerInterface interface {
	catchup(from, to uint32) error
	runFrom(from uint32) error
	getLogFilePath() string
	getMetaPipe() io.Reader
	close() error
}

type stellarCoreRunner struct {
	executablePath    string
	networkPassphrase string
	historyURLs       []string

	cmd      *exec.Cmd
	metaPipe io.Reader
	tempDir  string
}

func (r *stellarCoreRunner) getConf() string {
	lines := []string{
		"# Generated file -- do not edit",
		fmt.Sprintf(`NETWORK_PASSPHRASE="%s"`, r.networkPassphrase),
		fmt.Sprintf(`BUCKET_DIR_PATH="%s"`, filepath.Join(r.getTmpDir(), "buckets")),
		fmt.Sprintf(`METADATA_OUTPUT_STREAM="%s"`, r.getPipeName()),
		// "RUN_STANDALONE=true",
		"NODE_IS_VALIDATOR=false",
		// "DISABLE_XDR_FSYNC=true",
		`DATABASE="postgresql://dbname=core host=localhost user=Bartek"`,

		`
[[HOME_DOMAINS]]
HOME_DOMAIN="testnet.stellar.org"
QUALITY="HIGH"

[[VALIDATORS]]
NAME="sdf_testnet_1"
HOME_DOMAIN="testnet.stellar.org"
PUBLIC_KEY="GDKXE2OZMJIPOSLNA6N6F2BVCI3O777I2OOC4BV7VOYUEHYX7RTRYA7Y"
ADDRESS="core-testnet1.stellar.org"
HISTORY="curl -sf http://history.stellar.org/prd/core-testnet/core_testnet_001/{0} -o {1}"

[[VALIDATORS]]
NAME="sdf_testnet_2"
HOME_DOMAIN="testnet.stellar.org"
PUBLIC_KEY="GCUCJTIYXSOXKBSNFGNFWW5MUQ54HKRPGJUTQFJ5RQXZXNOLNXYDHRAP"
ADDRESS="core-testnet2.stellar.org"
HISTORY="curl -sf http://history.stellar.org/prd/core-testnet/core_testnet_002/{0} -o {1}"

[[VALIDATORS]]
NAME="sdf_testnet_3"
HOME_DOMAIN="testnet.stellar.org"
PUBLIC_KEY="GC2V2EFSXN6SQTWVYA5EPJPBWWIMSD2XQNKUOHGEKB535AQE2I6IXV2Z"
ADDRESS="core-testnet3.stellar.org"
HISTORY="curl -sf http://history.stellar.org/prd/core-testnet/core_testnet_003/{0} -o {1}"

`,
	}
	for i, val := range r.historyURLs {
		lines = append(lines, fmt.Sprintf("[HISTORY.h%d]", i))
		lines = append(lines, fmt.Sprintf(`get="curl -sf %s/{0} -o {1}"`, val))
	}
	return strings.ReplaceAll(strings.Join(lines, "\n"), "\\", "\\\\")
}

func (r *stellarCoreRunner) getConfFileName() string {
	return filepath.Join(r.getTmpDir(), "stellar-core.conf")
}

func (r *stellarCoreRunner) getLogLineWriter() (io.Writer, error) {
	f, err := os.OpenFile(r.getLogFilePath(), os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		return nil, errors.Wrap(err, "error creating a stellar-core.log file")
	}
	return f, nil
}

func (r *stellarCoreRunner) getLogFilePath() string {
	return fmt.Sprintf("%s/stellar-core.log", r.getTmpDir())
}

func (r *stellarCoreRunner) getTmpDir() string {
	if r.tempDir != "" {
		return r.tempDir
	}
	random := rand.New(rand.NewSource(time.Now().UnixNano()))
	r.tempDir = filepath.Join(os.TempDir(), fmt.Sprintf("captive-stellar-core-%x", random.Uint64()))
	return r.tempDir
}

// Makes the temp directory and writes the config file to it; called by the
// platform-specific captiveStellarCore.Start() methods.
func (r *stellarCoreRunner) writeConf() error {
	dir := r.getTmpDir()
	err := os.MkdirAll(dir, 0755)
	if err != nil {
		return errors.Wrap(err, "error creating subprocess tmpdir")
	}
	conf := r.getConf()
	return ioutil.WriteFile(r.getConfFileName(), []byte(conf), 0644)
}

func (r *stellarCoreRunner) catchup(from, to uint32) error {
	err := r.writeConf()
	if err != nil {
		return errors.Wrap(err, "error writing configuration")
	}

	// new-db
	cmd := exec.Command(r.executablePath, []string{"--conf", r.getConfFileName(), "new-db"}...)
	err = cmd.Start()
	if err != nil {
		return errors.Wrap(err, "error starting `stellar-core new-db` subprocess")
	}
	cmd.Dir = r.getTmpDir()
	writer, err := r.getLogLineWriter()
	if err != nil {
		return errors.Wrap(err, "error creating a log writer")
	}
	cmd.Stdout = writer
	cmd.Stderr = writer
	err = cmd.Wait()
	if err != nil {
		return errors.Wrap(err, "error waiting for `stellar-core new-db` subprocess")
	}

	rangeArg := fmt.Sprintf("%d/%d", to, to-from+1)
	args := []string{"--conf", r.getConfFileName(), "catchup", rangeArg, "--replay-in-memory"}
	cmd = exec.Command(r.executablePath, args...)
	cmd.Dir = r.getTmpDir()
	cmd.Stdout = writer
	cmd.Stderr = writer
	r.cmd = cmd
	r.metaPipe, err = r.start()
	if err != nil {
		return errors.Wrap(err, "error starting `stellar-core run` subprocess")
	}

	return nil
}

func (r *stellarCoreRunner) runFrom(from uint32) error {
	err := r.writeConf()
	if err != nil {
		return errors.Wrap(err, "error writing configuration")
	}

	// new-db
	cmd := exec.Command(r.executablePath, []string{"--conf", r.getConfFileName(), "new-db"}...)
	err = cmd.Start()
	if err != nil {
		return errors.Wrap(err, "error starting `stellar-core new-db` subprocess")
	}
	cmd.Dir = r.getTmpDir()
	writer, err := r.getLogLineWriter()
	if err != nil {
		return errors.Wrap(err, "error creating a log writer")
	}
	cmd.Stdout = writer
	cmd.Stderr = writer
	err = cmd.Wait()
	if err != nil {
		return errors.Wrap(err, "error waiting for `stellar-core new-db` subprocess")
	}

	// catchup to `from` ledger
	cmd = exec.Command(r.executablePath, []string{
		"--conf", r.getConfFileName(),
		"catchup", fmt.Sprintf("%d/0", from-1),
	}...)
	cmd.Dir = r.getTmpDir()
	cmd.Stdout = writer
	cmd.Stderr = writer
	err = cmd.Start()
	if err != nil {
		return errors.Wrapf(err, "error starting `stellar-core catchup %d/0` subprocess", from-1)
	}
	err = cmd.Wait()
	if err != nil {
		return errors.Wrapf(err, "error waiting for `stellar-core catchup %d/0` subprocess", from-1)
	}

	args := []string{"--conf", r.getConfFileName(), "run"}
	cmd = exec.Command(r.executablePath, args...)
	cmd.Dir = r.getTmpDir()
	// In order to get the full stellar core logs:
	logWriter, err := r.getLogLineWriter()
	if err != nil {
		return errors.Wrap(err, "error creting log writer")
	}
	cmd.Stdout = logWriter
	cmd.Stderr = logWriter
	r.cmd = cmd
	r.metaPipe, err = r.start()
	if err != nil {
		return errors.Wrap(err, "error starting `stellar-core run` subprocess")
	}

	return nil
}

func (r *stellarCoreRunner) getMetaPipe() io.Reader {
	return r.metaPipe
}

func (r *stellarCoreRunner) close() error {
	var err1, err2 error

	if r.processIsAlive() {
		err1 = r.cmd.Process.Kill()
		r.cmd.Wait()
		r.cmd = nil
	}
	err2 = os.RemoveAll(r.getTmpDir())
	if err1 != nil {
		return errors.Wrap(err1, "error killing subprocess")
	}
	if err2 != nil {
		return errors.Wrap(err2, "error removing subprocess tmpdir")
	}
	return nil
}
