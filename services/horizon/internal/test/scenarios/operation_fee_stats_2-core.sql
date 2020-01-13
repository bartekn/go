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

INSERT INTO accounts VALUES ('GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 1000000000000000000, NULL, NULL, 0, 0, NULL, '', 'AQAAAA==', 0, NULL, 1);


--
-- Data for Name: ban; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: ledgerheaders; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO ledgerheaders VALUES ('63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', '0000000000000000000000000000000000000000000000000000000000000000', '572a2e32ff248a07b0e70fd1f6d318c1facd20b6cc08c33d5775259868125a16', 1, 0, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXKi4y/ySKB7DnD9H20xjB+s0gtswIwz1XdSWYaBJaFgAAAAEN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('29d8ed7acbe87818f0bdef87312e13a48b9af72345c9f62174fe81b16b397489', '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', '735227ed398461291237687b08446aa2c9b096e0c98a462dadda569f05dd2484', 2, 1578926349, 'AAAAAGPZj1Nu5o0bJ7W4nyOvUxG3Vpok+vFAOtC1K2M7B76ZuZRHr9UdXKbTKiclfOjy72YZFJUkJPVcKT5htvorm1QAAAAAXhyBDQAAAAAAAAAA3z9hmASpL9tAVxktxD3XSOp3itxSvEmM6AUkwBS4ERlzUiftOYRhKRI3aHsIRGqiybCW4MmKRi2t2lafBd0khAAAAAIN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('c6b44465124f02b5d0809c8d5e0b267c9abf74e2eeef0fa41c1adeeacfccebff', '29d8ed7acbe87818f0bdef87312e13a48b9af72345c9f62174fe81b16b397489', '8d29c449b6b760b7b20ffb1672bbed234204aafe12d21ae4834e9bb38fc7ee59', 3, 1578926350, 'AAAADCnY7XrL6HgY8L3vhzEuE6SLmvcjRcn2IXT+gbFrOXSJVuTQyRtW66FZdcE6x2ZFbxcPIcBqrIx01unJjfmTQmsAAAAAXhyBDgAAAAIAAAAIAAAAAQAAAAwAAAAIAAAAAwAPQkAAAAAA3z9hmASpL9tAVxktxD3XSOp3itxSvEmM6AUkwBS4ERmNKcRJtrdgt7IP+xZyu+0jQgSq/hLSGuSDTpuzj8fuWQAAAAMN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('fc64b9795686e5a6089fc145a1d51decf0c9c9129bef78ba2c2039ece2e1ebff', 'c6b44465124f02b5d0809c8d5e0b267c9abf74e2eeef0fa41c1adeeacfccebff', 'af9663530bfcba085b6f3fda4a2f143b74835a272e60750e592f3f886e11f0dd', 4, 1578926351, 'AAAADMa0RGUSTwK10ICcjV4LJnyav3Ti7u8PpBwa3urPzOv/UkkODYUmp7194JbjE09Ml0yo+Btas+QDuuk4PyTb7LMAAAAAXhyBDwAAAAAAAAAA3z9hmASpL9tAVxktxD3XSOp3itxSvEmM6AUkwBS4ERmvlmNTC/y6CFtvP9pKLxQ7dINaJy5gdQ5ZLz+IbhHw3QAAAAQN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('aae72b05f52b894fb52abe07ccb4b73b5becb4741a376940ae11f3256c956f18', 'fc64b9795686e5a6089fc145a1d51decf0c9c9129bef78ba2c2039ece2e1ebff', 'af9663530bfcba085b6f3fda4a2f143b74835a272e60750e592f3f886e11f0dd', 5, 1578926352, 'AAAADPxkuXlWhuWmCJ/BRaHVHezwyckSm+94uiwgOezi4ev/O8Hz0D7vi1o0vob2KdHRc441ewD832f0/sbQgo+L8IsAAAAAXhyBEAAAAAAAAAAA3z9hmASpL9tAVxktxD3XSOp3itxSvEmM6AUkwBS4ERmvlmNTC/y6CFtvP9pKLxQ7dINaJy5gdQ5ZLz+IbhHw3QAAAAUN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('2a8f845fb8e7241d1bc770eba8b5c1f1a90e6d3714930242adcebeb96b779add', 'aae72b05f52b894fb52abe07ccb4b73b5becb4741a376940ae11f3256c956f18', '2cdab3cf0dd62db6f3f4f8b45c3d00c5a0c9db5f9ccfc6f35797b946df35a53b', 6, 1578926353, 'AAAADKrnKwX1K4lPtSq+B8y0tztb7LR0GjdpQK4R8yVslW8YxinN4HuV2cBXRhO8cFbbXAe5GbAPhYw3DbeAlyG5QpQAAAAAXhyBEQAAAAAAAAAA3z9hmASpL9tAVxktxD3XSOp3itxSvEmM6AUkwBS4ERks2rPPDdYttvP0+LRcPQDFoMnbX5zPxvNXl7lG3zWlOwAAAAYN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('9b0c896d7bcd8bf188392ab826b498b11e94d5b2469802d480500ce57ec1e1ab', '2a8f845fb8e7241d1bc770eba8b5c1f1a90e6d3714930242adcebeb96b779add', '2cdab3cf0dd62db6f3f4f8b45c3d00c5a0c9db5f9ccfc6f35797b946df35a53b', 7, 1578926354, 'AAAADCqPhF+45yQdG8dw66i1wfGpDm03FJMCQq3Ovrlrd5rdmAEXWx38L3osLsLjxv/icpFTuIgLxn8IdVQ5FKOAtEkAAAAAXhyBEgAAAAAAAAAA3z9hmASpL9tAVxktxD3XSOp3itxSvEmM6AUkwBS4ERks2rPPDdYttvP0+LRcPQDFoMnbX5zPxvNXl7lG3zWlOwAAAAcN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');


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

INSERT INTO scphistory VALUES ('GC6U7E5VPVZUO72DKGA4BEFPS2WXDK5KJ2M4OJ73U6GW5BBBRMVFTJTH', 2, 'AAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAAAAAAAIAAAACAAAAAQAAADC5lEev1R1cptMqJyV86PLvZhkUlSQk9VwpPmG2+iubVAAAAABeHIENAAAAAAAAAAAAAAABlIYQHnMFDa8OvpSbuiERUcij3RDzCRkwBk6DTosLQT8AAABAFeqJ/MUkym1N7ZJsL2bq+JnLc/4JVdNpbRcfAB903SbGlM15rNIPfKZnixbDw5JsOqG4cVXINR8EYZTOp6GIBg==');
INSERT INTO scphistory VALUES ('GC6U7E5VPVZUO72DKGA4BEFPS2WXDK5KJ2M4OJ73U6GW5BBBRMVFTJTH', 3, 'AAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAAAAAAAMAAAACAAAAAQAAAEhW5NDJG1broVl1wTrHZkVvFw8hwGqsjHTW6cmN+ZNCawAAAABeHIEOAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABlIYQHnMFDa8OvpSbuiERUcij3RDzCRkwBk6DTosLQT8AAABA6FuKPi+WWP7yylJsDHgVv5IaF6CKjay4s7EnUutJLygqWXgjTVzRwmP44JabDFRDGOA+CRHIggH1hh7lhVOwBA==');
INSERT INTO scphistory VALUES ('GC6U7E5VPVZUO72DKGA4BEFPS2WXDK5KJ2M4OJ73U6GW5BBBRMVFTJTH', 4, 'AAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAAAAAAAQAAAACAAAAAQAAADBSSQ4NhSanvX3gluMTT0yXTKj4G1qz5AO66Tg/JNvsswAAAABeHIEPAAAAAAAAAAAAAAABlIYQHnMFDa8OvpSbuiERUcij3RDzCRkwBk6DTosLQT8AAABArtnt8iCJwlX2AelkM3XgXh09N4BTcXB2LK1bYwFmlXcrVKTwrcYBxO/CObZvZLMEG9QeTYj5Zl57kwSkYkK4CA==');
INSERT INTO scphistory VALUES ('GC6U7E5VPVZUO72DKGA4BEFPS2WXDK5KJ2M4OJ73U6GW5BBBRMVFTJTH', 5, 'AAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAAAAAAAUAAAACAAAAAQAAADA7wfPQPu+LWjS+hvYp0dFzjjV7APzfZ/T+xtCCj4vwiwAAAABeHIEQAAAAAAAAAAAAAAABlIYQHnMFDa8OvpSbuiERUcij3RDzCRkwBk6DTosLQT8AAABAxPV6bcozL68/OH5anF0wpLTT6/LaeeY0iEWNOzZggKmTcfSbJ12WHizY/iTSLHW63ifeq4UbEx9NI13KylVwBw==');
INSERT INTO scphistory VALUES ('GC6U7E5VPVZUO72DKGA4BEFPS2WXDK5KJ2M4OJ73U6GW5BBBRMVFTJTH', 6, 'AAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAAAAAAAYAAAACAAAAAQAAADDGKc3ge5XZwFdGE7xwVttcB7kZsA+FjDcNt4CXIblClAAAAABeHIERAAAAAAAAAAAAAAABlIYQHnMFDa8OvpSbuiERUcij3RDzCRkwBk6DTosLQT8AAABAS499nWAqevaqrbrlpT21QZ1dB1AFfR7K8fzS6N3YiCrg+nzON3LJxEJKPsswNnEKR8KeqvrY6ASqIMpAbgjfBw==');
INSERT INTO scphistory VALUES ('GC6U7E5VPVZUO72DKGA4BEFPS2WXDK5KJ2M4OJ73U6GW5BBBRMVFTJTH', 7, 'AAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAAAAAAAcAAAACAAAAAQAAADCYARdbHfwveiwuwuPG/+JykVO4iAvGfwh1VDkUo4C0SQAAAABeHIESAAAAAAAAAAAAAAABlIYQHnMFDa8OvpSbuiERUcij3RDzCRkwBk6DTosLQT8AAABASMI69dKhev2tBpltyfUAUOJDkGGizoR9yl/R4cO52HH0Vx/iJqcqqtP02YLI+gyXH9xaF5D1w8FyEt5+ItZJDA==');


--
-- Data for Name: scpquorums; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO scpquorums VALUES ('9486101e73050daf0ebe949bba211151c8a3dd10f3091930064e834e8b0b413f', 7, 'AAAAAQAAAAEAAAAAvU+TtX1zR39DUYHAkK+WrXGrqk6Zxyf7p41uhCGLKlkAAAAA');


--
-- Data for Name: storestate; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO storestate VALUES ('lastclosedledger                ', '9b0c896d7bcd8bf188392ab826b498b11e94d5b2469802d480500ce57ec1e1ab');
INSERT INTO storestate VALUES ('databaseschema                  ', '11');
INSERT INTO storestate VALUES ('networkpassphrase               ', 'Test SDF Network ; September 2015');
INSERT INTO storestate VALUES ('forcescponnextlaunch            ', 'false');
INSERT INTO storestate VALUES ('historyarchivestate             ', '{
    "version": 1,
    "server": "v12.2.0",
    "currentLedger": 7,
    "currentBuckets": [
        {
            "curr": "a23514736957bb8c0a52047d696ec74f10fdc220d83a0a872af12ff871af9fad",
            "next": {
                "state": 0
            },
            "snap": "a23514736957bb8c0a52047d696ec74f10fdc220d83a0a872af12ff871af9fad"
        },
        {
            "curr": "e5ebf37dc1a78550aa4c6a691b486911633079e0f149997760ed32e08c219a94",
            "next": {
                "state": 1,
                "output": "a23514736957bb8c0a52047d696ec74f10fdc220d83a0a872af12ff871af9fad"
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
INSERT INTO storestate VALUES ('lastscpdata2                    ', 'AAAAAgAAAAC9T5O1fXNHf0NRgcCQr5atcauqTpnHJ/unjW6EIYsqWQAAAAAAAAACAAAAA5SGEB5zBQ2vDr6Um7ohEVHIo90Q8wkZMAZOg06LC0E/AAAAAQAAADC5lEev1R1cptMqJyV86PLvZhkUlSQk9VwpPmG2+iubVAAAAABeHIENAAAAAAAAAAAAAAABAAAAMLmUR6/VHVym0yonJXzo8u9mGRSVJCT1XCk+Ybb6K5tUAAAAAF4cgQ0AAAAAAAAAAAAAAEB+o9fPrI4u/lVAc1txCxr/JjJB+G3Ng8GZS1XkoJuV4L3O+5DrNTTNvJpls/R61MAwXwEbpINzfcI0UYvsua8FAAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAAAAAAAIAAAACAAAAAQAAADC5lEev1R1cptMqJyV86PLvZhkUlSQk9VwpPmG2+iubVAAAAABeHIENAAAAAAAAAAAAAAABlIYQHnMFDa8OvpSbuiERUcij3RDzCRkwBk6DTosLQT8AAABAFeqJ/MUkym1N7ZJsL2bq+JnLc/4JVdNpbRcfAB903SbGlM15rNIPfKZnixbDw5JsOqG4cVXINR8EYZTOp6GIBgAAAAFj2Y9TbuaNGye1uJ8jr1MRt1aaJPrxQDrQtStjOwe+mQAAAAAAAAABAAAAAQAAAAEAAAAAvU+TtX1zR39DUYHAkK+WrXGrqk6Zxyf7p41uhCGLKlkAAAAA');
INSERT INTO storestate VALUES ('ledgerupgrades                  ', '{
    "time": 1578926349,
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
INSERT INTO storestate VALUES ('lastscpdata5                    ', 'AAAAAgAAAAC9T5O1fXNHf0NRgcCQr5atcauqTpnHJ/unjW6EIYsqWQAAAAAAAAAFAAAAA5SGEB5zBQ2vDr6Um7ohEVHIo90Q8wkZMAZOg06LC0E/AAAAAQAAAJg7wfPQPu+LWjS+hvYp0dFzjjV7APzfZ/T+xtCCj4vwiwAAAABeHIEQAAAAAAAAAAEAAAAAvU+TtX1zR39DUYHAkK+WrXGrqk6Zxyf7p41uhCGLKlkAAABABCYP+DA7q5pWdNrU/IDyJ8EKEsCygdqJWIQOD4euiRX/ha4v75+wFrRoNo4Kgf6erT0UwRSFvfuCzrh0Bji+AQAAAAEAAACYO8Hz0D7vi1o0vob2KdHRc441ewD832f0/sbQgo+L8IsAAAAAXhyBEAAAAAAAAAABAAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAQAQmD/gwO6uaVnTa1PyA8ifBChLAsoHaiViEDg+HrokV/4WuL++fsBa0aDaOCoH+nq09FMEUhb37gs64dAY4vgEAAABAXgUmr4uRlHUqC+oRbBcRGvnS30HpUgF0+it/85aosyw7z/cB+znhEgU2PnDl5eQYuDRroyJOzZ17ayfKRg1cDQAAAAC9T5O1fXNHf0NRgcCQr5atcauqTpnHJ/unjW6EIYsqWQAAAAAAAAAFAAAAAgAAAAEAAAAwO8Hz0D7vi1o0vob2KdHRc441ewD832f0/sbQgo+L8IsAAAAAXhyBEAAAAAAAAAAAAAAAAZSGEB5zBQ2vDr6Um7ohEVHIo90Q8wkZMAZOg06LC0E/AAAAQMT1em3KMy+vPzh+WpxdMKS00+vy2nnmNIhFjTs2YICpk3H0myddlh4s2P4k0ix1ut4n3quFGxMfTSNdyspVcAcAAAAB/GS5eVaG5aYIn8FFodUd7PDJyRKb73i6LCA57OLh6/8AAAAAAAAAAQAAAAEAAAABAAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAAA==');
INSERT INTO storestate VALUES ('lastscpdata3                    ', 'AAAAAgAAAAC9T5O1fXNHf0NRgcCQr5atcauqTpnHJ/unjW6EIYsqWQAAAAAAAAADAAAAA5SGEB5zBQ2vDr6Um7ohEVHIo90Q8wkZMAZOg06LC0E/AAAAAQAAAEhW5NDJG1broVl1wTrHZkVvFw8hwGqsjHTW6cmN+ZNCawAAAABeHIEOAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABAAAASFbk0MkbVuuhWXXBOsdmRW8XDyHAaqyMdNbpyY35k0JrAAAAAF4cgQ4AAAACAAAACAAAAAEAAAAMAAAACAAAAAMAD0JAAAAAAAAAAEBXGvXBlqOcBKEqyijsvZ9Iclvp5U2sycTYLgF/cU5pC443nHCoz+Q6w/e0ZuDYMU/vbcLzy7ZfYhwpHTvlWEMLAAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAAAAAAAMAAAACAAAAAQAAAEhW5NDJG1broVl1wTrHZkVvFw8hwGqsjHTW6cmN+ZNCawAAAABeHIEOAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABlIYQHnMFDa8OvpSbuiERUcij3RDzCRkwBk6DTosLQT8AAABA6FuKPi+WWP7yylJsDHgVv5IaF6CKjay4s7EnUutJLygqWXgjTVzRwmP44JabDFRDGOA+CRHIggH1hh7lhVOwBAAAAAEp2O16y+h4GPC974cxLhOki5r3I0XJ9iF0/oGxazl0iQAAAAAAAAABAAAAAQAAAAEAAAAAvU+TtX1zR39DUYHAkK+WrXGrqk6Zxyf7p41uhCGLKlkAAAAA');
INSERT INTO storestate VALUES ('lastscpdata4                    ', 'AAAAAgAAAAC9T5O1fXNHf0NRgcCQr5atcauqTpnHJ/unjW6EIYsqWQAAAAAAAAAEAAAAA5SGEB5zBQ2vDr6Um7ohEVHIo90Q8wkZMAZOg06LC0E/AAAAAQAAAJhSSQ4NhSanvX3gluMTT0yXTKj4G1qz5AO66Tg/JNvsswAAAABeHIEPAAAAAAAAAAEAAAAAvU+TtX1zR39DUYHAkK+WrXGrqk6Zxyf7p41uhCGLKlkAAABAHAvz//B197Gr4UZaUyXxFlnMqRboT6zOQvcxsm8/+qAm7bFUSMaPq8JrlaGZqLz/UG2Zi2R4Rikuw5qBVh0MDQAAAAEAAACYUkkODYUmp7194JbjE09Ml0yo+Btas+QDuuk4PyTb7LMAAAAAXhyBDwAAAAAAAAABAAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAQBwL8//wdfexq+FGWlMl8RZZzKkW6E+szkL3MbJvP/qgJu2xVEjGj6vCa5Whmai8/1BtmYtkeEYpLsOagVYdDA0AAABAfSSWnQL1J3c7Pm9shofsCH/aK+LrMS7DNHq99L9jOoPkZaU1djr4slxF2jyoLzepH6SCUNbnfRGawhVuEWGQCgAAAAC9T5O1fXNHf0NRgcCQr5atcauqTpnHJ/unjW6EIYsqWQAAAAAAAAAEAAAAAgAAAAEAAAAwUkkODYUmp7194JbjE09Ml0yo+Btas+QDuuk4PyTb7LMAAAAAXhyBDwAAAAAAAAAAAAAAAZSGEB5zBQ2vDr6Um7ohEVHIo90Q8wkZMAZOg06LC0E/AAAAQK7Z7fIgicJV9gHpZDN14F4dPTeAU3FwdiytW2MBZpV3K1Sk8K3GAcTvwjm2b2SzBBvUHk2I+WZee5MEpGJCuAgAAAABxrREZRJPArXQgJyNXgsmfJq/dOLu7w+kHBre6s/M6/8AAAAAAAAAAQAAAAEAAAABAAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAAA==');
INSERT INTO storestate VALUES ('lastscpdata6                    ', 'AAAAAgAAAAC9T5O1fXNHf0NRgcCQr5atcauqTpnHJ/unjW6EIYsqWQAAAAAAAAAGAAAAA5SGEB5zBQ2vDr6Um7ohEVHIo90Q8wkZMAZOg06LC0E/AAAAAQAAAJjGKc3ge5XZwFdGE7xwVttcB7kZsA+FjDcNt4CXIblClAAAAABeHIERAAAAAAAAAAEAAAAAvU+TtX1zR39DUYHAkK+WrXGrqk6Zxyf7p41uhCGLKlkAAABAqBTpk1hvG1vNiqDhCExXKoDzprjghAVXYB9rnS3dGjc10U/ojTfBkanLyhe+Jjchco08Un79WFiXc24+54puAgAAAAEAAACYxinN4HuV2cBXRhO8cFbbXAe5GbAPhYw3DbeAlyG5QpQAAAAAXhyBEQAAAAAAAAABAAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAQKgU6ZNYbxtbzYqg4QhMVyqA86a44IQFV2Afa50t3Ro3NdFP6I03wZGpy8oXviY3IXKNPFJ+/VhYl3NuPueKbgIAAABALfwaYiWe65WJtvf7Gub/BTe9excnX+ZdZY9V5qNV/w86n9QHSEJz/O9FTHEddmHumiazHbP61ctH4mDraT5ABwAAAAC9T5O1fXNHf0NRgcCQr5atcauqTpnHJ/unjW6EIYsqWQAAAAAAAAAGAAAAAgAAAAEAAAAwxinN4HuV2cBXRhO8cFbbXAe5GbAPhYw3DbeAlyG5QpQAAAAAXhyBEQAAAAAAAAAAAAAAAZSGEB5zBQ2vDr6Um7ohEVHIo90Q8wkZMAZOg06LC0E/AAAAQEuPfZ1gKnr2qq265aU9tUGdXQdQBX0eyvH80ujd2Igq4Pp8zjdyycRCSj7LMDZxCkfCnqr62OgEqiDKQG4I3wcAAAABqucrBfUriU+1Kr4HzLS3O1vstHQaN2lArhHzJWyVbxgAAAAAAAAAAQAAAAEAAAABAAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAAA==');
INSERT INTO storestate VALUES ('lastscpdata7                    ', 'AAAAAgAAAAC9T5O1fXNHf0NRgcCQr5atcauqTpnHJ/unjW6EIYsqWQAAAAAAAAAHAAAAA5SGEB5zBQ2vDr6Um7ohEVHIo90Q8wkZMAZOg06LC0E/AAAAAQAAAJiYARdbHfwveiwuwuPG/+JykVO4iAvGfwh1VDkUo4C0SQAAAABeHIESAAAAAAAAAAEAAAAAvU+TtX1zR39DUYHAkK+WrXGrqk6Zxyf7p41uhCGLKlkAAABA+jorsAxYoGrDqBJmsWJRk/vagLithvOzBxPUAQYffKFHx63RMOP9mSud+ZYgkHcNup/V2EiZE/vh7tgmypD1AgAAAAEAAACYmAEXWx38L3osLsLjxv/icpFTuIgLxn8IdVQ5FKOAtEkAAAAAXhyBEgAAAAAAAAABAAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAQPo6K7AMWKBqw6gSZrFiUZP72oC4rYbzswcT1AEGH3yhR8et0TDj/ZkrnfmWIJB3Dbqf1dhImRP74e7YJsqQ9QIAAABAFfKgKcXLnm51LVoKH7D4l++jIjdgT4cQKZG899xJpLcm3tI5llwb3cryOfavPAjX4hupZJItsNUtXwB9doX/DAAAAAC9T5O1fXNHf0NRgcCQr5atcauqTpnHJ/unjW6EIYsqWQAAAAAAAAAHAAAAAgAAAAEAAAAwmAEXWx38L3osLsLjxv/icpFTuIgLxn8IdVQ5FKOAtEkAAAAAXhyBEgAAAAAAAAAAAAAAAZSGEB5zBQ2vDr6Um7ohEVHIo90Q8wkZMAZOg06LC0E/AAAAQEjCOvXSoXr9rQaZbcn1AFDiQ5Bhos6Efcpf0eHDudhx9Fcf4ianKqrT9NmCyPoMlx/cWheQ9cPBchLefiLWSQwAAAABKo+EX7jnJB0bx3DrqLXB8akObTcUkwJCrc6+uWt3mt0AAAAAAAAAAQAAAAEAAAABAAAAAL1Pk7V9c0d/Q1GBwJCvlq1xq6pOmccn+6eNboQhiypZAAAAAA==');


--
-- Data for Name: trustlines; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: txfeehistory; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: txhistory; Type: TABLE DATA; Schema: public; Owner: -
--



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

