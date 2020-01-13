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

INSERT INTO gorp_migrations VALUES ('1_initial_schema.sql', '2020-01-13 15:37:01.781346+01');
INSERT INTO gorp_migrations VALUES ('2_index_participants_by_toid.sql', '2020-01-13 15:37:01.788195+01');
INSERT INTO gorp_migrations VALUES ('3_use_sequence_in_history_accounts.sql', '2020-01-13 15:37:01.797006+01');
INSERT INTO gorp_migrations VALUES ('4_add_protocol_version.sql', '2020-01-13 15:37:01.812206+01');
INSERT INTO gorp_migrations VALUES ('5_create_trades_table.sql', '2020-01-13 15:37:01.824173+01');
INSERT INTO gorp_migrations VALUES ('6_create_assets_table.sql', '2020-01-13 15:37:01.831898+01');
INSERT INTO gorp_migrations VALUES ('7_modify_trades_table.sql', '2020-01-13 15:37:01.849208+01');
INSERT INTO gorp_migrations VALUES ('8_add_aggregators.sql', '2020-01-13 15:37:01.853484+01');
INSERT INTO gorp_migrations VALUES ('8_create_asset_stats_table.sql', '2020-01-13 15:37:01.863133+01');
INSERT INTO gorp_migrations VALUES ('9_add_header_xdr.sql', '2020-01-13 15:37:01.866818+01');
INSERT INTO gorp_migrations VALUES ('10_add_trades_price.sql', '2020-01-13 15:37:01.874991+01');
INSERT INTO gorp_migrations VALUES ('11_add_trades_account_index.sql', '2020-01-13 15:37:01.881004+01');
INSERT INTO gorp_migrations VALUES ('12_asset_stats_amount_string.sql', '2020-01-13 15:37:01.890686+01');
INSERT INTO gorp_migrations VALUES ('13_trade_offer_ids.sql', '2020-01-13 15:37:01.899245+01');
INSERT INTO gorp_migrations VALUES ('14_fix_asset_toml_field.sql', '2020-01-13 15:37:01.904616+01');
INSERT INTO gorp_migrations VALUES ('15_ledger_failed_txs.sql', '2020-01-13 15:37:01.907386+01');
INSERT INTO gorp_migrations VALUES ('16_ingest_failed_transactions.sql', '2020-01-13 15:37:01.909718+01');
INSERT INTO gorp_migrations VALUES ('17_transaction_fee_paid.sql', '2020-01-13 15:37:01.912763+01');
INSERT INTO gorp_migrations VALUES ('18_account_for_signers.sql', '2020-01-13 15:37:01.922967+01');
INSERT INTO gorp_migrations VALUES ('19_offers.sql', '2020-01-13 15:37:01.939345+01');
INSERT INTO gorp_migrations VALUES ('20_account_for_signer_index.sql', '2020-01-13 15:37:01.942816+01');
INSERT INTO gorp_migrations VALUES ('21_trades_remove_zero_amount_constraints.sql', '2020-01-13 15:37:01.947697+01');
INSERT INTO gorp_migrations VALUES ('22_trust_lines.sql', '2020-01-13 15:37:01.958556+01');
INSERT INTO gorp_migrations VALUES ('23_exp_asset_stats.sql', '2020-01-13 15:37:01.971115+01');
INSERT INTO gorp_migrations VALUES ('24_accounts.sql', '2020-01-13 15:37:02.007568+01');
INSERT INTO gorp_migrations VALUES ('25_expingest_rename_columns.sql', '2020-01-13 15:37:02.010506+01');
INSERT INTO gorp_migrations VALUES ('26_exp_history_ledgers.sql', '2020-01-13 15:37:02.025377+01');
INSERT INTO gorp_migrations VALUES ('27_exp_history_transactions.sql', '2020-01-13 15:37:02.046146+01');
INSERT INTO gorp_migrations VALUES ('28_exp_history_operations.sql', '2020-01-13 15:37:02.059328+01');
INSERT INTO gorp_migrations VALUES ('29_exp_history_assets.sql', '2020-01-13 15:37:02.069438+01');
INSERT INTO gorp_migrations VALUES ('30_exp_history_trades.sql', '2020-01-13 15:37:02.092228+01');
INSERT INTO gorp_migrations VALUES ('31_exp_history_effects.sql', '2020-01-13 15:37:02.100457+01');


--
-- Data for Name: history_accounts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_accounts VALUES (1, 'GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2');
INSERT INTO history_accounts VALUES (2, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_accounts VALUES (3, 'GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG');
INSERT INTO history_accounts VALUES (4, 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4');
INSERT INTO history_accounts VALUES (5, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');


--
-- Name: history_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_accounts_id_seq', 5, true);


--
-- Data for Name: history_assets; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_assets VALUES (1, 'credit_alphanum4', 'EUR', 'GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG');
INSERT INTO history_assets VALUES (2, 'credit_alphanum4', 'USD', 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4');


--
-- Name: history_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_assets_id_seq', 2, true);


--
-- Data for Name: history_effects; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_effects VALUES (2, 38654709761, 1, 33, '{"seller": "GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2", "offer_id": 2, "sold_amount": "49.9999999", "bought_amount": "45.0000000", "sold_asset_code": "USD", "sold_asset_type": "credit_alphanum4", "bought_asset_code": "EUR", "bought_asset_type": "credit_alphanum4", "sold_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "bought_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}');
INSERT INTO history_effects VALUES (1, 38654709761, 2, 33, '{"seller": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "offer_id": 2, "sold_amount": "45.0000000", "bought_amount": "49.9999999", "sold_asset_code": "EUR", "sold_asset_type": "credit_alphanum4", "bought_asset_code": "USD", "bought_asset_type": "credit_alphanum4", "sold_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG", "bought_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (2, 38654709761, 3, 33, '{"seller": "GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2", "offer_id": 3, "sold_amount": "100.0000000", "bought_amount": "80.0000000", "sold_asset_code": "USD", "sold_asset_type": "credit_alphanum4", "bought_asset_code": "EUR", "bought_asset_type": "credit_alphanum4", "sold_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "bought_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}');
INSERT INTO history_effects VALUES (1, 38654709761, 4, 33, '{"seller": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "offer_id": 3, "sold_amount": "80.0000000", "bought_amount": "100.0000000", "sold_asset_code": "EUR", "sold_asset_type": "credit_alphanum4", "bought_asset_code": "USD", "bought_asset_type": "credit_alphanum4", "sold_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG", "bought_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (2, 34359742465, 1, 33, '{"seller": "GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2", "offer_id": 1, "sold_amount": "100.0000000", "bought_amount": "100.0000000", "sold_asset_code": "USD", "sold_asset_type": "credit_alphanum4", "bought_asset_code": "EUR", "bought_asset_type": "credit_alphanum4", "sold_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "bought_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}');
INSERT INTO history_effects VALUES (1, 34359742465, 2, 33, '{"seller": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "offer_id": 1, "sold_amount": "100.0000000", "bought_amount": "100.0000000", "sold_asset_code": "EUR", "sold_asset_type": "credit_alphanum4", "bought_asset_code": "USD", "bought_asset_type": "credit_alphanum4", "sold_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG", "bought_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (2, 34359742465, 3, 33, '{"seller": "GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2", "offer_id": 2, "sold_amount": "50.0000000", "bought_amount": "45.0000000", "sold_asset_code": "USD", "sold_asset_type": "credit_alphanum4", "bought_asset_code": "EUR", "bought_asset_type": "credit_alphanum4", "sold_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "bought_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}');
INSERT INTO history_effects VALUES (1, 34359742465, 4, 33, '{"seller": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "offer_id": 2, "sold_amount": "45.0000000", "bought_amount": "50.0000000", "sold_asset_code": "EUR", "sold_asset_type": "credit_alphanum4", "bought_asset_code": "USD", "bought_asset_type": "credit_alphanum4", "sold_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG", "bought_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (1, 17179873281, 1, 2, '{"amount": "500.0000000", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}');
INSERT INTO history_effects VALUES (3, 17179873281, 2, 3, '{"amount": "500.0000000", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}');
INSERT INTO history_effects VALUES (2, 17179877377, 1, 2, '{"amount": "500.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (4, 17179877377, 2, 3, '{"amount": "500.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (2, 12884905985, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (1, 12884910081, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (1, 12884914177, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}');
INSERT INTO history_effects VALUES (2, 12884918273, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}');
INSERT INTO history_effects VALUES (2, 8589938689, 1, 0, '{"starting_balance": "100.0000000"}');
INSERT INTO history_effects VALUES (5, 8589938689, 2, 3, '{"amount": "100.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (2, 8589938689, 3, 10, '{"weight": 1, "public_key": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU"}');
INSERT INTO history_effects VALUES (1, 8589942785, 1, 0, '{"starting_balance": "100.0000000"}');
INSERT INTO history_effects VALUES (5, 8589942785, 2, 3, '{"amount": "100.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (1, 8589942785, 3, 10, '{"weight": 1, "public_key": "GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2"}');
INSERT INTO history_effects VALUES (4, 8589946881, 1, 0, '{"starting_balance": "100.0000000"}');
INSERT INTO history_effects VALUES (5, 8589946881, 2, 3, '{"amount": "100.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (4, 8589946881, 3, 10, '{"weight": 1, "public_key": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}');
INSERT INTO history_effects VALUES (3, 8589950977, 1, 0, '{"starting_balance": "100.0000000"}');
INSERT INTO history_effects VALUES (5, 8589950977, 2, 3, '{"amount": "100.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (3, 8589950977, 3, 10, '{"weight": 1, "public_key": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}');


--
-- Data for Name: history_ledgers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_ledgers VALUES (9, 'bfd2afdfded6234e873743f1cb726c9e39a76af3003c1a41299819fa95ba7120', '60b199d456c453e4877cfa48a6cca4f3f8e185b7418a9dff95c749d7d2c53ec4', 1, 1, '2020-01-13 14:37:05', '2020-01-13 14:37:02.471203', '2020-01-13 14:37:02.471203', 38654705664, 16, 1000000000000000000, 1500, 100, 100000000, 1000000, 12, 'AAAADGCxmdRWxFPkh3z6SKbMpPP44YW3QYqd/5XHSdfSxT7EO8JW/tnO2nl8AUNFHshXvDUYgP8pioVb3qLgcbjvexYAAAAAXhyAkQAAAAAAAAAA5u7HOB8cX0WnqixnvzOlY3D3Y3oP0dYzzW9yWnVbm0bBymJ+E3ozsnIjtNFTCTdFH3MBb7H9d6Px1MPMfXUdKgAAAAkN4Lazp2QAAAAAAAAAAAXcAAAAAAAAAAAAAAAEAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (8, '60b199d456c453e4877cfa48a6cca4f3f8e185b7418a9dff95c749d7d2c53ec4', '7ee48f559e21fe3dd73db28060e529a9e3b5f21e860ea198c871a801f88bee44', 1, 1, '2020-01-13 14:37:04', '2020-01-13 14:37:02.504907', '2020-01-13 14:37:02.504907', 34359738368, 16, 1000000000000000000, 1400, 100, 100000000, 1000000, 12, 'AAAADH7kj1WeIf491z2ygGDlKanjtfIehg6hmMhxqAH4i+5EG+tmmwQtuyGGq3SZyE4dYHz6rPO9NneJL+nrdAF3CQ0AAAAAXhyAkAAAAAAAAAAAAOMGyexOuevk4QIYCK/e2TLQXecE/TBuu1dvGQilTsMd48LH087AB4QqdhtSSCXI9EvbbRZCsoBEta70ZweAfAAAAAgN4Lazp2QAAAAAAAAAAAV4AAAAAAAAAAAAAAADAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (7, '7ee48f559e21fe3dd73db28060e529a9e3b5f21e860ea198c871a801f88bee44', 'b5045da62daae34f060c539baf790fa85602700b5ec58e484988ef44fc50f0a8', 1, 1, '2020-01-13 14:37:03', '2020-01-13 14:37:02.544878', '2020-01-13 14:37:02.544878', 30064771072, 16, 1000000000000000000, 1300, 100, 100000000, 1000000, 12, 'AAAADLUEXaYtquNPBgxTm695D6hWAnALXsWOSEmI70T8UPCoKBxZA0ECrEpLMGLduKPawXrqo+S6KQX4cYOxQetSD8AAAAAAXhyAjwAAAAAAAAAA8011I8cweiVULRk7g+I3eWM/k+U+svLLvJL8X9ENB1qAUUjk/9lKUbYChPH7OE/fxdY43tiGR7OU1CtvaQb5YgAAAAcN4Lazp2QAAAAAAAAAAAUUAAAAAAAAAAAAAAADAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (6, 'b5045da62daae34f060c539baf790fa85602700b5ec58e484988ef44fc50f0a8', '4b152fb1deccb816035ba55bb01964feff754c1f2e8ba228d3130caeafdc3e60', 1, 1, '2020-01-13 14:37:02', '2020-01-13 14:37:02.56028', '2020-01-13 14:37:02.560281', 25769803776, 16, 1000000000000000000, 1200, 100, 100000000, 1000000, 12, 'AAAADEsVL7HezLgWA1ulW7AZZP7/dUwfLouiKNMTDK6v3D5g09PhjQfDcqAM1nJnlwI2KwUnIhkF6sB+G1y6OVjzYrYAAAAAXhyAjgAAAAAAAAAAuQrPQr2qlNVpCIqhQaeQMsD9JWWNaxISOIwMsxvilIUV0TqTjw0NE5NtfcbPGqY9BD5qtTpYw0/Hp5yBcgzwZwAAAAYN4Lazp2QAAAAAAAAAAASwAAAAAAAAAAAAAAACAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (5, '4b152fb1deccb816035ba55bb01964feff754c1f2e8ba228d3130caeafdc3e60', '46d9f91003b8bd74ee04b43aeee59fcc60fd1506aa2c32262241fa24897eb503', 1, 1, '2020-01-13 14:37:01', '2020-01-13 14:37:02.576313', '2020-01-13 14:37:02.576313', 21474836480, 16, 1000000000000000000, 1100, 100, 100000000, 1000000, 12, 'AAAADEbZ+RADuL107gS0Ou7ln8xg/RUGqiwyJiJB+iSJfrUDSVE+9HJMJSGCf+Rff5EVQCn7twGZEdc6ODSPKWJcZp8AAAAAXhyAjQAAAAAAAAAA5tFak/fh7MEOithjlydErBU0/M0ilaefu1Ub0Cw1cbSND7LUhf+RekhpsHnOSqAAAOm9sA4SWfv5NhUDPOdjCAAAAAUN4Lazp2QAAAAAAAAAAARMAAAAAAAAAAAAAAABAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (4, '46d9f91003b8bd74ee04b43aeee59fcc60fd1506aa2c32262241fa24897eb503', '573b44e7a900d41a79a6edf4159b0cb71e4b47b5a167a0a12937cce2be7d6627', 2, 2, '2020-01-13 14:37:00', '2020-01-13 14:37:02.591179', '2020-01-13 14:37:02.591179', 17179869184, 16, 1000000000000000000, 1000, 100, 100000000, 1000000, 12, 'AAAADFc7ROepANQaeabt9BWbDLceS0e1oWegoSk3zOK+fWYnUDhvDBMFTLilpe2LTVlPY7gkmm044M4n9bNtMXRmZAEAAAAAXhyAjAAAAAAAAAAAkEeHwbiWWoxafh7Sc3UtLYZvNJJ2i7pv0rpNftdmmiRxNvUCIjAYg/lIxM9W5c2LTRekbuBc83yw0vsal/2E4wAAAAQN4Lazp2QAAAAAAAAAAAPoAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (3, '573b44e7a900d41a79a6edf4159b0cb71e4b47b5a167a0a12937cce2be7d6627', 'dd03f9c99abf57ea67ba7e6d9c8773246fe6190b79d056b657972403ff0598d9', 4, 4, '2020-01-13 14:36:59', '2020-01-13 14:37:02.610214', '2020-01-13 14:37:02.610214', 12884901888, 16, 1000000000000000000, 800, 100, 100000000, 1000000, 12, 'AAAADN0D+cmav1fqZ7p+bZyHcyRv5hkLedBWtleXJAP/BZjZMx/zom+N3g37pLGyEGkLI/BUIoPqwhGb9+W1yOTbbE4AAAAAXhyAiwAAAAIAAAAIAAAAAQAAAAwAAAAIAAAAAwAPQkAAAAAAJZ7LtwUPiAWjGqY5LkNjtznCDuGQDV7NB0LPyHF2s4tWf1/5awddWJCUbwuwvLELDlQfK/5aMOcwIfEBrfRBFQAAAAMN4Lazp2QAAAAAAAAAAAMgAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 4, 0);
INSERT INTO history_ledgers VALUES (2, 'dd03f9c99abf57ea67ba7e6d9c8773246fe6190b79d056b657972403ff0598d9', '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', 4, 4, '2020-01-13 14:36:58', '2020-01-13 14:37:02.627446', '2020-01-13 14:37:02.627446', 8589934592, 16, 1000000000000000000, 400, 100, 100000000, 100, 0, 'AAAAAGPZj1Nu5o0bJ7W4nyOvUxG3Vpok+vFAOtC1K2M7B76Zh82QgsuASmS0xgFp1fjiT2wNgvVWRClSW5uMP344SMoAAAAAXhyAigAAAAAAAAAAh7rHH3ehqvUsWEPfAlvVspAA2/ZR0JjPAFIdHbQ2sSjCdKNX9bX7oXl4uO6TSACchqtoxD28NFm6aqXf4rFVngAAAAIN4Lazp2QAAAAAAAAAAAGQAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 4, 0);
INSERT INTO history_ledgers VALUES (1, '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', NULL, 0, 0, '1970-01-01 00:00:00', '2020-01-13 14:37:02.64671', '2020-01-13 14:37:02.646711', 4294967296, 16, 1000000000000000000, 0, 100, 100000000, 100, 0, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXKi4y/ySKB7DnD9H20xjB+s0gtswIwz1XdSWYaBJaFgAAAAEN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 0, 0);


--
-- Data for Name: history_operation_participants; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_operation_participants VALUES (1, 38654709761, 2);
INSERT INTO history_operation_participants VALUES (2, 34359742465, 2);
INSERT INTO history_operation_participants VALUES (3, 30064775169, 1);
INSERT INTO history_operation_participants VALUES (4, 25769807873, 1);
INSERT INTO history_operation_participants VALUES (5, 21474840577, 1);
INSERT INTO history_operation_participants VALUES (6, 17179873281, 3);
INSERT INTO history_operation_participants VALUES (7, 17179873281, 1);
INSERT INTO history_operation_participants VALUES (8, 17179877377, 2);
INSERT INTO history_operation_participants VALUES (9, 17179877377, 4);
INSERT INTO history_operation_participants VALUES (10, 12884905985, 2);
INSERT INTO history_operation_participants VALUES (11, 12884910081, 1);
INSERT INTO history_operation_participants VALUES (12, 12884914177, 1);
INSERT INTO history_operation_participants VALUES (13, 12884918273, 2);
INSERT INTO history_operation_participants VALUES (14, 8589938689, 5);
INSERT INTO history_operation_participants VALUES (15, 8589938689, 2);
INSERT INTO history_operation_participants VALUES (16, 8589942785, 5);
INSERT INTO history_operation_participants VALUES (17, 8589942785, 1);
INSERT INTO history_operation_participants VALUES (18, 8589946881, 5);
INSERT INTO history_operation_participants VALUES (19, 8589946881, 4);
INSERT INTO history_operation_participants VALUES (20, 8589950977, 3);
INSERT INTO history_operation_participants VALUES (21, 8589950977, 5);


--
-- Name: history_operation_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_operation_participants_id_seq', 21, true);


--
-- Data for Name: history_operations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_operations VALUES (38654709761, 38654709760, 1, 3, '{"price": "0.8000000", "amount": "151.0000000", "price_r": {"d": 5, "n": 4}, "offer_id": 0, "buying_asset_code": "EUR", "buying_asset_type": "credit_alphanum4", "selling_asset_code": "USD", "selling_asset_type": "credit_alphanum4", "buying_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG", "selling_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (34359742465, 34359742464, 1, 3, '{"price": "0.9000000", "amount": "150.0000000", "price_r": {"d": 10, "n": 9}, "offer_id": 0, "buying_asset_code": "EUR", "buying_asset_type": "credit_alphanum4", "selling_asset_code": "USD", "selling_asset_type": "credit_alphanum4", "buying_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG", "selling_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (30064775169, 30064775168, 1, 3, '{"price": "1.2500000", "amount": "80.0000000", "price_r": {"d": 4, "n": 5}, "offer_id": 0, "buying_asset_code": "USD", "buying_asset_type": "credit_alphanum4", "selling_asset_code": "EUR", "selling_asset_type": "credit_alphanum4", "buying_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "selling_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}', 'GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2');
INSERT INTO history_operations VALUES (25769807873, 25769807872, 1, 3, '{"price": "1.1111111", "amount": "90.0000000", "price_r": {"d": 1000000000, "n": 1111111111}, "offer_id": 0, "buying_asset_code": "USD", "buying_asset_type": "credit_alphanum4", "selling_asset_code": "EUR", "selling_asset_type": "credit_alphanum4", "buying_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "selling_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}', 'GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2');
INSERT INTO history_operations VALUES (21474840577, 21474840576, 1, 3, '{"price": "1.0000000", "amount": "100.0000000", "price_r": {"d": 1, "n": 1}, "offer_id": 0, "buying_asset_code": "USD", "buying_asset_type": "credit_alphanum4", "selling_asset_code": "EUR", "selling_asset_type": "credit_alphanum4", "buying_asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "selling_asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}', 'GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2');
INSERT INTO history_operations VALUES (17179873281, 17179873280, 1, 1, '{"to": "GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2", "from": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG", "amount": "500.0000000", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}', 'GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG');
INSERT INTO history_operations VALUES (17179877377, 17179877376, 1, 1, '{"to": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "from": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "amount": "500.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4');
INSERT INTO history_operations VALUES (12884905985, 12884905984, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "trustor": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (12884910081, 12884910080, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "trustor": "GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4"}', 'GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2');
INSERT INTO history_operations VALUES (12884914177, 12884914176, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG", "trustor": "GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}', 'GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2');
INSERT INTO history_operations VALUES (12884918273, 12884918272, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG", "trustor": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG"}', 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU');
INSERT INTO history_operations VALUES (8589938689, 8589938688, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU", "starting_balance": "100.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (8589942785, 8589942784, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2", "starting_balance": "100.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (8589946881, 8589946880, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4", "starting_balance": "100.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (8589950977, 8589950976, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG", "starting_balance": "100.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');


--
-- Data for Name: history_trades; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_trades VALUES (38654709761, 0, '2020-01-13 14:37:05', 2, 1, 1, 450000000, 2, 2, 499999999, true, 1111111111, 1000000000, 2, 4);
INSERT INTO history_trades VALUES (38654709761, 1, '2020-01-13 14:37:05', 3, 1, 1, 800000000, 2, 2, 1000000000, true, 5, 4, 3, 4);
INSERT INTO history_trades VALUES (34359742465, 0, '2020-01-13 14:37:04', 1, 1, 1, 1000000000, 2, 2, 1000000000, true, 1, 1, 1, 4611686052787130369);
INSERT INTO history_trades VALUES (34359742465, 1, '2020-01-13 14:37:04', 2, 1, 1, 450000000, 2, 2, 500000000, true, 1111111111, 1000000000, 2, 4611686052787130369);


--
-- Data for Name: history_transaction_participants; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_transaction_participants VALUES (1, 38654709760, 2);
INSERT INTO history_transaction_participants VALUES (2, 34359742464, 2);
INSERT INTO history_transaction_participants VALUES (3, 30064775168, 1);
INSERT INTO history_transaction_participants VALUES (4, 25769807872, 1);
INSERT INTO history_transaction_participants VALUES (5, 21474840576, 1);
INSERT INTO history_transaction_participants VALUES (6, 17179873280, 3);
INSERT INTO history_transaction_participants VALUES (7, 17179873280, 1);
INSERT INTO history_transaction_participants VALUES (8, 17179877376, 4);
INSERT INTO history_transaction_participants VALUES (9, 17179877376, 2);
INSERT INTO history_transaction_participants VALUES (10, 12884905984, 2);
INSERT INTO history_transaction_participants VALUES (11, 12884910080, 1);
INSERT INTO history_transaction_participants VALUES (12, 12884914176, 1);
INSERT INTO history_transaction_participants VALUES (13, 12884918272, 2);
INSERT INTO history_transaction_participants VALUES (14, 8589938688, 5);
INSERT INTO history_transaction_participants VALUES (15, 8589938688, 2);
INSERT INTO history_transaction_participants VALUES (16, 8589942784, 5);
INSERT INTO history_transaction_participants VALUES (17, 8589942784, 1);
INSERT INTO history_transaction_participants VALUES (18, 8589946880, 5);
INSERT INTO history_transaction_participants VALUES (19, 8589946880, 4);
INSERT INTO history_transaction_participants VALUES (20, 8589950976, 5);
INSERT INTO history_transaction_participants VALUES (21, 8589950976, 3);


--
-- Name: history_transaction_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_transaction_participants_id_seq', 21, true);


--
-- Data for Name: history_transactions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_transactions VALUES ('54e27e3d7c84fdb79d6709922c52aaa752fd5080dcd433af901cd17860a957b2', 9, 1, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934596, 100, 1, '2020-01-13 14:37:02.471601', '2020-01-13 14:37:02.471601', 38654709760, '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', '{1q6EaaT1LdjuTrlh1ErZEAeMfBiK2+R64z7ec8I/eEaBSTP1YZrg9jzgJ4yCaSXXmJyT6VgWtd9vgugOqG5NCg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('1fa96abeeb0e2b71fa947d8f7003ca5d3e95734652c38b328ae62a8c1b1b3d73', 8, 1, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934595, 100, 1, '2020-01-13 14:37:02.505506', '2020-01-13 14:37:02.505506', 34359742464, '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', '{jjPwd3EIxz1iPsgxjjf6CdEvmZ5QxMY7kw2oez7V9qhYKcL7QgLetFeNhaiKA+cQEOZM3FBh80D0tBA0flV3DA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('4a0ac16e948710199659b0e8131be06df5944e57806c0db722859e4e8aad1e44', 7, 1, 'GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2', 8589934597, 100, 1, '2020-01-13 14:37:02.545295', '2020-01-13 14:37:02.545295', 30064775168, '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', '{YK8tE7Ae0YbqbY8nQgjPcVEcZTH1bKCo1cc1A83RimT+hM2W0kC4+fnYVn47t8ia9wd98wtUwIUM0NOAWeshAw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('2d0d264d9e2e3364c29faf6a6ec815a8a8e6a46e23096da1411f292309d78712', 6, 1, 'GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2', 8589934596, 100, 1, '2020-01-13 14:37:02.56062', '2020-01-13 14:37:02.560621', 25769807872, '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', '{eh97duB2MF3rrgCuqsouPb+JrhstrliUb8wvu4VVEpZNunSWlsoJrRsVHkAScIcP8XImAqHdOI06krccVGRZDw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('5ef9c06bb625d2da2281118bdf14d808768353ee2fca7457c8e506fbeb91fc55', 3, 3, 'GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2', 8589934594, 100, 1, '2020-01-13 14:37:02.610921', '2020-01-13 14:37:02.610921', 12884914176, 'AAAAADtgvwDuOWAQ97R1RTtUdwNDHpD/CUepzdQPXlonciLVAAAAZAAAAAIAAAACAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABRVVSAAAAAACg/Bj8V39wjI1Sr96oc7Omrth2jBx9LOQd9kVVEIrYSX//////////AAAAAAAAAAEnciLVAAAAQOG2GKO9i60cM1QK2UN1gXrHEYjeGLRXFT5snCqO5FnPET5cVs30N7ITPZ6HH6QcZ2IdC1c66wLge4GyR8vpww0=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msk4AAAAAgAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msk4AAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAFFVVIAAAAAAKD8GPxXf3CMjVKv3qhzs6au2HaMHH0s5B32RVUQithJAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAADAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msmcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msk4AAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{4bYYo72LrRwzVArZQ3WBescRiN4YtFcVPmycKo7kWc8RPlxWzfQ3shM9nocfpBxnYh0LVzrrAuB7gbJHy+nDDQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('356eec1f0432bbbba09ddcc1937e28253a4dc8e98ff77d5e9dee140be5093a70', 5, 1, 'GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2', 8589934595, 100, 1, '2020-01-13 14:37:02.576648', '2020-01-13 14:37:02.576649', 21474840576, 'AAAAADtgvwDuOWAQ97R1RTtUdwNDHpD/CUepzdQPXlonciLVAAAAZAAAAAIAAAADAAAAAAAAAAAAAAABAAAAAAAAAAMAAAABRVVSAAAAAACg/Bj8V39wjI1Sr96oc7Omrth2jBx9LOQd9kVVEIrYSQAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAADuaygAAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAEnciLVAAAAQE6AkyD+X3Poc6Fj6lalYvmHUdbN38uun6CX5Mc/cJnFQaqtZBOoAwDntTl1Gz/f7reRpXcJYSdQ+pEcUn/2PAE=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAADtgvwDuOWAQ97R1RTtUdwNDHpD/CUepzdQPXlonciLVAAAAAAAAAAEAAAABRVVSAAAAAACg/Bj8V39wjI1Sr96oc7Omrth2jBx9LOQd9kVVEIrYSQAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAADuaygAAAAABAAAAAQAAAAAAAAAAAAAAAA==', 'AAAAAQAAAAIAAAADAAAABQAAAAAAAAAAO2C/AO45YBD3tHVFO1R3A0MekP8JR6nN1A9eWidyItUAAAAAO5rI1AAAAAIAAAACAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABQAAAAAAAAAAO2C/AO45YBD3tHVFO1R3A0MekP8JR6nN1A9eWidyItUAAAAAO5rI1AAAAAIAAAADAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABwAAAAMAAAAFAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msjUAAAAAgAAAAMAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msjUAAAAAgAAAAMAAAADAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFAAAAAgAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAAAAAABAAAAAUVVUgAAAAAAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAA7msoAAAAAAQAAAAEAAAAAAAAAAAAAAAAAAAADAAAAAwAAAAEAAAAAO2C/AO45YBD3tHVFO1R3A0MekP8JR6nN1A9eWidyItUAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAAAAAAf/////////8AAAABAAAAAAAAAAAAAAABAAAABQAAAAEAAAAAO2C/AO45YBD3tHVFO1R3A0MekP8JR6nN1A9eWidyItUAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAAAAAAAf/////////8AAAABAAAAAQAAAAA7msoAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAAEAAAAAQAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAFFVVIAAAAAAKD8GPxXf3CMjVKv3qhzs6au2HaMHH0s5B32RVUQithJAAAAASoF8gB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAFAAAAAQAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAFFVVIAAAAAAKD8GPxXf3CMjVKv3qhzs6au2HaMHH0s5B32RVUQithJAAAAASoF8gB//////////wAAAAEAAAABAAAAAAAAAAAAAAAAO5rKAAAAAAAAAAAA', 'AAAAAgAAAAMAAAADAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msk4AAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msjUAAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{ToCTIP5fc+hzoWPqVqVi+YdR1s3fy66foJfkxz9wmcVBqq1kE6gDAOe1OXUbP9/ut5GldwlhJ1D6kRxSf/Y8AQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('e4febb6aab5f83df4c19b4f1f6b8687f11886169e996e16baa75aac2d8a09c68', 4, 1, 'GCQPYGH4K57XBDENKKX55KDTWOTK5WDWRQOH2LHEDX3EKVIQRLMESGBG', 8589934593, 100, 1, '2020-01-13 14:37:02.591636', '2020-01-13 14:37:02.591637', 17179873280, 'AAAAAKD8GPxXf3CMjVKv3qhzs6au2HaMHH0s5B32RVUQithJAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAAO2C/AO45YBD3tHVFO1R3A0MekP8JR6nN1A9eWidyItUAAAABRVVSAAAAAACg/Bj8V39wjI1Sr96oc7Omrth2jBx9LOQd9kVVEIrYSQAAAAEqBfIAAAAAAAAAAAEQithJAAAAQEghWBLDjmNLzcPF6o8dqUHMsI0WhttWE/ABSKaHNc+0FqsF+ui5+eky4ERyu99YR6BEHF4NlgyLnSq3zcDr9Qo=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAABAAAAAAAAAAAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAAAO5rJnAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAAAAAAAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAAAO5rJnAAAAAIAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAADAAAAAQAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAFFVVIAAAAAAKD8GPxXf3CMjVKv3qhzs6au2HaMHH0s5B32RVUQithJAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAEAAAAAQAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAFFVVIAAAAAAKD8GPxXf3CMjVKv3qhzs6au2HaMHH0s5B32RVUQithJAAAAASoF8gB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAACg/Bj8V39wjI1Sr96oc7Omrth2jBx9LOQd9kVVEIrYSQAAAAA7msoAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAAAACg/Bj8V39wjI1Sr96oc7Omrth2jBx9LOQd9kVVEIrYSQAAAAA7msmcAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{SCFYEsOOY0vNw8Xqjx2pQcywjRaG21YT8AFIpoc1z7QWqwX66Ln56TLgRHK731hHoEQcXg2WDIudKrfNwOv1Cg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('2837a1b3def2c2ddfdcde5b44bf08d7a11a9328d870df17fa2bb66d4c83260c7', 4, 2, 'GC23QF2HUE52AMXUFUH3AYJAXXGXXV2VHXYYR6EYXETPKDXZSAW67XO4', 8589934593, 100, 1, '2020-01-13 14:37:02.592019', '2020-01-13 14:37:02.592019', 17179877376, 'AAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAEqBfIAAAAAAAAAAAH5kC3vAAAAQGoQPiD0HEBi0U8cHN6nlZ3okEfdmt7mqkQHIt2tuRLaZZ1iMQwU43M8v+ntJQsA4c2eBXt9GYp/29FLjnba1Qw=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rJnAAAAAIAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rJnAAAAAIAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAEAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAASoF8gB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAA7msoAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAA7msmcAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{ahA+IPQcQGLRTxwc3qeVneiQR92a3uaqRAci3a25EtplnWIxDBTjczy/6e0lCwDhzZ4Fe30Zin/b0UuOdtrVDA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('bd486dbdd02d460817671c4a5a7e9d6e865ca29cb41e62d7aaf70a2fee5b36de', 3, 1, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934593, 100, 1, '2020-01-13 14:37:02.610431', '2020-01-13 14:37:02.610432', 12884905984, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt73//////////AAAAAAAAAAGu5L5MAAAAQB9kmKW2q3v7Qfy8PMekEb1TTI5ixqkI0BogXrOt7gO162Qbkh2dSTUfeDovc0PAafhDXxthVAlsLujlBmyjBAY=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msk4AAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msk4AAAAAgAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msoAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msmcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{H2SYpbare/tB/Lw8x6QRvVNMjmLGqQjQGiBes63uA7XrZBuSHZ1JNR94Oi9zQ8Bp+ENfG2FUCWwu6OUGbKMEBg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('00ab9cfce2b4c4141d8bb6768dd094bdbb1c7406710dbb3ba0ef98870f63a344', 3, 2, 'GA5WBPYA5Y4WAEHXWR2UKO2UO4BUGHUQ74EUPKON2QHV4WRHOIRNKKH2', 8589934593, 100, 1, '2020-01-13 14:37:02.610674', '2020-01-13 14:37:02.610675', 12884910080, 'AAAAADtgvwDuOWAQ97R1RTtUdwNDHpD/CUepzdQPXlonciLVAAAAZAAAAAIAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt73//////////AAAAAAAAAAEnciLVAAAAQLVbII+1LeizxgncDI46KHyBt05+H92n1+R328J9zNl2fgJW2nfn3FIoLVs2qV1+CUpr121a2B7AM6HKr4nBLAI=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msk4AAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msk4AAAAAgAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAFVU0QAAAAAALW4F0ehO6Ay9C0PsGEgvc1711U98Yj4mLkm9Q75kC3vAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msoAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msmcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{tVsgj7Ut6LPGCdwMjjoofIG3Tn4f3afX5Hfbwn3M2XZ+Albad+fcUigtWzapXX4JSmvXbVrYHsAzocqvicEsAg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('c7ab3843f0a0c4fe79dece0ff1b8391f7a9d34c47cbd7e35034f7b28f60dfc00', 3, 4, 'GCXKG6RN4ONIEPCMNFB732A436Z5PNDSRLGWK7GBLCMQLIFO4S7EYWVU', 8589934594, 100, 1, '2020-01-13 14:37:02.611147', '2020-01-13 14:37:02.611148', 12884918272, 'AAAAAK6jei3jmoI8TGlD/egc37PXtHKKzWV8wViZBaCu5L5MAAAAZAAAAAIAAAACAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABRVVSAAAAAACg/Bj8V39wjI1Sr96oc7Omrth2jBx9LOQd9kVVEIrYSX//////////AAAAAAAAAAGu5L5MAAAAQO/nblo8KAkSOf8cQOOiADXygx+I0ZdWoM4Vg4EKPAAJXFntctjCIyQ4csVUywaW32J/keQWYby52BjiNhT/6Qo=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msk4AAAAAgAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msk4AAAAAgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAQAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAFFVVIAAAAAAKD8GPxXf3CMjVKv3qhzs6au2HaMHH0s5B32RVUQithJAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msmcAAAAAgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msk4AAAAAgAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{7+duWjwoCRI5/xxA46IANfKDH4jRl1agzhWDgQo8AAlcWe1y2MIjJDhyxVTLBpbfYn+R5BZhvLnYGOI2FP/pCg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('2374e99349b9ef7dba9a5db3339b78fda8f34777b1af33ba468ad5c0df946d4d', 2, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 1, 100, 1, '2020-01-13 14:37:02.627571', '2020-01-13 14:37:02.627572', 8589938688, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAArqN6LeOagjxMaUP96Bzfs9e0corNZXzBWJkFoK7kvkwAAAAAO5rKAAAAAAAAAAABVvwF9wAAAECDzqvkQBQoNAJifPRXDoLhvtycT3lFPCQ51gkdsFHaBNWw05S/VhW0Xgkr0CBPE4NaFV2Kmcs3ZwLmib4TRrML', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/5wAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrNryTRwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAACuo3ot45qCPExpQ/3oHN+z17Ryis1lfMFYmQWgruS+TAAAAAA7msoAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAABAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{g86r5EAUKDQCYnz0Vw6C4b7cnE95RTwkOdYJHbBR2gTVsNOUv1YVtF4JK9AgTxODWhVdipnLN2cC5om+E0azCw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('164a5064eba64f2cdbadb856bf3448485fc626247ada3ed39cddf0f6902133b6', 2, 2, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 2, 100, 1, '2020-01-13 14:37:02.627702', '2020-01-13 14:37:02.627702', 8589942784, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAACAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAO2C/AO45YBD3tHVFO1R3A0MekP8JR6nN1A9eWidyItUAAAAAO5rKAAAAAAAAAAABVvwF9wAAAEASEZiZbeFwCsrKBnKIus/05VtJDBrgosuhLQ/U6XUj4twWyhs7UtS4CMexOM6JqcfqJK10WlBkkwn4g8PIfjIG', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrNryTRwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrMwLmpwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAA7YL8A7jlgEPe0dUU7VHcDQx6Q/wlHqc3UD15aJ3Ii1QAAAAA7msoAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/84AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{EhGYmW3hcArKygZyiLrP9OVbSQwa4KLLoS0P1Ol1I+LcFsobO1LUuAjHsTjOianH6iStdFpQZJMJ+IPDyH4yBg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('2d365c3c49f376570df856bca62503966f0e269a2f51cdb68ce2ee19a7f8245a', 2, 3, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 3, 100, 1, '2020-01-13 14:37:02.627805', '2020-01-13 14:37:02.627805', 8589946880, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAADAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAtbgXR6E7oDL0LQ+wYSC9zXvXVT3xiPiYuSb1DvmQLe8AAAAAO5rKAAAAAAAAAAABVvwF9wAAAEB/JBgvIM71gLBIh0TON9b+l+ApZz1CKDQiUFSV0scRguB1anyMwMR6s5SiaCwtDnxsPna12RdUQKlH2aeMAy8H', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrMwLmpwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrL0k6BwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAC1uBdHoTugMvQtD7BhIL3Ne9dVPfGI+Ji5JvUO+ZAt7wAAAAA7msoAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/84AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/7UAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{fyQYLyDO9YCwSIdEzjfW/pfgKWc9Qig0IlBUldLHEYLgdWp8jMDEerOUomgsLQ58bD52tdkXVECpR9mnjAMvBw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('003e91101d19aabb429491953806886d777c260233c6478f1c928a79ec4e2743', 2, 4, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 4, 100, 1, '2020-01-13 14:37:02.627911', '2020-01-13 14:37:02.627912', 8589950976, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAEAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAoPwY/Fd/cIyNUq/eqHOzpq7YdowcfSzkHfZFVRCK2EkAAAAAO5rKAAAAAAAAAAABVvwF9wAAAEDIOudzujfo+dSIJXXb06SjLBLLXsFxnVnR1HJejfq2NgFUtLuX2KrVNSZyRBG+WvfdoXwCPcp85hDRbCmjbPYM', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrL0k6BwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrK4+NZwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAACg/Bj8V39wjI1Sr96oc7Omrth2jBx9LOQd9kVVEIrYSQAAAAA7msoAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/7UAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAACAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/5wAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{yDrnc7o36PnUiCV129OkoywSy17BcZ1Z0dRyXo36tjYBVLS7l9iq1TUmckQRvlr33aF8Aj3KfOYQ0Wwpo2z2DA==}', 'none', NULL, NULL, true, 100);


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

