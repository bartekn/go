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

INSERT INTO accounts VALUES ('GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 999999997999999800, NULL, NULL, 2, 0, NULL, '', 'AQAAAA==', 0, NULL, 2);
INSERT INTO accounts VALUES ('GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4', 999999900, NULL, NULL, 8589934593, 0, NULL, '', 'AQAAAA==', 0, NULL, 4);
INSERT INTO accounts VALUES ('GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 999999800, NULL, NULL, 8589934594, 1, NULL, '', 'AQAAAA==', 0, NULL, 5);


--
-- Data for Name: ban; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: ledgerheaders; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO ledgerheaders VALUES ('63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', '0000000000000000000000000000000000000000000000000000000000000000', '572a2e32ff248a07b0e70fd1f6d318c1facd20b6cc08c33d5775259868125a16', 1, 0, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXKi4y/ySKB7DnD9H20xjB+s0gtswIwz1XdSWYaBJaFgAAAAEN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('a4ce6ff7c095a2aad16ba0f6b7628706dcab5bd6b42757bbca2218d982698b76', '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', 'aa8b1ab49f50fced171d1a71ecacb11bde53924c80728ca72b3801e240b93a6d', 2, 1578926192, 'AAAAAGPZj1Nu5o0bJ7W4nyOvUxG3Vpok+vFAOtC1K2M7B76ZUJe9O5kAzNzu/6p0ZJoZ88h0TDub3uYslZJ7cSsRWgAAAAAAXhyAcAAAAAAAAAAAAnQIKiwQ7y1yg69ER0rE+8ttWxjdS9dphrI7bdn6YS6qixq0n1D87RcdGnHsrLEb3lOSTIByjKcrOAHiQLk6bQAAAAIN4Lazp2QAAAAAAAAAAADIAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('5c0fb7c6a4c23e937765e4fa97518b7cb8868dd5bfb01f67d15fa2d823efe144', 'a4ce6ff7c095a2aad16ba0f6b7628706dcab5bd6b42757bbca2218d982698b76', '3e02087bf603a74694c4fcecc887ad7204d75c043497fec3ee30264962ef6142', 3, 1578926193, 'AAAADKTOb/fAlaKq0Wug9rdihwbcq1vWtCdXu8oiGNmCaYt2/cKUvps8gCTCseIaZTaLYFanJ0p0H2Xv6dA9gatEX98AAAAAXhyAcQAAAAIAAAAIAAAAAQAAAAwAAAAIAAAAAwAPQkAAAAAALLKPbMojH+RR+TSBDKGB/tufH2mL12ccCHr1Jn27yPA+Agh79gOnRpTE/OzIh61yBNdcBDSX/sPuMCZJYu9hQgAAAAMN4Lazp2QAAAAAAAAAAAEsAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('3ee93065566b1f39406961778edcf1832b572559bb7eed2091cdb722bf2e0ac6', '5c0fb7c6a4c23e937765e4fa97518b7cb8868dd5bfb01f67d15fa2d823efe144', 'c08ba65d20a5cbd9dcca95b7bcedf052e72833e6744c93cc1df2805751b2aa5c', 4, 1578926194, 'AAAADFwPt8akwj6Td2Xk+pdRi3y4ho3Vv7AfZ9Ffotgj7+FEvQQ5ylVN1yTdUX/STlVPLixyh0GUg9sqt4UQC/Pxk/QAAAAAXhyAcgAAAAAAAAAANvoQ5f0h4XOu2zzdNp+2aYFizWM/TiKsCFrgq+HrV6LAi6ZdIKXL2dzKlbe87fBS5ygz5nRMk8wd8oBXUbKqXAAAAAQN4Lazp2QAAAAAAAAAAAGQAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
INSERT INTO ledgerheaders VALUES ('c89a880329db9695948f81e81bcf19f6f4c8c0dc9cb7db8137164f80e5132c01', '3ee93065566b1f39406961778edcf1832b572559bb7eed2091cdb722bf2e0ac6', 'cd485d8895cccadf388f024e0dfa61cb8e417f768a552857d850c46e9eabba90', 5, 1578926195, 'AAAADD7pMGVWax85QGlhd47c8YMrVyVZu37tIJHNtyK/LgrG2snQFmHpUXCtP4mpxo0aEgQbGYnuDixhTOJRb3pSvckAAAAAXhyAcwAAAAAAAAAAqwSxrFb8etq4gSdxOi9F1KjbMMbBhDJdKXyKRqyFTJvNSF2IlczK3ziPAk4N+mHLjkF/dopVKFfYUMRunqu6kAAAAAUN4Lazp2QAAAAAAAAAAAH0AAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');


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

INSERT INTO scphistory VALUES ('GDA7TMGKQ3WPH3MREN5IVVBFF7QTNXMQWT634KXL4NEKNKH3L3DEHWO5', 2, 'AAAAAMH5sMqG7PPtkSN6itQlL+E23ZC0/b4q6+NIpqj7XsZDAAAAAAAAAAIAAAACAAAAAQAAADBQl707mQDM3O7/qnRkmhnzyHRMO5ve5iyVkntxKxFaAAAAAABeHIBwAAAAAAAAAAAAAAABtEzdxY5wqgEWVQ4olp0zEI5KBjJ2l2unqxSyLUTxbYkAAABACr1KAUbVzmK1OmSfB+DbDSJCLWG6XgczWgwMZ9xKjq93PW7wkDerPkiTFIcYRSPgtQQKVjc9L7paR+7p+aAaCA==');
INSERT INTO scphistory VALUES ('GDA7TMGKQ3WPH3MREN5IVVBFF7QTNXMQWT634KXL4NEKNKH3L3DEHWO5', 3, 'AAAAAMH5sMqG7PPtkSN6itQlL+E23ZC0/b4q6+NIpqj7XsZDAAAAAAAAAAMAAAACAAAAAQAAAEj9wpS+mzyAJMKx4hplNotgVqcnSnQfZe/p0D2Bq0Rf3wAAAABeHIBxAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABtEzdxY5wqgEWVQ4olp0zEI5KBjJ2l2unqxSyLUTxbYkAAABA7zit0fKB8nsHIwl0k23T+t+z7TPEoeYFOwhLp+X09ihdFEQj0KtNOHZ2U2/nL2of4+iwfpLsGnwDNPX5tJt6DA==');
INSERT INTO scphistory VALUES ('GDA7TMGKQ3WPH3MREN5IVVBFF7QTNXMQWT634KXL4NEKNKH3L3DEHWO5', 4, 'AAAAAMH5sMqG7PPtkSN6itQlL+E23ZC0/b4q6+NIpqj7XsZDAAAAAAAAAAQAAAACAAAAAQAAADC9BDnKVU3XJN1Rf9JOVU8uLHKHQZSD2yq3hRAL8/GT9AAAAABeHIByAAAAAAAAAAAAAAABtEzdxY5wqgEWVQ4olp0zEI5KBjJ2l2unqxSyLUTxbYkAAABAZe8WBY7fhbziPBBRBy5CRIbv8+2pdfADGypzfWFhyddbYg3pBgCoDWtye+dMTmNmYA1pjID8OanTIvugtdqcDw==');
INSERT INTO scphistory VALUES ('GDA7TMGKQ3WPH3MREN5IVVBFF7QTNXMQWT634KXL4NEKNKH3L3DEHWO5', 5, 'AAAAAMH5sMqG7PPtkSN6itQlL+E23ZC0/b4q6+NIpqj7XsZDAAAAAAAAAAUAAAACAAAAAQAAADDaydAWYelRcK0/ianGjRoSBBsZie4OLGFM4lFvelK9yQAAAABeHIBzAAAAAAAAAAAAAAABtEzdxY5wqgEWVQ4olp0zEI5KBjJ2l2unqxSyLUTxbYkAAABAeTBQ2hCApnB727Bv6jhpUn25mOEnebpmGjVtLKR774nd4qcYa73B9HbNWXJGj5SVXXZxYcJe4CIxzohE3JJACQ==');


--
-- Data for Name: scpquorums; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO scpquorums VALUES ('b44cddc58e70aa0116550e28969d33108e4a063276976ba7ab14b22d44f16d89', 5, 'AAAAAQAAAAEAAAAAwfmwyobs8+2RI3qK1CUv4TbdkLT9virr40imqPtexkMAAAAA');


--
-- Data for Name: storestate; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO storestate VALUES ('databaseschema                  ', '11');
INSERT INTO storestate VALUES ('networkpassphrase               ', 'Test SDF Network ; September 2015');
INSERT INTO storestate VALUES ('forcescponnextlaunch            ', 'false');
INSERT INTO storestate VALUES ('lastscpdata4                    ', 'AAAAAgAAAADB+bDKhuzz7ZEjeorUJS/hNt2QtP2+KuvjSKao+17GQwAAAAAAAAAEAAAAA7RM3cWOcKoBFlUOKJadMxCOSgYydpdrp6sUsi1E8W2JAAAAAQAAAJi9BDnKVU3XJN1Rf9JOVU8uLHKHQZSD2yq3hRAL8/GT9AAAAABeHIByAAAAAAAAAAEAAAAAwfmwyobs8+2RI3qK1CUv4TbdkLT9virr40imqPtexkMAAABAakAPTv6WwzW+oWzPkHd8xPDqU//gO4d8hWPCVfENJos+FMQzRxJJkeJ6BUWIkzFAJuCE9sIqlYr/9d6jUGkFAAAAAAEAAACYvQQ5ylVN1yTdUX/STlVPLixyh0GUg9sqt4UQC/Pxk/QAAAAAXhyAcgAAAAAAAAABAAAAAMH5sMqG7PPtkSN6itQlL+E23ZC0/b4q6+NIpqj7XsZDAAAAQGpAD07+lsM1vqFsz5B3fMTw6lP/4DuHfIVjwlXxDSaLPhTEM0cSSZHiegVFiJMxQCbghPbCKpWK//Xeo1BpBQAAAABABb1dUK3qEvVGHolU5gscoYnVBafyepx/uzfGB+8Vx/EGXmxiO9sltvt+kbrpNfgK46UlUvni3BxJ3Uue1fmlAgAAAADB+bDKhuzz7ZEjeorUJS/hNt2QtP2+KuvjSKao+17GQwAAAAAAAAAEAAAAAgAAAAEAAAAwvQQ5ylVN1yTdUX/STlVPLixyh0GUg9sqt4UQC/Pxk/QAAAAAXhyAcgAAAAAAAAAAAAAAAbRM3cWOcKoBFlUOKJadMxCOSgYydpdrp6sUsi1E8W2JAAAAQGXvFgWO34W84jwQUQcuQkSG7/PtqXXwAxsqc31hYcnXW2IN6QYAqA1rcnvnTE5jZmANaYyA/Dmp0yL7oLXanA8AAAABXA+3xqTCPpN3ZeT6l1GLfLiGjdW/sB9n0V+i2CPv4UQAAAABAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAWvMQekAAAAAAAAAAAAH5kC3vAAAAQMvzjWcUe8CdwX/cl5px2TkYt672RXOFvJOTK5fK6SjBpPHGj5EIFxCRXdLAFy2K1nSkHSnIk9N2qwwQKwK1swwAAAABAAAAAQAAAAEAAAAAwfmwyobs8+2RI3qK1CUv4TbdkLT9virr40imqPtexkMAAAAA');
INSERT INTO storestate VALUES ('lastclosedledger                ', 'c89a880329db9695948f81e81bcf19f6f4c8c0dc9cb7db8137164f80e5132c01');
INSERT INTO storestate VALUES ('lastscpdata2                    ', 'AAAAAgAAAADB+bDKhuzz7ZEjeorUJS/hNt2QtP2+KuvjSKao+17GQwAAAAAAAAACAAAAA7RM3cWOcKoBFlUOKJadMxCOSgYydpdrp6sUsi1E8W2JAAAAAQAAADBQl707mQDM3O7/qnRkmhnzyHRMO5ve5iyVkntxKxFaAAAAAABeHIBwAAAAAAAAAAAAAAABAAAAMFCXvTuZAMzc7v+qdGSaGfPIdEw7m97mLJWSe3ErEVoAAAAAAF4cgHAAAAAAAAAAAAAAAED4tIP3WOjamg5Sf1jww4pQBw972aas16XT4WX5neYn4KJbD+uM2H+q/61eFXcVQ8yifBri3CX/U7vYxQ5QWvIHAAAAAMH5sMqG7PPtkSN6itQlL+E23ZC0/b4q6+NIpqj7XsZDAAAAAAAAAAIAAAACAAAAAQAAADBQl707mQDM3O7/qnRkmhnzyHRMO5ve5iyVkntxKxFaAAAAAABeHIBwAAAAAAAAAAAAAAABtEzdxY5wqgEWVQ4olp0zEI5KBjJ2l2unqxSyLUTxbYkAAABACr1KAUbVzmK1OmSfB+DbDSJCLWG6XgczWgwMZ9xKjq93PW7wkDerPkiTFIcYRSPgtQQKVjc9L7paR+7p+aAaCAAAAAFj2Y9TbuaNGye1uJ8jr1MRt1aaJPrxQDrQtStjOwe+mQAAAAIAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAABkAAAAAAAAAAIAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msoAAAAAAAAAAAFW/AX3AAAAQBkJJIVtQoiIhOEHcEgd/W7mDS8NJlDQIPh8ED6k+pRD/13BI5Iv40Yxlm+XZ4lbTZ45ESM7hBVHhwhyZGYF1g0AAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAABkAAAAAAAAAAEAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAA7msoAAAAAAAAAAAFW/AX3AAAAQF0Nd7bdTh70LZLGkEtlHHWsnNIUsnTEMPS4oamapt+UNP5dcirpSIMHOYXG34Y75eoWhA92tdPunWgtkgepMw8AAAABAAAAAQAAAAEAAAAAwfmwyobs8+2RI3qK1CUv4TbdkLT9virr40imqPtexkMAAAAA');
INSERT INTO storestate VALUES ('ledgerupgrades                  ', '{
    "time": 1578926192,
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
INSERT INTO storestate VALUES ('historyarchivestate             ', '{
    "version": 1,
    "server": "v12.2.0",
    "currentLedger": 5,
    "currentBuckets": [
        {
            "curr": "9fce2f871019a88ecc4458e33312c3d1d28b3bd0843170e9aa0c18faa726197d",
            "next": {
                "state": 0
            },
            "snap": "42a823210e14e135fdf306b85bcb887c6c1ccda45e96717c1300b77c777c597d"
        },
        {
            "curr": "ef31a20a398ee73ce22275ea8177786bac54656f33dcc4f3fec60d55ddf163d9",
            "next": {
                "state": 1,
                "output": "42a823210e14e135fdf306b85bcb887c6c1ccda45e96717c1300b77c777c597d"
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
INSERT INTO storestate VALUES ('lastscpdata3                    ', 'AAAAAgAAAADB+bDKhuzz7ZEjeorUJS/hNt2QtP2+KuvjSKao+17GQwAAAAAAAAADAAAAA7RM3cWOcKoBFlUOKJadMxCOSgYydpdrp6sUsi1E8W2JAAAAAQAAAEj9wpS+mzyAJMKx4hplNotgVqcnSnQfZe/p0D2Bq0Rf3wAAAABeHIBxAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABAAAASP3ClL6bPIAkwrHiGmU2i2BWpydKdB9l7+nQPYGrRF/fAAAAAF4cgHEAAAACAAAACAAAAAEAAAAMAAAACAAAAAMAD0JAAAAAAAAAAEBMpkwKUq6PlLv1yTOU/K10V/a5cPQ4DOuv8Inx80pU97MnWzBe00BuZUAeB86Nnap+gvdUUIcI8xPTxSHdVTkLAAAAAMH5sMqG7PPtkSN6itQlL+E23ZC0/b4q6+NIpqj7XsZDAAAAAAAAAAMAAAACAAAAAQAAAEj9wpS+mzyAJMKx4hplNotgVqcnSnQfZe/p0D2Bq0Rf3wAAAABeHIBxAAAAAgAAAAgAAAABAAAADAAAAAgAAAADAA9CQAAAAAAAAAABtEzdxY5wqgEWVQ4olp0zEI5KBjJ2l2unqxSyLUTxbYkAAABA7zit0fKB8nsHIwl0k23T+t+z7TPEoeYFOwhLp+X09ihdFEQj0KtNOHZ2U2/nL2of4+iwfpLsGnwDNPX5tJt6DAAAAAGkzm/3wJWiqtFroPa3YocG3Ktb1rQnV7vKIhjZgmmLdgAAAAEAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAABkAAAAAgAAAAEAAAAAAAAAAAAAAAEAAAAAAAAABgAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vf/////////8AAAAAAAAAAa7kvkwAAABAH2SYpbare/tB/Lw8x6QRvVNMjmLGqQjQGiBes63uA7XrZBuSHZ1JNR94Oi9zQ8Bp+ENfG2FUCWwu6OUGbKMEBgAAAAEAAAABAAAAAQAAAADB+bDKhuzz7ZEjeorUJS/hNt2QtP2+KuvjSKao+17GQwAAAAA=');
INSERT INTO storestate VALUES ('lastscpdata5                    ', 'AAAAAgAAAADB+bDKhuzz7ZEjeorUJS/hNt2QtP2+KuvjSKao+17GQwAAAAAAAAAFAAAAA7RM3cWOcKoBFlUOKJadMxCOSgYydpdrp6sUsi1E8W2JAAAAAQAAAJjaydAWYelRcK0/ianGjRoSBBsZie4OLGFM4lFvelK9yQAAAABeHIBzAAAAAAAAAAEAAAAAwfmwyobs8+2RI3qK1CUv4TbdkLT9virr40imqPtexkMAAABAYtuuh8+mewa7g+z7mG3BlRGP8dwhvPcaQfzFfBDBW2IbDrkKCLKlPMdesuDe596CqP3HsIdeAxMe7I7gJ0RuCAAAAAEAAACY2snQFmHpUXCtP4mpxo0aEgQbGYnuDixhTOJRb3pSvckAAAAAXhyAcwAAAAAAAAABAAAAAMH5sMqG7PPtkSN6itQlL+E23ZC0/b4q6+NIpqj7XsZDAAAAQGLbrofPpnsGu4Ps+5htwZURj/HcIbz3GkH8xXwQwVtiGw65CgiypTzHXrLg3ufegqj9x7CHXgMTHuyO4CdEbggAAABAhIUPOLv8potNYj/rDVbcJ28N4JlThDaw3yUgrz7kRXuVwYnLWSr+qC8Ml8jDqFEh35Km4+f+fOLC+GtVPvmlDQAAAADB+bDKhuzz7ZEjeorUJS/hNt2QtP2+KuvjSKao+17GQwAAAAAAAAAFAAAAAgAAAAEAAAAw2snQFmHpUXCtP4mpxo0aEgQbGYnuDixhTOJRb3pSvckAAAAAXhyAcwAAAAAAAAAAAAAAAbRM3cWOcKoBFlUOKJadMxCOSgYydpdrp6sUsi1E8W2JAAAAQHkwUNoQgKZwe9uwb+o4aVJ9uZjhJ3m6Zho1bSyke++J3eKnGGu9wfR2zVlyRo+UlV12cWHCXuAiMc6IRNySQAkAAAABPukwZVZrHzlAaWF3jtzxgytXJVm7fu0gkc23Ir8uCsYAAAABAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAACAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAABdIdugAAAAAAAAAAAGu5L5MAAAAQJ7fL6KMtjD6elUg6OEd0ovvhbmnZNzM2qMAU8DWy7qjlknRETI1c9yaVhSrLlubyio5ExWa42fBEMMXqOA1iQYAAAABAAAAAQAAAAEAAAAAwfmwyobs8+2RI3qK1CUv4TbdkLT9virr40imqPtexkMAAAAA');


--
-- Data for Name: trustlines; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO trustlines VALUES ('GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 1, 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4', 'USD', 9223372036854775807, 99900000000000, NULL, NULL, 1, 5);


--
-- Data for Name: txfeehistory; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO txfeehistory VALUES ('666656a6eade2082c5780571267d9e4453eee5781ca9a58aa319eb0fe83455fd', 2, 1, 'AAAAAgAAAAMAAAABAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txfeehistory VALUES ('0ee11ddb4817a6165f062c28273bf521d9bfedca4ea304f7bded2cb8ed422b7e', 2, 2, 'AAAAAgAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/84AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txfeehistory VALUES ('bd486dbdd02d460817671c4a5a7e9d6e865ca29cb41e62d7aaf70a2fee5b36de', 3, 1, 'AAAAAgAAAAMAAAACAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msoAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msmcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txfeehistory VALUES ('267d3bd55a6902624d03f3895bc91bf89cb0379b75d39e5b97dc3d448a6ee5cb', 4, 1, 'AAAAAgAAAAMAAAACAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAA7msoAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAA7msmcAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txfeehistory VALUES ('23071d02983ad8b70733b8ee52a19745a366d71c1f7455199773e7683ddaa035', 5, 1, 'AAAAAgAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msmcAAAAAgAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msk4AAAAAgAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');


--
-- Data for Name: txhistory; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO txhistory VALUES ('666656a6eade2082c5780571267d9e4453eee5781ca9a58aa319eb0fe83455fd', 2, 1, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rKAAAAAAAAAAABVvwF9wAAAEBdDXe23U4e9C2SxpBLZRx1rJzSFLJ0xDD0uKGpmqbflDT+XXIq6UiDBzmFxt+GO+XqFoQPdrXT7p1oLZIHqTMP', 'ZmZWpureIILFeAVxJn2eRFPu5XgcqaWKoxnrD+g0Vf0AAAAAAAAAZAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAA==', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/84AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrNryTU4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAA7msoAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txhistory VALUES ('0ee11ddb4817a6165f062c28273bf521d9bfedca4ea304f7bded2cb8ed422b7e', 2, 2, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAACAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAAO5rKAAAAAAAAAAABVvwF9wAAAEAZCSSFbUKIiIThB3BIHf1u5g0vDSZQ0CD4fBA+pPqUQ/9dwSOSL+NGMZZvl2eJW02eOREjO4QVR4cIcmRmBdYN', 'DuEd20gXphZfBiwoJzv1Idm/7cpOowT3ve0suO1CK34AAAAAAAAAZAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAA==', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrNryTU4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrMwLms4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msoAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==');
INSERT INTO txhistory VALUES ('bd486dbdd02d460817671c4a5a7e9d6e865ca29cb41e62d7aaf70a2fee5b36de', 3, 1, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt73//////////AAAAAAAAAAGu5L5MAAAAQB9kmKW2q3v7Qfy8PMekEb1TTI5ixqkI0BogXrOt7gO162Qbkh2dSTUfeDovc0PAafhDXxthVAlsLujlBmyjBAY=', 'vUhtvdAtRggXZxxKWn6dboZcopy0HmLXqvcKL+5bNt4AAAAAAAAAZAAAAAAAAAABAAAAAAAAAAYAAAAAAAAAAA==', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msmcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msmcAAAAAgAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==');
INSERT INTO txhistory VALUES ('267d3bd55a6902624d03f3895bc91bf89cb0379b75d39e5b97dc3d448a6ee5cb', 4, 1, 'AAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAWvMQekAAAAAAAAAAAAH5kC3vAAAAQMvzjWcUe8CdwX/cl5px2TkYt672RXOFvJOTK5fK6SjBpPHGj5EIFxCRXdLAFy2K1nSkHSnIk9N2qwwQKwK1sww=', 'Jn071VppAmJNA/OJW8kb+JywN5t1055bl9w9RIpu5csAAAAAAAAAZAAAAAAAAAABAAAAAAAAAAEAAAAAAAAAAA==', 'AAAAAQAAAAIAAAADAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rJnAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rJnAAAAAIAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAEAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAABa8xB6QAB//////////wAAAAEAAAAAAAAAAA==');
INSERT INTO txhistory VALUES ('23071d02983ad8b70733b8ee52a19745a366d71c1f7455199773e7683ddaa035', 5, 1, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAACAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAABdIdugAAAAAAAAAAAGu5L5MAAAAQJ7fL6KMtjD6elUg6OEd0ovvhbmnZNzM2qMAU8DWy7qjlknRETI1c9yaVhSrLlubyio5ExWa42fBEMMXqOA1iQY=', 'IwcdApg62LcHM7juUqGXRaNm1xwfdFUZl3PnaD3aoDUAAAAAAAAAZAAAAAAAAAABAAAAAAAAAAEAAAAAAAAAAA==', 'AAAAAQAAAAIAAAADAAAABQAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAAO5rJOAAAAAIAAAABAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABQAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAAO5rJOAAAAAIAAAACAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAEAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAABa8xB6QAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAFAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAABa28gDWAB//////////wAAAAEAAAAAAAAAAA==');


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

