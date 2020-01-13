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
INSERT INTO accounts VALUES ('GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4', 9999999900, NULL, NULL, 8589934593, 0, NULL, '', 'AQAAAA==', 0, NULL, 4);


--
-- Data for Name: ban; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: ledgerheaders; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO ledgerheaders VALUES ('63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', '0000000000000000000000000000000000000000000000000000000000000000', '572a2e32ff248a07b0e70fd1f6d318c1facd20b6cc08c33d5775259868125a16', 1, 0, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXKi4y/ySKB7DnD9H20xjB+s0gtswIwz1XdSWYaBJaFgAAAAEN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('4874e847930077ac9b289b103fea982dd684ac41736d2d9abec1039b1a065053', '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', '69b1ded30c0c7a1fdf5306e16643da099d872904d16d9e447b1195be1e1172f0', 2, 1578926406, 'AAAAAGPZj1Nu5o0bJ7W4nyOvUxG3Vpok+vFAOtC1K2M7B76Zu5H9cHd0qAsZj9Q6Y8yIIc6utkf/CO+Lm/0KbsfrzPUAAAAAXhyBRgAAAAAAAAAAP0PjS3Rf7hs8xVIBg2g8xKvqOO/n/g/XwgPR/HB7qe9psd7TDAx6H99TBuFmQ9oJnYcpBNFtnkR7EZW+HhFy8AAAAAIN4Lazp2QAAAAAAAAAAADIAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('a13f312bdbd3c351e42f47ec369f2bf5f38084bc67109ae2c41c6151f542fc17', '4874e847930077ac9b289b103fea982dd684ac41736d2d9abec1039b1a065053', '0f95ba8cd368711ca6ec05a191d38b7eadf21ccd378beb6a6f0e9ed55c739eea', 3, 1578926407, 'AAAADEh06EeTAHesmyibED/qmC3WhKxBc20tmr7BA5saBlBTF/UNPySwMIy6r1MzFBrPdofzmtt/tAQBwAfE43ouyEoAAAAAXhyBRwAAAAIAAAAIAAAAAQAAAAwAAAAIAAAAAwAPQkAAAAAALLKPbMojH+RR+TSBDKGB/tufH2mL12ccCHr1Jn27yPAPlbqM02hxHKbsBaGR04t+rfIczTeL62pvDp7VXHOe6gAAAAMN4Lazp2QAAAAAAAAAAAEsAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('0c9df3cce245c69153b7fe68ebcc3fb17990289baab19cddd98bbb3bbd3cdfca', 'a13f312bdbd3c351e42f47ec369f2bf5f38084bc67109ae2c41c6151f542fc17', 'ec57e04322824b8c551f044a7475ad29bb590f83a1ab76c438a5923a28688009', 4, 1578926408, 'AAAADKE/MSvb08NR5C9H7DafK/XzgIS8ZxCa4sQcYVH1QvwXrZ3Hf1K6+GN+B43uPLk0I7YeRO9dTv6dv72Riu2cSz8AAAAAXhyBSAAAAAAAAAAAD7vJ2GXYn9oO/fo5QrmHKnTVIqBarv7BmCtsbOtbf6TsV+BDIoJLjFUfBEp0da0pu1kPg6GrdsQ4pZI6KGiACQAAAAQN4Lazp2QAAAAAAAAAAAGQAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');


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

INSERT INTO scphistory VALUES ('GD6ZYAIAFE5AYHZ6KZN5IMNQWK2EJ5UCJW3MMQCTCJKK3XYYRU5CLCJG', 2, 'AAAAAP2cAQApOgwfPlZb1DGwsrRE9oJNtsZAUxJUrd8YjTolAAAAAAAAAAIAAAACAAAAAQAAADC7kf1wd3SoCxmP1DpjzIghzq62R/8I74ub/Qpux+vM9QAAAABeHIFGAAAAAAAAAAAAAAABFpk9tob9tZrfioeoU2AEHcnwCcy7eQsE3XWHw4g/5TgAAABANoLBR+XTkuoEjGkmFb6p+O6clLlPzQabE/6wBr6tPs0GzrNdwV+p3feaKyC38QBvCpstzFZjR2i4P5PpKVJ/DA==');
INSERT INTO scphistory VALUES ('GD6ZYAIAFE5AYHZ6KZN5IMNQWK2EJ5UCJW3MMQCTCJKK3XYYRU5CLCJG', 3, 'AAAAAP2cAQApOgwfPlZb1DGwsrRE9oJNtsZAUxJUrd8YjTolAAAAAAAAAAMAAAACAAAAAQAAAEgX9Q0/JLAwjLqvUzMUGs92h/Oa23+0BAHAB8Tjei7ISgAAAABeHIFHAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABFpk9tob9tZrfioeoU2AEHcnwCcy7eQsE3XWHw4g/5TgAAABAiK65t/nF01sdUwXiWmLKvLq1M8XXXRFPsV1aDZK/Ne7/5iZNLHn+LQo+plJp0LGhgGxleN+xSsEgoG/56eytAA==');
INSERT INTO scphistory VALUES ('GD6ZYAIAFE5AYHZ6KZN5IMNQWK2EJ5UCJW3MMQCTCJKK3XYYRU5CLCJG', 4, 'AAAAAP2cAQApOgwfPlZb1DGwsrRE9oJNtsZAUxJUrd8YjTolAAAAAAAAAAQAAAACAAAAAQAAADCtncd/Urr4Y34Hje48uTQjth5E711O/p2/vZGK7ZxLPwAAAABeHIFIAAAAAAAAAAAAAAABFpk9tob9tZrfioeoU2AEHcnwCcy7eQsE3XWHw4g/5TgAAABAjkw8yLiF/4A5iGgU0ANfDYlXIoBVvD7O7oPGWFnzM3obQCOef0Gkme0H8odNZE+QidPTL4yIZnsjA2Bww0SiDg==');


--
-- Data for Name: scpquorums; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO scpquorums VALUES ('16993db686fdb59adf8a87a85360041dc9f009ccbb790b04dd7587c3883fe538', 4, 'AAAAAQAAAAEAAAAA/ZwBACk6DB8+VlvUMbCytET2gk22xkBTElSt3xiNOiUAAAAA');


--
-- Data for Name: storestate; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO storestate VALUES ('databaseschema                  ', '11');
INSERT INTO storestate VALUES ('networkpassphrase               ', 'Test SDF Network ; September 2015');
INSERT INTO storestate VALUES ('forcescponnextlaunch            ', 'false');
INSERT INTO storestate VALUES ('lastscpdata4                    ', 'AAAAAgAAAAD9nAEAKToMHz5WW9QxsLK0RPaCTbbGQFMSVK3fGI06JQAAAAAAAAAEAAAAAxaZPbaG/bWa34qHqFNgBB3J8AnMu3kLBN11h8OIP+U4AAAAAQAAAJitncd/Urr4Y34Hje48uTQjth5E711O/p2/vZGK7ZxLPwAAAABeHIFIAAAAAAAAAAEAAAAA/ZwBACk6DB8+VlvUMbCytET2gk22xkBTElSt3xiNOiUAAABA5Dg/AIQezTjg92j6wggyOzK2sQbSPbo8SVxrbqUW5itxHJjzDQ68twOHGMHnS0z3pklsqxJIwZ3tYePsgIPIDQAAAAEAAACYrZ3Hf1K6+GN+B43uPLk0I7YeRO9dTv6dv72Riu2cSz8AAAAAXhyBSAAAAAAAAAABAAAAAP2cAQApOgwfPlZb1DGwsrRE9oJNtsZAUxJUrd8YjTolAAAAQOQ4PwCEHs044Pdo+sIIMjsytrEG0j26PElca26lFuYrcRyY8w0OvLcDhxjB50tM96ZJbKsSSMGd7WHj7ICDyA0AAABAn0VGLrVoth2oRfaZwon4rD7mNs41lNYvYQvcg7FrIZmK6xGSWc4ezDVaSWgIp8R3MssGAq+IxHt3z0bFSXDyBwAAAAD9nAEAKToMHz5WW9QxsLK0RPaCTbbGQFMSVK3fGI06JQAAAAAAAAAEAAAAAgAAAAEAAAAwrZ3Hf1K6+GN+B43uPLk0I7YeRO9dTv6dv72Riu2cSz8AAAAAXhyBSAAAAAAAAAAAAAAAARaZPbaG/bWa34qHqFNgBB3J8AnMu3kLBN11h8OIP+U4AAAAQI5MPMi4hf+AOYhoFNADXw2JVyKAVbw+zu6DxlhZ8zN6G0Ajnn9BpJntB/KHTWRPkInT0y+MiGZ7IwNgcMNEog4AAAABoT8xK9vTw1HkL0fsNp8r9fOAhLxnEJrixBxhUfVC/BcAAAABAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAA8VyioAAAAAAAAAAH5kC3vAAAAQEceJbYupnWlUerU60gfpFg8Nk2a3A6QMSfVgQoNFZOLjN7zc4w7jBxwiFIUi6pyXJNNQpL2OQxTnV4gs9lDrgQAAAABAAAAAQAAAAEAAAAA/ZwBACk6DB8+VlvUMbCytET2gk22xkBTElSt3xiNOiUAAAAA');
INSERT INTO storestate VALUES ('lastscpdata2                    ', 'AAAAAgAAAAD9nAEAKToMHz5WW9QxsLK0RPaCTbbGQFMSVK3fGI06JQAAAAAAAAACAAAAAxaZPbaG/bWa34qHqFNgBB3J8AnMu3kLBN11h8OIP+U4AAAAAQAAADC7kf1wd3SoCxmP1DpjzIghzq62R/8I74ub/Qpux+vM9QAAAABeHIFGAAAAAAAAAAAAAAABAAAAMLuR/XB3dKgLGY/UOmPMiCHOrrZH/wjvi5v9Cm7H68z1AAAAAF4cgUYAAAAAAAAAAAAAAEDfICpQZNi7WD5/sURhXlP2E9EC72lYfjtIcxAVn5GFuFE3hhrylUzNVj3r4nt8JfcQoHEiX3d71DMV+VHvHY4FAAAAAP2cAQApOgwfPlZb1DGwsrRE9oJNtsZAUxJUrd8YjTolAAAAAAAAAAIAAAACAAAAAQAAADC7kf1wd3SoCxmP1DpjzIghzq62R/8I74ub/Qpux+vM9QAAAABeHIFGAAAAAAAAAAAAAAABFpk9tob9tZrfioeoU2AEHcnwCcy7eQsE3XWHw4g/5TgAAABANoLBR+XTkuoEjGkmFb6p+O6clLlPzQabE/6wBr6tPs0GzrNdwV+p3feaKyC38QBvCpstzFZjR2i4P5PpKVJ/DAAAAAFj2Y9TbuaNGye1uJ8jr1MRt1aaJPrxQDrQtStjOwe+mQAAAAIAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAABkAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+QAAAAAAAAAAAFW/AX3AAAAQBiNBw9PYbmGqcGaAYZ6D0nyXhzUSdSXGSUSUf2ypmvT3vUXo4tZ97+biSkW0j6wjSLWouK3kDQnJaduFgtbmgMAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAABkAAAAAAAAAAIAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+QAAAAAAAAAAAFW/AX3AAAAQGYqlKC+vAo7bRcI59h9ewYQRS3BhpoR+pK7rKYmaUOZr4hfojsiCBtRkyhxB1n3ggwB8p1AA2pdsg7vKzB54wIAAAABAAAAAQAAAAEAAAAA/ZwBACk6DB8+VlvUMbCytET2gk22xkBTElSt3xiNOiUAAAAA');
INSERT INTO storestate VALUES ('ledgerupgrades                  ', '{
    "time": 1578926406,
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
INSERT INTO storestate VALUES ('lastscpdata3                    ', 'AAAAAgAAAAD9nAEAKToMHz5WW9QxsLK0RPaCTbbGQFMSVK3fGI06JQAAAAAAAAADAAAAAxaZPbaG/bWa34qHqFNgBB3J8AnMu3kLBN11h8OIP+U4AAAAAQAAAEgX9Q0/JLAwjLqvUzMUGs92h/Oa23+0BAHAB8Tjei7ISgAAAABeHIFHAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABAAAASBf1DT8ksDCMuq9TMxQaz3aH85rbf7QEAcAHxON6LshKAAAAAF4cgUcAAAACAAAACAAAAAEAAAAMAAAACAAAAAMAD0JAAAAAAAAAAECA+v/fKZvSh2217SibmcICmi+8xSXS+uqDWQdY9qJhMW5t2ZAYeHvQFpUTuzbzytonkLPtD5rwpjAxE7kPM+8IAAAAAP2cAQApOgwfPlZb1DGwsrRE9oJNtsZAUxJUrd8YjTolAAAAAAAAAAMAAAACAAAAAQAAAEgX9Q0/JLAwjLqvUzMUGs92h/Oa23+0BAHAB8Tjei7ISgAAAABeHIFHAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABFpk9tob9tZrfioeoU2AEHcnwCcy7eQsE3XWHw4g/5TgAAABAiK65t/nF01sdUwXiWmLKvLq1M8XXXRFPsV1aDZK/Ne7/5iZNLHn+LQo+plJp0LGhgGxleN+xSsEgoG/56eytAAAAAAFIdOhHkwB3rJsomxA/6pgt1oSsQXNtLZq+wQObGgZQUwAAAAEAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAABkAAAAAgAAAAEAAAAAAAAAAAAAAAEAAAAAAAAABgAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vf/////////8AAAAAAAAAAa7kvkwAAABAH2SYpbare/tB/Lw8x6QRvVNMjmLGqQjQGiBes63uA7XrZBuSHZ1JNR94Oi9zQ8Bp+ENfG2FUCWwu6OUGbKMEBgAAAAEAAAABAAAAAQAAAAD9nAEAKToMHz5WW9QxsLK0RPaCTbbGQFMSVK3fGI06JQAAAAA=');
INSERT INTO storestate VALUES ('lastclosedledger                ', '0c9df3cce245c69153b7fe68ebcc3fb17990289baab19cddd98bbb3bbd3cdfca');
INSERT INTO storestate VALUES ('historyarchivestate             ', '{
    "version": 1,
    "server": "v12.2.0",
    "currentLedger": 4,
    "currentBuckets": [
        {
            "curr": "7014ff0528e4340a2575da741d59a05da99b146b1ab1053688da4161d07efc38",
            "next": {
                "state": 0
            },
            "snap": "70972ed7d881eacdb5a94557771ac78fb1bf84280068420aa7475687e2d15bfb"
        },
        {
            "curr": "ef31a20a398ee73ce22275ea8177786bac54656f33dcc4f3fec60d55ddf163d9",
            "next": {
                "state": 1,
                "output": "70972ed7d881eacdb5a94557771ac78fb1bf84280068420aa7475687e2d15bfb"
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


--
-- Data for Name: trustlines; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO trustlines VALUES ('GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 1, 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4', 'USD', 9223372036854775807, 1012345000, NULL, NULL, 1, 4);


--
-- Data for Name: txfeehistory; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO txfeehistory VALUES ('db398eb4ae89756325643cad21c94e13bfc074b323ee83e141bf701a5d904f1b', 2, 1, 'AAAAAgAAAAMAAAABAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txfeehistory VALUES ('f97caffab8c16023a37884165cb0b3ff1aa2daf4000fef49d21efc847ddbfbea', 2, 2, 'AAAAAgAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/84AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txfeehistory VALUES ('bd486dbdd02d460817671c4a5a7e9d6e865ca29cb41e62d7aaf70a2fee5b36de', 3, 1, 'AAAAAgAAAAMAAAACAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+OcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txfeehistory VALUES ('5243c6934f0fb5017758869aa3bff53ddc389cf81861cfae610cc225aae18ccc', 4, 1, 'AAAAAgAAAAMAAAACAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+OcAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');


--
-- Data for Name: txhistory; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO txhistory VALUES ('db398eb4ae89756325643cad21c94e13bfc074b323ee83e141bf701a5d904f1b', 2, 1, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvkAAAAAAAAAAABVvwF9wAAAEAYjQcPT2G5hqnBmgGGeg9J8l4c1EnUlxklElH9sqZr0971F6OLWfe/m4kpFtI+sI0i1qLit5A0JyWnbhYLW5oD', '2zmOtK6JdWMlZDytIclOE7/AdLMj7oPhQb9wGl2QTxsAAAAAAAAAZAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAA==', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/84AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBs4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txhistory VALUES ('f97caffab8c16023a37884165cb0b3ff1aa2daf4000fef49d21efc847ddbfbea', 2, 2, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAACAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAACVAvkAAAAAAAAAAABVvwF9wAAAEBmKpSgvrwKO20XCOfYfXsGEEUtwYaaEfqSu6ymJmlDma+IX6I7IggbUZMocQdZ94IMAfKdQANqXbIO7ysweeMC', '+Xyv+rjBYCOjeIQWXLCz/xqi2vQAD+9J0h78hH3b++oAAAAAAAAAZAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAA==', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBs4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtq7/TDc4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txhistory VALUES ('bd486dbdd02d460817671c4a5a7e9d6e865ca29cb41e62d7aaf70a2fee5b36de', 3, 1, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt73//////////AAAAAAAAAAGu5L5MAAAAQB9kmKW2q3v7Qfy8PMekEb1TTI5ixqkI0BogXrOt7gO162Qbkh2dSTUfeDovc0PAafhDXxthVAlsLujlBmyjBAY=', 'vUhtvdAtRggXZxxKWn6dboZcopy0HmLXqvcKL+5bNt4AAAAAAAAAZAAAAAAAAAABAAAAAAAAAAYAAAAAAAAAAA==', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+OcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+OcAAAAAgAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==');
INSERT INTO txhistory VALUES ('5243c6934f0fb5017758869aa3bff53ddc389cf81861cfae610cc225aae18ccc', 4, 1, 'AAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAA8VyioAAAAAAAAAAH5kC3vAAAAQEceJbYupnWlUerU60gfpFg8Nk2a3A6QMSfVgQoNFZOLjN7zc4w7jBxwiFIUi6pyXJNNQpL2OQxTnV4gs9lDrgQ=', 'UkPGk08PtQF3WIaao7/1Pdw4nPgYYc+uYQzCJarhjMwAAAAAAAAAZAAAAAAAAAABAAAAAAAAAAEAAAAAAAAAAA==', 'AAAAAQAAAAIAAAADAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvjnAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvjnAAAAAIAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAEAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAADxXKKh//////////wAAAAEAAAAAAAAAAA==');


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

