--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE IF EXISTS ONLY public.history_trades DROP CONSTRAINT IF EXISTS history_trades_counter_asset_id_fkey;
ALTER TABLE IF EXISTS ONLY public.history_trades DROP CONSTRAINT IF EXISTS history_trades_counter_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.history_trades DROP CONSTRAINT IF EXISTS history_trades_base_asset_id_fkey;
ALTER TABLE IF EXISTS ONLY public.history_trades DROP CONSTRAINT IF EXISTS history_trades_base_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.exp_history_trades DROP CONSTRAINT IF EXISTS exp_history_trades_counter_asset_id_fkey;
ALTER TABLE IF EXISTS ONLY public.exp_history_trades DROP CONSTRAINT IF EXISTS exp_history_trades_counter_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.exp_history_trades DROP CONSTRAINT IF EXISTS exp_history_trades_base_asset_id_fkey;
ALTER TABLE IF EXISTS ONLY public.exp_history_trades DROP CONSTRAINT IF EXISTS exp_history_trades_base_account_id_fkey;
ALTER TABLE IF EXISTS ONLY public.asset_stats DROP CONSTRAINT IF EXISTS asset_stats_id_fkey;
DROP INDEX IF EXISTS public.trust_lines_by_type_code_issuer;
DROP INDEX IF EXISTS public.trust_lines_by_issuer;
DROP INDEX IF EXISTS public.trust_lines_by_account_id;
DROP INDEX IF EXISTS public.trade_effects_by_order_book;
DROP INDEX IF EXISTS public.signers_by_account;
DROP INDEX IF EXISTS public.offers_by_selling_asset;
DROP INDEX IF EXISTS public.offers_by_seller;
DROP INDEX IF EXISTS public.offers_by_last_modified_ledger;
DROP INDEX IF EXISTS public.offers_by_buying_asset;
DROP INDEX IF EXISTS public.index_history_transactions_on_id;
DROP INDEX IF EXISTS public.index_history_operations_on_type;
DROP INDEX IF EXISTS public.index_history_operations_on_transaction_id;
DROP INDEX IF EXISTS public.index_history_operations_on_id;
DROP INDEX IF EXISTS public.index_history_ledgers_on_sequence;
DROP INDEX IF EXISTS public.index_history_ledgers_on_previous_ledger_hash;
DROP INDEX IF EXISTS public.index_history_ledgers_on_ledger_hash;
DROP INDEX IF EXISTS public.index_history_ledgers_on_importer_version;
DROP INDEX IF EXISTS public.index_history_ledgers_on_id;
DROP INDEX IF EXISTS public.index_history_ledgers_on_closed_at;
DROP INDEX IF EXISTS public.index_history_effects_on_type;
DROP INDEX IF EXISTS public.index_history_accounts_on_id;
DROP INDEX IF EXISTS public.index_history_accounts_on_address;
DROP INDEX IF EXISTS public.htrd_time_lookup;
DROP INDEX IF EXISTS public.htrd_pid;
DROP INDEX IF EXISTS public.htrd_pair_time_lookup;
DROP INDEX IF EXISTS public.htrd_counter_lookup;
DROP INDEX IF EXISTS public.htrd_by_offer;
DROP INDEX IF EXISTS public.htrd_by_counter_offer;
DROP INDEX IF EXISTS public.htrd_by_counter_account;
DROP INDEX IF EXISTS public.htrd_by_base_offer;
DROP INDEX IF EXISTS public.htrd_by_base_account;
DROP INDEX IF EXISTS public.htp_by_htid;
DROP INDEX IF EXISTS public.hs_transaction_by_id;
DROP INDEX IF EXISTS public.hs_ledger_by_id;
DROP INDEX IF EXISTS public.hop_by_hoid;
DROP INDEX IF EXISTS public.hist_tx_p_id;
DROP INDEX IF EXISTS public.hist_op_p_id;
DROP INDEX IF EXISTS public.hist_e_id;
DROP INDEX IF EXISTS public.hist_e_by_order;
DROP INDEX IF EXISTS public.exp_htrd_time_lookup;
DROP INDEX IF EXISTS public.exp_htrd_pid;
DROP INDEX IF EXISTS public.exp_htrd_pair_time_lookup;
DROP INDEX IF EXISTS public.exp_htrd_counter_lookup;
DROP INDEX IF EXISTS public.exp_htrd_by_offer;
DROP INDEX IF EXISTS public.exp_htrd_by_counter_offer;
DROP INDEX IF EXISTS public.exp_htrd_by_counter_account;
DROP INDEX IF EXISTS public.exp_htrd_by_base_offer;
DROP INDEX IF EXISTS public.exp_htrd_by_base_account;
DROP INDEX IF EXISTS public.exp_history_transactions_transaction_hash_idx;
DROP INDEX IF EXISTS public.exp_history_transactions_ledger_sequence_application_order_idx;
DROP INDEX IF EXISTS public.exp_history_transactions_id_idx;
DROP INDEX IF EXISTS public.exp_history_transactions_account_account_sequence_idx;
DROP INDEX IF EXISTS public.exp_history_transaction_participants_history_transaction_id_idx;
DROP INDEX IF EXISTS public.exp_history_transaction_parti_history_account_id_history_tr_idx;
DROP INDEX IF EXISTS public.exp_history_operations_type_idx;
DROP INDEX IF EXISTS public.exp_history_operations_transaction_id_idx;
DROP INDEX IF EXISTS public.exp_history_operations_id_idx;
DROP INDEX IF EXISTS public.exp_history_operation_participants_history_operation_id_idx;
DROP INDEX IF EXISTS public.exp_history_operation_partici_history_account_id_history_op_idx;
DROP INDEX IF EXISTS public.exp_history_ledgers_sequence_idx;
DROP INDEX IF EXISTS public.exp_history_ledgers_previous_ledger_hash_idx;
DROP INDEX IF EXISTS public.exp_history_ledgers_ledger_hash_idx;
DROP INDEX IF EXISTS public.exp_history_ledgers_importer_version_idx;
DROP INDEX IF EXISTS public.exp_history_ledgers_id_idx;
DROP INDEX IF EXISTS public.exp_history_ledgers_closed_at_idx;
DROP INDEX IF EXISTS public.exp_history_effects_type_idx;
DROP INDEX IF EXISTS public.exp_history_effects_history_operation_id_order_idx;
DROP INDEX IF EXISTS public.exp_history_effects_history_account_id_history_operation_id_idx;
DROP INDEX IF EXISTS public.exp_history_effects_expr_expr1_expr2_expr3_expr4_expr5_idx;
DROP INDEX IF EXISTS public.exp_history_assets_asset_issuer_idx;
DROP INDEX IF EXISTS public.exp_history_assets_asset_code_idx;
DROP INDEX IF EXISTS public.exp_history_accounts_id_idx;
DROP INDEX IF EXISTS public.exp_history_accounts_address_idx;
DROP INDEX IF EXISTS public.exp_asset_stats_by_issuer;
DROP INDEX IF EXISTS public.exp_asset_stats_by_code;
DROP INDEX IF EXISTS public.by_ledger;
DROP INDEX IF EXISTS public.by_hash;
DROP INDEX IF EXISTS public.by_account;
DROP INDEX IF EXISTS public.asset_by_issuer;
DROP INDEX IF EXISTS public.asset_by_code;
DROP INDEX IF EXISTS public.accounts_inflation_destination;
DROP INDEX IF EXISTS public.accounts_home_domain;
DROP INDEX IF EXISTS public.accounts_data_account_id_name;
ALTER TABLE IF EXISTS ONLY public.trust_lines DROP CONSTRAINT IF EXISTS trust_lines_pkey;
ALTER TABLE IF EXISTS ONLY public.offers DROP CONSTRAINT IF EXISTS offers_pkey;
ALTER TABLE IF EXISTS ONLY public.key_value_store DROP CONSTRAINT IF EXISTS key_value_store_pkey;
ALTER TABLE IF EXISTS ONLY public.history_transaction_participants DROP CONSTRAINT IF EXISTS history_transaction_participants_pkey;
ALTER TABLE IF EXISTS ONLY public.history_operation_participants DROP CONSTRAINT IF EXISTS history_operation_participants_pkey;
ALTER TABLE IF EXISTS ONLY public.history_assets DROP CONSTRAINT IF EXISTS history_assets_pkey;
ALTER TABLE IF EXISTS ONLY public.history_assets DROP CONSTRAINT IF EXISTS history_assets_asset_code_asset_type_asset_issuer_key;
ALTER TABLE IF EXISTS ONLY public.gorp_migrations DROP CONSTRAINT IF EXISTS gorp_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.exp_history_transaction_participants DROP CONSTRAINT IF EXISTS exp_history_transaction_participants_pkey;
ALTER TABLE IF EXISTS ONLY public.exp_history_operation_participants DROP CONSTRAINT IF EXISTS exp_history_operation_participants_pkey;
ALTER TABLE IF EXISTS ONLY public.exp_history_assets DROP CONSTRAINT IF EXISTS exp_history_assets_pkey;
ALTER TABLE IF EXISTS ONLY public.exp_history_assets DROP CONSTRAINT IF EXISTS exp_history_assets_asset_code_asset_type_asset_issuer_key;
ALTER TABLE IF EXISTS ONLY public.exp_asset_stats DROP CONSTRAINT IF EXISTS exp_asset_stats_pkey;
ALTER TABLE IF EXISTS ONLY public.asset_stats DROP CONSTRAINT IF EXISTS asset_stats_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_signers DROP CONSTRAINT IF EXISTS accounts_signers_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts DROP CONSTRAINT IF EXISTS accounts_pkey;
ALTER TABLE IF EXISTS ONLY public.accounts_data DROP CONSTRAINT IF EXISTS accounts_data_pkey;
ALTER TABLE IF EXISTS public.history_transaction_participants ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.history_operation_participants ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.history_assets ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS public.trust_lines;
DROP TABLE IF EXISTS public.offers;
DROP TABLE IF EXISTS public.key_value_store;
DROP TABLE IF EXISTS public.history_transactions;
DROP TABLE IF EXISTS public.history_trades;
DROP TABLE IF EXISTS public.history_operations;
DROP TABLE IF EXISTS public.history_ledgers;
DROP TABLE IF EXISTS public.history_effects;
DROP TABLE IF EXISTS public.history_accounts;
DROP TABLE IF EXISTS public.gorp_migrations;
DROP TABLE IF EXISTS public.exp_history_transactions;
DROP TABLE IF EXISTS public.exp_history_transaction_participants;
DROP SEQUENCE IF EXISTS public.history_transaction_participants_id_seq;
DROP TABLE IF EXISTS public.history_transaction_participants;
DROP TABLE IF EXISTS public.exp_history_trades;
DROP TABLE IF EXISTS public.exp_history_operations;
DROP TABLE IF EXISTS public.exp_history_operation_participants;
DROP SEQUENCE IF EXISTS public.history_operation_participants_id_seq;
DROP TABLE IF EXISTS public.history_operation_participants;
DROP TABLE IF EXISTS public.exp_history_ledgers;
DROP TABLE IF EXISTS public.exp_history_effects;
DROP TABLE IF EXISTS public.exp_history_assets;
DROP SEQUENCE IF EXISTS public.history_assets_id_seq;
DROP TABLE IF EXISTS public.history_assets;
DROP TABLE IF EXISTS public.exp_history_accounts;
DROP SEQUENCE IF EXISTS public.history_accounts_id_seq;
DROP TABLE IF EXISTS public.exp_asset_stats;
DROP TABLE IF EXISTS public.asset_stats;
DROP TABLE IF EXISTS public.accounts_signers;
DROP TABLE IF EXISTS public.accounts_data;
DROP TABLE IF EXISTS public.accounts;
DROP AGGREGATE IF EXISTS public.min_price(numeric[]);
DROP AGGREGATE IF EXISTS public.max_price(numeric[]);
DROP AGGREGATE IF EXISTS public.last(anyelement);
DROP AGGREGATE IF EXISTS public.first(anyelement);
DROP FUNCTION IF EXISTS public.min_price_agg(numeric[], numeric[]);
DROP FUNCTION IF EXISTS public.max_price_agg(numeric[], numeric[]);
DROP FUNCTION IF EXISTS public.last_agg(anyelement, anyelement);
DROP FUNCTION IF EXISTS public.first_agg(anyelement, anyelement);
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

--
-- Name: first_agg(anyelement, anyelement); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION first_agg(anyelement, anyelement) RETURNS anyelement
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT $1 $_$;


--
-- Name: last_agg(anyelement, anyelement); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION last_agg(anyelement, anyelement) RETURNS anyelement
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT $2 $_$;


--
-- Name: max_price_agg(numeric[], numeric[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION max_price_agg(numeric[], numeric[]) RETURNS numeric[]
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (
  CASE WHEN $1[1]/$1[2]>$2[1]/$2[2] THEN $1 ELSE $2 END) $_$;


--
-- Name: min_price_agg(numeric[], numeric[]); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION min_price_agg(numeric[], numeric[]) RETURNS numeric[]
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT (
  CASE WHEN $1[1]/$1[2]<$2[1]/$2[2] THEN $1 ELSE $2 END) $_$;


--
-- Name: first(anyelement); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE first(anyelement) (
    SFUNC = first_agg,
    STYPE = anyelement
);


--
-- Name: last(anyelement); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE last(anyelement) (
    SFUNC = last_agg,
    STYPE = anyelement
);


--
-- Name: max_price(numeric[]); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE max_price(numeric[]) (
    SFUNC = max_price_agg,
    STYPE = numeric[]
);


--
-- Name: min_price(numeric[]); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE min_price(numeric[]) (
    SFUNC = min_price_agg,
    STYPE = numeric[]
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts (
    account_id character varying(56) NOT NULL,
    balance bigint NOT NULL,
    buying_liabilities bigint NOT NULL,
    selling_liabilities bigint NOT NULL,
    sequence_number bigint NOT NULL,
    num_subentries integer NOT NULL,
    inflation_destination character varying(56) NOT NULL,
    flags integer NOT NULL,
    home_domain character varying(32) NOT NULL,
    master_weight smallint NOT NULL,
    threshold_low smallint NOT NULL,
    threshold_medium smallint NOT NULL,
    threshold_high smallint NOT NULL,
    last_modified_ledger integer NOT NULL
);


--
-- Name: accounts_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts_data (
    ledger_key character varying(150) NOT NULL,
    account_id character varying(56) NOT NULL,
    name character varying(64) NOT NULL,
    value character varying(90) NOT NULL,
    last_modified_ledger integer NOT NULL
);


--
-- Name: accounts_signers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts_signers (
    account_id character varying(64) NOT NULL,
    signer character varying(64) NOT NULL,
    weight integer NOT NULL
);


--
-- Name: asset_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE asset_stats (
    id bigint NOT NULL,
    amount character varying NOT NULL,
    num_accounts integer NOT NULL,
    flags smallint NOT NULL,
    toml character varying(255) NOT NULL
);


--
-- Name: exp_asset_stats; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE exp_asset_stats (
    asset_type integer NOT NULL,
    asset_code character varying(12) NOT NULL,
    asset_issuer character varying(56) NOT NULL,
    amount text NOT NULL,
    num_accounts integer NOT NULL
);


--
-- Name: history_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE history_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exp_history_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE exp_history_accounts (
    id bigint DEFAULT nextval('history_accounts_id_seq'::regclass) NOT NULL,
    address character varying(64)
);


--
-- Name: history_assets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE history_assets (
    id integer NOT NULL,
    asset_type character varying(64) NOT NULL,
    asset_code character varying(12) NOT NULL,
    asset_issuer character varying(56) NOT NULL
);


--
-- Name: history_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE history_assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: history_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE history_assets_id_seq OWNED BY history_assets.id;


--
-- Name: exp_history_assets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE exp_history_assets (
    id integer DEFAULT nextval('history_assets_id_seq'::regclass) NOT NULL,
    asset_type character varying(64) NOT NULL,
    asset_code character varying(12) NOT NULL,
    asset_issuer character varying(56) NOT NULL
);


--
-- Name: exp_history_effects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE exp_history_effects (
    history_account_id bigint NOT NULL,
    history_operation_id bigint NOT NULL,
    "order" integer NOT NULL,
    type integer NOT NULL,
    details jsonb
);


--
-- Name: exp_history_ledgers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE exp_history_ledgers (
    sequence integer NOT NULL,
    ledger_hash character varying(64) NOT NULL,
    previous_ledger_hash character varying(64),
    transaction_count integer DEFAULT 0 NOT NULL,
    operation_count integer DEFAULT 0 NOT NULL,
    closed_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    id bigint,
    importer_version integer DEFAULT 1 NOT NULL,
    total_coins bigint NOT NULL,
    fee_pool bigint NOT NULL,
    base_fee integer NOT NULL,
    base_reserve integer NOT NULL,
    max_tx_set_size integer NOT NULL,
    protocol_version integer DEFAULT 0 NOT NULL,
    ledger_header text,
    successful_transaction_count integer,
    failed_transaction_count integer
);


--
-- Name: history_operation_participants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE history_operation_participants (
    id integer NOT NULL,
    history_operation_id bigint NOT NULL,
    history_account_id bigint NOT NULL
);


--
-- Name: history_operation_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE history_operation_participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: history_operation_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE history_operation_participants_id_seq OWNED BY history_operation_participants.id;


--
-- Name: exp_history_operation_participants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE exp_history_operation_participants (
    id integer DEFAULT nextval('history_operation_participants_id_seq'::regclass) NOT NULL,
    history_operation_id bigint NOT NULL,
    history_account_id bigint NOT NULL
);


--
-- Name: exp_history_operations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE exp_history_operations (
    id bigint NOT NULL,
    transaction_id bigint NOT NULL,
    application_order integer NOT NULL,
    type integer NOT NULL,
    details jsonb,
    source_account character varying(64) DEFAULT ''::character varying NOT NULL
);


--
-- Name: exp_history_trades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE exp_history_trades (
    history_operation_id bigint NOT NULL,
    "order" integer NOT NULL,
    ledger_closed_at timestamp without time zone NOT NULL,
    offer_id bigint NOT NULL,
    base_account_id bigint NOT NULL,
    base_asset_id bigint NOT NULL,
    base_amount bigint NOT NULL,
    counter_account_id bigint NOT NULL,
    counter_asset_id bigint NOT NULL,
    counter_amount bigint NOT NULL,
    base_is_seller boolean,
    price_n bigint,
    price_d bigint,
    base_offer_id bigint,
    counter_offer_id bigint,
    CONSTRAINT exp_history_trades_base_amount_check CHECK ((base_amount >= 0)),
    CONSTRAINT exp_history_trades_check CHECK ((base_asset_id < counter_asset_id)),
    CONSTRAINT exp_history_trades_counter_amount_check CHECK ((counter_amount >= 0))
);


--
-- Name: history_transaction_participants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE history_transaction_participants (
    id integer NOT NULL,
    history_transaction_id bigint NOT NULL,
    history_account_id bigint NOT NULL
);


--
-- Name: history_transaction_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE history_transaction_participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: history_transaction_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE history_transaction_participants_id_seq OWNED BY history_transaction_participants.id;


--
-- Name: exp_history_transaction_participants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE exp_history_transaction_participants (
    id integer DEFAULT nextval('history_transaction_participants_id_seq'::regclass) NOT NULL,
    history_transaction_id bigint NOT NULL,
    history_account_id bigint NOT NULL
);


--
-- Name: exp_history_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE exp_history_transactions (
    transaction_hash character varying(64) NOT NULL,
    ledger_sequence integer NOT NULL,
    application_order integer NOT NULL,
    account character varying(64) NOT NULL,
    account_sequence bigint NOT NULL,
    max_fee integer NOT NULL,
    operation_count integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    id bigint,
    tx_envelope text NOT NULL,
    tx_result text NOT NULL,
    tx_meta text NOT NULL,
    tx_fee_meta text NOT NULL,
    signatures character varying(96)[] DEFAULT '{}'::character varying[] NOT NULL,
    memo_type character varying DEFAULT 'none'::character varying NOT NULL,
    memo character varying,
    time_bounds int8range,
    successful boolean,
    fee_charged integer
);


--
-- Name: gorp_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE gorp_migrations (
    id text NOT NULL,
    applied_at timestamp with time zone
);


--
-- Name: history_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE history_accounts (
    id bigint DEFAULT nextval('history_accounts_id_seq'::regclass) NOT NULL,
    address character varying(64)
);


--
-- Name: history_effects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE history_effects (
    history_account_id bigint NOT NULL,
    history_operation_id bigint NOT NULL,
    "order" integer NOT NULL,
    type integer NOT NULL,
    details jsonb
);


--
-- Name: history_ledgers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE history_ledgers (
    sequence integer NOT NULL,
    ledger_hash character varying(64) NOT NULL,
    previous_ledger_hash character varying(64),
    transaction_count integer DEFAULT 0 NOT NULL,
    operation_count integer DEFAULT 0 NOT NULL,
    closed_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    id bigint,
    importer_version integer DEFAULT 1 NOT NULL,
    total_coins bigint NOT NULL,
    fee_pool bigint NOT NULL,
    base_fee integer NOT NULL,
    base_reserve integer NOT NULL,
    max_tx_set_size integer NOT NULL,
    protocol_version integer DEFAULT 0 NOT NULL,
    ledger_header text,
    successful_transaction_count integer,
    failed_transaction_count integer
);


--
-- Name: history_operations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE history_operations (
    id bigint NOT NULL,
    transaction_id bigint NOT NULL,
    application_order integer NOT NULL,
    type integer NOT NULL,
    details jsonb,
    source_account character varying(64) DEFAULT ''::character varying NOT NULL
);


--
-- Name: history_trades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE history_trades (
    history_operation_id bigint NOT NULL,
    "order" integer NOT NULL,
    ledger_closed_at timestamp without time zone NOT NULL,
    offer_id bigint NOT NULL,
    base_account_id bigint NOT NULL,
    base_asset_id bigint NOT NULL,
    base_amount bigint NOT NULL,
    counter_account_id bigint NOT NULL,
    counter_asset_id bigint NOT NULL,
    counter_amount bigint NOT NULL,
    base_is_seller boolean,
    price_n bigint,
    price_d bigint,
    base_offer_id bigint,
    counter_offer_id bigint,
    CONSTRAINT history_trades_base_amount_check CHECK ((base_amount >= 0)),
    CONSTRAINT history_trades_check CHECK ((base_asset_id < counter_asset_id)),
    CONSTRAINT history_trades_counter_amount_check CHECK ((counter_amount >= 0))
);


--
-- Name: history_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE history_transactions (
    transaction_hash character varying(64) NOT NULL,
    ledger_sequence integer NOT NULL,
    application_order integer NOT NULL,
    account character varying(64) NOT NULL,
    account_sequence bigint NOT NULL,
    max_fee integer NOT NULL,
    operation_count integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    id bigint,
    tx_envelope text NOT NULL,
    tx_result text NOT NULL,
    tx_meta text NOT NULL,
    tx_fee_meta text NOT NULL,
    signatures character varying(96)[] DEFAULT '{}'::character varying[] NOT NULL,
    memo_type character varying DEFAULT 'none'::character varying NOT NULL,
    memo character varying,
    time_bounds int8range,
    successful boolean,
    fee_charged integer
);


--
-- Name: key_value_store; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE key_value_store (
    key character varying(255) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: offers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE offers (
    seller_id character varying(56) NOT NULL,
    offer_id bigint NOT NULL,
    selling_asset text NOT NULL,
    buying_asset text NOT NULL,
    amount bigint NOT NULL,
    pricen integer NOT NULL,
    priced integer NOT NULL,
    price double precision NOT NULL,
    flags integer NOT NULL,
    last_modified_ledger integer NOT NULL
);


--
-- Name: trust_lines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE trust_lines (
    ledger_key character varying(150) NOT NULL,
    account_id character varying(56) NOT NULL,
    asset_type integer NOT NULL,
    asset_issuer character varying(56) NOT NULL,
    asset_code character varying(12) NOT NULL,
    balance bigint NOT NULL,
    trust_line_limit bigint NOT NULL,
    buying_liabilities bigint NOT NULL,
    selling_liabilities bigint NOT NULL,
    flags integer NOT NULL,
    last_modified_ledger integer NOT NULL
);


--
-- Name: history_assets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY history_assets ALTER COLUMN id SET DEFAULT nextval('history_assets_id_seq'::regclass);


--
-- Name: history_operation_participants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY history_operation_participants ALTER COLUMN id SET DEFAULT nextval('history_operation_participants_id_seq'::regclass);


--
-- Name: history_transaction_participants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY history_transaction_participants ALTER COLUMN id SET DEFAULT nextval('history_transaction_participants_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: accounts_data; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: accounts_signers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: asset_stats; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: exp_asset_stats; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: exp_history_accounts; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: exp_history_assets; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: exp_history_effects; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: exp_history_ledgers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: exp_history_operation_participants; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: exp_history_operations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: exp_history_trades; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: exp_history_transaction_participants; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: exp_history_transactions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: gorp_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO gorp_migrations VALUES ('1_initial_schema.sql', '2020-01-13 15:39:20.693483+01');
INSERT INTO gorp_migrations VALUES ('2_index_participants_by_toid.sql', '2020-01-13 15:39:20.698869+01');
INSERT INTO gorp_migrations VALUES ('3_use_sequence_in_history_accounts.sql', '2020-01-13 15:39:20.703222+01');
INSERT INTO gorp_migrations VALUES ('4_add_protocol_version.sql', '2020-01-13 15:39:20.717676+01');
INSERT INTO gorp_migrations VALUES ('5_create_trades_table.sql', '2020-01-13 15:39:20.727426+01');
INSERT INTO gorp_migrations VALUES ('6_create_assets_table.sql', '2020-01-13 15:39:20.732162+01');
INSERT INTO gorp_migrations VALUES ('7_modify_trades_table.sql', '2020-01-13 15:39:20.743909+01');
INSERT INTO gorp_migrations VALUES ('8_add_aggregators.sql', '2020-01-13 15:39:20.749655+01');
INSERT INTO gorp_migrations VALUES ('8_create_asset_stats_table.sql', '2020-01-13 15:39:20.755434+01');
INSERT INTO gorp_migrations VALUES ('9_add_header_xdr.sql', '2020-01-13 15:39:20.758613+01');
INSERT INTO gorp_migrations VALUES ('10_add_trades_price.sql', '2020-01-13 15:39:20.76189+01');
INSERT INTO gorp_migrations VALUES ('11_add_trades_account_index.sql', '2020-01-13 15:39:20.765823+01');
INSERT INTO gorp_migrations VALUES ('12_asset_stats_amount_string.sql', '2020-01-13 15:39:20.772953+01');
INSERT INTO gorp_migrations VALUES ('13_trade_offer_ids.sql', '2020-01-13 15:39:20.777237+01');
INSERT INTO gorp_migrations VALUES ('14_fix_asset_toml_field.sql', '2020-01-13 15:39:20.778625+01');
INSERT INTO gorp_migrations VALUES ('15_ledger_failed_txs.sql', '2020-01-13 15:39:20.780091+01');
INSERT INTO gorp_migrations VALUES ('16_ingest_failed_transactions.sql', '2020-01-13 15:39:20.781257+01');
INSERT INTO gorp_migrations VALUES ('17_transaction_fee_paid.sql', '2020-01-13 15:39:20.782681+01');
INSERT INTO gorp_migrations VALUES ('18_account_for_signers.sql', '2020-01-13 15:39:20.787475+01');
INSERT INTO gorp_migrations VALUES ('19_offers.sql', '2020-01-13 15:39:20.798039+01');
INSERT INTO gorp_migrations VALUES ('20_account_for_signer_index.sql', '2020-01-13 15:39:20.800683+01');
INSERT INTO gorp_migrations VALUES ('21_trades_remove_zero_amount_constraints.sql', '2020-01-13 15:39:20.803699+01');
INSERT INTO gorp_migrations VALUES ('22_trust_lines.sql', '2020-01-13 15:39:20.811701+01');
INSERT INTO gorp_migrations VALUES ('23_exp_asset_stats.sql', '2020-01-13 15:39:20.818702+01');
INSERT INTO gorp_migrations VALUES ('24_accounts.sql', '2020-01-13 15:39:20.826818+01');
INSERT INTO gorp_migrations VALUES ('25_expingest_rename_columns.sql', '2020-01-13 15:39:20.829297+01');
INSERT INTO gorp_migrations VALUES ('26_exp_history_ledgers.sql', '2020-01-13 15:39:20.838162+01');
INSERT INTO gorp_migrations VALUES ('27_exp_history_transactions.sql', '2020-01-13 15:39:20.85637+01');
INSERT INTO gorp_migrations VALUES ('28_exp_history_operations.sql', '2020-01-13 15:39:20.867577+01');
INSERT INTO gorp_migrations VALUES ('29_exp_history_assets.sql', '2020-01-13 15:39:20.875103+01');
INSERT INTO gorp_migrations VALUES ('30_exp_history_trades.sql', '2020-01-13 15:39:20.889645+01');
INSERT INTO gorp_migrations VALUES ('31_exp_history_effects.sql', '2020-01-13 15:39:20.89876+01');


--
-- Data for Name: history_accounts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_accounts VALUES (1, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_accounts VALUES (2, 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4');
INSERT INTO history_accounts VALUES (3, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');


--
-- Name: history_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_accounts_id_seq', 3, true);


--
-- Data for Name: history_assets; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: history_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_assets_id_seq', 1, false);


--
-- Data for Name: history_effects; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_effects VALUES (1, 12884905985, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "USD1", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (1, 12884910081, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "USD2", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (2, 8589938689, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (3, 8589938689, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (2, 8589938689, 3, 10, '{"weight": 1, "public_key": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (1, 8589942785, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (3, 8589942785, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (1, 8589942785, 3, 10, '{"weight": 1, "public_key": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU"}');


--
-- Data for Name: history_ledgers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_ledgers VALUES (3, 'c869962fc5f8f29fa0bdcb111fa56fd1891ccbe5d7ef0cc16f3408296db3bd70', '3d205d70bc264f643ae6bc67d26df3093e7b3c54a9a2b4c89a0b1ace14931de2', 2, 2, '2020-01-13 14:39:19', '2020-01-13 14:39:21.157814', '2020-01-13 14:39:21.157814', 12884901888, 16, 1000000000000000000, 400, 100, 100000000, 1000000, 12, 'AAAADD0gXXC8Jk9kOua8Z9Jt8wk+ezxUqaK0yJoLGs4Ukx3iXeXXMmpDEgEtKQosdo+uHKLRNn45agKeu1/mbvRv9UsAAAAAXhyBFwAAAAIAAAAIAAAAAQAAAAwAAAAIAAAAAwAPQkAAAAAAqZ+gKTLothY9s7mUE9wPGSzC2wvgaWBDyFO+d3wnDjK+Jx1RANATUAgaTkw8Uia78WCT6/5hN/x2nM7e+10fJAAAAAMN4Lazp2QAAAAAAAAAAAGQAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (2, '3d205d70bc264f643ae6bc67d26df3093e7b3c54a9a2b4c89a0b1ace14931de2', '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', 2, 2, '2020-01-13 14:39:18', '2020-01-13 14:39:21.176633', '2020-01-13 14:39:21.176633', 8589934592, 16, 1000000000000000000, 200, 100, 100000000, 100, 0, 'AAAAAGPZj1Nu5o0bJ7W4nyOvUxG3Vpok+vFAOtC1K2M7B76Zu5H9cHd0qAsZj9Q6Y8yIIc6utkf/CO+Lm/0KbsfrzPUAAAAAXhyBFgAAAAAAAAAAP0PjS3Rf7hs8xVIBg2g8xKvqOO/n/g/XwgPR/HB7qe9psd7TDAx6H99TBuFmQ9oJnYcpBNFtnkR7EZW+HhFy8AAAAAIN4Lazp2QAAAAAAAAAAADIAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (1, '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', NULL, 0, 0, '1970-01-01 00:00:00', '2020-01-13 14:39:21.19212', '2020-01-13 14:39:21.19212', 4294967296, 16, 1000000000000000000, 0, 100, 100000000, 100, 0, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXKi4y/ySKB7DnD9H20xjB+s0gtswIwz1XdSWYaBJaFgAAAAEN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 0, 0);


--
-- Data for Name: history_operation_participants; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_operation_participants VALUES (1, 12884905985, 1);
INSERT INTO history_operation_participants VALUES (2, 12884910081, 1);
INSERT INTO history_operation_participants VALUES (3, 8589938689, 3);
INSERT INTO history_operation_participants VALUES (4, 8589938689, 2);
INSERT INTO history_operation_participants VALUES (5, 8589942785, 3);
INSERT INTO history_operation_participants VALUES (6, 8589942785, 1);


--
-- Name: history_operation_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_operation_participants_id_seq', 6, true);


--
-- Data for Name: history_operations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_operations VALUES (12884905985, 12884905984, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "trustor": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "asset_code": "USD1", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (12884910081, 12884910080, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "trustor": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "asset_code": "USD2", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (8589938689, 8589938688, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (8589942785, 8589942784, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');


--
-- Data for Name: history_trades; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: history_transaction_participants; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_transaction_participants VALUES (1, 12884905984, 1);
INSERT INTO history_transaction_participants VALUES (2, 12884910080, 1);
INSERT INTO history_transaction_participants VALUES (3, 8589938688, 3);
INSERT INTO history_transaction_participants VALUES (4, 8589938688, 2);
INSERT INTO history_transaction_participants VALUES (5, 8589942784, 3);
INSERT INTO history_transaction_participants VALUES (6, 8589942784, 1);


--
-- Name: history_transaction_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_transaction_participants_id_seq', 6, true);


--
-- Data for Name: history_transactions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_transactions VALUES ('c1fb42a38cf10241a172e577a71760921f59764ef844c88e70a8aa8a45cc95b3', 3, 1, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934593, 100, 1, '2020-01-13 14:39:21.158054', '2020-01-13 14:39:21.158054', 12884905984, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEMQAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt73//////////AAAAAAAAAAGu5L5MAAAAQJZ8WuWebLuHswBNTkDnCoAoLjvXtaaKjY/25jjdyHm2TZnoePKurryddGPThEuY7GYRJymdWkiOqDfnDPp0NAY=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+M4AAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+M4AAAAAgAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QxAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+OcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{lnxa5Z5su4ezAE1OQOcKgCguO9e1poqNj/bmON3IebZNmeh48q6uvJ10Y9OES5jsZhEnKZ1aSI6oN+cM+nQ0Bg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('373bb9329939fdb7d4448e72b01a4063e350b04a6c0f0434bc43413440d95bc0', 3, 2, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934594, 100, 1, '2020-01-13 14:39:21.158396', '2020-01-13 14:39:21.158396', 12884910080, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAACAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEMgAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt73//////////AAAAAAAAAAGu5L5MAAAAQFIuyQo5bQLTEoP2UHNr/GyjDMHoqL9x3Zvsfw/Nz6c6pYtnWfb/TyhwkTctbte/EF0zzmevTiTz3COG3vJgWwo=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+M4AAAAAgAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+M4AAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QyAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+OcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+M4AAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{Ui7JCjltAtMSg/ZQc2v8bKMMweiov3Hdm+x/D83Ppzqli2dZ9v9PKHCRNy1u178QXTPOZ69OJPPcI4be8mBbCg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('db398eb4ae89756325643cad21c94e13bfc074b323ee83e141bf701a5d904f1b', 2, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 1, 100, 1, '2020-01-13 14:39:21.176928', '2020-01-13 14:39:21.176929', 8589938688, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvkAAAAAAAAAAABVvwF9wAAAEAYjQcPT2G5hqnBmgGGeg9J8l4c1EnUlxklElH9sqZr0971F6OLWfe/m4kpFtI+sI0i1qLit5A0JyWnbhYLW5oD', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/84AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBs4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAABAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{GI0HD09huYapwZoBhnoPSfJeHNRJ1JcZJRJR/bKma9Pe9Reji1n3v5uJKRbSPrCNItai4reQNCclp24WC1uaAw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('f97caffab8c16023a37884165cb0b3ff1aa2daf4000fef49d21efc847ddbfbea', 2, 2, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 2, 100, 1, '2020-01-13 14:39:21.177194', '2020-01-13 14:39:21.177195', 8589942784, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAACAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAACVAvkAAAAAAAAAAABVvwF9wAAAEBmKpSgvrwKO20XCOfYfXsGEEUtwYaaEfqSu6ymJmlDma+IX6I7IggbUZMocQdZ94IMAfKdQANqXbIO7ysweeMC', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBs4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtq7/TDc4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/84AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{ZiqUoL68CjttFwjn2H17BhBFLcGGmhH6kruspiZpQ5mviF+iOyIIG1GTKHEHWfeCDAHynUADal2yDu8rMHnjAg==}', 'none', NULL, NULL, true, 100);


--
-- Data for Name: key_value_store; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO key_value_store VALUES ('exp_ingest_last_ledger', '0');


--
-- Data for Name: offers; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: trust_lines; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: accounts_data accounts_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts_data
    ADD CONSTRAINT accounts_data_pkey PRIMARY KEY (ledger_key);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (account_id);


--
-- Name: accounts_signers accounts_signers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts_signers
    ADD CONSTRAINT accounts_signers_pkey PRIMARY KEY (signer, account_id);


--
-- Name: asset_stats asset_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY asset_stats
    ADD CONSTRAINT asset_stats_pkey PRIMARY KEY (id);


--
-- Name: exp_asset_stats exp_asset_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exp_asset_stats
    ADD CONSTRAINT exp_asset_stats_pkey PRIMARY KEY (asset_code, asset_issuer, asset_type);


--
-- Name: exp_history_assets exp_history_assets_asset_code_asset_type_asset_issuer_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exp_history_assets
    ADD CONSTRAINT exp_history_assets_asset_code_asset_type_asset_issuer_key UNIQUE (asset_code, asset_type, asset_issuer);


--
-- Name: exp_history_assets exp_history_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exp_history_assets
    ADD CONSTRAINT exp_history_assets_pkey PRIMARY KEY (id);


--
-- Name: exp_history_operation_participants exp_history_operation_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exp_history_operation_participants
    ADD CONSTRAINT exp_history_operation_participants_pkey PRIMARY KEY (id);


--
-- Name: exp_history_transaction_participants exp_history_transaction_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exp_history_transaction_participants
    ADD CONSTRAINT exp_history_transaction_participants_pkey PRIMARY KEY (id);


--
-- Name: gorp_migrations gorp_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY gorp_migrations
    ADD CONSTRAINT gorp_migrations_pkey PRIMARY KEY (id);


--
-- Name: history_assets history_assets_asset_code_asset_type_asset_issuer_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY history_assets
    ADD CONSTRAINT history_assets_asset_code_asset_type_asset_issuer_key UNIQUE (asset_code, asset_type, asset_issuer);


--
-- Name: history_assets history_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY history_assets
    ADD CONSTRAINT history_assets_pkey PRIMARY KEY (id);


--
-- Name: history_operation_participants history_operation_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY history_operation_participants
    ADD CONSTRAINT history_operation_participants_pkey PRIMARY KEY (id);


--
-- Name: history_transaction_participants history_transaction_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY history_transaction_participants
    ADD CONSTRAINT history_transaction_participants_pkey PRIMARY KEY (id);


--
-- Name: key_value_store key_value_store_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY key_value_store
    ADD CONSTRAINT key_value_store_pkey PRIMARY KEY (key);


--
-- Name: offers offers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (offer_id);


--
-- Name: trust_lines trust_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trust_lines
    ADD CONSTRAINT trust_lines_pkey PRIMARY KEY (ledger_key);


--
-- Name: accounts_data_account_id_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX accounts_data_account_id_name ON accounts_data USING btree (account_id, name);


--
-- Name: accounts_home_domain; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_home_domain ON accounts USING btree (home_domain);


--
-- Name: accounts_inflation_destination; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX accounts_inflation_destination ON accounts USING btree (inflation_destination);


--
-- Name: asset_by_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX asset_by_code ON history_assets USING btree (asset_code);


--
-- Name: asset_by_issuer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX asset_by_issuer ON history_assets USING btree (asset_issuer);


--
-- Name: by_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX by_account ON history_transactions USING btree (account, account_sequence);


--
-- Name: by_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX by_hash ON history_transactions USING btree (transaction_hash);


--
-- Name: by_ledger; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX by_ledger ON history_transactions USING btree (ledger_sequence, application_order);


--
-- Name: exp_asset_stats_by_code; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_asset_stats_by_code ON exp_asset_stats USING btree (asset_code);


--
-- Name: exp_asset_stats_by_issuer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_asset_stats_by_issuer ON exp_asset_stats USING btree (asset_issuer);


--
-- Name: exp_history_accounts_address_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_history_accounts_address_idx ON exp_history_accounts USING btree (address);


--
-- Name: exp_history_accounts_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_history_accounts_id_idx ON exp_history_accounts USING btree (id);


--
-- Name: exp_history_assets_asset_code_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_assets_asset_code_idx ON exp_history_assets USING btree (asset_code);


--
-- Name: exp_history_assets_asset_issuer_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_assets_asset_issuer_idx ON exp_history_assets USING btree (asset_issuer);


--
-- Name: exp_history_effects_expr_expr1_expr2_expr3_expr4_expr5_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_effects_expr_expr1_expr2_expr3_expr4_expr5_idx ON exp_history_effects USING btree (((details ->> 'sold_asset_type'::text)), ((details ->> 'sold_asset_code'::text)), ((details ->> 'sold_asset_issuer'::text)), ((details ->> 'bought_asset_type'::text)), ((details ->> 'bought_asset_code'::text)), ((details ->> 'bought_asset_issuer'::text))) WHERE (type = 33);


--
-- Name: exp_history_effects_history_account_id_history_operation_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_history_effects_history_account_id_history_operation_id_idx ON exp_history_effects USING btree (history_account_id, history_operation_id, "order");


--
-- Name: exp_history_effects_history_operation_id_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_history_effects_history_operation_id_order_idx ON exp_history_effects USING btree (history_operation_id, "order");


--
-- Name: exp_history_effects_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_effects_type_idx ON exp_history_effects USING btree (type);


--
-- Name: exp_history_ledgers_closed_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_ledgers_closed_at_idx ON exp_history_ledgers USING btree (closed_at);


--
-- Name: exp_history_ledgers_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_history_ledgers_id_idx ON exp_history_ledgers USING btree (id);


--
-- Name: exp_history_ledgers_importer_version_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_ledgers_importer_version_idx ON exp_history_ledgers USING btree (importer_version);


--
-- Name: exp_history_ledgers_ledger_hash_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_history_ledgers_ledger_hash_idx ON exp_history_ledgers USING btree (ledger_hash);


--
-- Name: exp_history_ledgers_previous_ledger_hash_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_history_ledgers_previous_ledger_hash_idx ON exp_history_ledgers USING btree (previous_ledger_hash);


--
-- Name: exp_history_ledgers_sequence_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_history_ledgers_sequence_idx ON exp_history_ledgers USING btree (sequence);


--
-- Name: exp_history_operation_partici_history_account_id_history_op_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_history_operation_partici_history_account_id_history_op_idx ON exp_history_operation_participants USING btree (history_account_id, history_operation_id);


--
-- Name: exp_history_operation_participants_history_operation_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_operation_participants_history_operation_id_idx ON exp_history_operation_participants USING btree (history_operation_id);


--
-- Name: exp_history_operations_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_history_operations_id_idx ON exp_history_operations USING btree (id);


--
-- Name: exp_history_operations_transaction_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_operations_transaction_id_idx ON exp_history_operations USING btree (transaction_id);


--
-- Name: exp_history_operations_type_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_operations_type_idx ON exp_history_operations USING btree (type);


--
-- Name: exp_history_transaction_parti_history_account_id_history_tr_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_history_transaction_parti_history_account_id_history_tr_idx ON exp_history_transaction_participants USING btree (history_account_id, history_transaction_id);


--
-- Name: exp_history_transaction_participants_history_transaction_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_transaction_participants_history_transaction_id_idx ON exp_history_transaction_participants USING btree (history_transaction_id);


--
-- Name: exp_history_transactions_account_account_sequence_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_transactions_account_account_sequence_idx ON exp_history_transactions USING btree (account, account_sequence);


--
-- Name: exp_history_transactions_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_history_transactions_id_idx ON exp_history_transactions USING btree (id);


--
-- Name: exp_history_transactions_ledger_sequence_application_order_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_transactions_ledger_sequence_application_order_idx ON exp_history_transactions USING btree (ledger_sequence, application_order);


--
-- Name: exp_history_transactions_transaction_hash_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_history_transactions_transaction_hash_idx ON exp_history_transactions USING btree (transaction_hash);


--
-- Name: exp_htrd_by_base_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_htrd_by_base_account ON exp_history_trades USING btree (base_account_id);


--
-- Name: exp_htrd_by_base_offer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_htrd_by_base_offer ON exp_history_trades USING btree (base_offer_id);


--
-- Name: exp_htrd_by_counter_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_htrd_by_counter_account ON exp_history_trades USING btree (counter_account_id);


--
-- Name: exp_htrd_by_counter_offer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_htrd_by_counter_offer ON exp_history_trades USING btree (counter_offer_id);


--
-- Name: exp_htrd_by_offer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_htrd_by_offer ON exp_history_trades USING btree (offer_id);


--
-- Name: exp_htrd_counter_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_htrd_counter_lookup ON exp_history_trades USING btree (counter_asset_id);


--
-- Name: exp_htrd_pair_time_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_htrd_pair_time_lookup ON exp_history_trades USING btree (base_asset_id, counter_asset_id, ledger_closed_at);


--
-- Name: exp_htrd_pid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX exp_htrd_pid ON exp_history_trades USING btree (history_operation_id, "order");


--
-- Name: exp_htrd_time_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX exp_htrd_time_lookup ON exp_history_trades USING btree (ledger_closed_at);


--
-- Name: hist_e_by_order; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX hist_e_by_order ON history_effects USING btree (history_operation_id, "order");


--
-- Name: hist_e_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX hist_e_id ON history_effects USING btree (history_account_id, history_operation_id, "order");


--
-- Name: hist_op_p_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX hist_op_p_id ON history_operation_participants USING btree (history_account_id, history_operation_id);


--
-- Name: hist_tx_p_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX hist_tx_p_id ON history_transaction_participants USING btree (history_account_id, history_transaction_id);


--
-- Name: hop_by_hoid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX hop_by_hoid ON history_operation_participants USING btree (history_operation_id);


--
-- Name: hs_ledger_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX hs_ledger_by_id ON history_ledgers USING btree (id);


--
-- Name: hs_transaction_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX hs_transaction_by_id ON history_transactions USING btree (id);


--
-- Name: htp_by_htid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX htp_by_htid ON history_transaction_participants USING btree (history_transaction_id);


--
-- Name: htrd_by_base_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX htrd_by_base_account ON history_trades USING btree (base_account_id);


--
-- Name: htrd_by_base_offer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX htrd_by_base_offer ON history_trades USING btree (base_offer_id);


--
-- Name: htrd_by_counter_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX htrd_by_counter_account ON history_trades USING btree (counter_account_id);


--
-- Name: htrd_by_counter_offer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX htrd_by_counter_offer ON history_trades USING btree (counter_offer_id);


--
-- Name: htrd_by_offer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX htrd_by_offer ON history_trades USING btree (offer_id);


--
-- Name: htrd_counter_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX htrd_counter_lookup ON history_trades USING btree (counter_asset_id);


--
-- Name: htrd_pair_time_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX htrd_pair_time_lookup ON history_trades USING btree (base_asset_id, counter_asset_id, ledger_closed_at);


--
-- Name: htrd_pid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX htrd_pid ON history_trades USING btree (history_operation_id, "order");


--
-- Name: htrd_time_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX htrd_time_lookup ON history_trades USING btree (ledger_closed_at);


--
-- Name: index_history_accounts_on_address; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_history_accounts_on_address ON history_accounts USING btree (address);


--
-- Name: index_history_accounts_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_history_accounts_on_id ON history_accounts USING btree (id);


--
-- Name: index_history_effects_on_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_history_effects_on_type ON history_effects USING btree (type);


--
-- Name: index_history_ledgers_on_closed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_history_ledgers_on_closed_at ON history_ledgers USING btree (closed_at);


--
-- Name: index_history_ledgers_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_history_ledgers_on_id ON history_ledgers USING btree (id);


--
-- Name: index_history_ledgers_on_importer_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_history_ledgers_on_importer_version ON history_ledgers USING btree (importer_version);


--
-- Name: index_history_ledgers_on_ledger_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_history_ledgers_on_ledger_hash ON history_ledgers USING btree (ledger_hash);


--
-- Name: index_history_ledgers_on_previous_ledger_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_history_ledgers_on_previous_ledger_hash ON history_ledgers USING btree (previous_ledger_hash);


--
-- Name: index_history_ledgers_on_sequence; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_history_ledgers_on_sequence ON history_ledgers USING btree (sequence);


--
-- Name: index_history_operations_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_history_operations_on_id ON history_operations USING btree (id);


--
-- Name: index_history_operations_on_transaction_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_history_operations_on_transaction_id ON history_operations USING btree (transaction_id);


--
-- Name: index_history_operations_on_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_history_operations_on_type ON history_operations USING btree (type);


--
-- Name: index_history_transactions_on_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_history_transactions_on_id ON history_transactions USING btree (id);


--
-- Name: offers_by_buying_asset; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX offers_by_buying_asset ON offers USING btree (buying_asset);


--
-- Name: offers_by_last_modified_ledger; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX offers_by_last_modified_ledger ON offers USING btree (last_modified_ledger);


--
-- Name: offers_by_seller; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX offers_by_seller ON offers USING btree (seller_id);


--
-- Name: offers_by_selling_asset; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX offers_by_selling_asset ON offers USING btree (selling_asset);


--
-- Name: signers_by_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX signers_by_account ON accounts_signers USING btree (account_id);


--
-- Name: trade_effects_by_order_book; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX trade_effects_by_order_book ON history_effects USING btree (((details ->> 'sold_asset_type'::text)), ((details ->> 'sold_asset_code'::text)), ((details ->> 'sold_asset_issuer'::text)), ((details ->> 'bought_asset_type'::text)), ((details ->> 'bought_asset_code'::text)), ((details ->> 'bought_asset_issuer'::text))) WHERE (type = 33);


--
-- Name: trust_lines_by_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX trust_lines_by_account_id ON trust_lines USING btree (account_id);


--
-- Name: trust_lines_by_issuer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX trust_lines_by_issuer ON trust_lines USING btree (asset_issuer);


--
-- Name: trust_lines_by_type_code_issuer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX trust_lines_by_type_code_issuer ON trust_lines USING btree (asset_type, asset_code, asset_issuer);


--
-- Name: asset_stats asset_stats_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY asset_stats
    ADD CONSTRAINT asset_stats_id_fkey FOREIGN KEY (id) REFERENCES history_assets(id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: exp_history_trades exp_history_trades_base_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exp_history_trades
    ADD CONSTRAINT exp_history_trades_base_account_id_fkey FOREIGN KEY (base_account_id) REFERENCES exp_history_accounts(id);


--
-- Name: exp_history_trades exp_history_trades_base_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exp_history_trades
    ADD CONSTRAINT exp_history_trades_base_asset_id_fkey FOREIGN KEY (base_asset_id) REFERENCES exp_history_assets(id);


--
-- Name: exp_history_trades exp_history_trades_counter_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exp_history_trades
    ADD CONSTRAINT exp_history_trades_counter_account_id_fkey FOREIGN KEY (counter_account_id) REFERENCES exp_history_accounts(id);


--
-- Name: exp_history_trades exp_history_trades_counter_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY exp_history_trades
    ADD CONSTRAINT exp_history_trades_counter_asset_id_fkey FOREIGN KEY (counter_asset_id) REFERENCES exp_history_assets(id);


--
-- Name: history_trades history_trades_base_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY history_trades
    ADD CONSTRAINT history_trades_base_account_id_fkey FOREIGN KEY (base_account_id) REFERENCES history_accounts(id);


--
-- Name: history_trades history_trades_base_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY history_trades
    ADD CONSTRAINT history_trades_base_asset_id_fkey FOREIGN KEY (base_asset_id) REFERENCES history_assets(id);


--
-- Name: history_trades history_trades_counter_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY history_trades
    ADD CONSTRAINT history_trades_counter_account_id_fkey FOREIGN KEY (counter_account_id) REFERENCES history_accounts(id);


--
-- Name: history_trades history_trades_counter_asset_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY history_trades
    ADD CONSTRAINT history_trades_counter_asset_id_fkey FOREIGN KEY (counter_asset_id) REFERENCES history_assets(id);


--
-- PostgreSQL database dump complete
--

