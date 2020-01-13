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

INSERT INTO gorp_migrations VALUES ('1_initial_schema.sql', '2020-01-13 15:36:43.944144+01');
INSERT INTO gorp_migrations VALUES ('2_index_participants_by_toid.sql', '2020-01-13 15:36:43.950758+01');
INSERT INTO gorp_migrations VALUES ('3_use_sequence_in_history_accounts.sql', '2020-01-13 15:36:43.95591+01');
INSERT INTO gorp_migrations VALUES ('4_add_protocol_version.sql', '2020-01-13 15:36:43.970906+01');
INSERT INTO gorp_migrations VALUES ('5_create_trades_table.sql', '2020-01-13 15:36:43.978679+01');
INSERT INTO gorp_migrations VALUES ('6_create_assets_table.sql', '2020-01-13 15:36:43.983806+01');
INSERT INTO gorp_migrations VALUES ('7_modify_trades_table.sql', '2020-01-13 15:36:43.999024+01');
INSERT INTO gorp_migrations VALUES ('8_add_aggregators.sql', '2020-01-13 15:36:44.003786+01');
INSERT INTO gorp_migrations VALUES ('8_create_asset_stats_table.sql', '2020-01-13 15:36:44.009234+01');
INSERT INTO gorp_migrations VALUES ('9_add_header_xdr.sql', '2020-01-13 15:36:44.012336+01');
INSERT INTO gorp_migrations VALUES ('10_add_trades_price.sql', '2020-01-13 15:36:44.015681+01');
INSERT INTO gorp_migrations VALUES ('11_add_trades_account_index.sql', '2020-01-13 15:36:44.019472+01');
INSERT INTO gorp_migrations VALUES ('12_asset_stats_amount_string.sql', '2020-01-13 15:36:44.024742+01');
INSERT INTO gorp_migrations VALUES ('13_trade_offer_ids.sql', '2020-01-13 15:36:44.029592+01');
INSERT INTO gorp_migrations VALUES ('14_fix_asset_toml_field.sql', '2020-01-13 15:36:44.030917+01');
INSERT INTO gorp_migrations VALUES ('15_ledger_failed_txs.sql', '2020-01-13 15:36:44.03233+01');
INSERT INTO gorp_migrations VALUES ('16_ingest_failed_transactions.sql', '2020-01-13 15:36:44.033672+01');
INSERT INTO gorp_migrations VALUES ('17_transaction_fee_paid.sql', '2020-01-13 15:36:44.035431+01');
INSERT INTO gorp_migrations VALUES ('18_account_for_signers.sql', '2020-01-13 15:36:44.042479+01');
INSERT INTO gorp_migrations VALUES ('19_offers.sql', '2020-01-13 15:36:44.052927+01');
INSERT INTO gorp_migrations VALUES ('20_account_for_signer_index.sql', '2020-01-13 15:36:44.055517+01');
INSERT INTO gorp_migrations VALUES ('21_trades_remove_zero_amount_constraints.sql', '2020-01-13 15:36:44.058517+01');
INSERT INTO gorp_migrations VALUES ('22_trust_lines.sql', '2020-01-13 15:36:44.066053+01');
INSERT INTO gorp_migrations VALUES ('23_exp_asset_stats.sql', '2020-01-13 15:36:44.07251+01');
INSERT INTO gorp_migrations VALUES ('24_accounts.sql', '2020-01-13 15:36:44.08057+01');
INSERT INTO gorp_migrations VALUES ('25_expingest_rename_columns.sql', '2020-01-13 15:36:44.083169+01');
INSERT INTO gorp_migrations VALUES ('26_exp_history_ledgers.sql', '2020-01-13 15:36:44.093517+01');
INSERT INTO gorp_migrations VALUES ('27_exp_history_transactions.sql', '2020-01-13 15:36:44.109201+01');
INSERT INTO gorp_migrations VALUES ('28_exp_history_operations.sql', '2020-01-13 15:36:44.119467+01');
INSERT INTO gorp_migrations VALUES ('29_exp_history_assets.sql', '2020-01-13 15:36:44.125243+01');
INSERT INTO gorp_migrations VALUES ('30_exp_history_trades.sql', '2020-01-13 15:36:44.141891+01');
INSERT INTO gorp_migrations VALUES ('31_exp_history_effects.sql', '2020-01-13 15:36:44.149757+01');


--
-- Data for Name: history_accounts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_accounts VALUES (1, 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON');
INSERT INTO history_accounts VALUES (2, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_accounts VALUES (3, 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4');
INSERT INTO history_accounts VALUES (4, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');


--
-- Name: history_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_accounts_id_seq', 4, true);


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

INSERT INTO history_effects VALUES (2, 17179873281, 1, 2, '{"amount": "5000.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (3, 17179873281, 2, 3, '{"amount": "5000.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (1, 17179877377, 1, 2, '{"amount": "5000.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (3, 17179877377, 2, 3, '{"amount": "5000.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (2, 17179881473, 1, 2, '{"amount": "6000.0000000", "asset_code": "BTC", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (3, 17179881473, 2, 3, '{"amount": "6000.0000000", "asset_code": "BTC", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (1, 17179885569, 1, 2, '{"amount": "6000.0000000", "asset_code": "BTC", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (3, 17179885569, 2, 3, '{"amount": "6000.0000000", "asset_code": "BTC", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (1, 12884905985, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (2, 12884910081, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (2, 12884914177, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "BTC", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (1, 12884918273, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "BTC", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (3, 8589938689, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (4, 8589938689, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (3, 8589938689, 3, 10, '{"weight": 1, "public_key": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (2, 8589942785, 1, 0, '{"starting_balance": "10000.0000000"}');
INSERT INTO history_effects VALUES (4, 8589942785, 2, 3, '{"amount": "10000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (2, 8589942785, 3, 10, '{"weight": 1, "public_key": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU"}');
INSERT INTO history_effects VALUES (1, 8589946881, 1, 0, '{"starting_balance": "10000.0000000"}');
INSERT INTO history_effects VALUES (4, 8589946881, 2, 3, '{"amount": "10000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (1, 8589946881, 3, 10, '{"weight": 1, "public_key": "GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON"}');


--
-- Data for Name: history_ledgers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_ledgers VALUES (6, '512cb3d63bb344ddf82712943a18e2667fd2fd7ae29538f0648f66352183ffdc', '8cc61ce6b6a9468f82ac9dd53a5f8f7e32629ade8c3393b84b299efef84e42d5', 6, 6, '2020-01-13 14:36:45', '2020-01-13 14:36:44.417003', '2020-01-13 14:36:44.417003', 25769803776, 16, 1000000000000000000, 2300, 100, 100000000, 1000000, 12, 'AAAADIzGHOa2qUaPgqyd1Tpfj34yYprejDOTuEspnv74TkLVxfzu14RSi+RBbu5BJgkFjGRRk94jbsoLvTQk8lS9+rAAAAAAXhyAfQAAAAAAAAAAO03rkSSGII+TmdA0r8T7dSNCWamYkyOlDZ73gpuryU/VkJy3/ThsJFUX/mOAq7/b7ACQnbWRfsrakuPDFToTwAAAAAYN4Lazp2QAAAAAAAAAAAj8AAAAAAAAAAAAAAAMAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 6, 0);
INSERT INTO history_ledgers VALUES (5, '8cc61ce6b6a9468f82ac9dd53a5f8f7e32629ade8c3393b84b299efef84e42d5', '2a69f259a7aad74c18983114fad4e3b2ca21a50e27cf4db0285d242da389d744', 6, 6, '2020-01-13 14:36:44', '2020-01-13 14:36:44.436706', '2020-01-13 14:36:44.436706', 21474836480, 16, 1000000000000000000, 1700, 100, 100000000, 1000000, 12, 'AAAADCpp8lmnqtdMGJgxFPrU47LKIaUOJ89NsChdJC2jiddEzu2MdvjxZJfRLpaVUU8gdCFg6Z9jflV36wpBGTvRQSQAAAAAXhyAfAAAAAAAAAAAougk/RtTORnfcsQ4nqGdyTRU18L5Jip13GkYYbC+pmIjDayJOi3mTYDBVuOMusf1aqqe7DJemietyYbK80xpjAAAAAUN4Lazp2QAAAAAAAAAAAakAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 6, 0);
INSERT INTO history_ledgers VALUES (4, '2a69f259a7aad74c18983114fad4e3b2ca21a50e27cf4db0285d242da389d744', '754c5e85bf47b0603ca240073cb0855dbce84123ad34d4eb3f790aa591158f4d', 4, 4, '2020-01-13 14:36:43', '2020-01-13 14:36:44.452185', '2020-01-13 14:36:44.452185', 17179869184, 16, 1000000000000000000, 1100, 100, 100000000, 1000000, 12, 'AAAADHVMXoW/R7BgPKJABzywhV286EEjrTTU6z95CqWRFY9No1mVq35oJL6OzhlAgrQde4y4dwyPUKX/Ez8ayaXRCe0AAAAAXhyAewAAAAAAAAAAEvM5tT8l0dTEZQLsPGomBGcTJkGZVcTwRLD10i4EXb8QE804T1S3Uf3aNCmkIu4Mu+uVwH2g6Lt+J2GhdqwISwAAAAQN4Lazp2QAAAAAAAAAAARMAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 4, 0);
INSERT INTO history_ledgers VALUES (3, '754c5e85bf47b0603ca240073cb0855dbce84123ad34d4eb3f790aa591158f4d', '3c0507580115b0251a7429f668e262263dcb72ce2342cef8421a6f8f8706f7ad', 4, 4, '2020-01-13 14:36:42', '2020-01-13 14:36:44.472927', '2020-01-13 14:36:44.472927', 12884901888, 16, 1000000000000000000, 700, 100, 100000000, 1000000, 12, 'AAAADDwFB1gBFbAlGnQp9mjiYiY9y3LOI0LO+EIab4+HBvetxrLPGhzuNAzzYp4Br6vRPrizHR/uVGI2Xe/yJJX05jcAAAAAXhyAegAAAAIAAAAIAAAAAQAAAAwAAAAIAAAAAwAPQkAAAAAAscFlow9fsw7DsFjGhjjPxcSMdjdLNWUz34mmgDWxHBYyyeplxdT35tjOxUBtcEYfdlqt2ytWbpj9qrDulvE3jwAAAAMN4Lazp2QAAAAAAAAAAAK8AAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 4, 0);
INSERT INTO history_ledgers VALUES (2, '3c0507580115b0251a7429f668e262263dcb72ce2342cef8421a6f8f8706f7ad', '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', 3, 3, '2020-01-13 14:36:41', '2020-01-13 14:36:44.484841', '2020-01-13 14:36:44.484841', 8589934592, 16, 1000000000000000000, 300, 100, 100000000, 100, 0, 'AAAAAGPZj1Nu5o0bJ7W4nyOvUxG3Vpok+vFAOtC1K2M7B76ZCS8URcyE4gRYsZAdb7e4uHwbaA5fhFIEcA1CSR23Z5oAAAAAXhyAeQAAAAAAAAAAzi1xgnE3PAfb2CbU6dwiHL3p/nbMw7WpXJpWKu4ASug/J66yoSmncDm/ZibPQsmqZ6XGb6Vj/E0UaOKHzJtZnwAAAAIN4Lazp2QAAAAAAAAAAAEsAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 3, 0);
INSERT INTO history_ledgers VALUES (1, '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', NULL, 0, 0, '1970-01-01 00:00:00', '2020-01-13 14:36:44.498531', '2020-01-13 14:36:44.498531', 4294967296, 16, 1000000000000000000, 0, 100, 100000000, 100, 0, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXKi4y/ySKB7DnD9H20xjB+s0gtswIwz1XdSWYaBJaFgAAAAEN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 0, 0);


--
-- Data for Name: history_operation_participants; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_operation_participants VALUES (1, 25769807873, 1);
INSERT INTO history_operation_participants VALUES (2, 25769811969, 2);
INSERT INTO history_operation_participants VALUES (3, 25769816065, 1);
INSERT INTO history_operation_participants VALUES (4, 25769820161, 2);
INSERT INTO history_operation_participants VALUES (5, 25769824257, 2);
INSERT INTO history_operation_participants VALUES (6, 25769828353, 1);
INSERT INTO history_operation_participants VALUES (7, 21474840577, 2);
INSERT INTO history_operation_participants VALUES (8, 21474844673, 1);
INSERT INTO history_operation_participants VALUES (9, 21474848769, 1);
INSERT INTO history_operation_participants VALUES (10, 21474852865, 2);
INSERT INTO history_operation_participants VALUES (11, 21474856961, 2);
INSERT INTO history_operation_participants VALUES (12, 21474861057, 1);
INSERT INTO history_operation_participants VALUES (13, 17179873281, 3);
INSERT INTO history_operation_participants VALUES (14, 17179873281, 2);
INSERT INTO history_operation_participants VALUES (15, 17179877377, 3);
INSERT INTO history_operation_participants VALUES (16, 17179877377, 1);
INSERT INTO history_operation_participants VALUES (17, 17179881473, 3);
INSERT INTO history_operation_participants VALUES (18, 17179881473, 2);
INSERT INTO history_operation_participants VALUES (19, 17179885569, 3);
INSERT INTO history_operation_participants VALUES (20, 17179885569, 1);
INSERT INTO history_operation_participants VALUES (21, 12884905985, 1);
INSERT INTO history_operation_participants VALUES (22, 12884910081, 2);
INSERT INTO history_operation_participants VALUES (23, 12884914177, 2);
INSERT INTO history_operation_participants VALUES (24, 12884918273, 1);
INSERT INTO history_operation_participants VALUES (25, 8589938689, 4);
INSERT INTO history_operation_participants VALUES (26, 8589938689, 3);
INSERT INTO history_operation_participants VALUES (27, 8589942785, 4);
INSERT INTO history_operation_participants VALUES (28, 8589942785, 2);
INSERT INTO history_operation_participants VALUES (29, 8589946881, 4);
INSERT INTO history_operation_participants VALUES (30, 8589946881, 1);


--
-- Name: history_operation_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_operation_participants_id_seq', 30, true);


--
-- Data for Name: history_operations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_operations VALUES (25769807873, 25769807872, 1, 3, '{"price": "15.0000000", "amount": "10.0000000", "price_r": {"d": 1, "n": 15}, "offer_id": 0, "buying_asset_code": "BTC", "buying_asset_type": "credit_alphanum4", "selling_asset_code": "USD", "selling_asset_type": "credit_alphanum4", "buying_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "selling_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON');
INSERT INTO history_operations VALUES (25769811969, 25769811968, 1, 3, '{"price": "0.1000000", "amount": "100.0000000", "price_r": {"d": 10, "n": 1}, "offer_id": 0, "buying_asset_code": "USD", "buying_asset_type": "credit_alphanum4", "selling_asset_code": "BTC", "selling_asset_type": "credit_alphanum4", "buying_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "selling_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (25769816065, 25769816064, 1, 3, '{"price": "20.0000000", "amount": "100.0000000", "price_r": {"d": 1, "n": 20}, "offer_id": 0, "buying_asset_code": "BTC", "buying_asset_type": "credit_alphanum4", "selling_asset_code": "USD", "selling_asset_type": "credit_alphanum4", "buying_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "selling_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON');
INSERT INTO history_operations VALUES (25769820161, 25769820160, 1, 3, '{"price": "0.1111111", "amount": "900.0000000", "price_r": {"d": 9, "n": 1}, "offer_id": 0, "buying_asset_code": "USD", "buying_asset_type": "credit_alphanum4", "selling_asset_code": "BTC", "selling_asset_type": "credit_alphanum4", "buying_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "selling_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (25769824257, 25769824256, 1, 3, '{"price": "0.2000000", "amount": "5000.0000000", "price_r": {"d": 5, "n": 1}, "offer_id": 0, "buying_asset_code": "USD", "buying_asset_type": "credit_alphanum4", "selling_asset_code": "BTC", "selling_asset_type": "credit_alphanum4", "buying_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "selling_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (25769828353, 25769828352, 1, 3, '{"price": "50.0000000", "amount": "1000.0000000", "price_r": {"d": 1, "n": 50}, "offer_id": 0, "buying_asset_code": "BTC", "buying_asset_type": "credit_alphanum4", "selling_asset_code": "USD", "selling_asset_type": "credit_alphanum4", "buying_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "selling_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON');
INSERT INTO history_operations VALUES (21474840577, 21474840576, 1, 3, '{"price": "0.1000000", "amount": "100.0000000", "price_r": {"d": 10, "n": 1}, "offer_id": 0, "buying_asset_code": "USD", "buying_asset_type": "credit_alphanum4", "selling_asset_type": "native", "buying_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (21474844673, 21474844672, 1, 3, '{"price": "15.0000000", "amount": "10.0000000", "price_r": {"d": 1, "n": 15}, "offer_id": 0, "buying_asset_type": "native", "selling_asset_code": "USD", "selling_asset_type": "credit_alphanum4", "selling_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON');
INSERT INTO history_operations VALUES (21474848769, 21474848768, 1, 3, '{"price": "20.0000000", "amount": "100.0000000", "price_r": {"d": 1, "n": 20}, "offer_id": 0, "buying_asset_type": "native", "selling_asset_code": "USD", "selling_asset_type": "credit_alphanum4", "selling_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON');
INSERT INTO history_operations VALUES (21474852865, 21474852864, 1, 3, '{"price": "0.1111111", "amount": "900.0000000", "price_r": {"d": 9, "n": 1}, "offer_id": 0, "buying_asset_code": "USD", "buying_asset_type": "credit_alphanum4", "selling_asset_type": "native", "buying_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (21474856961, 21474856960, 1, 3, '{"price": "0.2000000", "amount": "5000.0000000", "price_r": {"d": 5, "n": 1}, "offer_id": 0, "buying_asset_code": "USD", "buying_asset_type": "credit_alphanum4", "selling_asset_type": "native", "buying_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (21474861057, 21474861056, 1, 3, '{"price": "50.0000000", "amount": "1000.0000000", "price_r": {"d": 1, "n": 50}, "offer_id": 0, "buying_asset_type": "native", "selling_asset_code": "USD", "selling_asset_type": "credit_alphanum4", "selling_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON');
INSERT INTO history_operations VALUES (17179873281, 17179873280, 1, 1, '{"to": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "from": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "amount": "5000.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4');
INSERT INTO history_operations VALUES (17179877377, 17179877376, 1, 1, '{"to": "GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON", "from": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "amount": "5000.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4');
INSERT INTO history_operations VALUES (17179881473, 17179881472, 1, 1, '{"to": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "from": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "amount": "6000.0000000", "asset_code": "BTC", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4');
INSERT INTO history_operations VALUES (17179885569, 17179885568, 1, 1, '{"to": "GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON", "from": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "amount": "6000.0000000", "asset_code": "BTC", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4');
INSERT INTO history_operations VALUES (12884905985, 12884905984, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "trustor": "GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON');
INSERT INTO history_operations VALUES (12884910081, 12884910080, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "trustor": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (12884914177, 12884914176, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "trustor": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "asset_code": "BTC", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (12884918273, 12884918272, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "trustor": "GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON", "asset_code": "BTC", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON');
INSERT INTO history_operations VALUES (8589938689, 8589938688, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (8589942785, 8589942784, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "starting_balance": "10000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (8589946881, 8589946880, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON", "starting_balance": "10000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');


--
-- Data for Name: history_trades; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: history_transaction_participants; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_transaction_participants VALUES (1, 25769807872, 1);
INSERT INTO history_transaction_participants VALUES (2, 25769811968, 2);
INSERT INTO history_transaction_participants VALUES (3, 25769816064, 1);
INSERT INTO history_transaction_participants VALUES (4, 25769820160, 2);
INSERT INTO history_transaction_participants VALUES (5, 25769824256, 2);
INSERT INTO history_transaction_participants VALUES (6, 25769828352, 1);
INSERT INTO history_transaction_participants VALUES (7, 21474840576, 2);
INSERT INTO history_transaction_participants VALUES (8, 21474844672, 1);
INSERT INTO history_transaction_participants VALUES (9, 21474848768, 1);
INSERT INTO history_transaction_participants VALUES (10, 21474852864, 2);
INSERT INTO history_transaction_participants VALUES (11, 21474856960, 2);
INSERT INTO history_transaction_participants VALUES (12, 21474861056, 1);
INSERT INTO history_transaction_participants VALUES (13, 17179873280, 3);
INSERT INTO history_transaction_participants VALUES (14, 17179873280, 2);
INSERT INTO history_transaction_participants VALUES (15, 17179877376, 3);
INSERT INTO history_transaction_participants VALUES (16, 17179877376, 1);
INSERT INTO history_transaction_participants VALUES (17, 17179881472, 3);
INSERT INTO history_transaction_participants VALUES (18, 17179881472, 2);
INSERT INTO history_transaction_participants VALUES (19, 17179885568, 3);
INSERT INTO history_transaction_participants VALUES (20, 17179885568, 1);
INSERT INTO history_transaction_participants VALUES (21, 12884905984, 1);
INSERT INTO history_transaction_participants VALUES (22, 12884910080, 2);
INSERT INTO history_transaction_participants VALUES (23, 12884914176, 2);
INSERT INTO history_transaction_participants VALUES (24, 12884918272, 1);
INSERT INTO history_transaction_participants VALUES (25, 8589938688, 4);
INSERT INTO history_transaction_participants VALUES (26, 8589938688, 3);
INSERT INTO history_transaction_participants VALUES (27, 8589942784, 4);
INSERT INTO history_transaction_participants VALUES (28, 8589942784, 2);
INSERT INTO history_transaction_participants VALUES (29, 8589946880, 1);
INSERT INTO history_transaction_participants VALUES (30, 8589946880, 4);


--
-- Name: history_transaction_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_transaction_participants_id_seq', 30, true);


--
-- Data for Name: history_transactions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_transactions VALUES ('82ebbbd502be295802887ff05f5cc888c4357a3c6c81f6b1dbdde1e3fb3989b1', 6, 1, 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON', 8589934598, 100, 1, '2020-01-13 14:36:44.417417', '2020-01-13 14:36:44.417417', 25769807872, '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', '{lFlL601BUvClwtCF2Ml08uHMy0rQ/xguaNPgG8aOgbt/n9z236xF+rkndcbjsTCf5LM6dz1VXhDC8st26yLDAA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('701efa0b0226e961d31df74f4282982b4048b2b9849ea3f7e02a418511d7a9c5', 6, 2, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934598, 100, 1, '2020-01-13 14:36:44.418329', '2020-01-13 14:36:44.41833', 25769811968, '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', '{6ATOWt8jLNjc5W5Z1E5SPvfIsEi1XWalmVY45kyDnrxWOrXpqx7JOC9RQG9aYFA6N0ssOxju9TdJHxECCIIwCQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('a415b192f3730a3ef139035f3c67e3b10a4ea69ff5145f3a76615c1a82400dc9', 6, 3, 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON', 8589934599, 100, 1, '2020-01-13 14:36:44.41892', '2020-01-13 14:36:44.41892', 25769816064, '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', '{09iNPJPv+ZhprZCRsXMObSMuksOEm1kD6sk0lHtJN+4FxQldzlb5TBaz/AjfaLC7iJ5TeVrqkkiTAj/R2rp1DA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('5dbdfd3ab91f4a52a11ba92c60334bca0d4aad951fe3d159b373afaba1632ea1', 6, 4, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934599, 100, 1, '2020-01-13 14:36:44.41918', '2020-01-13 14:36:44.41918', 25769820160, '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', '{OwcvMP/ur+0FoW368vyy+fjLerUAXEwhi5Pw0zNuzBWwJRwsjVCWTEFBa0HtKOgNAy13p0kRo7a6mY9f0/c8BA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('dfcf019e8c71290048dcd0e4fa01a6d7278386b3e6a793b4c53dd7751cd289e9', 6, 5, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934600, 100, 1, '2020-01-13 14:36:44.419396', '2020-01-13 14:36:44.419396', 25769824256, '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', '{noayYrF6OEhKYq4sh0Xp2LEPACIaoYIbEnndY6gUDG5R2kC+vfFXkiG/+ePx2DlG0HNvwpgKg5hOJsVEMysHBQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('483298f40a79f46f684c41d22d4d902f1d3feb53abe5551d3ad69dc832408055', 6, 6, 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON', 8589934600, 100, 1, '2020-01-13 14:36:44.419584', '2020-01-13 14:36:44.419584', 25769828352, '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', '{4Q+Q7+2pPiRAHM2VM57Nm2LJu4ST2YybEaMuWYe55bxC1RLgnU7daHLg0qHy/CaicpDW4ykIz/NhHO6aNIS4CQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('f42caf0be4aa867ffa832f8f925b75cf89b5615528016eb7ea47a285d2919a6c', 5, 1, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934595, 100, 1, '2020-01-13 14:36:44.437002', '2020-01-13 14:36:44.437003', 21474840576, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAADAAAAAAAAAAAAAAABAAAAAAAAAAMAAAAAAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rKAAAAAAEAAAAKAAAAAAAAAAAAAAAAAAAAAa7kvkwAAABAeyObGhkwxonX/VI/jcfjrHOdhMDI9U7u4KxVjA3XHqkW4ENworQ5mZDRjj282acAG8cMfWGvYfFcQVVdX62nCw==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAAAAAAAEAAAAAAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rKAAAAAAEAAAAKAAAAAAAAAAAAAAAA', 'AAAAAQAAAAIAAAADAAAABQAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAXSHbmDAAAAAIAAAACAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABQAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAXSHbmDAAAAAIAAAADAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABQAAAAMAAAAFAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduYMAAAAAgAAAAMAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduYMAAAAAgAAAAMAAAADAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAAAO5rKAAAAAAAAAAAAAAAAAAAAAAUAAAACAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAAAAAAAEAAAAAAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rKAAAAAAEAAAAKAAAAAAAAAAAAAAAAAAAAAwAAAAQAAAABAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAALpDt0AH//////////AAAAAQAAAAAAAAAAAAAAAQAAAAUAAAABAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAALpDt0AH//////////AAAAAQAAAAEAAAAABfXhAAAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAgAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduc4AAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIdubUAAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{eyObGhkwxonX/VI/jcfjrHOdhMDI9U7u4KxVjA3XHqkW4ENworQ5mZDRjj282acAG8cMfWGvYfFcQVVdX62nCw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('6fcbcfbcde0ad6e2da47126334413984d7337dffa9c537fb0569f848b3d2f6f2', 5, 2, 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON', 8589934595, 100, 1, '2020-01-13 14:36:44.4373', '2020-01-13 14:36:44.4373', 21474844672, 'AAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAZAAAAAIAAAADAAAAAAAAAAAAAAABAAAAAAAAAAMAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAAAAAABfXhAAAAAA8AAAABAAAAAAAAAAAAAAAAAAAAAW8UiFoAAABAxsghzEhvQmICVccjSoy9Q2LUjXol62JlBd8shmRwqO9XyelpSY554bdmHq6xqc6jYZow955E47PWqCEfeVhhCw==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAAAAAAIAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAAAAAABfXhAAAAAA8AAAABAAAAAAAAAAAAAAAA', 'AAAAAQAAAAIAAAADAAAABQAAAAAAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAXSHbmDAAAAAIAAAACAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABQAAAAAAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAXSHbmDAAAAAIAAAADAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABQAAAAMAAAAFAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduYMAAAAAgAAAAMAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduYMAAAAAgAAAAMAAAADAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAFloLwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUAAAACAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAAAAAAIAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAAAAAABfXhAAAAAA8AAAABAAAAAAAAAAAAAAAAAAAAAwAAAAQAAAABAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAALpDt0AH//////////AAAAAQAAAAAAAAAAAAAAAQAAAAUAAAABAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAALpDt0AH//////////AAAAAQAAAAEAAAAAAAAAAAAAAAAF9eEAAAAAAAAAAAA=', 'AAAAAgAAAAMAAAADAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduc4AAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIdubUAAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{xsghzEhvQmICVccjSoy9Q2LUjXol62JlBd8shmRwqO9XyelpSY554bdmHq6xqc6jYZow955E47PWqCEfeVhhCw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('e9185c1cd138c5c15625531cfb527c50b9b84fadaa1a45c749f7af9647dec450', 5, 3, 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON', 8589934596, 100, 1, '2020-01-13 14:36:44.437572', '2020-01-13 14:36:44.437572', 21474848768, 'AAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAZAAAAAIAAAAEAAAAAAAAAAAAAAABAAAAAAAAAAMAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAAAAAAO5rKAAAAABQAAAABAAAAAAAAAAAAAAAAAAAAAW8UiFoAAABAgI2ziUivGtOdn4yh1DKts6kzH4kZroEEHAUKspjBt8JrewsqrY1vOvn/5ob+x5EGmpEOFaDB/mINM33OASmyAA==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAAAAAAMAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAAAAAAO5rKAAAAABQAAAABAAAAAAAAAAAAAAAA', 'AAAAAQAAAAIAAAADAAAABQAAAAAAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAXSHbmDAAAAAIAAAADAAAAAwAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAABZaC8AAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduYMAAAAAgAAAAQAAAADAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAFloLwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAUAAAADAAAABQAAAAAAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAXSHbmDAAAAAIAAAAEAAAAAwAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAABZaC8AAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduYMAAAAAgAAAAQAAAAEAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAABQF/9wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUAAAACAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAAAAAAMAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAAAAAAO5rKAAAAABQAAAABAAAAAAAAAAAAAAAAAAAAAwAAAAUAAAABAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAALpDt0AH//////////AAAAAQAAAAEAAAAAAAAAAAAAAAAF9eEAAAAAAAAAAAAAAAABAAAABQAAAAEAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAukO3QAf/////////8AAAABAAAAAQAAAAAAAAAAAAAAAEGQqwAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAFAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIdubUAAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduZwAAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{gI2ziUivGtOdn4yh1DKts6kzH4kZroEEHAUKspjBt8JrewsqrY1vOvn/5ob+x5EGmpEOFaDB/mINM33OASmyAA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('dcd151fda3242912d2fe71e0181f80806f081a61cf4746873b2ec15bb1bae395', 5, 4, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934596, 100, 1, '2020-01-13 14:36:44.437828', '2020-01-13 14:36:44.437828', 21474852864, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAAEAAAAAAAAAAAAAAABAAAAAAAAAAMAAAAAAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACGHEaAAAAAAEAAAAJAAAAAAAAAAAAAAAAAAAAAa7kvkwAAABAqPx69qSD18N3YK5zdNznZdpXBkbohJTuCKnYl0dQPAE/HWxA8fNfVggVZtGaGk8YMcH/4dvB7zeGF9SEQoSQBg==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAAAAAAAQAAAAAAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACGHEaAAAAAAEAAAAJAAAAAAAAAAAAAAAA', 'AAAAAQAAAAIAAAADAAAABQAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAXSHbmDAAAAAIAAAADAAAAAwAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAAAAAAAAAAAADuaygAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduYMAAAAAgAAAAQAAAADAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAAAO5rKAAAAAAAAAAAAAAAAAQAAAAUAAAAAAAAABQAAAAIAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAAAAAABAAAAAAAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAIYcRoAAAAAAQAAAAkAAAAAAAAAAAAAAAAAAAADAAAABQAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAXSHbmDAAAAAIAAAAEAAAAAwAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAAAAAAAAAAAADuaygAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduYMAAAAAgAAAAQAAAAEAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAACVAvkAAAAAAAAAAAAAAAAAwAAAAUAAAABAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAALpDt0AH//////////AAAAAQAAAAEAAAAABfXhAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAABQAAAAEAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAukO3QAf/////////8AAAABAAAAAQAAAABBkKsAAAAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAFAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIdubUAAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduZwAAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{qPx69qSD18N3YK5zdNznZdpXBkbohJTuCKnYl0dQPAE/HWxA8fNfVggVZtGaGk8YMcH/4dvB7zeGF9SEQoSQBg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('f93841b864bc4ce3ddcc2e2ab4378bfd443ecd6eee85b95d634da5c00b0cd667', 5, 5, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934597, 100, 1, '2020-01-13 14:36:44.438106', '2020-01-13 14:36:44.438106', 21474856960, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAAFAAAAAAAAAAAAAAABAAAAAAAAAAMAAAAAAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAALpDt0AAAAAAEAAAAFAAAAAAAAAAAAAAAAAAAAAa7kvkwAAABAO6P8u7hte5mLhMJe3EDbGFmBHKg/kN03Gfvwao0kYaGv7wHYouK/zhWBLu3A+tB4haCav2a/dO1JiND6xX11AA==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAAAAAAAUAAAAAAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAALpDt0AAAAAAEAAAAFAAAAAAAAAAAAAAAA', 'AAAAAQAAAAIAAAADAAAABQAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAXSHbmDAAAAAIAAAAEAAAABAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAlQL5AAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduYMAAAAAgAAAAUAAAAEAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAACVAvkAAAAAAAAAAAAAAAAAQAAAAUAAAADAAAABQAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAXSHbmDAAAAAIAAAAFAAAABAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAlQL5AAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduYMAAAAAgAAAAUAAAAFAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAAN+EdYAAAAAAAAAAAAAAAAAAAAAAUAAAACAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAAAAAAAUAAAAAAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAALpDt0AAAAAAEAAAAFAAAAAAAAAAAAAAAAAAAAAwAAAAUAAAABAAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAALpDt0AH//////////AAAAAQAAAAEAAAAAQZCrAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAABQAAAAEAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAukO3QAf/////////8AAAABAAAAAQAAAAKVnI8AAAAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAFAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduZwAAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduYMAAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{O6P8u7hte5mLhMJe3EDbGFmBHKg/kN03Gfvwao0kYaGv7wHYouK/zhWBLu3A+tB4haCav2a/dO1JiND6xX11AA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('cd12e89db9e04541e37c796ebaae118d36f3bf9dcd3dde4ae0af96b768ffe71f', 5, 6, 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON', 8589934597, 100, 1, '2020-01-13 14:36:44.43836', '2020-01-13 14:36:44.438361', 21474861056, 'AAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAZAAAAAIAAAAFAAAAAAAAAAAAAAABAAAAAAAAAAMAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAAAAACVAvkAAAAADIAAAABAAAAAAAAAAAAAAAAAAAAAW8UiFoAAABA5Xo6CV4r7iFHfyeH2p1RsjxOyoXGqhom3bEbhCMeTQNK2+UYCyWnmhZR6yRiWge9MSfcFhiv1LafatF+SW+EAg==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAAAAAAYAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAAAAACVAvkAAAAADIAAAABAAAAAAAAAAAAAAAA', 'AAAAAQAAAAIAAAADAAAABQAAAAAAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAXSHbmDAAAAAIAAAAEAAAABAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAUBf/cAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduYMAAAAAgAAAAUAAAAEAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAABQF/9wAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAUAAAADAAAABQAAAAAAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAXSHbmDAAAAAIAAAAFAAAABAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAUBf/cAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduYMAAAAAgAAAAUAAAAFAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAeWvSfwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUAAAACAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAAAAAAYAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAAAAACVAvkAAAAADIAAAABAAAAAAAAAAAAAAAAAAAAAwAAAAUAAAABAAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAAVVTRAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAALpDt0AH//////////AAAAAQAAAAEAAAAAAAAAAAAAAABBkKsAAAAAAAAAAAAAAAABAAAABQAAAAEAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAukO3QAf/////////8AAAABAAAAAQAAAAAAAAAAAAAAApWcjwAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAFAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduZwAAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduYMAAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{5Xo6CV4r7iFHfyeH2p1RsjxOyoXGqhom3bEbhCMeTQNK2+UYCyWnmhZR6yRiWge9MSfcFhiv1LafatF+SW+EAg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('ea945436a3b650efa88063e737518cf1928d9a43d1aba3ec684704f160b3733e', 4, 1, 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4', 8589934593, 100, 1, '2020-01-13 14:36:44.452397', '2020-01-13 14:36:44.452398', 17179873280, 'AAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAukO3QAAAAAAAAAAAH5kC3vAAAAQH/ZkzR/eC0F7xP9zApeHvMH7nqetzaSdYh8WHyrwwvbEnx4Db6gz0grnRJBJS66OZbGmCk7yzHm8DkJ7bJ4QAU=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvicAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvicAAAAAIAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAEAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAC6Q7dAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+OcAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{f9mTNH94LQXvE/3MCl4e8wfuep63NpJ1iHxYfKvDC9sSfHgNvqDPSCudEkElLro5lsaYKTvLMebwOQntsnhABQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('416a63c3f1491537698cdb6f981097ed8e44ca27d2d9006bd0ba68832ebf9d55', 4, 2, 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4', 8589934594, 100, 1, '2020-01-13 14:36:44.452655', '2020-01-13 14:36:44.452655', 17179877376, 'AAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAZAAAAAIAAAACAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAukO3QAAAAAAAAAAAH5kC3vAAAAQFFGLGFFXbEDRdk2eFyQATNpHuqO/sFrpqsxmNNwGa+MLibNQJLDXWafC4W8KMKQ/hE0M0TLxZeu/O8tYnBuwwA=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvicAAAAAIAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvicAAAAAIAAAACAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAADAAAAAQAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAEAAAAAQAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAC6Q7dAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAEAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+OcAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+M4AAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{UUYsYUVdsQNF2TZ4XJABM2ke6o7+wWumqzGY03AZr4wuJs1AksNdZp8LhbwowpD+ETQzRMvFl6787y1icG7DAA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('73d859647f9f24f6a74bfc936df199256f67d852c472c26cabea83bec22b832d', 4, 3, 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4', 8589934595, 100, 1, '2020-01-13 14:36:44.452864', '2020-01-13 14:36:44.452864', 17179881472, 'AAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAZAAAAAIAAAADAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAABQlRDAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAA34R1gAAAAAAAAAAAH5kC3vAAAAQDRihMZEiZbpT45/sHslqaKo9bRzLTxvKY+d7hxxHyvlpZSCM8LOZ6frXbAweCsomNpe449ZDHEiwT2oQTWjXg8=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvicAAAAAIAAAACAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvicAAAAAIAAAADAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFCVEMAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAEAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFCVEMAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAADfhHWAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAEAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+M4AAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+LUAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{NGKExkSJlulPjn+weyWpoqj1tHMtPG8pj53uHHEfK+WllIIzws5np+tdsDB4KyiY2l7jj1kMcSLBPahBNaNeDw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('5ce932151e3d972e4ef521b0a6c63f173a5d73c324178379c1c8d52b19713ec8', 4, 4, 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4', 8589934596, 100, 1, '2020-01-13 14:36:44.453089', '2020-01-13 14:36:44.453089', 17179885568, 'AAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAZAAAAAIAAAAEAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAABQlRDAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAA34R1gAAAAAAAAAAAH5kC3vAAAAQIk+tsokBzu1gulfbYjE1e8r1k1piyBZ4dBn0u7vVgZ6/+qiElx7hKerBLj1KjbZGQXdaf90YaYEiJ8bby0EYgo=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvicAAAAAIAAAADAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvicAAAAAIAAAAEAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAADAAAAAQAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAAAFCVEMAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAEAAAAAQAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAAAFCVEMAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAADfhHWAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAEAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+LUAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+JwAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{iT62yiQHO7WC6V9tiMTV7yvWTWmLIFnh0GfS7u9WBnr/6qISXHuEp6sEuPUqNtkZBd1p/3RhpgSInxtvLQRiCg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('811192c38643df73c015a5a1d77b802dff05d4f50fc6d10816aa75c0a6109f9a', 3, 1, 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON', 8589934593, 100, 1, '2020-01-13 14:36:44.473055', '2020-01-13 14:36:44.473056', 12884905984, 'AAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt73//////////AAAAAAAAAAFvFIhaAAAAQPlg7GLhJg0x7jpAw1Ew6H2XF6yRImfJIwFfx09Nui5btOJAFewFANfOaAB8FQZl5p3A5g3k6DHDigfUNUD16gc=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduc4AAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduc4AAAAAgAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIdugAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduecAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{+WDsYuEmDTHuOkDDUTDofZcXrJEiZ8kjAV/HT026Llu04kAV7AUA185oAHwVBmXmncDmDeToMcOKB9Q1QPXqBw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('bd486dbdd02d460817671c4a5a7e9d6e865ca29cb41e62d7aaf70a2fee5b36de', 3, 2, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934593, 100, 1, '2020-01-13 14:36:44.473702', '2020-01-13 14:36:44.473703', 12884910080, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt73//////////AAAAAAAAAAGu5L5MAAAAQB9kmKW2q3v7Qfy8PMekEb1TTI5ixqkI0BogXrOt7gO162Qbkh2dSTUfeDovc0PAafhDXxthVAlsLujlBmyjBAY=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduc4AAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduc4AAAAAgAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIdugAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduecAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{H2SYpbare/tB/Lw8x6QRvVNMjmLGqQjQGiBes63uA7XrZBuSHZ1JNR94Oi9zQ8Bp+ENfG2FUCWwu6OUGbKMEBg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('3476bc649563488cf025d82790aa9c44649188232b150d2864d13fe9face5406', 3, 3, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934594, 100, 1, '2020-01-13 14:36:44.473979', '2020-01-13 14:36:44.473979', 12884914176, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAACAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABQlRDAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt73//////////AAAAAAAAAAGu5L5MAAAAQEKBv+8zL1epwxC+sJhEYPmbjL9XScXtctoMIdet5dhgk7YJVJzAnRSgYTvfyoIJKJdQmX66uh2o+rG9K6JImgY=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduc4AAAAAgAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduc4AAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFCVEMAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduecAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIduc4AAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{QoG/7zMvV6nDEL6wmERg+ZuMv1dJxe1y2gwh163l2GCTtglUnMCdFKBhO9/Kggkol1CZfrq6Haj6sb0rokiaBg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('7df857c23c7dfeb974d7c3956775685a8edfa8496bb781fd346c8e2025fad9bf', 3, 4, 'GBXGQJWVLWOYHFLVTKWV5FGHA3LNYY2JQKM7OAJAUEQFU6LPCSEFVXON', 8589934594, 100, 1, '2020-01-13 14:36:44.474474', '2020-01-13 14:36:44.474475', 12884918272, 'AAAAAG5oJtVdnYOVdZqtXpTHBtbcY0mCmfcBIKEgWnlvFIhaAAAAZAAAAAIAAAACAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABQlRDAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt73//////////AAAAAAAAAAFvFIhaAAAAQBH/ML6+RzWquFPh8gLF2RuZzYtjjpPeHv/od9M74xlU09Xa4a5e1NhMtMSRIoLItg1EaDWE9zvtHflVWIAaSwQ=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduc4AAAAAgAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduc4AAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAAAFCVEMAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAADAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduecAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIduc4AAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{Ef8wvr5HNaq4U+HyAsXZG5nNi2OOk94e/+h30zvjGVTT1drhrl7U2Ey0xJEigsi2DURoNYT3O+0d+VVYgBpLBA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('db398eb4ae89756325643cad21c94e13bfc074b323ee83e141bf701a5d904f1b', 2, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 1, 100, 1, '2020-01-13 14:36:44.485024', '2020-01-13 14:36:44.485024', 8589938688, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAACVAvkAAAAAAAAAAABVvwF9wAAAEAYjQcPT2G5hqnBmgGGeg9J8l4c1EnUlxklElH9sqZr0971F6OLWfe/m4kpFtI+sI0i1qLit5A0JyWnbhYLW5oD', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/7UAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBrUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAJUC+QAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAABAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{GI0HD09huYapwZoBhnoPSfJeHNRJ1JcZJRJR/bKma9Pe9Reji1n3v5uJKRbSPrCNItai4reQNCclp24WC1uaAw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('2aadfb093f2817bd454a973ab441c4a3d7c948cc3a277fcb006bef7528bf949b', 2, 2, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 2, 100, 1, '2020-01-13 14:36:44.485264', '2020-01-13 14:36:44.485264', 8589942784, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAACAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAXSHboAAAAAAAAAAABVvwF9wAAAECHa9hPxY+5w4/Cg1gW2BdJIU0CmCgnjjXQzx1DjeJzT4phXDLOieuZJoTX6jvhdzMahfepPlpQEIx82W5X8pIG', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBrUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpoK4TLUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAABdIdugAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/84AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{h2vYT8WPucOPwoNYFtgXSSFNApgoJ4410M8dQ43ic0+KYVwyzonrmSaE1+o74XczGoX3qT5aUBCMfNluV/KSBg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('37156be3b9c170a015dbb63fe7b282b1309d477626f84cc6c9bcad1bf2bb3927', 2, 3, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 3, 100, 1, '2020-01-13 14:36:44.48543', '2020-01-13 14:36:44.485431', 8589946880, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAADAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAbmgm1V2dg5V1mq1elMcG1txjSYKZ9wEgoSBaeW8UiFoAAAAXSHboAAAAAAAAAAABVvwF9wAAAEDJvf4IwI5rQT3Ap0/ZSFq+RwV1J6eAZV53d+d4+Bal+v3zdhIu82I/eIrOhDHQYrtuPZFwIcE4fuDjBgVIguEO', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpoK4TLUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtoLCakrUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAABuaCbVXZ2DlXWarV6UxwbW3GNJgpn3ASChIFp5bxSIWgAAABdIdugAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/84AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/7UAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{yb3+CMCOa0E9wKdP2UhavkcFdSengGVed3fnePgWpfr983YSLvNiP3iKzoQx0GK7bj2RcCHBOH7g4wYFSILhDg==}', 'none', NULL, NULL, true, 100);


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

