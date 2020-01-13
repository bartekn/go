running recipe
recipe finished
--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

DROP INDEX IF EXISTS public.upgradehistbyseq;
DROP INDEX IF EXISTS public.scpquorumsbyseq;
DROP INDEX IF EXISTS public.scpenvsbyseq;
DROP INDEX IF EXISTS public.ledgersbyseq;
DROP INDEX IF EXISTS public.histfeebyseq;
DROP INDEX IF EXISTS public.histbyseq;
DROP INDEX IF EXISTS public.bestofferindex;
DROP INDEX IF EXISTS public.accountbalances;
ALTER TABLE IF EXISTS ONLY public.upgradehistory DROP CONSTRAINT IF EXISTS upgradehistory_pkey;
ALTER TABLE IF EXISTS ONLY public.txhistory DROP CONSTRAINT IF EXISTS txhistory_pkey;
ALTER TABLE IF EXISTS ONLY public.txfeehistory DROP CONSTRAINT IF EXISTS txfeehistory_pkey;
ALTER TABLE IF EXISTS ONLY public.trustlines DROP CONSTRAINT IF EXISTS trustlines_pkey;
ALTER TABLE IF EXISTS ONLY public.storestate DROP CONSTRAINT IF EXISTS storestate_pkey;
ALTER TABLE IF EXISTS ONLY public.scpquorums DROP CONSTRAINT IF EXISTS scpquorums_pkey;
ALTER TABLE IF EXISTS ONLY public.quoruminfo DROP CONSTRAINT IF EXISTS quoruminfo_pkey;
ALTER TABLE IF EXISTS ONLY public.pubsub DROP CONSTRAINT IF EXISTS pubsub_pkey;
ALTER TABLE IF EXISTS ONLY public.publishqueue DROP CONSTRAINT IF EXISTS publishqueue_pkey;
ALTER TABLE IF EXISTS ONLY public.peers DROP CONSTRAINT IF EXISTS peers_pkey;
ALTER TABLE IF EXISTS ONLY public.offers DROP CONSTRAINT IF EXISTS offers_pkey;
ALTER TABLE IF EXISTS ONLY public.ledgerheaders DROP CONSTRAINT IF EXISTS ledgerheaders_pkey;
ALTER TABLE IF EXISTS ONLY public.ledgerheaders DROP CONSTRAINT IF EXISTS ledgerheaders_ledgerseq_key;
ALTER TABLE IF EXISTS ONLY public.ban DROP CONSTRAINT IF EXISTS ban_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts DROP CONSTRAINT IF EXISTS accounts_pkey;
ALTER TABLE IF EXISTS ONLY public.accountdata DROP CONSTRAINT IF EXISTS accountdata_pkey;
DROP TABLE IF EXISTS public.upgradehistory;
DROP TABLE IF EXISTS public.txhistory;
DROP TABLE IF EXISTS public.txfeehistory;
DROP TABLE IF EXISTS public.trustlines;
DROP TABLE IF EXISTS public.storestate;
DROP TABLE IF EXISTS public.scpquorums;
DROP TABLE IF EXISTS public.scphistory;
DROP TABLE IF EXISTS public.quoruminfo;
DROP TABLE IF EXISTS public.pubsub;
DROP TABLE IF EXISTS public.publishqueue;
DROP TABLE IF EXISTS public.peers;
DROP TABLE IF EXISTS public.offers;
DROP TABLE IF EXISTS public.ledgerheaders;
DROP TABLE IF EXISTS public.ban;
DROP TABLE IF EXISTS public.accounts;
DROP TABLE IF EXISTS public.accountdata;
DROP EXTENSION IF EXISTS plpgsql;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accountdata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accountdata (
    accountid character varying(56) NOT NULL,
    dataname character varying(88) NOT NULL,
    datavalue character varying(112) NOT NULL,
    lastmodified integer NOT NULL
);


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts (
    accountid character varying(56) NOT NULL,
    balance bigint NOT NULL,
    buyingliabilities bigint,
    sellingliabilities bigint,
    seqnum bigint NOT NULL,
    numsubentries integer NOT NULL,
    inflationdest character varying(56),
    homedomain character varying(44) NOT NULL,
    thresholds text NOT NULL,
    flags integer NOT NULL,
    signers text,
    lastmodified integer NOT NULL,
    CONSTRAINT accounts_balance_check CHECK ((balance >= 0)),
    CONSTRAINT accounts_buyingliabilities_check CHECK ((buyingliabilities >= 0)),
    CONSTRAINT accounts_numsubentries_check CHECK ((numsubentries >= 0)),
    CONSTRAINT accounts_sellingliabilities_check CHECK ((sellingliabilities >= 0))
);


--
-- Name: ban; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ban (
    nodeid character(56) NOT NULL
);


--
-- Name: ledgerheaders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ledgerheaders (
    ledgerhash character(64) NOT NULL,
    prevhash character(64) NOT NULL,
    bucketlisthash character(64) NOT NULL,
    ledgerseq integer,
    closetime bigint NOT NULL,
    data text NOT NULL,
    CONSTRAINT ledgerheaders_closetime_check CHECK ((closetime >= 0)),
    CONSTRAINT ledgerheaders_ledgerseq_check CHECK ((ledgerseq >= 0))
);


--
-- Name: offers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE offers (
    sellerid character varying(56) NOT NULL,
    offerid bigint NOT NULL,
    sellingasset text NOT NULL,
    buyingasset text NOT NULL,
    amount bigint NOT NULL,
    pricen integer NOT NULL,
    priced integer NOT NULL,
    price double precision NOT NULL,
    flags integer NOT NULL,
    lastmodified integer NOT NULL,
    CONSTRAINT offers_amount_check CHECK ((amount >= 0)),
    CONSTRAINT offers_offerid_check CHECK ((offerid >= 0))
);


--
-- Name: peers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE peers (
    ip character varying(15) NOT NULL,
    port integer DEFAULT 0 NOT NULL,
    nextattempt timestamp without time zone NOT NULL,
    numfailures integer DEFAULT 0 NOT NULL,
    type integer NOT NULL,
    CONSTRAINT peers_numfailures_check CHECK ((numfailures >= 0)),
    CONSTRAINT peers_port_check CHECK (((port > 0) AND (port <= 65535)))
);


--
-- Name: publishqueue; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE publishqueue (
    ledger integer NOT NULL,
    state text
);


--
-- Name: pubsub; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pubsub (
    resid character(32) NOT NULL,
    lastread integer
);


--
-- Name: quoruminfo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE quoruminfo (
    nodeid character(56) NOT NULL,
    qsethash character(64) NOT NULL
);


--
-- Name: scphistory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE scphistory (
    nodeid character(56) NOT NULL,
    ledgerseq integer NOT NULL,
    envelope text NOT NULL,
    CONSTRAINT scphistory_ledgerseq_check CHECK ((ledgerseq >= 0))
);


--
-- Name: scpquorums; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE scpquorums (
    qsethash character(64) NOT NULL,
    lastledgerseq integer NOT NULL,
    qset text NOT NULL,
    CONSTRAINT scpquorums_lastledgerseq_check CHECK ((lastledgerseq >= 0))
);


--
-- Name: storestate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE storestate (
    statename character(32) NOT NULL,
    state text
);


--
-- Name: trustlines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE trustlines (
    accountid character varying(56) NOT NULL,
    assettype integer NOT NULL,
    issuer character varying(56) NOT NULL,
    assetcode character varying(12) NOT NULL,
    tlimit bigint NOT NULL,
    balance bigint NOT NULL,
    buyingliabilities bigint,
    sellingliabilities bigint,
    flags integer NOT NULL,
    lastmodified integer NOT NULL,
    CONSTRAINT trustlines_balance_check CHECK ((balance >= 0)),
    CONSTRAINT trustlines_buyingliabilities_check CHECK ((buyingliabilities >= 0)),
    CONSTRAINT trustlines_sellingliabilities_check CHECK ((sellingliabilities >= 0)),
    CONSTRAINT trustlines_tlimit_check CHECK ((tlimit > 0))
);


--
-- Name: txfeehistory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE txfeehistory (
    txid character(64) NOT NULL,
    ledgerseq integer NOT NULL,
    txindex integer NOT NULL,
    txchanges text NOT NULL,
    CONSTRAINT txfeehistory_ledgerseq_check CHECK ((ledgerseq >= 0))
);


--
-- Name: txhistory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE txhistory (
    txid character(64) NOT NULL,
    ledgerseq integer NOT NULL,
    txindex integer NOT NULL,
    txbody text NOT NULL,
    txresult text NOT NULL,
    txmeta text NOT NULL,
    CONSTRAINT txhistory_ledgerseq_check CHECK ((ledgerseq >= 0))
);


--
-- Name: upgradehistory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE upgradehistory (
    ledgerseq integer NOT NULL,
    upgradeindex integer NOT NULL,
    upgrade text NOT NULL,
    changes text NOT NULL,
    CONSTRAINT upgradehistory_ledgerseq_check CHECK ((ledgerseq >= 0))
);


--
-- Data for Name: accountdata; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO accountdata VALUES ('GD6NTRJW5Z6NCWH4USWMNEYF77RUR2MTO6NP4KEDVJATTCUXDRO3YIFS', 'ZG9uZQ==', 'dHJ1ZQ==', 5);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO accounts VALUES ('GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 999999989999999900, NULL, NULL, 1, 0, NULL, '', 'AQAAAA==', 0, NULL, 3);
INSERT INTO accounts VALUES ('GD6NTRJW5Z6NCWH4USWMNEYF77RUR2MTO6NP4KEDVJATTCUXDRO3YIFS', 9999999800, NULL, NULL, 12884901890, 2, NULL, '', 'AQAAAA==', 0, 'AAAAAQAAAAK8YtS4DZ422inBbF1NnxFzHzYFLHJAGnbCPA+1qbdEIwAAAAE=', 5);


--
-- Data for Name: ban; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: ledgerheaders; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO ledgerheaders VALUES ('63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', '0000000000000000000000000000000000000000000000000000000000000000', '572a2e32ff248a07b0e70fd1f6d318c1facd20b6cc08c33d5775259868125a16', 1, 0, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXKi4y/ySKB7DnD9H20xjB+s0gtswIwz1XdSWYaBJaFgAAAAEN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('661465376964c318135525e67415c547bf3246194cd57caae8fccca5d41ffb68', '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', '735227ed398461291237687b08446aa2c9b096e0c98a462dadda569f05dd2484', 2, 1578926154, 'AAAAAGPZj1Nu5o0bJ7W4nyOvUxG3Vpok+vFAOtC1K2M7B76ZuZRHr9UdXKbTKiclfOjy72YZFJUkJPVcKT5htvorm1QAAAAAXhyASgAAAAAAAAAA3z9hmASpL9tAVxktxD3XSOp3itxSvEmM6AUkwBS4ERlzUiftOYRhKRI3aHsIRGqiybCW4MmKRi2t2lafBd0khAAAAAIN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('ae92ae9d3586732d542e7e8031833241bb22233f7414d4c80947757322a0128d', '661465376964c318135525e67415c547bf3246194cd57caae8fccca5d41ffb68', 'a96ecf6bbf799f5341801c1b93ced140d79ac0afb838ba5abcc5589681c17e98', 3, 1578926155, 'AAAADGYUZTdpZMMYE1Ul5nQVxUe/MkYZTNV8quj8zKXUH/tooHYlby+NcjK7IVbk6mHdJShqCv0+oYrjrA/jcSa9nLYAAAAAXhyASwAAAAIAAAAIAAAAAQAAAAwAAAAIAAAAAwAPQkAAAAAAlzJ1vISHXzElAf05LhN7qiqWqKvjHhTijb/BgG6FsuKpbs9rv3mfU0GAHBuTztFA15rAr7g4ulq8xViWgcF+mAAAAAMN4Lazp2QAAAAAAAAAAABkAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('cb019abc8dbacbad1faa7fae1c88e554eda2ff8966e48ed133062c64d641e004', 'ae92ae9d3586732d542e7e8031833241bb22233f7414d4c80947757322a0128d', 'd40078bfb68c31cc3aa0d30f5be2959456061784f6b6acd3ed53f658245d08c1', 4, 1578926156, 'AAAADK6Srp01hnMtVC5+gDGDMkG7IiM/dBTUyAlHdXMioBKNxBbi7KZS+4Ww+TQuD7tIQ/ifOMOQSFI7gj7Xs9YEqhcAAAAAXhyATAAAAAAAAAAApOCJokUPy1wA/XbpkumCKr9Nv3B8+fRGt4d1ygPrKBzUAHi/towxzDqg0w9b4pWUVgYXhPa2rNPtU/ZYJF0IwQAAAAQN4Lazp2QAAAAAAAAAAADIAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('97d86305ab39e0a2eb43e9e2c26dad2fd8580c7c4379fc8dc5524ccf19481aae', 'cb019abc8dbacbad1faa7fae1c88e554eda2ff8966e48ed133062c64d641e004', 'd12672b014836ed2351b733a4fca51293fdadc6772166fc87e590031821cf8dc', 5, 1578926157, 'AAAADMsBmryNusutH6p/rhyI5VTtov+JZuSO0TMGLGTWQeAEikoD3NdATBihX1InObUqnpGguK39MT2TwsWJpwCDMz4AAAAAXhyATQAAAAAAAAAAnzt6UJX5by6BwcesLvsJTMJPn/Y/s/aBHlEOtmT5mwfRJnKwFINu0jUbczpPylEpP9rcZ3IWb8h+WQAxghz43AAAAAUN4Lazp2QAAAAAAAAAAAEsAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');


--
-- Data for Name: offers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: peers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: publishqueue; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: pubsub; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: quoruminfo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: scphistory; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO scphistory VALUES ('GA72BYJCSX5ZJYBKUCO63ZEZSGYHUQ26D4DXFKODAT4LKAVYCAECT7MN', 2, 'AAAAAD+g4SKV+5TgKqCd7eSZkbB6Q14fB3KpwwT4tQK4EAgpAAAAAAAAAAIAAAACAAAAAQAAADC5lEev1R1cptMqJyV86PLvZhkUlSQk9VwpPmG2+iubVAAAAABeHIBKAAAAAAAAAAAAAAAB72jVL87XttbuathEc5wNA4XOfe7M6s2uFCtp8/VPhjQAAABAKD3gMZkl8JzT3z+bHWqShf3Hd3PFAAaUA/OobnQ9V0nSFS/cN5C3W50T6Wmhiq3i4hs0neCgYLU8VYCiuUiiAw==');
INSERT INTO scphistory VALUES ('GA72BYJCSX5ZJYBKUCO63ZEZSGYHUQ26D4DXFKODAT4LKAVYCAECT7MN', 3, 'AAAAAD+g4SKV+5TgKqCd7eSZkbB6Q14fB3KpwwT4tQK4EAgpAAAAAAAAAAMAAAACAAAAAQAAAEigdiVvL41yMrshVuTqYd0lKGoK/T6hiuOsD+NxJr2ctgAAAABeHIBLAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAAB72jVL87XttbuathEc5wNA4XOfe7M6s2uFCtp8/VPhjQAAABAUElUI6xgg/Sj3b93X9byDkt7w3Ghp7P83jah1bqDuuAprNGfzqxTOj4FzCwi0AQLpQfz+598QlHQUbACjiz/Cg==');
INSERT INTO scphistory VALUES ('GA72BYJCSX5ZJYBKUCO63ZEZSGYHUQ26D4DXFKODAT4LKAVYCAECT7MN', 4, 'AAAAAD+g4SKV+5TgKqCd7eSZkbB6Q14fB3KpwwT4tQK4EAgpAAAAAAAAAAQAAAACAAAAAQAAADDEFuLsplL7hbD5NC4Pu0hD+J84w5BIUjuCPtez1gSqFwAAAABeHIBMAAAAAAAAAAAAAAAB72jVL87XttbuathEc5wNA4XOfe7M6s2uFCtp8/VPhjQAAABAPVHz28iPrwQpTi6xiB4BjIN/0i/XE0A7OxsrNcLXSyIYXSHjsavfGBP/5hoPhbaU/XJ3k5T51NhtHlYxh5A2DQ==');
INSERT INTO scphistory VALUES ('GA72BYJCSX5ZJYBKUCO63ZEZSGYHUQ26D4DXFKODAT4LKAVYCAECT7MN', 5, 'AAAAAD+g4SKV+5TgKqCd7eSZkbB6Q14fB3KpwwT4tQK4EAgpAAAAAAAAAAUAAAACAAAAAQAAADCKSgPc10BMGKFfUic5tSqekaC4rf0xPZPCxYmnAIMzPgAAAABeHIBNAAAAAAAAAAAAAAAB72jVL87XttbuathEc5wNA4XOfe7M6s2uFCtp8/VPhjQAAABAe2lui8abPhmtqThSFISrM7AML1OFQygc8/N/0BNSBXRggSdpHqBqIUf9u05uValgrpqLtaL3xi6yl33dBXbyAA==');


--
-- Data for Name: scpquorums; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO scpquorums VALUES ('ef68d52fced7b6d6ee6ad844739c0d0385ce7deecceacdae142b69f3f54f8634', 5, 'AAAAAQAAAAEAAAAAP6DhIpX7lOAqoJ3t5JmRsHpDXh8HcqnDBPi1ArgQCCkAAAAA');


--
-- Data for Name: storestate; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO storestate VALUES ('lastclosedledger                ', '97d86305ab39e0a2eb43e9e2c26dad2fd8580c7c4379fc8dc5524ccf19481aae');
INSERT INTO storestate VALUES ('databaseschema                  ', '11');
INSERT INTO storestate VALUES ('networkpassphrase               ', 'Test SDF Network ; September 2015');
INSERT INTO storestate VALUES ('forcescponnextlaunch            ', 'false');
INSERT INTO storestate VALUES ('historyarchivestate             ', '{
    "version": 1,
    "server": "v12.2.0",
    "currentLedger": 5,
    "currentBuckets": [
        {
            "curr": "6744e8e03bec1e78c39366c8708d8b2d72647fa87d50c2b7cc20f03e30fcd016",
            "next": {
                "state": 0
            },
            "snap": "fc50e1dd6ab2f1b7551450193f37183536786cabe141e5d08e84b63a725c5190"
        },
        {
            "curr": "ef31a20a398ee73ce22275ea8177786bac54656f33dcc4f3fec60d55ddf163d9",
            "next": {
                "state": 1,
                "output": "fc50e1dd6ab2f1b7551450193f37183536786cabe141e5d08e84b63a725c5190"
            },
            "snap": "0000000000000000000000000000000000000000000000000000000000000000"
        },
        {
            "curr": "0000000000000000000000000000000000000000000000000000000000000000",
            "next": {
                "state": 0
            },
            "snap": "0000000000000000000000000000000000000000000000000000000000000000"
        },
        {
            "curr": "0000000000000000000000000000000000000000000000000000000000000000",
            "next": {
                "state": 0
            },
            "snap": "0000000000000000000000000000000000000000000000000000000000000000"
        },
        {
            "curr": "0000000000000000000000000000000000000000000000000000000000000000",
            "next": {
                "state": 0
            },
            "snap": "0000000000000000000000000000000000000000000000000000000000000000"
        },
        {
            "curr": "0000000000000000000000000000000000000000000000000000000000000000",
            "next": {
                "state": 0
            },
            "snap": "0000000000000000000000000000000000000000000000000000000000000000"
        },
        {
            "curr": "0000000000000000000000000000000000000000000000000000000000000000",
            "next": {
                "state": 0
            },
            "snap": "0000000000000000000000000000000000000000000000000000000000000000"
        },
        {
            "curr": "0000000000000000000000000000000000000000000000000000000000000000",
            "next": {
                "state": 0
            },
            "snap": "0000000000000000000000000000000000000000000000000000000000000000"
        },
        {
            "curr": "0000000000000000000000000000000000000000000000000000000000000000",
            "next": {
                "state": 0
            },
            "snap": "0000000000000000000000000000000000000000000000000000000000000000"
        },
        {
            "curr": "0000000000000000000000000000000000000000000000000000000000000000",
            "next": {
                "state": 0
            },
            "snap": "0000000000000000000000000000000000000000000000000000000000000000"
        },
        {
            "curr": "0000000000000000000000000000000000000000000000000000000000000000",
            "next": {
                "state": 0
            },
            "snap": "0000000000000000000000000000000000000000000000000000000000000000"
        }
    ]
}');
INSERT INTO storestate VALUES ('lastscpdata2                    ', 'AAAAAgAAAAA/oOEilfuU4Cqgne3kmZGwekNeHwdyqcME+LUCuBAIKQAAAAAAAAACAAAAA+9o1S/O17bW7mrYRHOcDQOFzn3uzOrNrhQrafP1T4Y0AAAAAQAAADC5lEev1R1cptMqJyV86PLvZhkUlSQk9VwpPmG2+iubVAAAAABeHIBKAAAAAAAAAAAAAAABAAAAMLmUR6/VHVym0yonJXzo8u9mGRSVJCT1XCk+Ybb6K5tUAAAAAF4cgEoAAAAAAAAAAAAAAECSPzGApkqmHobPtEhM01Pgx+sqmgzYvClHj6NFbnUXM6oNhYqUa4bB3R0zSMhaeoC6tl+eBoXOIamd9xlastQOAAAAAD+g4SKV+5TgKqCd7eSZkbB6Q14fB3KpwwT4tQK4EAgpAAAAAAAAAAIAAAACAAAAAQAAADC5lEev1R1cptMqJyV86PLvZhkUlSQk9VwpPmG2+iubVAAAAABeHIBKAAAAAAAAAAAAAAAB72jVL87XttbuathEc5wNA4XOfe7M6s2uFCtp8/VPhjQAAABAKD3gMZkl8JzT3z+bHWqShf3Hd3PFAAaUA/OobnQ9V0nSFS/cN5C3W50T6Wmhiq3i4hs0neCgYLU8VYCiuUiiAwAAAAFj2Y9TbuaNGye1uJ8jr1MRt1aaJPrxQDrQtStjOwe+mQAAAAAAAAABAAAAAQAAAAEAAAAAP6DhIpX7lOAqoJ3t5JmRsHpDXh8HcqnDBPi1ArgQCCkAAAAA');
INSERT INTO storestate VALUES ('ledgerupgrades                  ', '{
    "time": 1578926154,
    "version": {
        "has": false
    },
    "fee": {
        "has": false
    },
    "maxtxsize": {
        "has": false
    },
    "reserve": {
        "has": false
    }
}');
INSERT INTO storestate VALUES ('lastscpdata3                    ', 'AAAAAgAAAAA/oOEilfuU4Cqgne3kmZGwekNeHwdyqcME+LUCuBAIKQAAAAAAAAADAAAAA+9o1S/O17bW7mrYRHOcDQOFzn3uzOrNrhQrafP1T4Y0AAAAAQAAAEigdiVvL41yMrshVuTqYd0lKGoK/T6hiuOsD+NxJr2ctgAAAABeHIBLAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABAAAASKB2JW8vjXIyuyFW5Oph3SUoagr9PqGK46wP43EmvZy2AAAAAF4cgEsAAAACAAAACAAAAAEAAAAMAAAACAAAAAMAD0JAAAAAAAAAAEBfq6IEUiENu8zujfOmeMdD6NPU9eWJuUMjtMchz3xSbbdJiaEUp2x9XEEqqYkLoB1D2u0ehO2DrVQgspqgD0kAAAAAAD+g4SKV+5TgKqCd7eSZkbB6Q14fB3KpwwT4tQK4EAgpAAAAAAAAAAMAAAACAAAAAQAAAEigdiVvL41yMrshVuTqYd0lKGoK/T6hiuOsD+NxJr2ctgAAAABeHIBLAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAAB72jVL87XttbuathEc5wNA4XOfe7M6s2uFCtp8/VPhjQAAABAUElUI6xgg/Sj3b93X9byDkt7w3Ghp7P83jah1bqDuuAprNGfzqxTOj4FzCwi0AQLpQfz+598QlHQUbACjiz/CgAAAAFmFGU3aWTDGBNVJeZ0FcVHvzJGGUzVfKro/Myl1B/7aAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAABkAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAD82cU27nzRWPykrMaTBf/jSOmTd5r+KIOqQTmKlxxdvAAAAAJUC+QAAAAAAAAAAAFW/AX3AAAAQOLT73z+W1LY9k7E0I2iB0LRy2Q5as2dD7d5W7Y8jf4s11Wyxg6vDiDC9kVQuwylLXrrLutV/KfoAinuCpXmkwMAAAABAAAAAQAAAAEAAAAAP6DhIpX7lOAqoJ3t5JmRsHpDXh8HcqnDBPi1ArgQCCkAAAAA');
INSERT INTO storestate VALUES ('lastscpdata4                    ', 'AAAAAgAAAAA/oOEilfuU4Cqgne3kmZGwekNeHwdyqcME+LUCuBAIKQAAAAAAAAAEAAAAA+9o1S/O17bW7mrYRHOcDQOFzn3uzOrNrhQrafP1T4Y0AAAAAQAAAJjEFuLsplL7hbD5NC4Pu0hD+J84w5BIUjuCPtez1gSqFwAAAABeHIBMAAAAAAAAAAEAAAAAP6DhIpX7lOAqoJ3t5JmRsHpDXh8HcqnDBPi1ArgQCCkAAABAPQ8ibt5wA+zFA4bkrTeSirUQwnBHy83EofHp+eqSnc5lqNJO0/8UhlhHtqKAKrEZO7Lc4CCkDTRY9iTCAvwFDQAAAAEAAACYxBbi7KZS+4Ww+TQuD7tIQ/ifOMOQSFI7gj7Xs9YEqhcAAAAAXhyATAAAAAAAAAABAAAAAD+g4SKV+5TgKqCd7eSZkbB6Q14fB3KpwwT4tQK4EAgpAAAAQD0PIm7ecAPsxQOG5K03koq1EMJwR8vNxKHx6fnqkp3OZajSTtP/FIZYR7aigCqxGTuy3OAgpA00WPYkwgL8BQ0AAABA1Bf2FYuoozW0igr69YWUsWuFvnwasmbxfSHfZKqxZ4hAvy3mhDdYmD2ysqhk1tlVG6cB6RMhhaAWXrXMBjV2DgAAAAA/oOEilfuU4Cqgne3kmZGwekNeHwdyqcME+LUCuBAIKQAAAAAAAAAEAAAAAgAAAAEAAAAwxBbi7KZS+4Ww+TQuD7tIQ/ifOMOQSFI7gj7Xs9YEqhcAAAAAXhyATAAAAAAAAAAAAAAAAe9o1S/O17bW7mrYRHOcDQOFzn3uzOrNrhQrafP1T4Y0AAAAQD1R89vIj68EKU4usYgeAYyDf9Iv1xNAOzsbKzXC10siGF0h47Gr3xgT/+YaD4W2lP1yd5OU+dTYbR5WMYeQNg0AAAABrpKunTWGcy1ULn6AMYMyQbsiIz90FNTICUd1cyKgEo0AAAABAAAAAPzZxTbufNFY/KSsxpMF/+NI6ZN3mv4og6pBOYqXHF28AAAAZAAAAAMAAAABAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAK8YtS4DZ422inBbF1NnxFzHzYFLHJAGnbCPA+1qbdEIwAAAAEAAAAAAAAAAZccXbwAAABAeVu+uPT8KOhoKoNJidCWqVs71WAIqQns2Zq4mM3LBluMVDHej/SJhUxiKlsSR5MJwQU3trQbPsOAwb56BinbCwAAAAEAAAABAAAAAQAAAAA/oOEilfuU4Cqgne3kmZGwekNeHwdyqcME+LUCuBAIKQAAAAA=');
INSERT INTO storestate VALUES ('lastscpdata5                    ', 'AAAAAgAAAAA/oOEilfuU4Cqgne3kmZGwekNeHwdyqcME+LUCuBAIKQAAAAAAAAAFAAAAA+9o1S/O17bW7mrYRHOcDQOFzn3uzOrNrhQrafP1T4Y0AAAAAQAAAJiKSgPc10BMGKFfUic5tSqekaC4rf0xPZPCxYmnAIMzPgAAAABeHIBNAAAAAAAAAAEAAAAAP6DhIpX7lOAqoJ3t5JmRsHpDXh8HcqnDBPi1ArgQCCkAAABAfeDjO15wDtQfP86ijK0JbkvNrblYIjG2nnbJLORyzlIzpLgAqS6dV0xfFER1EBQBZBGSY60uSetqMTykDvqpDAAAAAEAAACYikoD3NdATBihX1InObUqnpGguK39MT2TwsWJpwCDMz4AAAAAXhyATQAAAAAAAAABAAAAAD+g4SKV+5TgKqCd7eSZkbB6Q14fB3KpwwT4tQK4EAgpAAAAQH3g4ztecA7UHz/OooytCW5Lza25WCIxtp52ySzkcs5SM6S4AKkunVdMXxREdRAUAWQRkmOtLknrajE8pA76qQwAAABAmNqokFkRNIDV955UR6e3OcoMrJ81vIlUmnabcN+vsCp/bIerEngUnfTRp24Y6qmhKbvYX0YVDFnUFR00DlZxAQAAAAA/oOEilfuU4Cqgne3kmZGwekNeHwdyqcME+LUCuBAIKQAAAAAAAAAFAAAAAgAAAAEAAAAwikoD3NdATBihX1InObUqnpGguK39MT2TwsWJpwCDMz4AAAAAXhyATQAAAAAAAAAAAAAAAe9o1S/O17bW7mrYRHOcDQOFzn3uzOrNrhQrafP1T4Y0AAAAQHtpbovGmz4Zrak4UhSEqzOwDC9ThUMoHPPzf9ATUgV0YIEnaR6gaiFH/btOblWpYK6ai7Wi98Yuspd93QV28gAAAAABywGavI26y60fqn+uHIjlVO2i/4lm5I7RMwYsZNZB4AQAAAABAAAAAPzZxTbufNFY/KSsxpMF/+NI6ZN3mv4og6pBOYqXHF28AAAAZAAAAAMAAAACAAAAAAAAAAAAAAABAAAAAAAAAAoAAAAEZG9uZQAAAAEAAAAEdHJ1ZQAAAAAAAAABqbdEIwAAACC5TSe5k00+CKUuUtfafav6xITv43pTgO6QiPes4u/N6QAAAAEAAAABAAAAAQAAAAA/oOEilfuU4Cqgne3kmZGwekNeHwdyqcME+LUCuBAIKQAAAAA=');


--
-- Data for Name: trustlines; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: txfeehistory; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO txfeehistory VALUES ('54c49533d937a906c0e6e501322bb600ffe332bf888cb474bd4261d42f542470', 3, 1, 'AAAAAgAAAAMAAAABAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txfeehistory VALUES ('59de4450bcc1830b6da83fb481aab833db04dadf1e88d568a00274d4038d531e', 4, 1, 'AAAAAgAAAAMAAAADAAAAAAAAAAD82cU27nzRWPykrMaTBf/jSOmTd5r+KIOqQTmKlxxdvAAAAAJUC+QAAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAAAAD82cU27nzRWPykrMaTBf/jSOmTd5r+KIOqQTmKlxxdvAAAAAJUC+OcAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txfeehistory VALUES ('b0879add9f3957c9796d1d1fb23720dbed15d07793c742773455f2706c0e9a25', 5, 1, 'AAAAAgAAAAMAAAAEAAAAAAAAAAD82cU27nzRWPykrMaTBf/jSOmTd5r+KIOqQTmKlxxdvAAAAAJUC+OcAAAAAwAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAEAAAACvGLUuA2eNtopwWxdTZ8Rcx82BSxyQBp2wjwPtam3RCMAAAABAAAAAAAAAAAAAAABAAAABQAAAAAAAAAA/NnFNu580Vj8pKzGkwX/40jpk3ea/iiDqkE5ipccXbwAAAACVAvjOAAAAAMAAAABAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAABAAAAArxi1LgNnjbaKcFsXU2fEXMfNgUsckAadsI8D7Wpt0QjAAAAAQAAAAAAAAAA');


--
-- Data for Name: txhistory; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO txhistory VALUES ('54c49533d937a906c0e6e501322bb600ffe332bf888cb474bd4261d42f542470', 3, 1, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAA/NnFNu580Vj8pKzGkwX/40jpk3ea/iiDqkE5ipccXbwAAAACVAvkAAAAAAAAAAABVvwF9wAAAEDi0+98/ltS2PZOxNCNogdC0ctkOWrNnQ+3eVu2PI3+LNdVssYOrw4gwvZFULsMpS166y7rVfyn6AIp7gqV5pMD', 'VMSVM9k3qQbA5uUBMiu2AP/jMr+IjLR0vUJh1C9UJHAAAAAAAAAAZAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAA==', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBucAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAD82cU27nzRWPykrMaTBf/jSOmTd5r+KIOqQTmKlxxdvAAAAAJUC+QAAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txhistory VALUES ('59de4450bcc1830b6da83fb481aab833db04dadf1e88d568a00274d4038d531e', 4, 1, 'AAAAAPzZxTbufNFY/KSsxpMF/+NI6ZN3mv4og6pBOYqXHF28AAAAZAAAAAMAAAABAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAK8YtS4DZ422inBbF1NnxFzHzYFLHJAGnbCPA+1qbdEIwAAAAEAAAAAAAAAAZccXbwAAABAeVu+uPT8KOhoKoNJidCWqVs71WAIqQns2Zq4mM3LBluMVDHej/SJhUxiKlsSR5MJwQU3trQbPsOAwb56BinbCw==', 'Wd5EULzBgwttqD+0gaq4M9sE2t8eiNVooAJ01AONUx4AAAAAAAAAZAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAA==', 'AAAAAQAAAAIAAAADAAAABAAAAAAAAAAA/NnFNu580Vj8pKzGkwX/40jpk3ea/iiDqkE5ipccXbwAAAACVAvjnAAAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAAAAAAA/NnFNu580Vj8pKzGkwX/40jpk3ea/iiDqkE5ipccXbwAAAACVAvjnAAAAAMAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAEAAAAAAAAAAD82cU27nzRWPykrMaTBf/jSOmTd5r+KIOqQTmKlxxdvAAAAAJUC+OcAAAAAwAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAAAAD82cU27nzRWPykrMaTBf/jSOmTd5r+KIOqQTmKlxxdvAAAAAJUC+OcAAAAAwAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAEAAAACvGLUuA2eNtopwWxdTZ8Rcx82BSxyQBp2wjwPtam3RCMAAAABAAAAAAAAAAA=');
INSERT INTO txhistory VALUES ('b0879add9f3957c9796d1d1fb23720dbed15d07793c742773455f2706c0e9a25', 5, 1, 'AAAAAPzZxTbufNFY/KSsxpMF/+NI6ZN3mv4og6pBOYqXHF28AAAAZAAAAAMAAAACAAAAAAAAAAAAAAABAAAAAAAAAAoAAAAEZG9uZQAAAAEAAAAEdHJ1ZQAAAAAAAAABqbdEIwAAACC5TSe5k00+CKUuUtfafav6xITv43pTgO6QiPes4u/N6Q==', 'sIea3Z85V8l5bR0fsjcg2+0V0HeTx0J3NFXycGwOmiUAAAAAAAAAZAAAAAAAAAABAAAAAAAAAAoAAAAAAAAAAA==', 'AAAAAQAAAAIAAAADAAAABQAAAAAAAAAA/NnFNu580Vj8pKzGkwX/40jpk3ea/iiDqkE5ipccXbwAAAACVAvjOAAAAAMAAAABAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAABAAAAArxi1LgNnjbaKcFsXU2fEXMfNgUsckAadsI8D7Wpt0QjAAAAAQAAAAAAAAAAAAAAAQAAAAUAAAAAAAAAAPzZxTbufNFY/KSsxpMF/+NI6ZN3mv4og6pBOYqXHF28AAAAAlQL4zgAAAADAAAAAgAAAAEAAAAAAAAAAAAAAAABAAAAAAAAAQAAAAK8YtS4DZ422inBbF1NnxFzHzYFLHJAGnbCPA+1qbdEIwAAAAEAAAAAAAAAAAAAAAEAAAADAAAAAwAAAAUAAAAAAAAAAPzZxTbufNFY/KSsxpMF/+NI6ZN3mv4og6pBOYqXHF28AAAAAlQL4zgAAAADAAAAAgAAAAEAAAAAAAAAAAAAAAABAAAAAAAAAQAAAAK8YtS4DZ422inBbF1NnxFzHzYFLHJAGnbCPA+1qbdEIwAAAAEAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAAD82cU27nzRWPykrMaTBf/jSOmTd5r+KIOqQTmKlxxdvAAAAAJUC+M4AAAAAwAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAEAAAACvGLUuA2eNtopwWxdTZ8Rcx82BSxyQBp2wjwPtam3RCMAAAABAAAAAAAAAAAAAAAAAAAABQAAAAMAAAAA/NnFNu580Vj8pKzGkwX/40jpk3ea/iiDqkE5ipccXbwAAAAEZG9uZQAAAAR0cnVlAAAAAAAAAAA=');


--
-- Data for Name: upgradehistory; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO upgradehistory VALUES (3, 1, 'AAAAAQAAAAw=', 'AAAAAA==');
INSERT INTO upgradehistory VALUES (3, 2, 'AAAAAwAPQkA=', 'AAAAAA==');


--
-- Name: accountdata accountdata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accountdata
    ADD CONSTRAINT accountdata_pkey PRIMARY KEY (accountid, dataname);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (accountid);


--
-- Name: ban ban_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ban
    ADD CONSTRAINT ban_pkey PRIMARY KEY (nodeid);


--
-- Name: ledgerheaders ledgerheaders_ledgerseq_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ledgerheaders
    ADD CONSTRAINT ledgerheaders_ledgerseq_key UNIQUE (ledgerseq);


--
-- Name: ledgerheaders ledgerheaders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ledgerheaders
    ADD CONSTRAINT ledgerheaders_pkey PRIMARY KEY (ledgerhash);


--
-- Name: offers offers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (offerid);


--
-- Name: peers peers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY peers
    ADD CONSTRAINT peers_pkey PRIMARY KEY (ip, port);


--
-- Name: publishqueue publishqueue_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY publishqueue
    ADD CONSTRAINT publishqueue_pkey PRIMARY KEY (ledger);


--
-- Name: pubsub pubsub_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pubsub
    ADD CONSTRAINT pubsub_pkey PRIMARY KEY (resid);


--
-- Name: quoruminfo quoruminfo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY quoruminfo
    ADD CONSTRAINT quoruminfo_pkey PRIMARY KEY (nodeid);


--
-- Name: scpquorums scpquorums_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY scpquorums
    ADD CONSTRAINT scpquorums_pkey PRIMARY KEY (qsethash);


--
-- Name: storestate storestate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY storestate
    ADD CONSTRAINT storestate_pkey PRIMARY KEY (statename);


--
-- Name: trustlines trustlines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trustlines
    ADD CONSTRAINT trustlines_pkey PRIMARY KEY (accountid, issuer, assetcode);


--
-- Name: txfeehistory txfeehistory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY txfeehistory
    ADD CONSTRAINT txfeehistory_pkey PRIMARY KEY (ledgerseq, txindex);


--
-- Name: txhistory txhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY txhistory
    ADD CONSTRAINT txhistory_pkey PRIMARY KEY (ledgerseq, txindex);


--
-- Name: upgradehistory upgradehistory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY upgradehistory
    ADD CONSTRAINT upgradehistory_pkey PRIMARY KEY (ledgerseq, upgradeindex);


--
-- Name: accountbalances; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accountbalances ON accounts USING btree (balance) WHERE (balance >= 1000000000);


--
-- Name: bestofferindex; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bestofferindex ON offers USING btree (sellingasset, buyingasset, price, offerid);


--
-- Name: histbyseq; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX histbyseq ON txhistory USING btree (ledgerseq);


--
-- Name: histfeebyseq; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX histfeebyseq ON txfeehistory USING btree (ledgerseq);


--
-- Name: ledgersbyseq; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ledgersbyseq ON ledgerheaders USING btree (ledgerseq);


--
-- Name: scpenvsbyseq; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX scpenvsbyseq ON scphistory USING btree (ledgerseq);


--
-- Name: scpquorumsbyseq; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX scpquorumsbyseq ON scpquorums USING btree (lastledgerseq);


--
-- Name: upgradehistbyseq; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upgradehistbyseq ON upgradehistory USING btree (ledgerseq);


--
-- PostgreSQL database dump complete
--

