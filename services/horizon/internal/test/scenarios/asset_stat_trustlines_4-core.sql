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



--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO accounts VALUES ('GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 999999979999999800, NULL, NULL, 2, 0, NULL, '', 'AQAAAA==', 0, NULL, 2);
INSERT INTO accounts VALUES ('GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 9999999900, NULL, NULL, 8589934593, 1, NULL, '', 'AQAAAA==', 0, NULL, 3);
INSERT INTO accounts VALUES ('GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4', 9999999900, NULL, NULL, 8589934593, 1, NULL, '', 'AQAAAA==', 0, NULL, 3);


--
-- Data for Name: ban; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: ledgerheaders; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO ledgerheaders VALUES ('63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', '0000000000000000000000000000000000000000000000000000000000000000', '572a2e32ff248a07b0e70fd1f6d318c1facd20b6cc08c33d5775259868125a16', 1, 0, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXKi4y/ySKB7DnD9H20xjB+s0gtswIwz1XdSWYaBJaFgAAAAEN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('28c2ba3eca3624c4ef9ee6f13201dbbf7e8d136de44d2cc2ae89f68051a46808', '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', '69b1ded30c0c7a1fdf5306e16643da099d872904d16d9e447b1195be1e1172f0', 2, 1578926313, 'AAAAAGPZj1Nu5o0bJ7W4nyOvUxG3Vpok+vFAOtC1K2M7B76Zu5H9cHd0qAsZj9Q6Y8yIIc6utkf/CO+Lm/0KbsfrzPUAAAAAXhyA6QAAAAAAAAAAP0PjS3Rf7hs8xVIBg2g8xKvqOO/n/g/XwgPR/HB7qe9psd7TDAx6H99TBuFmQ9oJnYcpBNFtnkR7EZW+HhFy8AAAAAIN4Lazp2QAAAAAAAAAAADIAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('ab12c3a4b13a59b5edda37344b3b1f558fc2beb000614a399e67d9c0e7ec07c8', '28c2ba3eca3624c4ef9ee6f13201dbbf7e8d136de44d2cc2ae89f68051a46808', '34b000fe734b29a49e60b197ae2e84712376fdb79154e0ec197c7a8a9502209d', 3, 1578926314, 'AAAADCjCuj7KNiTE757m8TIB279+jRNt5E0swq6J9oBRpGgIgQjgu0stObXTEEZGRkxMjvHDBlLVQKxFgUuJtzgRDVAAAAAAXhyA6gAAAAIAAAAIAAAAAQAAAAwAAAAIAAAAAwAPQkAAAAAAkM0AO8fy+R01RLHQxi8QIFovYEyg8nO2PXelvRJMMGA0sAD+c0sppJ5gsZeuLoRxI3b9t5FU4OwZfHqKlQIgnQAAAAMN4Lazp2QAAAAAAAAAAAGQAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');


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

INSERT INTO scphistory VALUES ('GBPKND2EJ4PRD5HCPIJZ2DGIWZF7PKED7DOVLA6Z2CJL6SBMHJF5F3YH', 2, 'AAAAAF6mj0RPHxH04noTnQzItkv3qIP43VWD2dCSv0gsOkvSAAAAAAAAAAIAAAACAAAAAQAAADC7kf1wd3SoCxmP1DpjzIghzq62R/8I74ub/Qpux+vM9QAAAABeHIDpAAAAAAAAAAAAAAABgrA7duI3a91m5J+m3C6+LP+xQSOWY9dWnSygmZT6QtgAAABAAOp9S+LpuvycHFqxE6pm1vw+bdKrXfVO0RaZgw1wjXRK7BU/kIr/o+SqxvPJus3B5eEJ1lvl/xRdJ2/NKHQcBg==');
INSERT INTO scphistory VALUES ('GBPKND2EJ4PRD5HCPIJZ2DGIWZF7PKED7DOVLA6Z2CJL6SBMHJF5F3YH', 3, 'AAAAAF6mj0RPHxH04noTnQzItkv3qIP43VWD2dCSv0gsOkvSAAAAAAAAAAMAAAACAAAAAQAAAEiBCOC7Sy05tdMQRkZGTEyO8cMGUtVArEWBS4m3OBENUAAAAABeHIDqAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABgrA7duI3a91m5J+m3C6+LP+xQSOWY9dWnSygmZT6QtgAAABAZbCX8QaVeNvWgN18oAjyXGoXL4f+70H+7oWppXICCKIk/PGpZeUVLouKaFS4LLn90tTFVxprGR4Q5Kihq0f/AQ==');


--
-- Data for Name: scpquorums; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO scpquorums VALUES ('82b03b76e2376bdd66e49fa6dc2ebe2cffb141239663d7569d2ca09994fa42d8', 3, 'AAAAAQAAAAEAAAAAXqaPRE8fEfTiehOdDMi2S/eog/jdVYPZ0JK/SCw6S9IAAAAA');


--
-- Data for Name: storestate; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO storestate VALUES ('databaseschema                  ', '11');
INSERT INTO storestate VALUES ('networkpassphrase               ', 'Test SDF Network ; September 2015');
INSERT INTO storestate VALUES ('forcescponnextlaunch            ', 'false');
INSERT INTO storestate VALUES ('lastscpdata2                    ', 'AAAAAgAAAABepo9ETx8R9OJ6E50MyLZL96iD+N1Vg9nQkr9ILDpL0gAAAAAAAAACAAAAA4KwO3biN2vdZuSfptwuviz/sUEjlmPXVp0soJmU+kLYAAAAAQAAADC7kf1wd3SoCxmP1DpjzIghzq62R/8I74ub/Qpux+vM9QAAAABeHIDpAAAAAAAAAAAAAAABAAAAMLuR/XB3dKgLGY/UOmPMiCHOrrZH/wjvi5v9Cm7H68z1AAAAAF4cgOkAAAAAAAAAAAAAAEDjwTBqffN1MFFLH92exvysgeCkLk9SfVh31JCBZ6Pr3BXXeTDNBQaXle4zCKHJ/N4wNiVz/EllNIcoalb3TUwPAAAAAF6mj0RPHxH04noTnQzItkv3qIP43VWD2dCSv0gsOkvSAAAAAAAAAAIAAAACAAAAAQAAADC7kf1wd3SoCxmP1DpjzIghzq62R/8I74ub/Qpux+vM9QAAAABeHIDpAAAAAAAAAAAAAAABgrA7duI3a91m5J+m3C6+LP+xQSOWY9dWnSygmZT6QtgAAABAAOp9S+LpuvycHFqxE6pm1vw+bdKrXfVO0RaZgw1wjXRK7BU/kIr/o+SqxvPJus3B5eEJ1lvl/xRdJ2/NKHQcBgAAAAFj2Y9TbuaNGye1uJ8jr1MRt1aaJPrxQDrQtStjOwe+mQAAAAIAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAABkAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+QAAAAAAAAAAAFW/AX3AAAAQBiNBw9PYbmGqcGaAYZ6D0nyXhzUSdSXGSUSUf2ypmvT3vUXo4tZ97+biSkW0j6wjSLWouK3kDQnJaduFgtbmgMAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAABkAAAAAAAAAAIAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+QAAAAAAAAAAAFW/AX3AAAAQGYqlKC+vAo7bRcI59h9ewYQRS3BhpoR+pK7rKYmaUOZr4hfojsiCBtRkyhxB1n3ggwB8p1AA2pdsg7vKzB54wIAAAABAAAAAQAAAAEAAAAAXqaPRE8fEfTiehOdDMi2S/eog/jdVYPZ0JK/SCw6S9IAAAAA');
INSERT INTO storestate VALUES ('ledgerupgrades                  ', '{
    "time": 1578926313,
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
INSERT INTO storestate VALUES ('lastclosedledger                ', 'ab12c3a4b13a59b5edda37344b3b1f558fc2beb000614a399e67d9c0e7ec07c8');
INSERT INTO storestate VALUES ('historyarchivestate             ', '{
    "version": 1,
    "server": "v12.2.0",
    "currentLedger": 3,
    "currentBuckets": [
        {
            "curr": "1f866c0987e33c70e07aa3efff3e193bae6e98f57349a9c2c137ed948010baf9",
            "next": {
                "state": 0
            },
            "snap": "ef31a20a398ee73ce22275ea8177786bac54656f33dcc4f3fec60d55ddf163d9"
        },
        {
            "curr": "0000000000000000000000000000000000000000000000000000000000000000",
            "next": {
                "state": 1,
                "output": "ef31a20a398ee73ce22275ea8177786bac54656f33dcc4f3fec60d55ddf163d9"
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
INSERT INTO storestate VALUES ('lastscpdata3                    ', 'AAAAAgAAAABepo9ETx8R9OJ6E50MyLZL96iD+N1Vg9nQkr9ILDpL0gAAAAAAAAADAAAAA4KwO3biN2vdZuSfptwuviz/sUEjlmPXVp0soJmU+kLYAAAAAQAAAEiBCOC7Sy05tdMQRkZGTEyO8cMGUtVArEWBS4m3OBENUAAAAABeHIDqAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABAAAASIEI4LtLLTm10xBGRkZMTI7xwwZS1UCsRYFLibc4EQ1QAAAAAF4cgOoAAAACAAAACAAAAAEAAAAMAAAACAAAAAMAD0JAAAAAAAAAAECa8Ye3ao7O1/rCIwscRHc5ggJVe/27JcSgNK6trluaTJY273KLhY2CjKgxx+fzWrq6w9b6+g7DxKdtMUPgsj4KAAAAAF6mj0RPHxH04noTnQzItkv3qIP43VWD2dCSv0gsOkvSAAAAAAAAAAMAAAACAAAAAQAAAEiBCOC7Sy05tdMQRkZGTEyO8cMGUtVArEWBS4m3OBENUAAAAABeHIDqAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABgrA7duI3a91m5J+m3C6+LP+xQSOWY9dWnSygmZT6QtgAAABAZbCX8QaVeNvWgN18oAjyXGoXL4f+70H+7oWppXICCKIk/PGpZeUVLouKaFS4LLn90tTFVxprGR4Q5Kihq0f/AQAAAAEowro+yjYkxO+e5vEyAdu/fo0TbeRNLMKuifaAUaRoCAAAAAIAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAABkAAAAAgAAAAEAAAAAAAAAAAAAAAEAAAAAAAAABgAAAAFVU0QAAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5Mf/////////8AAAAAAAAAAfmQLe8AAABAqxcJNBqySnWC2ch/ABPz4opjb6Ev9u/tQwUsn8fP26yCd1/leET/rkQUn3fq731yG05owJgMcVfOwAX//YuiAwAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAGQAAAACAAAAAQAAAAAAAAAAAAAAAQAAAAAAAAAGAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe9//////////wAAAAAAAAABruS+TAAAAEAfZJiltqt7+0H8vDzHpBG9U0yOYsapCNAaIF6zre4DtetkG5IdnUk1H3g6L3NDwGn4Q18bYVQJbC7o5QZsowQGAAAAAQAAAAEAAAABAAAAAF6mj0RPHxH04noTnQzItkv3qIP43VWD2dCSv0gsOkvSAAAAAA==');


--
-- Data for Name: trustlines; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO trustlines VALUES ('GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 1, 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4', 'USD', 9223372036854775807, 0, NULL, NULL, 1, 3);
INSERT INTO trustlines VALUES ('GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4', 1, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 'USD', 9223372036854775807, 0, NULL, NULL, 1, 3);


--
-- Data for Name: txfeehistory; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO txfeehistory VALUES ('db398eb4ae89756325643cad21c94e13bfc074b323ee83e141bf701a5d904f1b', 2, 1, 'AAAAAgAAAAMAAAABAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txfeehistory VALUES ('f97caffab8c16023a37884165cb0b3ff1aa2daf4000fef49d21efc847ddbfbea', 2, 2, 'AAAAAgAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/84AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txfeehistory VALUES ('bd486dbdd02d460817671c4a5a7e9d6e865ca29cb41e62d7aaf70a2fee5b36de', 3, 1, 'AAAAAgAAAAMAAAACAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+OcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txfeehistory VALUES ('2e85d9a320409ec6017076f0fb34809dcd723202d5af498af04350faa9a7e361', 3, 2, 'AAAAAgAAAAMAAAACAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+OcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');


--
-- Data for Name: txhistory; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO txhistory VALUES ('db398eb4ae89756325643cad21c94e13bfc074b323ee83e141bf701a5d904f1b', 2, 1, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvkAAAAAAAAAAABVvwF9wAAAEAYjQcPT2G5hqnBmgGGeg9J8l4c1EnUlxklElH9sqZr0971F6OLWfe/m4kpFtI+sI0i1qLit5A0JyWnbhYLW5oD', '2zmOtK6JdWMlZDytIclOE7/AdLMj7oPhQb9wGl2QTxsAAAAAAAAAZAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAA==', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/84AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBs4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txhistory VALUES ('f97caffab8c16023a37884165cb0b3ff1aa2daf4000fef49d21efc847ddbfbea', 2, 2, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAACAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAACVAvkAAAAAAAAAAABVvwF9wAAAEBmKpSgvrwKO20XCOfYfXsGEEUtwYaaEfqSu6ymJmlDma+IX6I7IggbUZMocQdZ94IMAfKdQANqXbIO7ysweeMC', '+Xyv+rjBYCOjeIQWXLCz/xqi2vQAD+9J0h78hH3b++oAAAAAAAAAZAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAA==', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBs4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtq7/TDc4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txhistory VALUES ('bd486dbdd02d460817671c4a5a7e9d6e865ca29cb41e62d7aaf70a2fee5b36de', 3, 1, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt73//////////AAAAAAAAAAGu5L5MAAAAQB9kmKW2q3v7Qfy8PMekEb1TTI5ixqkI0BogXrOt7gO162Qbkh2dSTUfeDovc0PAafhDXxthVAlsLujlBmyjBAY=', 'vUhtvdAtRggXZxxKWn6dboZcopy0HmLXqvcKL+5bNt4AAAAAAAAAZAAAAAAAAAABAAAAAAAAAAYAAAAAAAAAAA==', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+OcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+OcAAAAAgAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==');
INSERT INTO txhistory VALUES ('2e85d9a320409ec6017076f0fb34809dcd723202d5af498af04350faa9a7e361', 3, 2, 'AAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TH//////////AAAAAAAAAAH5kC3vAAAAQKsXCTQaskp1gtnIfwAT8+KKY2+hL/bv7UMFLJ/Hz9usgndf5XhE/65EFJ936u99chtOaMCYDHFXzsAF//2LogM=', 'LoXZoyBAnsYBcHbw+zSAnc1yMgLVr0mK8ENQ+qmn42EAAAAAAAAAZAAAAAAAAAABAAAAAAAAAAYAAAAAAAAAAA==', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+OcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+OcAAAAAgAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAFVU0QAAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==');


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

