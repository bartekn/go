package ledgerbackend

import (
	"bufio"
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
)

const pipeBufferSize = 1024 * 1024

type stellarCoreRunnerInterface interface {
	run(from, to uint32) error
	getMetaPipe() *bufferedPipe
	close() error
}

type stellarCoreRunner struct {
	executablePath    string
	networkPassphrase string
	historyURLs       []string

	cmd      *exec.Cmd
	metaPipe *bufferedPipe
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

		// 		`

		// NODE_NAMES=[
		// "GAOO3LWBC4XF6VWRP5ESJ6IBHAISVJMSBTALHOQM2EZG7Q477UWA6L7U  eno",
		// "GAXP5DW4CVCW2BJNPFGTWCEGZTJKTNWFQQBE5SCWNJIJ54BOHR3WQC3W  moni",
		// "GBFZFQRGOPQC5OEAWO76NOY6LBRLUNH4I5QYPUYAK53QSQWVTQ2D4FT5  dzham",
		// "GDXWQCSKVYAJSUGR2HBYVFVR7NA7YWYSYK3XYKKFO553OQGOHAUP2PX2  jianing",
		// "GCJCSMSPIWKKPR7WEPIQG63PDF7JGGEENRC33OKVBSPUDIRL6ZZ5M7OO  tempo.eu.com",
		// "GCCW4H2DKAC7YYW62H3ZBDRRE5KXRLYLI4T5QOSO6EAMUOE37ICSKKRJ  sparrow_tw",
		// "GD5DJQDDBKGAYNEAXU562HYGOOSYAEOO6AS53PZXBOZGCP5M2OPGMZV3  fuxi.lab",
		// "GBGGNBZVYNMVLCWNQRO7ASU6XX2MRPITAGLASRWOWLB4ZIIPHMGNMC4I  huang.lab",
		// "GDPJ4DPPFEIP2YTSQNOKT7NMLPKU2FFVOEIJMG36RCMBWBUR4GTXLL57  nezha.lab",
		// "GCDLFPQ76D6YUSCUECLKI3AFEVXFWVRY2RZH2YQNYII35FDECWUGV24T  SnT.Lux",
		// "GBAR4OY6T6M4P344IF5II5DNWHVUJU7OLQPSMG2FWVJAFF642BX5E3GB  telindus",
		// # non validating
		// "GCGB2S2KGYARPVIA37HYZXVRM2YZUEXA6S33ZU5BUDC6THSB62LZSTYH  sdf_watcher1",
		// "GCM6QMP3DLRPTAZW2UZPCPX2LF3SXWXKPMP3GKFZBDSF3QZGV2G5QSTK  sdf_watcher2",
		// "GABMKJM6I25XI4K7U6XWMULOUQIQ27BCTMLS6BYYSOWKTBUXVRJSXHYQ  sdf_watcher3",
		// # seem down
		// "GB6REF5GOGGSEHZ3L2YK6K4T4KX3YDMWHDCPMV7MZJDLHBDNZXEPRBGM  donovan",
		// "GBGR22MRCIVW2UZHFXMY5UIBJGPYABPQXQ5GGMNCSUM2KHE3N6CNH6G5  nelisky1",
		// "GA2DE5AQF32LU5OZ5OKAFGPA2DLW4H6JHPGYJUVTNS3W7N2YZCTQFFV6  nelisky2",
		// "GDJ73EX25GGUVMUBCK6DPSTJLYP3IC7I3H2URLXJQ5YP56BW756OUHIG  w00kie",
		// "GAM7A32QZF5PJASRSGVFPAB36WWTHCBHO5CHG3WUFTUQPT7NZX3ONJU4  ptarasov"
		// ]

		// KNOWN_PEERS=[
		// "core-live-a.stellar.org:11625",
		// "core-live-b.stellar.org:11625",
		// "core-live-c.stellar.org:11625",
		// "confucius.strllar.org",
		// "stellar1.bitventure.co",
		// "stellar.256kw.com"]

		// UNSAFE_QUORUM=true

		// [QUORUM_SET]
		// VALIDATORS=[
		// "$sdf_watcher1","$sdf_watcher2","$sdf_watcher3"
		// ]
		// `,
	}
	for i, val := range r.historyURLs {
		lines = append(lines, fmt.Sprintf("[HISTORY.h%d]", i))
		lines = append(lines, fmt.Sprintf(`get="curl -sf %s/{0} -o {1}"`, val))
	}
	// Add a fictional quorum -- necessary to convince core to start up;
	// but not used at all for our purposes. Pubkey here is just random.
	// lines = append(lines,
	// 	"[QUORUM_SET]",
	// 	"THRESHOLD_PERCENT=100",
	// 	`VALIDATORS=["GCZBOIAY4HLKAJVNJORXZOZRAY2BJDBZHKPBHZCRAIUR5IHC2UHBGCQR"]`)
	return strings.ReplaceAll(strings.Join(lines, "\n"), "\\", "\\\\")
}

func (r *stellarCoreRunner) getConfFileName() string {
	return filepath.Join(r.getTmpDir(), "stellar-core.conf")
}

func (*stellarCoreRunner) getLogLineWriter() io.Writer {
	r, w := io.Pipe()
	br := bufio.NewReader(r)
	// Strip timestamps from log lines from captive stellar-core. We emit our own.
	dateRx := regexp.MustCompile(`^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3} `)
	go func() {
		for {
			line, e := br.ReadString('\n')
			if e != nil {
				break
			}
			line = dateRx.ReplaceAllString(line, "")
			fmt.Print(line)
		}
	}()
	return w
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
	e := os.MkdirAll(dir, 0755)
	if e != nil {
		return errors.Wrap(e, "error creating subprocess tmpdir")
	}
	conf := r.getConf()
	return ioutil.WriteFile(r.getConfFileName(), []byte(conf), 0644)
}

func (r *stellarCoreRunner) run(from, to uint32) error {
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
	cmd.Stdout = r.getLogLineWriter()
	cmd.Stderr = r.getLogLineWriter()
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
	cmd.Stdout = r.getLogLineWriter()
	cmd.Stderr = r.getLogLineWriter()
	err = cmd.Start()
	if err != nil {
		return errors.Wrap(err, "error starting `stellar-core catchup X/0` subprocess")
	}
	err = cmd.Wait()
	if err != nil {
		return errors.Wrap(err, "error waiting for `stellar-core catchup X/0` subprocess")
	}

	// rangeArg := fmt.Sprintf("%d/%d", to, to-from+1)
	args := []string{"--conf", r.getConfFileName(), "run"} //, rangeArg, "--replay-in-memory"}
	cmd = exec.Command(r.executablePath, args...)
	cmd.Dir = r.getTmpDir()
	// In order to get the full stellar core logs:
	cmd.Stdout = r.getLogLineWriter()
	// cmd.Stderr = r.GetLogLineWriter()
	r.cmd = cmd
	reader, err := r.start()
	if err != nil {
		return errors.Wrap(err, "error starting `stellar-core run` subprocess")
	}

	r.metaPipe = newBufferedPipe(pipeBufferSize)
	go func() {
		for {
			io.Copy(r.metaPipe, reader)
			if !r.processIsAlive() {
				return
			}
		}
	}()

	return nil
}

func (r *stellarCoreRunner) getMetaPipe() *bufferedPipe {
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
