package expingest

import (
	"testing"

	"github.com/stellar/go/exp/ingest"
	"github.com/stretchr/testify/assert"
)

func TestCheckVerifyStateVersion(t *testing.T) {
	assert.Equal(
		t,
		CurrentVersion,
		stateVerifierExpectedIngestionVersion,
		"State verifier is outdated, update it, then update stateVerifierExpectedIngestionVersion value",
	)
}

func TestNewSystem(t *testing.T) {
	config := Config{
		HistoryArchiveURL: "https://history.stellar.org",
		StellarCoreURL:    "http://stellarcore:11625",
		TempSet:           nil,
	}

	system, err := NewSystem(config)
	assert.NoError(t, err)

	session := system.session.(*ingest.LiveSession)

	backend := session.GetArchive().GetURL()
	assert.Equal(t, config.HistoryArchiveURL, backend)
	assert.Equal(t, config.StellarCoreURL, session.StellarCoreClient.URL)
	assert.Nil(t, session.TempSet)
}
