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

INSERT INTO gorp_migrations VALUES ('1_initial_schema.sql', '2020-01-13 15:37:28.304771+01');
INSERT INTO gorp_migrations VALUES ('2_index_participants_by_toid.sql', '2020-01-13 15:37:28.311168+01');
INSERT INTO gorp_migrations VALUES ('3_use_sequence_in_history_accounts.sql', '2020-01-13 15:37:28.315719+01');
INSERT INTO gorp_migrations VALUES ('4_add_protocol_version.sql', '2020-01-13 15:37:28.325327+01');
INSERT INTO gorp_migrations VALUES ('5_create_trades_table.sql', '2020-01-13 15:37:28.334417+01');
INSERT INTO gorp_migrations VALUES ('6_create_assets_table.sql', '2020-01-13 15:37:28.341765+01');
INSERT INTO gorp_migrations VALUES ('7_modify_trades_table.sql', '2020-01-13 15:37:28.357018+01');
INSERT INTO gorp_migrations VALUES ('8_add_aggregators.sql', '2020-01-13 15:37:28.361439+01');
INSERT INTO gorp_migrations VALUES ('8_create_asset_stats_table.sql', '2020-01-13 15:37:28.36689+01');
INSERT INTO gorp_migrations VALUES ('9_add_header_xdr.sql', '2020-01-13 15:37:28.370155+01');
INSERT INTO gorp_migrations VALUES ('10_add_trades_price.sql', '2020-01-13 15:37:28.372776+01');
INSERT INTO gorp_migrations VALUES ('11_add_trades_account_index.sql', '2020-01-13 15:37:28.376012+01');
INSERT INTO gorp_migrations VALUES ('12_asset_stats_amount_string.sql', '2020-01-13 15:37:28.381199+01');
INSERT INTO gorp_migrations VALUES ('13_trade_offer_ids.sql', '2020-01-13 15:37:28.387196+01');
INSERT INTO gorp_migrations VALUES ('14_fix_asset_toml_field.sql', '2020-01-13 15:37:28.388846+01');
INSERT INTO gorp_migrations VALUES ('15_ledger_failed_txs.sql', '2020-01-13 15:37:28.390769+01');
INSERT INTO gorp_migrations VALUES ('16_ingest_failed_transactions.sql', '2020-01-13 15:37:28.392096+01');
INSERT INTO gorp_migrations VALUES ('17_transaction_fee_paid.sql', '2020-01-13 15:37:28.393576+01');
INSERT INTO gorp_migrations VALUES ('18_account_for_signers.sql', '2020-01-13 15:37:28.399622+01');
INSERT INTO gorp_migrations VALUES ('19_offers.sql', '2020-01-13 15:37:28.409823+01');
INSERT INTO gorp_migrations VALUES ('20_account_for_signer_index.sql', '2020-01-13 15:37:28.412085+01');
INSERT INTO gorp_migrations VALUES ('21_trades_remove_zero_amount_constraints.sql', '2020-01-13 15:37:28.41488+01');
INSERT INTO gorp_migrations VALUES ('22_trust_lines.sql', '2020-01-13 15:37:28.421812+01');
INSERT INTO gorp_migrations VALUES ('23_exp_asset_stats.sql', '2020-01-13 15:37:28.428114+01');
INSERT INTO gorp_migrations VALUES ('24_accounts.sql', '2020-01-13 15:37:28.437444+01');
INSERT INTO gorp_migrations VALUES ('25_expingest_rename_columns.sql', '2020-01-13 15:37:28.439804+01');
INSERT INTO gorp_migrations VALUES ('26_exp_history_ledgers.sql', '2020-01-13 15:37:28.449917+01');
INSERT INTO gorp_migrations VALUES ('27_exp_history_transactions.sql', '2020-01-13 15:37:28.466257+01');
INSERT INTO gorp_migrations VALUES ('28_exp_history_operations.sql', '2020-01-13 15:37:28.475651+01');
INSERT INTO gorp_migrations VALUES ('29_exp_history_assets.sql', '2020-01-13 15:37:28.481835+01');
INSERT INTO gorp_migrations VALUES ('30_exp_history_trades.sql', '2020-01-13 15:37:28.500902+01');
INSERT INTO gorp_migrations VALUES ('31_exp_history_effects.sql', '2020-01-13 15:37:28.509407+01');


--
-- Data for Name: history_accounts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_accounts VALUES (1, 'GCQZP3IU7XU6EJ63JZXKCQOYT2RNXN3HB5CNHENNUEUHSMA4VUJJJSEN');
INSERT INTO history_accounts VALUES (2, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_accounts VALUES (3, 'GANFZDRBCNTUXIODCJEYMACPMCSZEVE4WZGZ3CZDZ3P2SXK4KH75IK6Y');
INSERT INTO history_accounts VALUES (4, 'GACJPE4YUR22VP4CM2BDFDAHY3DLEF3H7NENKUQ53DT5TEI2GAHT5N4X');
INSERT INTO history_accounts VALUES (5, 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD');
INSERT INTO history_accounts VALUES (6, 'GDR53WAEIKOU3ZKN34CSHAWH7HV6K63CBJRUTWUDBFSMY7RRQK3SPKOS');
INSERT INTO history_accounts VALUES (7, 'GCHPXGVDKPF5KT4CNAT7X77OXYZ7YVE4JHKFDUHCGCVWCL4K4PQ67KKZ');
INSERT INTO history_accounts VALUES (8, 'GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF');
INSERT INTO history_accounts VALUES (9, 'GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG');
INSERT INTO history_accounts VALUES (10, 'GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG');
INSERT INTO history_accounts VALUES (11, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_accounts VALUES (12, 'GB6GN3LJUW6JYR7EDOJ47VBH7D45M4JWHXGK6LHJRAEI5JBSN2DBQY7Q');
INSERT INTO history_accounts VALUES (13, 'GBOK7BOUSOWPHBANBYM6MIRYZJIDIPUYJPXHTHADF75UEVIVYWHHONQC');
INSERT INTO history_accounts VALUES (14, 'GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD');
INSERT INTO history_accounts VALUES (15, 'GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU');
INSERT INTO history_accounts VALUES (16, 'GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD');
INSERT INTO history_accounts VALUES (17, 'GACAR2AEYEKITE2LKI5RMXF5MIVZ6Q7XILROGDT22O7JX4DSWFS7FDDP');
INSERT INTO history_accounts VALUES (18, 'GANZGPKY5WSHWG5YOZMNG52GCK5SCJ4YGUWMJJVGZSK2FP4BI2JIJN2C');
INSERT INTO history_accounts VALUES (19, 'GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG');
INSERT INTO history_accounts VALUES (20, 'GCB7FPYGLL6RJ37HKRAYW5TAWMFBGGFGM4IM6ERBCZXI2BZ4OOOX2UAY');
INSERT INTO history_accounts VALUES (21, 'GDCVTBGSEEU7KLXUMHMSXBALXJ2T4I2KOPXW2S5TRLKDRIAXD5UDHAYO');
INSERT INTO history_accounts VALUES (22, 'GAG52TW6QAB6TGNMOTL32Y4M3UQQLNNNHPEHYAIYRP6SFF6ZAVRF5ZQY');
INSERT INTO history_accounts VALUES (23, 'GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB');
INSERT INTO history_accounts VALUES (24, 'GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB');
INSERT INTO history_accounts VALUES (25, 'GAXI33UCLQTCKM2NMRBS7XYBR535LLEVAHL5YBN4FTCB4HZHT7ZA5CVK');


--
-- Name: history_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_accounts_id_seq', 25, true);


--
-- Data for Name: history_assets; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_assets VALUES (1, 'native', '', '');
INSERT INTO history_assets VALUES (2, 'credit_alphanum4', 'USD', 'GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD');
INSERT INTO history_assets VALUES (3, 'credit_alphanum4', 'EUR', 'GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU');
INSERT INTO history_assets VALUES (4, 'credit_alphanum4', 'USD', 'GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU');


--
-- Name: history_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_assets_id_seq', 4, true);


--
-- Data for Name: history_effects; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_effects VALUES (1, 249108107265, 1, 43, '{"new_seq": 300000000000}');
INSERT INTO history_effects VALUES (1, 244813139969, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 244813139969, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (1, 244813139969, 3, 10, '{"weight": 1, "public_key": "GCQZP3IU7XU6EJ63JZXKCQOYT2RNXN3HB5CNHENNUEUHSMA4VUJJJSEN"}');
INSERT INTO history_effects VALUES (3, 240518172673, 1, 2, '{"amount": "10.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (3, 240518172673, 2, 3, '{"amount": "10.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (3, 236223205377, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 236223205377, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (3, 236223205377, 3, 10, '{"weight": 1, "public_key": "GANFZDRBCNTUXIODCJEYMACPMCSZEVE4WZGZ3CZDZ3P2SXK4KH75IK6Y"}');
INSERT INTO history_effects VALUES (4, 231928238081, 1, 2, '{"amount": "10.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (2, 231928238081, 2, 3, '{"amount": "10.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (2, 231928238082, 1, 2, '{"amount": "10.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (4, 231928238082, 2, 3, '{"amount": "10.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (4, 227633270785, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 227633270785, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (4, 227633270785, 3, 10, '{"weight": 1, "public_key": "GACJPE4YUR22VP4CM2BDFDAHY3DLEF3H7NENKUQ53DT5TEI2GAHT5N4X"}');
INSERT INTO history_effects VALUES (5, 223338303489, 1, 42, '{"name": "name1", "value": "MDAwMA=="}');
INSERT INTO history_effects VALUES (5, 219043336193, 1, 42, '{"name": "name1", "value": "MTIzNA=="}');
INSERT INTO history_effects VALUES (5, 214748368897, 1, 41, '{"name": "name2"}');
INSERT INTO history_effects VALUES (5, 210453401601, 1, 40, '{"name": "name1", "value": "MTIzNA=="}');
INSERT INTO history_effects VALUES (5, 210453405697, 1, 40, '{"name": "name2", "value": "NTY3OA=="}');
INSERT INTO history_effects VALUES (5, 210453409793, 1, 40, '{"name": "name ", "value": "aXRzIGdvdCBzcGFjZXMh"}');
INSERT INTO history_effects VALUES (5, 206158434305, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 206158434305, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (5, 206158434305, 3, 10, '{"weight": 1, "public_key": "GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD"}');
INSERT INTO history_effects VALUES (6, 197568499713, 1, 7, '{"inflation_destination": "GDR53WAEIKOU3ZKN34CSHAWH7HV6K63CBJRUTWUDBFSMY7RRQK3SPKOS"}');
INSERT INTO history_effects VALUES (2, 197568503809, 1, 7, '{"inflation_destination": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"}');
INSERT INTO history_effects VALUES (6, 193273532417, 1, 0, '{"starting_balance": "20000000000.0000000"}');
INSERT INTO history_effects VALUES (2, 193273532417, 2, 3, '{"amount": "20000000000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (6, 193273532417, 3, 10, '{"weight": 1, "public_key": "GDR53WAEIKOU3ZKN34CSHAWH7HV6K63CBJRUTWUDBFSMY7RRQK3SPKOS"}');
INSERT INTO history_effects VALUES (7, 188978565121, 1, 3, '{"amount": "999.9999900", "asset_type": "native"}');
INSERT INTO history_effects VALUES (2, 188978565121, 2, 2, '{"amount": "999.9999900", "asset_type": "native"}');
INSERT INTO history_effects VALUES (7, 188978565121, 3, 1, '{}');
INSERT INTO history_effects VALUES (7, 184683597825, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 184683597825, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (7, 184683597825, 3, 10, '{"weight": 1, "public_key": "GCHPXGVDKPF5KT4CNAT7X77OXYZ7YVE4JHKFDUHCGCVWCL4K4PQ67KKZ"}');
INSERT INTO history_effects VALUES (8, 180388630529, 1, 24, '{"trustor": "GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF"}');
INSERT INTO history_effects VALUES (8, 176093663233, 1, 23, '{"trustor": "GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF"}');
INSERT INTO history_effects VALUES (8, 176093667329, 1, 23, '{"trustor": "GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF"}');
INSERT INTO history_effects VALUES (9, 171798695937, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF"}');
INSERT INTO history_effects VALUES (9, 171798700033, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF"}');
INSERT INTO history_effects VALUES (8, 167503728641, 1, 6, '{"auth_required_flag": true, "auth_revocable_flag": true}');
INSERT INTO history_effects VALUES (9, 163208761345, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 163208761345, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (9, 163208761345, 3, 10, '{"weight": 1, "public_key": "GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG"}');
INSERT INTO history_effects VALUES (8, 163208765441, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 163208765441, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (8, 163208765441, 3, 10, '{"weight": 1, "public_key": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF"}');
INSERT INTO history_effects VALUES (10, 158913794049, 1, 21, '{"limit": "0.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"}');
INSERT INTO history_effects VALUES (10, 154618826753, 1, 22, '{"limit": "100.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"}');
INSERT INTO history_effects VALUES (10, 150323859457, 1, 22, '{"limit": "100.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"}');
INSERT INTO history_effects VALUES (10, 146028892161, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"}');
INSERT INTO history_effects VALUES (10, 141733924865, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 141733924865, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (10, 141733924865, 3, 10, '{"weight": 1, "public_key": "GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG"}');
INSERT INTO history_effects VALUES (11, 137438957569, 1, 6, '{"auth_required_flag": false, "auth_revocable_flag": false}');
INSERT INTO history_effects VALUES (11, 137438961665, 1, 12, '{"weight": 2, "public_key": "GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES"}');
INSERT INTO history_effects VALUES (11, 137438961665, 2, 11, '{"public_key": "GB6J3WOLKYQE6KVDZEA4JDMFTTONUYP3PUHNDNZRWIKA6JQWIMJZATFE"}');
INSERT INTO history_effects VALUES (11, 133143990273, 1, 12, '{"weight": 2, "public_key": "GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES"}');
INSERT INTO history_effects VALUES (11, 133143990273, 2, 12, '{"weight": 5, "public_key": "GB6J3WOLKYQE6KVDZEA4JDMFTTONUYP3PUHNDNZRWIKA6JQWIMJZATFE"}');
INSERT INTO history_effects VALUES (11, 120259088385, 1, 7, '{"inflation_destination": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"}');
INSERT INTO history_effects VALUES (11, 120259092481, 1, 6, '{"auth_required_flag": true}');
INSERT INTO history_effects VALUES (11, 120259096577, 1, 6, '{"auth_revocable_flag": true}');
INSERT INTO history_effects VALUES (11, 120259100673, 1, 12, '{"weight": 2, "public_key": "GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES"}');
INSERT INTO history_effects VALUES (11, 120259104769, 1, 4, '{"low_threshold": 0, "med_threshold": 2, "high_threshold": 2}');
INSERT INTO history_effects VALUES (11, 120259108865, 1, 5, '{"home_domain": "example.com"}');
INSERT INTO history_effects VALUES (11, 120259112961, 1, 12, '{"weight": 2, "public_key": "GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES"}');
INSERT INTO history_effects VALUES (11, 120259112961, 2, 10, '{"weight": 1, "public_key": "GB6J3WOLKYQE6KVDZEA4JDMFTTONUYP3PUHNDNZRWIKA6JQWIMJZATFE"}');
INSERT INTO history_effects VALUES (11, 115964121089, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 115964121089, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (11, 115964121089, 3, 10, '{"weight": 1, "public_key": "GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES"}');
INSERT INTO history_effects VALUES (12, 107374186497, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 107374186497, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (12, 107374186497, 3, 10, '{"weight": 1, "public_key": "GB6GN3LJUW6JYR7EDOJ47VBH7D45M4JWHXGK6LHJRAEI5JBSN2DBQY7Q"}');
INSERT INTO history_effects VALUES (14, 103079219201, 1, 33, '{"seller": "GBOK7BOUSOWPHBANBYM6MIRYZJIDIPUYJPXHTHADF75UEVIVYWHHONQC", "offer_id": 3, "sold_amount": "20.0000000", "bought_amount": "20.0000000", "sold_asset_code": "USD", "sold_asset_type": "credit_alphanum4", "bought_asset_type": "native", "sold_asset_issuer": "GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD"}');
INSERT INTO history_effects VALUES (13, 103079219201, 2, 33, '{"seller": "GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD", "offer_id": 3, "sold_amount": "20.0000000", "bought_amount": "20.0000000", "sold_asset_type": "native", "bought_asset_code": "USD", "bought_asset_type": "credit_alphanum4", "bought_asset_issuer": "GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD"}');
INSERT INTO history_effects VALUES (13, 94489284609, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD"}');
INSERT INTO history_effects VALUES (13, 90194317313, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 90194317313, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (13, 90194317313, 3, 10, '{"weight": 1, "public_key": "GBOK7BOUSOWPHBANBYM6MIRYZJIDIPUYJPXHTHADF75UEVIVYWHHONQC"}');
INSERT INTO history_effects VALUES (14, 90194321409, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 90194321409, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (14, 90194321409, 3, 10, '{"weight": 1, "public_key": "GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD"}');
INSERT INTO history_effects VALUES (17, 85899350017, 1, 2, '{"amount": "100.0000000", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (16, 85899350017, 2, 3, '{"amount": "100.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (16, 85899350017, 3, 33, '{"seller": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU", "offer_id": 2, "sold_amount": "100.0000000", "bought_amount": "100.0000000", "sold_asset_type": "native", "bought_asset_code": "EUR", "bought_asset_type": "credit_alphanum4", "bought_asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (15, 85899350017, 4, 33, '{"seller": "GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD", "offer_id": 2, "sold_amount": "100.0000000", "bought_amount": "100.0000000", "sold_asset_code": "EUR", "sold_asset_type": "credit_alphanum4", "bought_asset_type": "native", "sold_asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (17, 81604382721, 1, 2, '{"amount": "200.0000000", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (16, 81604382721, 2, 3, '{"amount": "100.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (16, 81604382721, 3, 33, '{"seller": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU", "offer_id": 1, "sold_amount": "100.0000000", "bought_amount": "200.0000000", "sold_asset_code": "USD", "sold_asset_type": "credit_alphanum4", "bought_asset_type": "native", "sold_asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (15, 81604382721, 4, 33, '{"seller": "GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD", "offer_id": 1, "sold_amount": "200.0000000", "bought_amount": "100.0000000", "sold_asset_type": "native", "bought_asset_code": "USD", "bought_asset_type": "credit_alphanum4", "bought_asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (16, 81604382721, 5, 33, '{"seller": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU", "offer_id": 2, "sold_amount": "200.0000000", "bought_amount": "200.0000000", "sold_asset_type": "native", "bought_asset_code": "EUR", "bought_asset_type": "credit_alphanum4", "bought_asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (15, 81604382721, 6, 33, '{"seller": "GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD", "offer_id": 2, "sold_amount": "200.0000000", "bought_amount": "200.0000000", "sold_asset_code": "EUR", "sold_asset_type": "credit_alphanum4", "bought_asset_type": "native", "sold_asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (16, 77309415425, 1, 2, '{"amount": "100.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (15, 77309415425, 2, 3, '{"amount": "100.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (16, 73014448129, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (17, 73014452225, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (16, 68719480833, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 68719480833, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (16, 68719480833, 3, 10, '{"weight": 1, "public_key": "GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD"}');
INSERT INTO history_effects VALUES (17, 68719484929, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 68719484929, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (17, 68719484929, 3, 10, '{"weight": 1, "public_key": "GACAR2AEYEKITE2LKI5RMXF5MIVZ6Q7XILROGDT22O7JX4DSWFS7FDDP"}');
INSERT INTO history_effects VALUES (15, 68719489025, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 68719489025, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (15, 68719489025, 3, 10, '{"weight": 1, "public_key": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}');
INSERT INTO history_effects VALUES (18, 64424513537, 1, 2, '{"amount": "10.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG"}');
INSERT INTO history_effects VALUES (19, 64424513537, 2, 3, '{"amount": "10.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG"}');
INSERT INTO history_effects VALUES (18, 60129546241, 1, 20, '{"limit": "922337203685.4775807", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG"}');
INSERT INTO history_effects VALUES (18, 60129550337, 1, 2, '{"amount": "10.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (19, 60129550337, 2, 3, '{"amount": "10.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (19, 55834578945, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 55834578945, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (19, 55834578945, 3, 10, '{"weight": 1, "public_key": "GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG"}');
INSERT INTO history_effects VALUES (18, 55834583041, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 55834583041, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (18, 55834583041, 3, 10, '{"weight": 1, "public_key": "GANZGPKY5WSHWG5YOZMNG52GCK5SCJ4YGUWMJJVGZSK2FP4BI2JIJN2C"}');
INSERT INTO history_effects VALUES (20, 51539611649, 1, 0, '{"starting_balance": "50.0000000"}');
INSERT INTO history_effects VALUES (21, 51539611649, 2, 3, '{"amount": "50.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (20, 51539611649, 3, 10, '{"weight": 1, "public_key": "GCB7FPYGLL6RJ37HKRAYW5TAWMFBGGFGM4IM6ERBCZXI2BZ4OOOX2UAY"}');
INSERT INTO history_effects VALUES (21, 47244644353, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 47244644353, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (21, 47244644353, 3, 10, '{"weight": 1, "public_key": "GDCVTBGSEEU7KLXUMHMSXBALXJ2T4I2KOPXW2S5TRLKDRIAXD5UDHAYO"}');
INSERT INTO history_effects VALUES (2, 42949677057, 1, 2, '{"amount": "10.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (22, 42949677057, 2, 3, '{"amount": "10.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (2, 42949677058, 1, 2, '{"amount": "10.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (22, 42949677058, 2, 3, '{"amount": "10.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (22, 38654709761, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 38654709761, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (22, 38654709761, 3, 10, '{"weight": 1, "public_key": "GAG52TW6QAB6TGNMOTL32Y4M3UQQLNNNHPEHYAIYRP6SFF6ZAVRF5ZQY"}');
INSERT INTO history_effects VALUES (2, 34359742465, 1, 2, '{"amount": "1.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (23, 34359742465, 2, 3, '{"amount": "1.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (2, 34359746561, 1, 2, '{"amount": "1.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (23, 34359746561, 2, 3, '{"amount": "1.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (2, 34359750657, 1, 2, '{"amount": "1.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (23, 34359750657, 2, 3, '{"amount": "1.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (2, 34359754753, 1, 2, '{"amount": "1.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (23, 34359754753, 2, 3, '{"amount": "1.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (23, 30064775169, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 30064775169, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (23, 30064775169, 3, 10, '{"weight": 1, "public_key": "GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB"}');
INSERT INTO history_effects VALUES (24, 25769807873, 1, 12, '{"weight": 2, "public_key": "GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB"}');
INSERT INTO history_effects VALUES (24, 25769807873, 2, 12, '{"weight": 1, "public_key": "GD3E7HKMRNT6HGBGHBT6I6JE4N2S4W5KZ246TGJ4KQSXJ2P4BXCUPQMP"}');
INSERT INTO history_effects VALUES (24, 21474844673, 1, 12, '{"weight": 1, "public_key": "GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB"}');
INSERT INTO history_effects VALUES (24, 21474844673, 2, 10, '{"weight": 1, "public_key": "GD3E7HKMRNT6HGBGHBT6I6JE4N2S4W5KZ246TGJ4KQSXJ2P4BXCUPQMP"}');
INSERT INTO history_effects VALUES (24, 21474848769, 1, 4, '{"low_threshold": 2, "med_threshold": 2, "high_threshold": 2}');
INSERT INTO history_effects VALUES (24, 17179873281, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 17179873281, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (24, 17179873281, 3, 10, '{"weight": 1, "public_key": "GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB"}');
INSERT INTO history_effects VALUES (25, 12884905985, 1, 0, '{"starting_balance": "1000.0000000"}');
INSERT INTO history_effects VALUES (2, 12884905985, 2, 3, '{"amount": "1000.0000000", "asset_type": "native"}');
INSERT INTO history_effects VALUES (25, 12884905985, 3, 10, '{"weight": 1, "public_key": "GAXI33UCLQTCKM2NMRBS7XYBR535LLEVAHL5YBN4FTCB4HZHT7ZA5CVK"}');


--
-- Data for Name: history_ledgers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_ledgers VALUES (61, '4f1ea5d8624c15d1531d806c1c5cc4335be90b54f400d933a0cda6d45333234b', 'f63a60ae7ba99a7deb586006ac2aa10c9fb4e4d061262cc08b74ff4850d810ec', 1, 1, '2020-01-13 14:38:22', '2020-01-13 14:37:28.790316', '2020-01-13 14:37:28.790316', 261993005056, 16, 1000000000000000000, 8700, 100, 100000000, 1000000, 12, 'AAAADPY6YK57qZp961hgBqwqoQyftOTQYSYswIt0/0hQ2BDsjQ6TDYYd6cvN4BLamBIPqec4NtG7ETbQFxi0EvThDowAAAAAXhyA3gAAAAAAAAAAosEhvRTCvadI/J9r+8kB+lYA6OphTjHH/5o2+iklI4MHUff2OEJkZAStZxcCOeXfgySiAk1/q6XESBvU4J67LwAAAD0N4Lazp2QAAAAAAAAAACH8AAAAAAAAAAAAAAAGAAAAZAX14QAAD0JALSTqwV3vpsCKVegnprEP8HdBThUmR610kZb1nrbMJ1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (60, 'f63a60ae7ba99a7deb586006ac2aa10c9fb4e4d061262cc08b74ff4850d810ec', '1baa3ac0ab58181128530bd58d7877c949e254beb192e70c02253fddbc7e5774', 1, 1, '2020-01-13 14:38:21', '2020-01-13 14:37:28.809163', '2020-01-13 14:37:28.809163', 257698037760, 16, 1000000000000000000, 8600, 100, 100000000, 1000000, 12, 'AAAADBuqOsCrWBgRKFML1Y14d8lJ4lS+sZLnDAIlP928fld0yYQZ9aubefXrG7yn7uhFKRFzJ4MSGVoEnGbI1Nka4PIAAAAAXhyA3QAAAAAAAAAAZB2X7lcCb772lP7QltIwf7Af+ESisKsoFpU1cBZvSc7PYNSgXll/lzfanhogdHO6+j2JLZTMyP0RycIciq9z9AAAADwN4Lazp2QAAAAAAAAAACGYAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JALSTqwV3vpsCKVegnprEP8HdBThUmR610kZb1nrbMJ1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (59, '1baa3ac0ab58181128530bd58d7877c949e254beb192e70c02253fddbc7e5774', '6a79534fb3bb8519ae5e4e2a7dbb456656130a31b8cb8ce9e5978451016e1979', 1, 1, '2020-01-13 14:38:20', '2020-01-13 14:37:28.821293', '2020-01-13 14:37:28.821293', 253403070464, 16, 1000000000000000000, 8500, 100, 100000000, 1000000, 12, 'AAAADGp5U0+zu4UZrl5OKn27RWZWEwoxuMuM6eWXhFEBbhl5t1ZRkEFI89dnB3bw/EBoNuwz/l7z+kgN4BS7+nosDTcAAAAAXhyA3AAAAAAAAAAAlNMwBDUEqtiETmU+aulkMrDuVtBffL8sVeqm0xm+yFz12Y99TpP+ovOH5s7Htb5LAb1xLNCiJTF6tiuwETkYSAAAADsN4Lazp2QAAAAAAAAAACE0AAAAAAAAAAAAAAAGAAAAZAX14QAAD0JALSTqwV3vpsCKVegnprEP8HdBThUmR610kZb1nrbMJ1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (58, '6a79534fb3bb8519ae5e4e2a7dbb456656130a31b8cb8ce9e5978451016e1979', '3e75a0fbf8a385bc17965b23016450e090908737b67784c32306217bd8012992', 1, 1, '2020-01-13 14:38:19', '2020-01-13 14:37:28.834403', '2020-01-13 14:37:28.834404', 249108103168, 16, 1000000000000000000, 8400, 100, 100000000, 1000000, 12, 'AAAADD51oPv4o4W8F5ZbIwFkUOCQkIc3tneEwyMGIXvYASmSghhbDGClKKuVXUwevi4JuzAc3AvfUbJeUmpPjZaBU6cAAAAAXhyA2wAAAAAAAAAAGMfQBF/YqYedEUNnQuilzukzLJPeVrR9I6q3baNG83lVb3o8cNEz3ATO61ClGmpiDVKoO6lBKZIzcZXb96XbgwAAADoN4Lazp2QAAAAAAAAAACDQAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JALSTqwV3vpsCKVegnprEP8HdBThUmR610kZb1nrbMJ1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (57, '3e75a0fbf8a385bc17965b23016450e090908737b67784c32306217bd8012992', 'e0b1d98376127d27ea6a68d70dba5882c24525748bf3cfae5b3187ee98e1faab', 1, 1, '2020-01-13 14:38:18', '2020-01-13 14:37:28.848241', '2020-01-13 14:37:28.848241', 244813135872, 16, 1000000000000000000, 8300, 100, 100000000, 1000000, 12, 'AAAADOCx2YN2En0n6mpo1w26WILCRSV0i/PPrlsxh+6Y4fqrZzrMo1izXLMvFGWtfdKMy2GynUrQUBUE4WZv2+6Hdm4AAAAAXhyA2gAAAAAAAAAA+gpxV8zlXX0rHIV7o/j6cHmaOUhVHdRkX+tH34sLAwGJipI/YJAsyAssgZqnT3obIutLTjI/eJsIxVKltV3LpAAAADkN4Lazp2QAAAAAAAAAACBsAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JALSTqwV3vpsCKVegnprEP8HdBThUmR610kZb1nrbMJ1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (56, 'e0b1d98376127d27ea6a68d70dba5882c24525748bf3cfae5b3187ee98e1faab', 'c1b1ee31634102916582831b3e2d329e36e043b1bfc91f3feb834bce5afc928e', 1, 1, '2020-01-13 14:38:17', '2020-01-13 14:37:28.861847', '2020-01-13 14:37:28.861848', 240518168576, 16, 1000000000000000000, 8200, 100, 100000000, 1000000, 12, 'AAAADMGx7jFjQQKRZYKDGz4tMp424EOxv8kfP+uDS85a/JKOhQ69EXqHhE4dvBMwUaIdAdiBJIuDsP66EE4G8kVKZggAAAAAXhyA2QAAAAAAAAAAudvIKbdFQO6cnqBlfAQ0qwiv8T/bow/WPTIANo/ERRG3Uy+CgE7NZKxeO7G53Ughnh9IxLGUtMu+UIdnADFaNQAAADgN4Lazp2QAAAAAAAAAACAIAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JALSTqwV3vpsCKVegnprEP8HdBThUmR610kZb1nrbMJ1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (55, 'c1b1ee31634102916582831b3e2d329e36e043b1bfc91f3feb834bce5afc928e', '428a06fbc20d25e6d8b6a63194ee14a99f1c946a9a3ea959d756c23cd9427453', 1, 1, '2020-01-13 14:38:16', '2020-01-13 14:37:28.873284', '2020-01-13 14:37:28.873284', 236223201280, 16, 1000000000000000000, 8100, 100, 100000000, 1000000, 12, 'AAAADEKKBvvCDSXm2LamMZTuFKmfHJRqmj6pWddWwjzZQnRTaAN0WKIn/sZv/LQ7yIKHxYaxk9TMgL4mg3QxDH3nHwMAAAAAXhyA2AAAAAAAAAAAzRBy0nxi8iD4SM8FlGGwd01pzAotgrfJIoM2XRwcIWh4dmfzemOSJiKrrs/kJcLvfGgkraLnBrOntpLPhURufQAAADcN4Lazp2QAAAAAAAAAAB+kAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JALSTqwV3vpsCKVegnprEP8HdBThUmR610kZb1nrbMJ1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (54, '428a06fbc20d25e6d8b6a63194ee14a99f1c946a9a3ea959d756c23cd9427453', '78a5d14f00617e7c7693afeff96cb6628c06528c8c81e408b048a4c2344b05da', 1, 2, '2020-01-13 14:38:15', '2020-01-13 14:37:28.88374', '2020-01-13 14:37:28.88374', 231928233984, 16, 1000000000000000000, 8000, 100, 100000000, 1000000, 12, 'AAAADHil0U8AYX58dpOv7/lstmKMBlKMjIHkCLBIpMI0SwXagO1rDY5NmUT66Y4w6rf4zX3n6LlU2VS/WC5Zzc5y5VIAAAAAXhyA1wAAAAAAAAAAmpLa9NzWbLjK2mB0fbRSEnodkiaLW5cLuLMT6SWdlnKNfjI9DM6JPB0dIXqIdCDAk4EE8YDV1cXbrH3vs8Xx4wAAADYN4Lazp2QAAAAAAAAAAB9AAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JALSTqwV3vpsCKVegnprEP8HdBThUmR610kZb1nrbMJ1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (53, '78a5d14f00617e7c7693afeff96cb6628c06528c8c81e408b048a4c2344b05da', 'f274077b7fc61a47cd00f85261af7edfa7cf079e5bfb305ab13be6418ec23360', 1, 1, '2020-01-13 14:38:14', '2020-01-13 14:37:28.896665', '2020-01-13 14:37:28.896665', 227633266688, 16, 1000000000000000000, 7800, 100, 100000000, 1000000, 12, 'AAAADPJ0B3t/xhpHzQD4UmGvft+nzweeW/swWrE75kGOwjNglOt4W1LJQYX/vP64igtTA3MdqAo5b7Wq+qjZZIXjx5cAAAAAXhyA1gAAAAAAAAAADqJIwT3y0IqHVPUMbXcHwPSbHirkS3phXIFWZ+KUBiWtwP4sKW2g9ZSzg3vbvtuHftnsXKrfo0PG5VdDj+la3gAAADUN4Lazp2QAAAAAAAAAAB54AAAAAAAAAAAAAAAGAAAAZAX14QAAD0JALSTqwV3vpsCKVegnprEP8HdBThUmR610kZb1nrbMJ1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (52, 'f274077b7fc61a47cd00f85261af7edfa7cf079e5bfb305ab13be6418ec23360', 'a0ac75b03b64ddabe50d2b4e2ea7374cd040a5a007819fe1e743cdc458cfe027', 1, 1, '2020-01-13 14:38:13', '2020-01-13 14:37:28.908595', '2020-01-13 14:37:28.908596', 223338299392, 16, 1000000000000000000, 7700, 100, 100000000, 1000000, 12, 'AAAADKCsdbA7ZN2r5Q0rTi6nN0zQQKWgB4Gf4edDzcRYz+AnMfm7/W6/C+hbV206qwK6+QBXl2YRMLEIY2sBVX/jfYkAAAAAXhyA1QAAAAAAAAAAdFs0uvdku2e14ZLZNY/inkD0IgG9m+9h08GbknZs9EzjicuGFB4w65HMv6apWhZg7jkNtoXX2gTv3Z0ll7CF5gAAADQN4Lazp2QAAAAAAAAAAB4UAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JALSTqwV3vpsCKVegnprEP8HdBThUmR610kZb1nrbMJ1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (51, 'a0ac75b03b64ddabe50d2b4e2ea7374cd040a5a007819fe1e743cdc458cfe027', 'b24fe248f1a67d16f54c1b377ec3e2c6fb0f97aa43ea16123faaf478d81250fa', 1, 1, '2020-01-13 14:38:12', '2020-01-13 14:37:28.921258', '2020-01-13 14:37:28.921258', 219043332096, 16, 1000000000000000000, 7600, 100, 100000000, 1000000, 12, 'AAAADLJP4kjxpn0W9UwbN37D4sb7D5eqQ+oWEj+q9HjYElD6PFXu6YYc8BUod9u3JIvc1eeO9kWdAqtjH5FwW+fhp2AAAAAAXhyA1AAAAAAAAAAAG9Lveo8KOMBsuTXxxarafYQzHKlqwhXWtcRjpmTOc+Nj0GG01ZZSlubrFAOsCucqnNvmGffP7pGcVU6b5ztbjQAAADMN4Lazp2QAAAAAAAAAAB2wAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JALSTqwV3vpsCKVegnprEP8HdBThUmR610kZb1nrbMJ1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (50, 'b24fe248f1a67d16f54c1b377ec3e2c6fb0f97aa43ea16123faaf478d81250fa', '110f4aee58a3219288c6dcaa939af2590299f4f5fa8972632e9daa4475d0fdbe', 1, 1, '2020-01-13 14:38:11', '2020-01-13 14:37:28.930266', '2020-01-13 14:37:28.930266', 214748364800, 16, 1000000000000000000, 7500, 100, 100000000, 1000000, 12, 'AAAADBEPSu5YoyGSiMbcqpOa8lkCmfT1+olyYy6dqkR10P2+Xfu8AoElHF6BgyqXSrg+ZkpaapJTA0iz+SHJ7jltNyAAAAAAXhyA0wAAAAAAAAAAe2zMUWV2ofxxSJUd0hgEpW+dk+M503UNhsqXLKL0TMgtJOrBXe+mwIpV6CemsQ/wd0FOFSZHrXSRlvWetswnVQAAADIN4Lazp2QAAAAAAAAAAB1MAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JALSTqwV3vpsCKVegnprEP8HdBThUmR610kZb1nrbMJ1UAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (49, '110f4aee58a3219288c6dcaa939af2590299f4f5fa8972632e9daa4475d0fdbe', '223dfbc8045137d5a1d409c4fff3252d8b9927d277ae1737ea6f433e82664851', 3, 3, '2020-01-13 14:38:10', '2020-01-13 14:37:28.942836', '2020-01-13 14:37:28.942836', 210453397504, 16, 1000000000000000000, 7400, 100, 100000000, 1000000, 12, 'AAAADCI9+8gEUTfVodQJxP/zJS2LmSfSd64XN+pvQz6CZkhRWseg2QWTdRTuBg7FHfyrHsQtJFtyKvPyh57yqAsNu/QAAAAAXhyA0gAAAAAAAAAAsSOLB+Fh7PI1BdmA+nlx5DdeXSAZY7OnyHcuyeMEmJClg4x4VQ2pDrwqXzwpScH+QiVOjY4hatDyzhxi6M3pcAAAADEN4Lazp2QAAAAAAAAAABzoAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 3, 0);
INSERT INTO history_ledgers VALUES (48, '223dfbc8045137d5a1d409c4fff3252d8b9927d277ae1737ea6f433e82664851', '47565e05b907f01ad9053fee7b21d3d17be9a1969b14df749ea2e1c13a7a17c2', 1, 1, '2020-01-13 14:38:09', '2020-01-13 14:37:28.956358', '2020-01-13 14:37:28.956358', 206158430208, 16, 1000000000000000000, 7100, 100, 100000000, 1000000, 12, 'AAAADEdWXgW5B/Aa2QU/7nsh09F76aGWmxTfdJ6i4cE6ehfCI2IdCZM9/QmtMA/E0Br/ibVxWFLWvwJXSEhIjLO04TQAAAAAXhyA0QAAAAAAAAAAMnDZx1As2hKzSfjIlMtVA6oGm0LubnHBEO+SB3Ja6Jr+C6Qycq6TPK3SQ3n3qmzpQqAmhpqdwSyF8XK3SbcVqAAAADAN4Lazp2QAAAAAAAAAABu8AAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (47, '47565e05b907f01ad9053fee7b21d3d17be9a1969b14df749ea2e1c13a7a17c2', 'bb03022425e6161a31c9aa41fcec74bf28178955839bd2babcf3bbbb4cf25f3d', 0, 0, '2020-01-13 14:38:08', '2020-01-13 14:37:28.966648', '2020-01-13 14:37:28.966648', 201863462912, 16, 1000000000000000000, 7000, 100, 100000000, 1000000, 12, 'AAAADLsDAiQl5hYaMcmqQfzsdL8oF4lVg5vSurzzu7tM8l89D0t4fYnCg4ShgptqFvrmP8FegtwdkgH2+NnNjw2txGwAAAAAXhyA0AAAAAAAAAAA3z9hmASpL9tAVxktxD3XSOp3itxSvEmM6AUkwBS4ERkgEkfsUXd6IRELyhHwP4v/qWF1PToLYGGOUqDLD1bWjgAAAC8N4Lazp2QAAAAAAAAAABtYAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 0, 0);
INSERT INTO history_ledgers VALUES (46, 'bb03022425e6161a31c9aa41fcec74bf28178955839bd2babcf3bbbb4cf25f3d', 'c35071a57bbf2a897c47797ee9333b64c4008d42ea8e5ac16ee958e34af4913f', 2, 2, '2020-01-13 14:38:07', '2020-01-13 14:37:28.973794', '2020-01-13 14:37:28.973794', 197568495616, 16, 1000000000000000000, 7000, 100, 100000000, 1000000, 12, 'AAAADMNQcaV7vyqJfEd5fukzO2TEAI1C6o5awW7pWONK9JE/ChOHumoX6CDLN76mnYJ6FoLp43dNaXQEYptodn9igUwAAAAAXhyAzwAAAAAAAAAAhkYgTYVFfiNxywZFyKUj6rUeR42SRzNzOnasgV/WuDsgEkfsUXd6IRELyhHwP4v/qWF1PToLYGGOUqDLD1bWjgAAAC4N4Lazp2QAAAAAAAAAABtYAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (45, 'c35071a57bbf2a897c47797ee9333b64c4008d42ea8e5ac16ee958e34af4913f', 'd84c2eb19eed7bf27d9cadf913c4526d841d38e519bc1e93a11e756038daa838', 1, 1, '2020-01-13 14:38:06', '2020-01-13 14:37:28.98514', '2020-01-13 14:37:28.98514', 193273528320, 16, 1000000000000000000, 6800, 100, 100000000, 1000000, 12, 'AAAADNhMLrGe7XvyfZyt+RPEUm2EHTjlGbwek6EedWA42qg4pUci/iM24l6pCaHoMzisWcB4mb3/XZb4HpmkHlBKxpIAAAAAXhyAzgAAAAAAAAAA2s+Yd36GUBmFrCn8nxzR3G7G6BlWwDjWIvSuQxGMICYpz53fFbx92GbQDhEF/97z0mo8APVNnx+d8Z7JnsbGKQAAAC0N4Lazp2QAAAAAAAAAABqQAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (44, 'd84c2eb19eed7bf27d9cadf913c4526d841d38e519bc1e93a11e756038daa838', 'c008a88ec35db4d76591dcbea05282b9b748201796970c20e422a1959c876fbd', 1, 1, '2020-01-13 14:38:05', '2020-01-13 14:37:28.996386', '2020-01-13 14:37:28.996386', 188978561024, 16, 1000000000000000000, 6700, 100, 100000000, 1000000, 12, 'AAAADMAIqI7DXbTXZZHcvqBSgrm3SCAXlpcMIOQioZWch2+9/+3co2+zuSrZl0i/Js8h6enCLp4EtdkEeQSrN+GDZ6kAAAAAXhyAzQAAAAAAAAAAWWc1pYhVWRoEJa6GcHIsaj1ysxI4CQ+BcJqiGW3wjmIIC1j8j+CEdb10lE3PM6AcLtULwnMM1VRxSghBdLJQUwAAACwN4Lazp2QAAAAAAAAAABosAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (43, 'c008a88ec35db4d76591dcbea05282b9b748201796970c20e422a1959c876fbd', 'fa47c3100fecdcd6e67f5fbe4a7c66ba4c05c8e859778ea07bc8da146526ae78', 1, 1, '2020-01-13 14:38:04', '2020-01-13 14:37:29.006778', '2020-01-13 14:37:29.006778', 184683593728, 16, 1000000000000000000, 6600, 100, 100000000, 1000000, 12, 'AAAADPpHwxAP7NzW5n9fvkp8ZrpMBcjoWXeOoHvI2hRlJq54LaBUiFi3XiVOAFkD3XnuMtEaD3W5BG7gqnaTs8Ug0TIAAAAAXhyAzAAAAAAAAAAA9L2wqBam8xx6EMlQ1e/R7JPhksJqFoZDmKFcFBwf3xC2ooa+4Z8atd8EfX9Lwh0LTeV3rCXvmFgd5nFciZbYewAAACsN4Lazp2QAAAAAAAAAABnIAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (42, 'fa47c3100fecdcd6e67f5fbe4a7c66ba4c05c8e859778ea07bc8da146526ae78', 'be037fbdc43cea79a9a05d5dc6d1ecd6a618cbbe305293e7f56e1c51685e9619', 1, 1, '2020-01-13 14:38:03', '2020-01-13 14:37:29.019948', '2020-01-13 14:37:29.019948', 180388626432, 16, 1000000000000000000, 6500, 100, 100000000, 1000000, 12, 'AAAADL4Df73EPOp5qaBdXcbR7NamGMu+MFKT5/VuHFFoXpYZGSjXKTiwKvGJYxvFKOp8KC6A1txJj2ri5HWCMn2CLrUAAAAAXhyAywAAAAAAAAAA4mQxuIyGkMnUNprxo1u6b3NOKgS/CqRR0k9oMQPLWs8YZD9J/96nwdNaqhnoK70e0mO8nwHhDjPEQz5BjOChPQAAACoN4Lazp2QAAAAAAAAAABlkAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (41, 'be037fbdc43cea79a9a05d5dc6d1ecd6a618cbbe305293e7f56e1c51685e9619', '19bc791285acacf1dd08cc7017cfc141fed5dc7137f50dce5be301d22aafc99f', 2, 2, '2020-01-13 14:38:02', '2020-01-13 14:37:29.031292', '2020-01-13 14:37:29.031292', 176093659136, 16, 1000000000000000000, 6400, 100, 100000000, 1000000, 12, 'AAAADBm8eRKFrKzx3QjMcBfPwUH+1dxxN/UNzlvjAdIqr8mfTCssZcCQm2qzkM4pJB/LjfWskhcOuSBgXb4uwEi0Gj4AAAAAXhyAygAAAAAAAAAA3texHWkeXlsh8yl52JzE1M7p/8uzk36DdlbvwdqWw1Zs6dAMeK8Gb3nhcHMSfhAbK6kdvfzpy42Zi1IfoWpbewAAACkN4Lazp2QAAAAAAAAAABkAAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (40, '19bc791285acacf1dd08cc7017cfc141fed5dc7137f50dce5be301d22aafc99f', 'f492595e1d6d693ca553630b2826270184d83225f96861f3148f8e4a2e765dda', 2, 2, '2020-01-13 14:38:01', '2020-01-13 14:37:29.042942', '2020-01-13 14:37:29.042942', 171798691840, 16, 1000000000000000000, 6200, 100, 100000000, 1000000, 12, 'AAAADPSSWV4dbWk8pVNjCygmJwGE2DIl+Whh8xSPjkoudl3aI+1jDu6Ghk9fqaPzSGYNKHOs8YC71DX21eg4uSXWUKkAAAAAXhyAyQAAAAAAAAAAWJlo97rfQjjINuAEkeCOb3Rwl6NYUk95Xa63Nc0UCv2MtCbB504g6+QplwnvK2ImzVqjVu9QLQFCkUk9Ll6xwwAAACgN4Lazp2QAAAAAAAAAABg4AAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (39, 'f492595e1d6d693ca553630b2826270184d83225f96861f3148f8e4a2e765dda', 'c152eb9ed4c5990d48c2aedaaa9fd2cca7a8ee632fe682b029f8875709517f22', 1, 1, '2020-01-13 14:38:00', '2020-01-13 14:37:29.053566', '2020-01-13 14:37:29.053567', 167503724544, 16, 1000000000000000000, 6000, 100, 100000000, 1000000, 12, 'AAAADMFS657UxZkNSMKu2qqf0synqO5jL+aCsCn4h1cJUX8iTONEpKRCd3D8rISOlUd2wHemF7xPNZKPLLsQJ5KZk9UAAAAAXhyAyAAAAAAAAAAASeHBruDgNPJb9kfcJVMyCg6meb0kov5dW9Ok8EEep2bHNzkHeCQ/shUQ1kv7qi/u3mL9JAZHJZXbroyAjjl8owAAACcN4Lazp2QAAAAAAAAAABdwAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (38, 'c152eb9ed4c5990d48c2aedaaa9fd2cca7a8ee632fe682b029f8875709517f22', '2b02ec34bced87491ce88e25eea0183c6a9ffbb201dc89d52747c9cb1a9a9aba', 2, 2, '2020-01-13 14:37:59', '2020-01-13 14:37:29.064084', '2020-01-13 14:37:29.064085', 163208757248, 16, 1000000000000000000, 5900, 100, 100000000, 1000000, 12, 'AAAADCsC7DS87YdJHOiOJe6gGDxqn/uyAdyJ1SdHycsampq6FRUBkVWPj/96WexsMFS1YHKjGBN+ofUS73xD/w8MBUoAAAAAXhyAxwAAAAAAAAAAN/+dCsXSVcipJLX5fSVl/dtD8pFe+iZnfnNZ2g7vXj8aRsU7mocEeE7Uhwh996ivIqwovok30oQY/Aq0G+Ok0wAAACYN4Lazp2QAAAAAAAAAABcMAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (37, '2b02ec34bced87491ce88e25eea0183c6a9ffbb201dc89d52747c9cb1a9a9aba', 'd6b41366d195f82dd67a6dae1121eaa9471c87d62fdcc371f4b47d9fb29af24b', 1, 1, '2020-01-13 14:37:58', '2020-01-13 14:37:29.075192', '2020-01-13 14:37:29.075193', 158913789952, 16, 1000000000000000000, 5700, 100, 100000000, 1000000, 12, 'AAAADNa0E2bRlfgt1nptrhEh6qlHHIfWL9zDcfS0fZ+ymvJLoZGxhSIZoX5y+vSuoX2AOj7Cbw6I9RiRVQ6SM2XEJL4AAAAAXhyAxgAAAAAAAAAAPORbuvHNNFfsSSmddqmUP8Fk8iW9Jb1yQL/uEyYGc2se9f8m0yR87nc/ryDl4YPvpTYsVeMO/ZMFthxo1Qt8VQAAACUN4Lazp2QAAAAAAAAAABZEAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (36, 'd6b41366d195f82dd67a6dae1121eaa9471c87d62fdcc371f4b47d9fb29af24b', '651946ded75ead67eda60418e57db21f4795e97e530163ffa6ddf63763fc9d0d', 1, 1, '2020-01-13 14:37:57', '2020-01-13 14:37:29.086016', '2020-01-13 14:37:29.086017', 154618822656, 16, 1000000000000000000, 5600, 100, 100000000, 1000000, 12, 'AAAADGUZRt7XXq1n7aYEGOV9sh9Hlel+UwFj/6bd9jdj/J0NjFE1LUSR7EzQPFev7E5YqGjcPxZqsntcCLPWQQVAl9wAAAAAXhyAxQAAAAAAAAAADx7u3Tt890DDCAY2PUo3lKiU3M3nylcrqmvMlFLS+fFEZRpT0QB/IhnuCqabR7HDoSMXZTpwN+mzQGzj9d3pjgAAACQN4Lazp2QAAAAAAAAAABXgAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (35, '651946ded75ead67eda60418e57db21f4795e97e530163ffa6ddf63763fc9d0d', '12a1a2fbd4ab8dc228f43fd735b68911bc930f926887e0940ca6e1994786fb9b', 1, 1, '2020-01-13 14:37:56', '2020-01-13 14:37:29.095713', '2020-01-13 14:37:29.095713', 150323855360, 16, 1000000000000000000, 5500, 100, 100000000, 1000000, 12, 'AAAADBKhovvUq43CKPQ/1zW2iRG8kw+SaIfglAym4ZlHhvubv2XdbdTpsxhURvjtyrJuR/F4IrNEEBNMObGLEy+MeVkAAAAAXhyAxAAAAAAAAAAAU3lWP9fTSJmRnN7PpNBaZaYziGh9Xk2I2lyAgYUdNszx+IjnMuzgD3pfdjYIDOaotJBuoPr2bZ/DxVMa4K/xVgAAACMN4Lazp2QAAAAAAAAAABV8AAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (34, '12a1a2fbd4ab8dc228f43fd735b68911bc930f926887e0940ca6e1994786fb9b', 'ebf5429e0cd6395dd57dc38328693cc620c02eea5a4478235b6481f540484270', 1, 1, '2020-01-13 14:37:55', '2020-01-13 14:37:29.105438', '2020-01-13 14:37:29.105438', 146028888064, 16, 1000000000000000000, 5400, 100, 100000000, 1000000, 12, 'AAAADOv1Qp4M1jld1X3DgyhpPMYgwC7qWkR4I1tkgfVASEJws0BmClmMpMU7tcAwn41Yh7fYlt2lk2SwWoWGFWp9rIQAAAAAXhyAwwAAAAAAAAAA/bE+PeQRbcMvSIfQyaXSWXEgzB7abwreNVQeYYIhwiZYjTB6QF1XSQjm9vhLn5K66rhB8z2miQVwGBWKtsLm5wAAACIN4Lazp2QAAAAAAAAAABUYAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (33, 'ebf5429e0cd6395dd57dc38328693cc620c02eea5a4478235b6481f540484270', 'dd67ee2fafa45a8da9b969c2c4f8b7b5e70739185c79be0377b477fbf9a88b35', 1, 1, '2020-01-13 14:37:54', '2020-01-13 14:37:29.115877', '2020-01-13 14:37:29.115877', 141733920768, 16, 1000000000000000000, 5300, 100, 100000000, 1000000, 12, 'AAAADN1n7i+vpFqNqblpwsT4t7XnBzkYXHm+A3e0d/v5qIs1zO8TQv0B5ZJonBkQZDXJTr71AiRyRdnM9m7camYLM7kAAAAAXhyAwgAAAAAAAAAAHdP8tBBtpeyL899tLPnNdaqUoHRWmHKjK8mobr412wF9J14tRAwY9nPl5yLevrzz7TeclwcuynHIfs55nExVZQAAACEN4Lazp2QAAAAAAAAAABS0AAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (32, 'dd67ee2fafa45a8da9b969c2c4f8b7b5e70739185c79be0377b477fbf9a88b35', 'b52aeaa04a67ab0d51e3653217e4cfadafca494e887936b5916d53d5e533a8ce', 2, 2, '2020-01-13 14:37:53', '2020-01-13 14:37:29.126047', '2020-01-13 14:37:29.126048', 137438953472, 16, 1000000000000000000, 5200, 100, 100000000, 1000000, 12, 'AAAADLUq6qBKZ6sNUeNlMhfkz62vyklOiHk2tZFtU9XlM6jOE94HjLpn1sV7zObLlr0tVdPHx5w7Nxh248ncqbI6m80AAAAAXhyAwQAAAAAAAAAA2zD57d2oUw2L6murtm/oe2Dj6FuzBXnVm7l7HoDsMUw937YGJEmdOw58879bx9QVjDJpgYoHihjRv3YXXy9QFgAAACAN4Lazp2QAAAAAAAAAABRQAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (31, 'b52aeaa04a67ab0d51e3653217e4cfadafca494e887936b5916d53d5e533a8ce', 'e7144c6e831247d08f502d1f45aa47aef2723ed1a99edfec6a69d0877503489a', 1, 1, '2020-01-13 14:37:52', '2020-01-13 14:37:29.137869', '2020-01-13 14:37:29.137869', 133143986176, 16, 1000000000000000000, 5000, 100, 100000000, 1000000, 12, 'AAAADOcUTG6DEkfQj1AtH0WqR67ycj7RqZ7f7Gpp0Id1A0iaDxtCFwypASVGD/50fT+3+nO7UQC0uGvuX0j+65ws8X4AAAAAXhyAwAAAAAAAAAAA8GmZ2mhGWPCcWAd1pU9SBJXfejtD7FOEoLD6oFsTOv52ELOnGq22k6YzxVn90latnq+ZH2tvxqRUV/K9un86VgAAAB8N4Lazp2QAAAAAAAAAABOIAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (30, 'e7144c6e831247d08f502d1f45aa47aef2723ed1a99edfec6a69d0877503489a', '70377122c2b04b526317c3b14f1db0dbe50c49bae4567a0c89c779e8aae0778e', 1, 1, '2020-01-13 14:37:51', '2020-01-13 14:37:29.147782', '2020-01-13 14:37:29.147782', 128849018880, 16, 1000000000000000000, 4900, 100, 100000000, 1000000, 12, 'AAAADHA3cSLCsEtSYxfDsU8dsNvlDEm65FZ6DInHeeiq4HeO+oqQeqBX6n/72RThdtWq4YcRIT8sjkdpZDA7Ib8eMfcAAAAAXhyAvwAAAAAAAAAA1jXLaoK/IOqKNVkib2cNLrjlETHXpZlcJ4BFYO8bM3l4A4eNe4kSNvLe8WTMyZs1kx4Y6X1UN6ZMOXl0dD1t6QAAAB4N4Lazp2QAAAAAAAAAABMkAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (29, '70377122c2b04b526317c3b14f1db0dbe50c49bae4567a0c89c779e8aae0778e', '635ae116fd2ce357356ff9181d07f8362ef2ab0b249972fd97461d488489d6b4', 1, 1, '2020-01-13 14:37:50', '2020-01-13 14:37:29.156934', '2020-01-13 14:37:29.156934', 124554051584, 16, 1000000000000000000, 4800, 100, 100000000, 1000000, 12, 'AAAADGNa4Rb9LONXNW/5GB0H+DYu8qsLJJly/ZdGHUiEida06xC3tHtutGTw6EkzFvA5RjBCwKyizpUF+e+qP8rMAwUAAAAAXhyAvgAAAAAAAAAAbaCD4RbfEqSrI+qpIyzzUU+bYYMJsRw3pHcmHwQrvaBiNI3xUEH4buwanL7sBUn8QBn07ocauSy2wTGGtx6dvAAAAB0N4Lazp2QAAAAAAAAAABLAAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (28, '635ae116fd2ce357356ff9181d07f8362ef2ab0b249972fd97461d488489d6b4', 'ae5effe0318057856588494bd2a96af217a9eb4448940f14557a5474d328ea88', 7, 7, '2020-01-13 14:37:49', '2020-01-13 14:37:29.168157', '2020-01-13 14:37:29.168157', 120259084288, 16, 1000000000000000000, 4700, 100, 100000000, 1000000, 12, 'AAAADK5e/+AxgFeFZYhJS9KpavIXqetESJQPFFV6VHTTKOqIn2TNnFUalAO81Grq2j1in+BXWC07M/QeHUG538PRV2wAAAAAXhyAvQAAAAAAAAAAdQ/T4yJNKn9hiJoTuxDsNbd9ibRWf2hNHJhsiqBKWD0deLyewesg3oCcX3FwP+aLikjamN1+idBm+aSKMZ1h5AAAABwN4Lazp2QAAAAAAAAAABJcAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 7, 0);
INSERT INTO history_ledgers VALUES (27, 'ae5effe0318057856588494bd2a96af217a9eb4448940f14557a5474d328ea88', 'd6cecd8da2731fdfb7b6dbcefd38d1134e39bb60dcfa4bd182fde7139406404a', 1, 1, '2020-01-13 14:37:48', '2020-01-13 14:37:29.185388', '2020-01-13 14:37:29.185388', 115964116992, 16, 1000000000000000000, 4000, 100, 100000000, 1000000, 12, 'AAAADNbOzY2icx/ft7bbzv040RNOObtg3PpL0YL95xOUBkBKl+5jH9w5nGpMoDyZsdsll/EFbYOIHYCBAyI2ImxDYqcAAAAAXhyAvAAAAAAAAAAAkpeXdNXfmh1EnUjCYIMebdzV8PlgCe6J6eJq8Mb4SXbB3seCw+K5TmVD4v7ACwLMkXSUrbhf+sHh5YJgBOd30QAAABsN4Lazp2QAAAAAAAAAAA+gAAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (26, 'd6cecd8da2731fdfb7b6dbcefd38d1134e39bb60dcfa4bd182fde7139406404a', 'c8c9b9a54ecb6be22e720db17aa0ae788171f67b5bc1d4068c63788f47d4de71', 2, 2, '2020-01-13 14:37:47', '2020-01-13 14:37:29.198235', '2020-01-13 14:37:29.198235', 111669149696, 16, 1000000000000000000, 3900, 100, 100000000, 1000000, 12, 'AAAADMjJuaVOy2viLnINsXqgrniBcfZ7W8HUBoxjeI9H1N5xrAtJIKKF2m2NsScNSLMcthGWd94qFYNF7A1aPx/B504AAAAAXhyAuwAAAAAAAAAAGTKcjd5tsclF3P+ptDiMdUWp83tuYF+zlADp+X+gt+cmdIg5jQzMmw3O6EcWPdJeQk9+hByrqukdi29YlSaHoQAAABoN4Lazp2QAAAAAAAAAAA88AAAAAAAAAAAAAAAGAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (25, 'c8c9b9a54ecb6be22e720db17aa0ae788171f67b5bc1d4068c63788f47d4de71', '41ccbd237e7301b75f1c7a5dcb5a5e8b571d100495f1b1e1ab9ef594600e6dc3', 1, 1, '2020-01-13 14:37:46', '2020-01-13 14:37:29.209321', '2020-01-13 14:37:29.209321', 107374182400, 16, 1000000000000000000, 3700, 100, 100000000, 1000000, 12, 'AAAADEHMvSN+cwG3Xxx6XctaXotXHRAElfGx4aue9ZRgDm3D5vqbJVtJfEWov+hK/pVogRjwRPrCecvcZBSMZtkJutMAAAAAXhyAugAAAAAAAAAAM9gLVDvjwMuVZ+njRjvvMxlhodRg/VJpuapiCb0y9SD8gV9hk/xxwKLP22Pdpfhphqfv7mj7dsckJ5QCnqEOwwAAABkN4Lazp2QAAAAAAAAAAA50AAAAAAAAAAAAAAAEAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (24, '41ccbd237e7301b75f1c7a5dcb5a5e8b571d100495f1b1e1ab9ef594600e6dc3', '0b34c668a10a32dad0267728dc27e65bf8aa2235f3b379a0f7e805346348c2e8', 1, 1, '2020-01-13 14:37:45', '2020-01-13 14:37:29.220507', '2020-01-13 14:37:29.220507', 103079215104, 16, 1000000000000000000, 3600, 100, 100000000, 1000000, 12, 'AAAADAs0xmihCjLa0CZ3KNwn5lv4qiI187N5oPfoBTRjSMLogpHG1dFTS0nKmClCowak2KDFj1S3WeiCJOKT0qF2asgAAAAAXhyAuQAAAAAAAAAA1ziHajubDrj1Iu5EQ8YZB24Czm29AJPdaJnsX3+A+fU0VRx81gsxbITa3A4j0gQx9+Ojk9WBGQxrZmkdTX1/ugAAABgN4Lazp2QAAAAAAAAAAA4QAAAAAAAAAAAAAAAEAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (23, '0b34c668a10a32dad0267728dc27e65bf8aa2235f3b379a0f7e805346348c2e8', 'cb050092c89a1f9a8ab4a5d551703cb6fdd5a5073f856732ec131c56407edbcb', 1, 1, '2020-01-13 14:37:44', '2020-01-13 14:37:29.239263', '2020-01-13 14:37:29.239264', 98784247808, 16, 1000000000000000000, 3500, 100, 100000000, 1000000, 12, 'AAAADMsFAJLImh+airSl1VFwPLb91aUHP4VnMuwTHFZAftvLhPrlJB64lw6IlcE+IdIU1VGLSiEkKNMtW+7XsecPHrcAAAAAXhyAuAAAAAAAAAAAeu6ZLz++eOyW3/HPY616v+oF2X756WCT8G93ApdHifqfCZ5crk9tqY6kYTz5s+RUNEgTWpw+OBlhPSODscGmZQAAABcN4Lazp2QAAAAAAAAAAA2sAAAAAAAAAAAAAAADAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (22, 'cb050092c89a1f9a8ab4a5d551703cb6fdd5a5073f856732ec131c56407edbcb', 'a33b180b1ecf1ad434a054903d61c3a681aa45190f0f21f3ffcca11d9ec54c46', 1, 1, '2020-01-13 14:37:43', '2020-01-13 14:37:29.250876', '2020-01-13 14:37:29.250876', 94489280512, 16, 1000000000000000000, 3400, 100, 100000000, 1000000, 12, 'AAAADKM7GAsezxrUNKBUkD1hw6aBqkUZDw8h8//MoR2exUxGBngBWO+j0DoU9WLdgRZfgqeiF8qfOYpbEvyZhA7TQhkAAAAAXhyAtwAAAAAAAAAA0AMiyT4CyDLLvayS0AmP97hen9j1rkIsoYeN0iQrjuqqupxEvwg2wAPIdNyHDEHwIGTFQc0X4jwJQE1ruNGIYAAAABYN4Lazp2QAAAAAAAAAAA1IAAAAAAAAAAAAAAACAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (21, 'a33b180b1ecf1ad434a054903d61c3a681aa45190f0f21f3ffcca11d9ec54c46', '0ad8d7dbe4b3bfd449d9faebf02dc9d15969fc5db84d1da4e6f3ea8c67236993', 2, 2, '2020-01-13 14:37:42', '2020-01-13 14:37:29.261933', '2020-01-13 14:37:29.261933', 90194313216, 16, 1000000000000000000, 3300, 100, 100000000, 1000000, 12, 'AAAADArY19vks7/USdn66/AtydFZafxduE0dpObz6oxnI2mTvsZ8WH2zBCR6ZzlLui8ChBYulHa4Iwbd40SoUmLSm5QAAAAAXhyAtgAAAAAAAAAA3LAnNjSwmLo474ojoHgysfkXmeeBIXdgWbyOJwbnsx+3vJc/rDk0CA7q44+493qQ8Zd2WJwAed67g8c+gVeHVgAAABUN4Lazp2QAAAAAAAAAAAzkAAAAAAAAAAAAAAACAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (20, '0ad8d7dbe4b3bfd449d9faebf02dc9d15969fc5db84d1da4e6f3ea8c67236993', '4d7c69a8dcc9d783366420c267297c6bf9297778b0fde67838c5a741deb00b5c', 1, 1, '2020-01-13 14:37:41', '2020-01-13 14:37:29.276037', '2020-01-13 14:37:29.276038', 85899345920, 16, 1000000000000000000, 3100, 100, 100000000, 1000000, 12, 'AAAADE18aajcydeDNmQgwmcpfGv5KXd4sP3meDjFp0HesAtc0GI7JZb8qI5gk8umo8+IqrZgbf76y4yO9+Dv5yOtENkAAAAAXhyAtQAAAAAAAAAAx/hxaEW2XNJB3iDf23eYfGcwcQ862pSt7OJ6FF108IYAWUcsaj4a4trzr6qQA2AhgusuB1MxMuiZK9ITz/5F2gAAABQN4Lazp2QAAAAAAAAAAAwcAAAAAAAAAAAAAAACAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (19, '4d7c69a8dcc9d783366420c267297c6bf9297778b0fde67838c5a741deb00b5c', '409c172b2d0b45fcd795750c367484b163d3e60ef3f1c54764494fb50438da8d', 1, 1, '2020-01-13 14:37:40', '2020-01-13 14:37:29.29318', '2020-01-13 14:37:29.29318', 81604378624, 16, 1000000000000000000, 3000, 100, 100000000, 1000000, 12, 'AAAADECcFystC0X815V1DDZ0hLFj0+YO8/HFR2RJT7UEONqNvDUvlVyA1q+qhtNq4FQ1ZHSmeiDCjgf81KWbAO1bTiIAAAAAXhyAtAAAAAAAAAAAYzC64fmWjZOtqE4JjsKqwerdnzN6ywnJSvdsDWFPcu1Fxs6RBvgbgBYNgnS8KV1SsVbzv2Et81dOVqGCXXxd5gAAABMN4Lazp2QAAAAAAAAAAAu4AAAAAAAAAAAAAAACAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (18, '409c172b2d0b45fcd795750c367484b163d3e60ef3f1c54764494fb50438da8d', 'f5acdbf81533d0d0c50b6761115f004de3bccde71ea7e7e1b2bc1edbc6a82e4a', 3, 3, '2020-01-13 14:37:39', '2020-01-13 14:37:29.313619', '2020-01-13 14:37:29.313619', 77309411328, 16, 1000000000000000000, 2900, 100, 100000000, 1000000, 12, 'AAAADPWs2/gVM9DQxQtnYRFfAE3jvM3nHqfn4bK8HtvGqC5KDG36/ZCvF3yxgVNjkmLoQihFv1G1WoW3apovHwEptaQAAAAAXhyAswAAAAAAAAAANKxyAMoyM/gn59hBYzLxbU28Wbix3QHy7s086vpSY4ea3o91Nu9WlEHeZlclEpvUPbIEizXVS3DpW8e8pBbQpAAAABIN4Lazp2QAAAAAAAAAAAtUAAAAAAAAAAAAAAACAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 3, 0);
INSERT INTO history_ledgers VALUES (17, 'f5acdbf81533d0d0c50b6761115f004de3bccde71ea7e7e1b2bc1edbc6a82e4a', 'f2ca2c4d6d9196f02466dc8be7b3f9d919eac5d18546b34393c196bef93304c6', 2, 2, '2020-01-13 14:37:38', '2020-01-13 14:37:29.327263', '2020-01-13 14:37:29.327263', 73014444032, 16, 1000000000000000000, 2600, 100, 100000000, 1000000, 12, 'AAAADPLKLE1tkZbwJGbci+ez+dkZ6sXRhUazQ5PBlr75MwTGTc67uPyXwgeGMRMoZRVU+JwxUBH9YpNcLo3t183C0zkAAAAAXhyAsgAAAAAAAAAAqHWOFRdWDweK4ZIEBYTYOkzwi2q8iIoB9xFzAOqPS/cvsA9mXmq8g3Qjv0CXn+vdnSZlLK8not7UwsPqOohpqQAAABEN4Lazp2QAAAAAAAAAAAooAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (16, 'f2ca2c4d6d9196f02466dc8be7b3f9d919eac5d18546b34393c196bef93304c6', 'b16698b1c08d70df41f0424bb45d232c123254120c5549685b94fb7aa8effdfc', 3, 3, '2020-01-13 14:37:37', '2020-01-13 14:37:29.339', '2020-01-13 14:37:29.339', 68719476736, 16, 1000000000000000000, 2400, 100, 100000000, 1000000, 12, 'AAAADLFmmLHAjXDfQfBCS7RdIywSMlQSDFVJaFuU+3qo7/38wrMo/tiN5x8Jx6g2yub8A4AD4CdU9BMgxc+Pvk4++BQAAAAAXhyAsQAAAAAAAAAAYKou7BkPtQtmD4O54/TToUgBAVUCmCl/O+9Tgq2hNHzW3Dames5DBBPIpsZcyVvqhNf8m5cfYF20H5OTgFeAIAAAABAN4Lazp2QAAAAAAAAAAAlgAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 3, 0);
INSERT INTO history_ledgers VALUES (15, 'b16698b1c08d70df41f0424bb45d232c123254120c5549685b94fb7aa8effdfc', 'b3330c6bc92ee5bf865db84ed6a4435e7a4ed0e7630bbf57610e7f55645f4c9d', 1, 1, '2020-01-13 14:37:36', '2020-01-13 14:37:29.349342', '2020-01-13 14:37:29.349342', 64424509440, 16, 1000000000000000000, 2100, 100, 100000000, 1000000, 12, 'AAAADLMzDGvJLuW/hl24TtakQ156TtDnYwu/V2EOf1VkX0ydsYKgvBydPfcXzFLb2u8JnhiQcU4/fMS/yseDVvCdv4wAAAAAXhyAsAAAAAAAAAAAUsjUlWJzXzXDGEu7ZX8NM4G3hXMJgTqm1o4qvEMfb6HHb9wsSjBslGspRdGuHGBiZERyrIVH4GCji6nV33OKcwAAAA8N4Lazp2QAAAAAAAAAAAg0AAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (14, 'b3330c6bc92ee5bf865db84ed6a4435e7a4ed0e7630bbf57610e7f55645f4c9d', '28813ae2a194f95c72ae50f5f2647021ae3a54213c239dfe41a78fba03301eb9', 2, 2, '2020-01-13 14:37:35', '2020-01-13 14:37:29.360673', '2020-01-13 14:37:29.360673', 60129542144, 16, 1000000000000000000, 2000, 100, 100000000, 1000000, 12, 'AAAADCiBOuKhlPlccq5Q9fJkcCGuOlQhPCOd/kGnj7oDMB65a0Fakq4r6zEi6dFJq+GeOjft+8MN5Na/PsnrvFsVsO4AAAAAXhyArwAAAAAAAAAAkBsR4zZKGkuzmOMkFZMIwPdAxWuGy+ssPtEN7i6N7emNOq9hCM26mf5fEIgTIJpeE2e7Iifu4NFBLw65ov/lqgAAAA4N4Lazp2QAAAAAAAAAAAfQAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (13, '28813ae2a194f95c72ae50f5f2647021ae3a54213c239dfe41a78fba03301eb9', 'c39da7c2bd78e382418f3dc716f40ca78f8f8ae17662267ee407f0ddb35627c7', 2, 2, '2020-01-13 14:37:34', '2020-01-13 14:37:29.371059', '2020-01-13 14:37:29.371059', 55834574848, 16, 1000000000000000000, 1800, 100, 100000000, 1000000, 12, 'AAAADMOdp8K9eOOCQY89xxb0DKePj4rhdmImfuQH8N2zVifH8VwU/lvj3sg6A3xN2nfUzL4jBcRRiwJlCTFtXSWPOLAAAAAAXhyArgAAAAAAAAAAFkWUNyF+w67R5n+HgDNebl5snV2YlBsz3xLTqBMQsQHWfvwFh+jqVvjR2HEVHSMSITQpb4FWNhdcIP+VlBdCLgAAAA0N4Lazp2QAAAAAAAAAAAcIAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 2, 0);
INSERT INTO history_ledgers VALUES (12, 'c39da7c2bd78e382418f3dc716f40ca78f8f8ae17662267ee407f0ddb35627c7', '0596da576f23b35159c86f3590939fbf5c16a8f5690aad4a8a73d15884414855', 1, 1, '2020-01-13 14:37:33', '2020-01-13 14:37:29.381692', '2020-01-13 14:37:29.381692', 51539607552, 16, 1000000000000000000, 1600, 100, 100000000, 1000000, 12, 'AAAADAWW2ldvI7NRWchvNZCTn79cFqj1aQqtSopz0ViEQUhVQ07oPcS+/FNoqZJvTJ/OIJMhw1y+hS+2MVuEmd2WUXEAAAAAXhyArQAAAAAAAAAAc4P3o+BJiJvXXIfj/eVQPF1RRIrnE2nfX0a4J7WFySq1RU2S8AMT5k42jOlm5vZroGgkEi5H1Uzw85qqZdxpXAAAAAwN4Lazp2QAAAAAAAAAAAZAAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (11, '0596da576f23b35159c86f3590939fbf5c16a8f5690aad4a8a73d15884414855', '9ad2a36299aebc5833364f8eb9e203d0f530ae5664ad9976a82dfb9255a2933c', 1, 1, '2020-01-13 14:37:32', '2020-01-13 14:37:29.391919', '2020-01-13 14:37:29.39192', 47244640256, 16, 1000000000000000000, 1500, 100, 100000000, 1000000, 12, 'AAAADJrSo2KZrrxYMzZPjrniA9D1MK5WZK2Zdqgt+5JVopM8Hie/U4hI/VcGtU7DrOfy7J9d6Nt1SGR32v3IXzdKOl0AAAAAXhyArAAAAAAAAAAApIxpaTPANJS3XftGXFSYrEJ0MhfN6GN1Oe5+YEP6099Q228FWICS1ce3jrMN2vVflziESw5NhBJpUOZed/DfLQAAAAsN4Lazp2QAAAAAAAAAAAXcAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (10, '9ad2a36299aebc5833364f8eb9e203d0f530ae5664ad9976a82dfb9255a2933c', '18e0366807c10b906691e63c1f446658a3d8b12d1f2d36ace668010ae6457ba1', 1, 2, '2020-01-13 14:37:31', '2020-01-13 14:37:29.401495', '2020-01-13 14:37:29.401495', 42949672960, 16, 1000000000000000000, 1400, 100, 100000000, 1000000, 12, 'AAAADBjgNmgHwQuQZpHmPB9EZlij2LEtHy02rOZoAQrmRXuhITAlxBFVrmHjdRENItBBNsoYqc1Ho6q6rsMa+zBlymAAAAAAXhyAqwAAAAAAAAAA9+jjsWK6v6g0OYMFxTo1+Yogi2yDSjXhJ86N1AxJOvEKktmTdURVD0Ooo8aJaxovGwd3ivOyxPot4n647w6bpAAAAAoN4Lazp2QAAAAAAAAAAAV4AAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (9, '18e0366807c10b906691e63c1f446658a3d8b12d1f2d36ace668010ae6457ba1', 'a56912456a4cc335080c40f602f6a6e0b411a941b1a9e082ad88c8f28521b770', 1, 1, '2020-01-13 14:37:30', '2020-01-13 14:37:29.411674', '2020-01-13 14:37:29.411674', 38654705664, 16, 1000000000000000000, 1200, 100, 100000000, 1000000, 12, 'AAAADKVpEkVqTMM1CAxA9gL2puC0EalBsanggq2IyPKFIbdwc6ajrj1EANia1vHAS1P8uzsjYtVXgmiQHEPXSHWI/vkAAAAAXhyAqgAAAAAAAAAAbXQLWug2IZ2G4RnwUrCTvIwO6TMpu21+S2UXhqLKWTFbN5y1xIzhRSB0BGtGfnWJkk8++Hk5DwLt2GKNx3YEpQAAAAkN4Lazp2QAAAAAAAAAAASwAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (8, 'a56912456a4cc335080c40f602f6a6e0b411a941b1a9e082ad88c8f28521b770', 'ce52c0545a76e90c4f9747c43f109dfe886902b7851468e059b299b17044aece', 4, 4, '2020-01-13 14:37:29', '2020-01-13 14:37:29.421838', '2020-01-13 14:37:29.421838', 34359738368, 16, 1000000000000000000, 1100, 100, 100000000, 1000000, 12, 'AAAADM5SwFRadukMT5dHxD8Qnf6IaQK3hRRo4FmymbFwRK7OZInILcieQybEAgQXiPB009oop/QyQjU8kfg9CWA4vdEAAAAAXhyAqQAAAAAAAAAA5fh0DRZ+OfeA4iH3GTMbG6cqJGEx0qC57216HbTwQPV9aAFs1FmCUniORX+XZWxIQuowmzGSXJvKJJ7TP7GuTwAAAAgN4Lazp2QAAAAAAAAAAARMAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 4, 0);
INSERT INTO history_ledgers VALUES (7, 'ce52c0545a76e90c4f9747c43f109dfe886902b7851468e059b299b17044aece', '81f0ca0aa4c0a4c729a4b9c80ed4661078fcadeaacb3f51cde940325e041f218', 1, 1, '2020-01-13 14:37:28', '2020-01-13 14:37:29.434602', '2020-01-13 14:37:29.434603', 30064771072, 16, 1000000000000000000, 700, 100, 100000000, 1000000, 12, 'AAAADIHwygqkwKTHKaS5yA7UZhB4/K3qrLP1HN6UAyXgQfIYKtXdYtqSjbL0eNWZC3Rw+fdDT0SyQpp6DBIeHrrCGI8AAAAAXhyAqAAAAAAAAAAAk5HOQp3TCIyOUj8VmNGrhs2C+IXj942pn3qPVIAXXx49HX0tc7vZQIFFo4WbbnYEcoF37rSsxQ4M5jzUJ6urRAAAAAcN4Lazp2QAAAAAAAAAAAK8AAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (6, '81f0ca0aa4c0a4c729a4b9c80ed4661078fcadeaacb3f51cde940325e041f218', 'dc469d91db9dfc552d1e2a42b6b14cfb102d86a763c429e5a836790b36380fdc', 1, 1, '2020-01-13 14:37:27', '2020-01-13 14:37:29.45305', '2020-01-13 14:37:29.45305', 25769803776, 16, 1000000000000000000, 600, 100, 100000000, 1000000, 12, 'AAAADNxGnZHbnfxVLR4qQraxTPsQLYanY8Qp5ag2eQs2OA/cbu3Ydc6yJBhuc+yEwKzgb9Gaak2tLYwPMAndv2YYfkMAAAAAXhyApwAAAAAAAAAAN8Q2AtCCsel4HIsK4udqXyLQqcraGjcAHVSUN815grGo8I60So+VzeXuMBm7QruK+BarFoUsi3nol7QK8y6iCQAAAAYN4Lazp2QAAAAAAAAAAAJYAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (5, 'dc469d91db9dfc552d1e2a42b6b14cfb102d86a763c429e5a836790b36380fdc', '74dccda56c1d703f71853fc85398331c855b4d91a9750047155ccaf04e5bc3f5', 3, 3, '2020-01-13 14:37:26', '2020-01-13 14:37:29.46486', '2020-01-13 14:37:29.464861', 21474836480, 16, 1000000000000000000, 500, 100, 100000000, 1000000, 12, 'AAAADHTczaVsHXA/cYU/yFOYMxyFW02RqXUARxVcyvBOW8P1nofuXBvsCm+cQH5txAvjGV9TQSsG/8MMCFOLcYFskM0AAAAAXhyApgAAAAAAAAAAk6vO/KRxwZ0ynJMMrKUpOSf5WhbdkNk0LIO/zZxB+qc8nuxORDCdVZYp5sokctpOjfuezdQ40y7xTjVWtAEAhAAAAAUN4Lazp2QAAAAAAAAAAAH0AAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 3, 0);
INSERT INTO history_ledgers VALUES (4, '74dccda56c1d703f71853fc85398331c855b4d91a9750047155ccaf04e5bc3f5', '0c74dca178b44d7d19c0477827fc0e6960ad4e32539daa1a7146ce8d6e2f8597', 1, 1, '2020-01-13 14:37:25', '2020-01-13 14:37:29.474719', '2020-01-13 14:37:29.474719', 17179869184, 16, 1000000000000000000, 200, 100, 100000000, 1000000, 12, 'AAAADAx03KF4tE19GcBHeCf8DmlgrU4yU52qGnFGzo1uL4WXpvhFye4ILZBZfQ3oHFOJRAuKfKNME7e39AiM7RWLeq8AAAAAXhyApQAAAAAAAAAAI8FeHEzJ0/4FO8/NG/43wTEny1CW/vcH2jcrQkzbbciJqO/x2oSqSL4JYO+rpRl1kTt2cHWJ4BSQRUisbrGVOAAAAAQN4Lazp2QAAAAAAAAAAADIAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (3, '0c74dca178b44d7d19c0477827fc0e6960ad4e32539daa1a7146ce8d6e2f8597', '7bc04006cfd84ac3e6dd968813daff1f818952c4d264d03f296dd7240d8a08f2', 1, 1, '2020-01-13 14:37:24', '2020-01-13 14:37:29.484335', '2020-01-13 14:37:29.484335', 12884901888, 16, 1000000000000000000, 100, 100, 100000000, 1000000, 12, 'AAAADHvAQAbP2ErD5t2WiBPa/x+BiVLE0mTQPylt1yQNigjyom805yCltxSTKBJwzn0P7d963C2f1w+ZlMNJKptYEYIAAAAAXhyApAAAAAIAAAAIAAAAAQAAAAwAAAAIAAAAAwAPQkAAAAAAFGs/xxdWJPvq7ID1cWZzYT0WPVQAlbYGsSn/TkimHL66RHfEtxS2FeoyZLYXlbTCm0ArcbqBV5eA1qpQ268ErwAAAAMN4Lazp2QAAAAAAAAAAABkAAAAAAAAAAAAAAAAAAAAZAX14QAAD0JAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 1, 0);
INSERT INTO history_ledgers VALUES (2, '7bc04006cfd84ac3e6dd968813daff1f818952c4d264d03f296dd7240d8a08f2', '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', 0, 0, '2020-01-13 14:37:23', '2020-01-13 14:37:29.496149', '2020-01-13 14:37:29.496149', 8589934592, 16, 1000000000000000000, 0, 100, 100000000, 100, 0, 'AAAAAGPZj1Nu5o0bJ7W4nyOvUxG3Vpok+vFAOtC1K2M7B76ZuZRHr9UdXKbTKiclfOjy72YZFJUkJPVcKT5htvorm1QAAAAAXhyAowAAAAAAAAAA3z9hmASpL9tAVxktxD3XSOp3itxSvEmM6AUkwBS4ERlzUiftOYRhKRI3aHsIRGqiybCW4MmKRi2t2lafBd0khAAAAAIN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 0, 0);
INSERT INTO history_ledgers VALUES (1, '63d98f536ee68d1b27b5b89f23af5311b7569a24faf1403ad0b52b633b07be99', NULL, 0, 0, '1970-01-01 00:00:00', '2020-01-13 14:37:29.502228', '2020-01-13 14:37:29.502228', 4294967296, 16, 1000000000000000000, 0, 100, 100000000, 100, 0, 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABXKi4y/ySKB7DnD9H20xjB+s0gtswIwz1XdSWYaBJaFgAAAAEN4Lazp2QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAX14QAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', 0, 0);


--
-- Data for Name: history_operation_participants; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_operation_participants VALUES (1, 261993009153, 1);
INSERT INTO history_operation_participants VALUES (2, 257698041857, 1);
INSERT INTO history_operation_participants VALUES (3, 253403074561, 1);
INSERT INTO history_operation_participants VALUES (4, 249108107265, 1);
INSERT INTO history_operation_participants VALUES (5, 244813139969, 2);
INSERT INTO history_operation_participants VALUES (6, 244813139969, 1);
INSERT INTO history_operation_participants VALUES (7, 240518172673, 3);
INSERT INTO history_operation_participants VALUES (8, 236223205377, 2);
INSERT INTO history_operation_participants VALUES (9, 236223205377, 3);
INSERT INTO history_operation_participants VALUES (10, 231928238081, 2);
INSERT INTO history_operation_participants VALUES (11, 231928238081, 4);
INSERT INTO history_operation_participants VALUES (12, 231928238082, 4);
INSERT INTO history_operation_participants VALUES (13, 231928238082, 2);
INSERT INTO history_operation_participants VALUES (14, 227633270785, 2);
INSERT INTO history_operation_participants VALUES (15, 227633270785, 4);
INSERT INTO history_operation_participants VALUES (16, 223338303489, 5);
INSERT INTO history_operation_participants VALUES (17, 219043336193, 5);
INSERT INTO history_operation_participants VALUES (18, 214748368897, 5);
INSERT INTO history_operation_participants VALUES (19, 210453401601, 5);
INSERT INTO history_operation_participants VALUES (20, 210453405697, 5);
INSERT INTO history_operation_participants VALUES (21, 210453409793, 5);
INSERT INTO history_operation_participants VALUES (22, 206158434305, 2);
INSERT INTO history_operation_participants VALUES (23, 206158434305, 5);
INSERT INTO history_operation_participants VALUES (24, 197568499713, 6);
INSERT INTO history_operation_participants VALUES (25, 197568503809, 2);
INSERT INTO history_operation_participants VALUES (26, 193273532417, 2);
INSERT INTO history_operation_participants VALUES (27, 193273532417, 6);
INSERT INTO history_operation_participants VALUES (28, 188978565121, 7);
INSERT INTO history_operation_participants VALUES (29, 188978565121, 2);
INSERT INTO history_operation_participants VALUES (30, 184683597825, 2);
INSERT INTO history_operation_participants VALUES (31, 184683597825, 7);
INSERT INTO history_operation_participants VALUES (32, 180388630529, 8);
INSERT INTO history_operation_participants VALUES (33, 180388630529, 9);
INSERT INTO history_operation_participants VALUES (34, 176093663233, 8);
INSERT INTO history_operation_participants VALUES (35, 176093663233, 9);
INSERT INTO history_operation_participants VALUES (36, 176093667329, 8);
INSERT INTO history_operation_participants VALUES (37, 176093667329, 9);
INSERT INTO history_operation_participants VALUES (38, 171798695937, 9);
INSERT INTO history_operation_participants VALUES (39, 171798700033, 9);
INSERT INTO history_operation_participants VALUES (40, 167503728641, 8);
INSERT INTO history_operation_participants VALUES (41, 163208761345, 2);
INSERT INTO history_operation_participants VALUES (42, 163208761345, 9);
INSERT INTO history_operation_participants VALUES (43, 163208765441, 8);
INSERT INTO history_operation_participants VALUES (44, 163208765441, 2);
INSERT INTO history_operation_participants VALUES (45, 158913794049, 10);
INSERT INTO history_operation_participants VALUES (46, 154618826753, 10);
INSERT INTO history_operation_participants VALUES (47, 150323859457, 10);
INSERT INTO history_operation_participants VALUES (48, 146028892161, 10);
INSERT INTO history_operation_participants VALUES (49, 141733924865, 2);
INSERT INTO history_operation_participants VALUES (50, 141733924865, 10);
INSERT INTO history_operation_participants VALUES (51, 137438957569, 11);
INSERT INTO history_operation_participants VALUES (52, 137438961665, 11);
INSERT INTO history_operation_participants VALUES (53, 133143990273, 11);
INSERT INTO history_operation_participants VALUES (54, 128849022977, 11);
INSERT INTO history_operation_participants VALUES (55, 124554055681, 11);
INSERT INTO history_operation_participants VALUES (56, 120259088385, 11);
INSERT INTO history_operation_participants VALUES (57, 120259092481, 11);
INSERT INTO history_operation_participants VALUES (58, 120259096577, 11);
INSERT INTO history_operation_participants VALUES (59, 120259100673, 11);
INSERT INTO history_operation_participants VALUES (60, 120259104769, 11);
INSERT INTO history_operation_participants VALUES (61, 120259108865, 11);
INSERT INTO history_operation_participants VALUES (62, 120259112961, 11);
INSERT INTO history_operation_participants VALUES (63, 115964121089, 2);
INSERT INTO history_operation_participants VALUES (64, 115964121089, 11);
INSERT INTO history_operation_participants VALUES (65, 111669153793, 12);
INSERT INTO history_operation_participants VALUES (66, 111669157889, 12);
INSERT INTO history_operation_participants VALUES (67, 107374186497, 2);
INSERT INTO history_operation_participants VALUES (68, 107374186497, 12);
INSERT INTO history_operation_participants VALUES (69, 103079219201, 14);
INSERT INTO history_operation_participants VALUES (70, 98784251905, 13);
INSERT INTO history_operation_participants VALUES (71, 94489284609, 13);
INSERT INTO history_operation_participants VALUES (72, 90194317313, 2);
INSERT INTO history_operation_participants VALUES (73, 90194317313, 13);
INSERT INTO history_operation_participants VALUES (74, 90194321409, 2);
INSERT INTO history_operation_participants VALUES (75, 90194321409, 14);
INSERT INTO history_operation_participants VALUES (76, 85899350017, 17);
INSERT INTO history_operation_participants VALUES (77, 85899350017, 16);
INSERT INTO history_operation_participants VALUES (78, 81604382721, 16);
INSERT INTO history_operation_participants VALUES (79, 81604382721, 17);
INSERT INTO history_operation_participants VALUES (80, 77309415425, 15);
INSERT INTO history_operation_participants VALUES (81, 77309415425, 16);
INSERT INTO history_operation_participants VALUES (82, 77309419521, 15);
INSERT INTO history_operation_participants VALUES (83, 77309423617, 15);
INSERT INTO history_operation_participants VALUES (84, 73014448129, 16);
INSERT INTO history_operation_participants VALUES (85, 73014452225, 17);
INSERT INTO history_operation_participants VALUES (86, 68719480833, 2);
INSERT INTO history_operation_participants VALUES (87, 68719480833, 16);
INSERT INTO history_operation_participants VALUES (88, 68719484929, 2);
INSERT INTO history_operation_participants VALUES (89, 68719484929, 17);
INSERT INTO history_operation_participants VALUES (90, 68719489025, 2);
INSERT INTO history_operation_participants VALUES (91, 68719489025, 15);
INSERT INTO history_operation_participants VALUES (92, 64424513537, 19);
INSERT INTO history_operation_participants VALUES (93, 64424513537, 18);
INSERT INTO history_operation_participants VALUES (94, 60129546241, 18);
INSERT INTO history_operation_participants VALUES (95, 60129550337, 19);
INSERT INTO history_operation_participants VALUES (96, 60129550337, 18);
INSERT INTO history_operation_participants VALUES (97, 55834578945, 2);
INSERT INTO history_operation_participants VALUES (98, 55834578945, 19);
INSERT INTO history_operation_participants VALUES (99, 55834583041, 2);
INSERT INTO history_operation_participants VALUES (100, 55834583041, 18);
INSERT INTO history_operation_participants VALUES (101, 51539611649, 21);
INSERT INTO history_operation_participants VALUES (102, 51539611649, 20);
INSERT INTO history_operation_participants VALUES (103, 47244644353, 2);
INSERT INTO history_operation_participants VALUES (104, 47244644353, 21);
INSERT INTO history_operation_participants VALUES (105, 42949677057, 22);
INSERT INTO history_operation_participants VALUES (106, 42949677057, 2);
INSERT INTO history_operation_participants VALUES (107, 42949677058, 22);
INSERT INTO history_operation_participants VALUES (108, 42949677058, 2);
INSERT INTO history_operation_participants VALUES (109, 38654709761, 2);
INSERT INTO history_operation_participants VALUES (110, 38654709761, 22);
INSERT INTO history_operation_participants VALUES (111, 34359742465, 2);
INSERT INTO history_operation_participants VALUES (112, 34359742465, 23);
INSERT INTO history_operation_participants VALUES (113, 34359746561, 23);
INSERT INTO history_operation_participants VALUES (114, 34359746561, 2);
INSERT INTO history_operation_participants VALUES (115, 34359750657, 23);
INSERT INTO history_operation_participants VALUES (116, 34359750657, 2);
INSERT INTO history_operation_participants VALUES (117, 34359754753, 23);
INSERT INTO history_operation_participants VALUES (118, 34359754753, 2);
INSERT INTO history_operation_participants VALUES (119, 30064775169, 2);
INSERT INTO history_operation_participants VALUES (120, 30064775169, 23);
INSERT INTO history_operation_participants VALUES (121, 25769807873, 24);
INSERT INTO history_operation_participants VALUES (122, 21474840577, 24);
INSERT INTO history_operation_participants VALUES (123, 21474844673, 24);
INSERT INTO history_operation_participants VALUES (124, 21474848769, 24);
INSERT INTO history_operation_participants VALUES (125, 17179873281, 2);
INSERT INTO history_operation_participants VALUES (126, 17179873281, 24);
INSERT INTO history_operation_participants VALUES (127, 12884905985, 2);
INSERT INTO history_operation_participants VALUES (128, 12884905985, 25);


--
-- Name: history_operation_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_operation_participants_id_seq', 128, true);


--
-- Data for Name: history_operations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_operations VALUES (261993009153, 261993009152, 1, 11, '{"bump_to": "300000000003"}', 'GCQZP3IU7XU6EJ63JZXKCQOYT2RNXN3HB5CNHENNUEUHSMA4VUJJJSEN');
INSERT INTO history_operations VALUES (257698041857, 257698041856, 1, 11, '{"bump_to": "300000000001"}', 'GCQZP3IU7XU6EJ63JZXKCQOYT2RNXN3HB5CNHENNUEUHSMA4VUJJJSEN');
INSERT INTO history_operations VALUES (253403074561, 253403074560, 1, 11, '{"bump_to": "100"}', 'GCQZP3IU7XU6EJ63JZXKCQOYT2RNXN3HB5CNHENNUEUHSMA4VUJJJSEN');
INSERT INTO history_operations VALUES (249108107265, 249108107264, 1, 11, '{"bump_to": "300000000000"}', 'GCQZP3IU7XU6EJ63JZXKCQOYT2RNXN3HB5CNHENNUEUHSMA4VUJJJSEN');
INSERT INTO history_operations VALUES (244813139969, 244813139968, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GCQZP3IU7XU6EJ63JZXKCQOYT2RNXN3HB5CNHENNUEUHSMA4VUJJJSEN", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (240518172673, 240518172672, 1, 1, '{"to": "GANFZDRBCNTUXIODCJEYMACPMCSZEVE4WZGZ3CZDZ3P2SXK4KH75IK6Y", "from": "GANFZDRBCNTUXIODCJEYMACPMCSZEVE4WZGZ3CZDZ3P2SXK4KH75IK6Y", "amount": "10.0000000", "asset_type": "native"}', 'GANFZDRBCNTUXIODCJEYMACPMCSZEVE4WZGZ3CZDZ3P2SXK4KH75IK6Y');
INSERT INTO history_operations VALUES (236223205377, 236223205376, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GANFZDRBCNTUXIODCJEYMACPMCSZEVE4WZGZ3CZDZ3P2SXK4KH75IK6Y", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (231928238081, 231928238080, 1, 1, '{"to": "GACJPE4YUR22VP4CM2BDFDAHY3DLEF3H7NENKUQ53DT5TEI2GAHT5N4X", "from": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "amount": "10.0000000", "asset_type": "native"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (231928238082, 231928238080, 2, 1, '{"to": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "from": "GACJPE4YUR22VP4CM2BDFDAHY3DLEF3H7NENKUQ53DT5TEI2GAHT5N4X", "amount": "10.0000000", "asset_type": "native"}', 'GACJPE4YUR22VP4CM2BDFDAHY3DLEF3H7NENKUQ53DT5TEI2GAHT5N4X');
INSERT INTO history_operations VALUES (227633270785, 227633270784, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GACJPE4YUR22VP4CM2BDFDAHY3DLEF3H7NENKUQ53DT5TEI2GAHT5N4X", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (223338303489, 223338303488, 1, 10, '{"name": "name1", "value": "MDAwMA=="}', 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD');
INSERT INTO history_operations VALUES (219043336193, 219043336192, 1, 10, '{"name": "name1", "value": "MTIzNA=="}', 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD');
INSERT INTO history_operations VALUES (214748368897, 214748368896, 1, 10, '{"name": "name2", "value": null}', 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD');
INSERT INTO history_operations VALUES (210453401601, 210453401600, 1, 10, '{"name": "name1", "value": "MTIzNA=="}', 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD');
INSERT INTO history_operations VALUES (210453405697, 210453405696, 1, 10, '{"name": "name2", "value": "NTY3OA=="}', 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD');
INSERT INTO history_operations VALUES (210453409793, 210453409792, 1, 10, '{"name": "name ", "value": "aXRzIGdvdCBzcGFjZXMh"}', 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD');
INSERT INTO history_operations VALUES (206158434305, 206158434304, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (197568499713, 197568499712, 1, 5, '{"inflation_dest": "GDR53WAEIKOU3ZKN34CSHAWH7HV6K63CBJRUTWUDBFSMY7RRQK3SPKOS"}', 'GDR53WAEIKOU3ZKN34CSHAWH7HV6K63CBJRUTWUDBFSMY7RRQK3SPKOS');
INSERT INTO history_operations VALUES (197568503809, 197568503808, 1, 5, '{"inflation_dest": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (193273532417, 193273532416, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GDR53WAEIKOU3ZKN34CSHAWH7HV6K63CBJRUTWUDBFSMY7RRQK3SPKOS", "starting_balance": "20000000000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (188978565121, 188978565120, 1, 8, '{"into": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GCHPXGVDKPF5KT4CNAT7X77OXYZ7YVE4JHKFDUHCGCVWCL4K4PQ67KKZ"}', 'GCHPXGVDKPF5KT4CNAT7X77OXYZ7YVE4JHKFDUHCGCVWCL4K4PQ67KKZ');
INSERT INTO history_operations VALUES (184683597825, 184683597824, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GCHPXGVDKPF5KT4CNAT7X77OXYZ7YVE4JHKFDUHCGCVWCL4K4PQ67KKZ", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (180388630529, 180388630528, 1, 7, '{"trustee": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF", "trustor": "GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG", "authorize": false, "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF"}', 'GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF');
INSERT INTO history_operations VALUES (176093663233, 176093663232, 1, 7, '{"trustee": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF", "trustor": "GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG", "authorize": true, "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF"}', 'GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF');
INSERT INTO history_operations VALUES (176093667329, 176093667328, 1, 7, '{"trustee": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF", "trustor": "GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG", "authorize": true, "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF"}', 'GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF');
INSERT INTO history_operations VALUES (171798695937, 171798695936, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF", "trustor": "GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF"}', 'GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG');
INSERT INTO history_operations VALUES (171798700033, 171798700032, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF", "trustor": "GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF"}', 'GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG');
INSERT INTO history_operations VALUES (167503728641, 167503728640, 1, 5, '{"set_flags": [1, 2], "set_flags_s": ["auth_required", "auth_revocable"]}', 'GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF');
INSERT INTO history_operations VALUES (163208761345, 163208761344, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (163208765441, 163208765440, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (30064775169, 30064775168, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (158913794049, 158913794048, 1, 6, '{"limit": "0.0000000", "trustee": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "trustor": "GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"}', 'GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG');
INSERT INTO history_operations VALUES (154618826753, 154618826752, 1, 6, '{"limit": "100.0000000", "trustee": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "trustor": "GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"}', 'GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG');
INSERT INTO history_operations VALUES (150323859457, 150323859456, 1, 6, '{"limit": "100.0000000", "trustee": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "trustor": "GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"}', 'GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG');
INSERT INTO history_operations VALUES (146028892161, 146028892160, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "trustor": "GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"}', 'GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG');
INSERT INTO history_operations VALUES (141733924865, 141733924864, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (137438957569, 137438957568, 1, 5, '{"clear_flags": [1, 2], "clear_flags_s": ["auth_required", "auth_revocable"]}', 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_operations VALUES (137438961665, 137438961664, 1, 5, '{"signer_key": "GB6J3WOLKYQE6KVDZEA4JDMFTTONUYP3PUHNDNZRWIKA6JQWIMJZATFE", "signer_weight": 0}', 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_operations VALUES (133143990273, 133143990272, 1, 5, '{"signer_key": "GB6J3WOLKYQE6KVDZEA4JDMFTTONUYP3PUHNDNZRWIKA6JQWIMJZATFE", "signer_weight": 5}', 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_operations VALUES (128849022977, 128849022976, 1, 5, '{"signer_key": "GB6J3WOLKYQE6KVDZEA4JDMFTTONUYP3PUHNDNZRWIKA6JQWIMJZATFE", "signer_weight": 1}', 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_operations VALUES (124554055681, 124554055680, 1, 5, '{"master_key_weight": 2}', 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_operations VALUES (120259088385, 120259088384, 1, 5, '{"inflation_dest": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"}', 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_operations VALUES (120259092481, 120259092480, 1, 5, '{"set_flags": [1], "set_flags_s": ["auth_required"]}', 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_operations VALUES (120259096577, 120259096576, 1, 5, '{"set_flags": [2], "set_flags_s": ["auth_revocable"]}', 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_operations VALUES (120259100673, 120259100672, 1, 5, '{"master_key_weight": 2}', 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_operations VALUES (120259104769, 120259104768, 1, 5, '{"low_threshold": 0, "med_threshold": 2, "high_threshold": 2}', 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_operations VALUES (120259108865, 120259108864, 1, 5, '{"home_domain": "example.com"}', 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_operations VALUES (120259112961, 120259112960, 1, 5, '{"signer_key": "GB6J3WOLKYQE6KVDZEA4JDMFTTONUYP3PUHNDNZRWIKA6JQWIMJZATFE", "signer_weight": 1}', 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES');
INSERT INTO history_operations VALUES (115964121089, 115964121088, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (111669153793, 111669153792, 1, 4, '{"price": "1.0000000", "amount": "200.0000000", "price_r": {"d": 1, "n": 1}, "buying_asset_type": "native", "selling_asset_code": "USD", "selling_asset_type": "credit_alphanum4", "selling_asset_issuer": "GB6GN3LJUW6JYR7EDOJ47VBH7D45M4JWHXGK6LHJRAEI5JBSN2DBQY7Q"}', 'GB6GN3LJUW6JYR7EDOJ47VBH7D45M4JWHXGK6LHJRAEI5JBSN2DBQY7Q');
INSERT INTO history_operations VALUES (111669157889, 111669157888, 1, 4, '{"price": "1.0000000", "amount": "200.0000000", "price_r": {"d": 1, "n": 1}, "buying_asset_code": "USD", "buying_asset_type": "credit_alphanum4", "selling_asset_type": "native", "buying_asset_issuer": "GB6GN3LJUW6JYR7EDOJ47VBH7D45M4JWHXGK6LHJRAEI5JBSN2DBQY7Q"}', 'GB6GN3LJUW6JYR7EDOJ47VBH7D45M4JWHXGK6LHJRAEI5JBSN2DBQY7Q');
INSERT INTO history_operations VALUES (107374186497, 107374186496, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GB6GN3LJUW6JYR7EDOJ47VBH7D45M4JWHXGK6LHJRAEI5JBSN2DBQY7Q", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (103079219201, 103079219200, 1, 3, '{"price": "1.0000000", "amount": "30.0000000", "price_r": {"d": 1, "n": 1}, "offer_id": 0, "buying_asset_type": "native", "selling_asset_code": "USD", "selling_asset_type": "credit_alphanum4", "selling_asset_issuer": "GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD"}', 'GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD');
INSERT INTO history_operations VALUES (98784251905, 98784251904, 1, 3, '{"price": "1.0000000", "amount": "20.0000000", "price_r": {"d": 1, "n": 1}, "offer_id": 0, "buying_asset_code": "USD", "buying_asset_type": "credit_alphanum4", "selling_asset_type": "native", "buying_asset_issuer": "GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD"}', 'GBOK7BOUSOWPHBANBYM6MIRYZJIDIPUYJPXHTHADF75UEVIVYWHHONQC');
INSERT INTO history_operations VALUES (94489284609, 94489284608, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD", "trustor": "GBOK7BOUSOWPHBANBYM6MIRYZJIDIPUYJPXHTHADF75UEVIVYWHHONQC", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD"}', 'GBOK7BOUSOWPHBANBYM6MIRYZJIDIPUYJPXHTHADF75UEVIVYWHHONQC');
INSERT INTO history_operations VALUES (90194317313, 90194317312, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GBOK7BOUSOWPHBANBYM6MIRYZJIDIPUYJPXHTHADF75UEVIVYWHHONQC", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (90194321409, 90194321408, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (85899350017, 85899350016, 1, 2, '{"to": "GACAR2AEYEKITE2LKI5RMXF5MIVZ6Q7XILROGDT22O7JX4DSWFS7FDDP", "from": "GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD", "path": [], "amount": "100.0000000", "asset_code": "EUR", "asset_type": "credit_alphanum4", "source_max": "100.0000000", "asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU", "source_amount": "100.0000000", "source_asset_type": "native"}', 'GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD');
INSERT INTO history_operations VALUES (81604382721, 81604382720, 1, 2, '{"to": "GACAR2AEYEKITE2LKI5RMXF5MIVZ6Q7XILROGDT22O7JX4DSWFS7FDDP", "from": "GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD", "path": [{"asset_type": "native"}], "amount": "200.0000000", "asset_code": "EUR", "asset_type": "credit_alphanum4", "source_max": "100.0000000", "asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU", "source_amount": "100.0000000", "source_asset_code": "USD", "source_asset_type": "credit_alphanum4", "source_asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}', 'GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD');
INSERT INTO history_operations VALUES (77309415425, 77309415424, 1, 1, '{"to": "GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD", "from": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU", "amount": "100.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}', 'GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU');
INSERT INTO history_operations VALUES (77309419521, 77309419520, 1, 3, '{"price": "0.5000000", "amount": "400.0000000", "price_r": {"d": 2, "n": 1}, "offer_id": 0, "buying_asset_code": "USD", "buying_asset_type": "credit_alphanum4", "selling_asset_type": "native", "buying_asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}', 'GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU');
INSERT INTO history_operations VALUES (77309423617, 77309423616, 1, 3, '{"price": "1.0000000", "amount": "300.0000000", "price_r": {"d": 1, "n": 1}, "offer_id": 0, "buying_asset_type": "native", "selling_asset_code": "EUR", "selling_asset_type": "credit_alphanum4", "selling_asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}', 'GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU');
INSERT INTO history_operations VALUES (73014448129, 73014448128, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU", "trustor": "GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}', 'GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD');
INSERT INTO history_operations VALUES (73014452225, 73014452224, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU", "trustor": "GACAR2AEYEKITE2LKI5RMXF5MIVZ6Q7XILROGDT22O7JX4DSWFS7FDDP", "asset_code": "EUR", "asset_type": "credit_alphanum4", "asset_issuer": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU"}', 'GACAR2AEYEKITE2LKI5RMXF5MIVZ6Q7XILROGDT22O7JX4DSWFS7FDDP');
INSERT INTO history_operations VALUES (68719480833, 68719480832, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (68719484929, 68719484928, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GACAR2AEYEKITE2LKI5RMXF5MIVZ6Q7XILROGDT22O7JX4DSWFS7FDDP", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (68719489025, 68719489024, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (64424513537, 64424513536, 1, 1, '{"to": "GANZGPKY5WSHWG5YOZMNG52GCK5SCJ4YGUWMJJVGZSK2FP4BI2JIJN2C", "from": "GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG", "amount": "10.0000000", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG"}', 'GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG');
INSERT INTO history_operations VALUES (60129546241, 60129546240, 1, 6, '{"limit": "922337203685.4775807", "trustee": "GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG", "trustor": "GANZGPKY5WSHWG5YOZMNG52GCK5SCJ4YGUWMJJVGZSK2FP4BI2JIJN2C", "asset_code": "USD", "asset_type": "credit_alphanum4", "asset_issuer": "GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG"}', 'GANZGPKY5WSHWG5YOZMNG52GCK5SCJ4YGUWMJJVGZSK2FP4BI2JIJN2C');
INSERT INTO history_operations VALUES (60129550337, 60129550336, 1, 1, '{"to": "GANZGPKY5WSHWG5YOZMNG52GCK5SCJ4YGUWMJJVGZSK2FP4BI2JIJN2C", "from": "GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG", "amount": "10.0000000", "asset_type": "native"}', 'GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG');
INSERT INTO history_operations VALUES (55834578945, 55834578944, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (55834583041, 55834583040, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GANZGPKY5WSHWG5YOZMNG52GCK5SCJ4YGUWMJJVGZSK2FP4BI2JIJN2C", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (51539611649, 51539611648, 1, 0, '{"funder": "GDCVTBGSEEU7KLXUMHMSXBALXJ2T4I2KOPXW2S5TRLKDRIAXD5UDHAYO", "account": "GCB7FPYGLL6RJ37HKRAYW5TAWMFBGGFGM4IM6ERBCZXI2BZ4OOOX2UAY", "starting_balance": "50.0000000"}', 'GDCVTBGSEEU7KLXUMHMSXBALXJ2T4I2KOPXW2S5TRLKDRIAXD5UDHAYO');
INSERT INTO history_operations VALUES (47244644353, 47244644352, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GDCVTBGSEEU7KLXUMHMSXBALXJ2T4I2KOPXW2S5TRLKDRIAXD5UDHAYO", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (42949677057, 42949677056, 1, 1, '{"to": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "from": "GAG52TW6QAB6TGNMOTL32Y4M3UQQLNNNHPEHYAIYRP6SFF6ZAVRF5ZQY", "amount": "10.0000000", "asset_type": "native"}', 'GAG52TW6QAB6TGNMOTL32Y4M3UQQLNNNHPEHYAIYRP6SFF6ZAVRF5ZQY');
INSERT INTO history_operations VALUES (42949677058, 42949677056, 2, 1, '{"to": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "from": "GAG52TW6QAB6TGNMOTL32Y4M3UQQLNNNHPEHYAIYRP6SFF6ZAVRF5ZQY", "amount": "10.0000000", "asset_type": "native"}', 'GAG52TW6QAB6TGNMOTL32Y4M3UQQLNNNHPEHYAIYRP6SFF6ZAVRF5ZQY');
INSERT INTO history_operations VALUES (38654709761, 38654709760, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GAG52TW6QAB6TGNMOTL32Y4M3UQQLNNNHPEHYAIYRP6SFF6ZAVRF5ZQY", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (34359742465, 34359742464, 1, 1, '{"to": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "from": "GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB", "amount": "1.0000000", "asset_type": "native"}', 'GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB');
INSERT INTO history_operations VALUES (34359746561, 34359746560, 1, 1, '{"to": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "from": "GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB", "amount": "1.0000000", "asset_type": "native"}', 'GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB');
INSERT INTO history_operations VALUES (34359750657, 34359750656, 1, 1, '{"to": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "from": "GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB", "amount": "1.0000000", "asset_type": "native"}', 'GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB');
INSERT INTO history_operations VALUES (34359754753, 34359754752, 1, 1, '{"to": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "from": "GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB", "amount": "1.0000000", "asset_type": "native"}', 'GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB');
INSERT INTO history_operations VALUES (25769807873, 25769807872, 1, 5, '{"master_key_weight": 2}', 'GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB');
INSERT INTO history_operations VALUES (21474840577, 21474840576, 1, 5, '{"master_key_weight": 1}', 'GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB');
INSERT INTO history_operations VALUES (21474844673, 21474844672, 1, 5, '{"signer_key": "GD3E7HKMRNT6HGBGHBT6I6JE4N2S4W5KZ246TGJ4KQSXJ2P4BXCUPQMP", "signer_weight": 1}', 'GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB');
INSERT INTO history_operations VALUES (21474848769, 21474848768, 1, 5, '{"low_threshold": 2, "med_threshold": 2, "high_threshold": 2}', 'GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB');
INSERT INTO history_operations VALUES (17179873281, 17179873280, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');
INSERT INTO history_operations VALUES (12884905985, 12884905984, 1, 0, '{"funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H", "account": "GAXI33UCLQTCKM2NMRBS7XYBR535LLEVAHL5YBN4FTCB4HZHT7ZA5CVK", "starting_balance": "1000.0000000"}', 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H');


--
-- Data for Name: history_trades; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_trades VALUES (103079219201, 0, '2020-01-13 14:37:45', 3, 13, 1, 200000000, 14, 2, 200000000, true, 1, 1, 3, 4);
INSERT INTO history_trades VALUES (85899350017, 0, '2020-01-13 14:37:41', 2, 16, 1, 1000000000, 15, 3, 1000000000, false, 1, 1, 4611686104326737921, 2);
INSERT INTO history_trades VALUES (81604382721, 0, '2020-01-13 14:37:40', 1, 15, 1, 2000000000, 16, 4, 1000000000, true, 1, 2, 1, 4611686100031770625);
INSERT INTO history_trades VALUES (81604382721, 1, '2020-01-13 14:37:40', 2, 16, 1, 2000000000, 15, 3, 2000000000, false, 1, 1, 4611686100031770625, 2);


--
-- Data for Name: history_transaction_participants; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_transaction_participants VALUES (1, 261993009152, 1);
INSERT INTO history_transaction_participants VALUES (2, 257698041856, 1);
INSERT INTO history_transaction_participants VALUES (3, 253403074560, 1);
INSERT INTO history_transaction_participants VALUES (4, 249108107264, 1);
INSERT INTO history_transaction_participants VALUES (5, 244813139968, 2);
INSERT INTO history_transaction_participants VALUES (6, 244813139968, 1);
INSERT INTO history_transaction_participants VALUES (7, 240518172672, 3);
INSERT INTO history_transaction_participants VALUES (8, 236223205376, 2);
INSERT INTO history_transaction_participants VALUES (9, 236223205376, 3);
INSERT INTO history_transaction_participants VALUES (10, 231928238080, 2);
INSERT INTO history_transaction_participants VALUES (11, 231928238080, 4);
INSERT INTO history_transaction_participants VALUES (12, 227633270784, 2);
INSERT INTO history_transaction_participants VALUES (13, 227633270784, 4);
INSERT INTO history_transaction_participants VALUES (14, 223338303488, 5);
INSERT INTO history_transaction_participants VALUES (15, 219043336192, 5);
INSERT INTO history_transaction_participants VALUES (16, 214748368896, 5);
INSERT INTO history_transaction_participants VALUES (17, 210453401600, 5);
INSERT INTO history_transaction_participants VALUES (18, 210453405696, 5);
INSERT INTO history_transaction_participants VALUES (19, 210453409792, 5);
INSERT INTO history_transaction_participants VALUES (20, 206158434304, 2);
INSERT INTO history_transaction_participants VALUES (21, 206158434304, 5);
INSERT INTO history_transaction_participants VALUES (22, 197568499712, 6);
INSERT INTO history_transaction_participants VALUES (23, 197568503808, 2);
INSERT INTO history_transaction_participants VALUES (24, 193273532416, 2);
INSERT INTO history_transaction_participants VALUES (25, 193273532416, 6);
INSERT INTO history_transaction_participants VALUES (26, 188978565120, 7);
INSERT INTO history_transaction_participants VALUES (27, 188978565120, 2);
INSERT INTO history_transaction_participants VALUES (28, 184683597824, 2);
INSERT INTO history_transaction_participants VALUES (29, 184683597824, 7);
INSERT INTO history_transaction_participants VALUES (30, 180388630528, 8);
INSERT INTO history_transaction_participants VALUES (31, 180388630528, 9);
INSERT INTO history_transaction_participants VALUES (32, 176093663232, 8);
INSERT INTO history_transaction_participants VALUES (33, 176093663232, 9);
INSERT INTO history_transaction_participants VALUES (34, 176093667328, 8);
INSERT INTO history_transaction_participants VALUES (35, 176093667328, 9);
INSERT INTO history_transaction_participants VALUES (36, 171798695936, 9);
INSERT INTO history_transaction_participants VALUES (37, 171798700032, 9);
INSERT INTO history_transaction_participants VALUES (38, 167503728640, 8);
INSERT INTO history_transaction_participants VALUES (39, 163208761344, 2);
INSERT INTO history_transaction_participants VALUES (40, 163208761344, 9);
INSERT INTO history_transaction_participants VALUES (41, 163208765440, 2);
INSERT INTO history_transaction_participants VALUES (42, 163208765440, 8);
INSERT INTO history_transaction_participants VALUES (43, 158913794048, 10);
INSERT INTO history_transaction_participants VALUES (44, 154618826752, 10);
INSERT INTO history_transaction_participants VALUES (45, 150323859456, 10);
INSERT INTO history_transaction_participants VALUES (46, 146028892160, 10);
INSERT INTO history_transaction_participants VALUES (47, 141733924864, 2);
INSERT INTO history_transaction_participants VALUES (48, 141733924864, 10);
INSERT INTO history_transaction_participants VALUES (49, 137438957568, 11);
INSERT INTO history_transaction_participants VALUES (50, 137438961664, 11);
INSERT INTO history_transaction_participants VALUES (51, 133143990272, 11);
INSERT INTO history_transaction_participants VALUES (52, 128849022976, 11);
INSERT INTO history_transaction_participants VALUES (53, 124554055680, 11);
INSERT INTO history_transaction_participants VALUES (54, 120259088384, 11);
INSERT INTO history_transaction_participants VALUES (55, 120259092480, 11);
INSERT INTO history_transaction_participants VALUES (56, 120259096576, 11);
INSERT INTO history_transaction_participants VALUES (57, 120259100672, 11);
INSERT INTO history_transaction_participants VALUES (58, 120259104768, 11);
INSERT INTO history_transaction_participants VALUES (59, 120259108864, 11);
INSERT INTO history_transaction_participants VALUES (60, 120259112960, 11);
INSERT INTO history_transaction_participants VALUES (61, 115964121088, 2);
INSERT INTO history_transaction_participants VALUES (62, 115964121088, 11);
INSERT INTO history_transaction_participants VALUES (63, 111669153792, 12);
INSERT INTO history_transaction_participants VALUES (64, 111669157888, 12);
INSERT INTO history_transaction_participants VALUES (65, 107374186496, 2);
INSERT INTO history_transaction_participants VALUES (66, 107374186496, 12);
INSERT INTO history_transaction_participants VALUES (67, 103079219200, 14);
INSERT INTO history_transaction_participants VALUES (68, 98784251904, 13);
INSERT INTO history_transaction_participants VALUES (69, 94489284608, 13);
INSERT INTO history_transaction_participants VALUES (70, 90194317312, 2);
INSERT INTO history_transaction_participants VALUES (71, 90194317312, 13);
INSERT INTO history_transaction_participants VALUES (72, 90194321408, 2);
INSERT INTO history_transaction_participants VALUES (73, 90194321408, 14);
INSERT INTO history_transaction_participants VALUES (74, 85899350016, 16);
INSERT INTO history_transaction_participants VALUES (75, 85899350016, 17);
INSERT INTO history_transaction_participants VALUES (76, 81604382720, 16);
INSERT INTO history_transaction_participants VALUES (77, 81604382720, 17);
INSERT INTO history_transaction_participants VALUES (78, 77309415424, 15);
INSERT INTO history_transaction_participants VALUES (79, 77309415424, 16);
INSERT INTO history_transaction_participants VALUES (80, 77309419520, 15);
INSERT INTO history_transaction_participants VALUES (81, 77309423616, 15);
INSERT INTO history_transaction_participants VALUES (82, 73014448128, 16);
INSERT INTO history_transaction_participants VALUES (83, 73014452224, 17);
INSERT INTO history_transaction_participants VALUES (84, 68719480832, 2);
INSERT INTO history_transaction_participants VALUES (85, 68719480832, 16);
INSERT INTO history_transaction_participants VALUES (86, 68719484928, 2);
INSERT INTO history_transaction_participants VALUES (87, 68719484928, 17);
INSERT INTO history_transaction_participants VALUES (88, 68719489024, 2);
INSERT INTO history_transaction_participants VALUES (89, 68719489024, 15);
INSERT INTO history_transaction_participants VALUES (90, 64424513536, 19);
INSERT INTO history_transaction_participants VALUES (91, 64424513536, 18);
INSERT INTO history_transaction_participants VALUES (92, 60129546240, 18);
INSERT INTO history_transaction_participants VALUES (93, 60129550336, 19);
INSERT INTO history_transaction_participants VALUES (94, 60129550336, 18);
INSERT INTO history_transaction_participants VALUES (95, 55834578944, 2);
INSERT INTO history_transaction_participants VALUES (96, 55834578944, 19);
INSERT INTO history_transaction_participants VALUES (97, 55834583040, 2);
INSERT INTO history_transaction_participants VALUES (98, 55834583040, 18);
INSERT INTO history_transaction_participants VALUES (99, 51539611648, 21);
INSERT INTO history_transaction_participants VALUES (100, 51539611648, 20);
INSERT INTO history_transaction_participants VALUES (101, 47244644352, 2);
INSERT INTO history_transaction_participants VALUES (102, 47244644352, 21);
INSERT INTO history_transaction_participants VALUES (103, 42949677056, 22);
INSERT INTO history_transaction_participants VALUES (104, 42949677056, 2);
INSERT INTO history_transaction_participants VALUES (105, 38654709760, 2);
INSERT INTO history_transaction_participants VALUES (106, 38654709760, 22);
INSERT INTO history_transaction_participants VALUES (107, 34359742464, 23);
INSERT INTO history_transaction_participants VALUES (108, 34359742464, 2);
INSERT INTO history_transaction_participants VALUES (109, 34359746560, 23);
INSERT INTO history_transaction_participants VALUES (110, 34359746560, 2);
INSERT INTO history_transaction_participants VALUES (111, 34359750656, 23);
INSERT INTO history_transaction_participants VALUES (112, 34359750656, 2);
INSERT INTO history_transaction_participants VALUES (113, 34359754752, 23);
INSERT INTO history_transaction_participants VALUES (114, 34359754752, 2);
INSERT INTO history_transaction_participants VALUES (115, 30064775168, 2);
INSERT INTO history_transaction_participants VALUES (116, 30064775168, 23);
INSERT INTO history_transaction_participants VALUES (117, 25769807872, 24);
INSERT INTO history_transaction_participants VALUES (118, 21474840576, 24);
INSERT INTO history_transaction_participants VALUES (119, 21474844672, 24);
INSERT INTO history_transaction_participants VALUES (120, 21474848768, 24);
INSERT INTO history_transaction_participants VALUES (121, 17179873280, 2);
INSERT INTO history_transaction_participants VALUES (122, 17179873280, 24);
INSERT INTO history_transaction_participants VALUES (123, 12884905984, 2);
INSERT INTO history_transaction_participants VALUES (124, 12884905984, 25);


--
-- Name: history_transaction_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('history_transaction_participants_id_seq', 124, true);


--
-- Data for Name: history_transactions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO history_transactions VALUES ('bc11b5c41de791369fd85fa1ccf01c35c20df5f98ff2f75d02ead61bfd520e21', 61, 1, 'GCQZP3IU7XU6EJ63JZXKCQOYT2RNXN3HB5CNHENNUEUHSMA4VUJJJSEN', 300000000003, 100, 1, '2020-01-13 14:37:28.790539', '2020-01-13 14:37:28.79054', 261993009152, 'AAAAAKGX7RT96eIn205uoUHYnqLbt2cPRNORraEoeTAcrRKUAAAAZAAAAEXZZLgDAAAAAAAAAAAAAAABAAAAAAAAAAsAAABF2WS4AwAAAAAAAAABHK0SlAAAAECcI6ex0Dq6YAh6aK14jHxuAvhvKG2+NuzboAKrfYCaC1ZSQ77BYH/5MghPX97JO9WXV17ehNK7d0umxBgaJj8A', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAALAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAPQAAAAAAAAAAoZftFP3p4ifbTm6hQdieotu3Zw9E05GtoSh5MBytEpQAAAACVAvicAAAAEXZZLgCAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAPQAAAAAAAAAAoZftFP3p4ifbTm6hQdieotu3Zw9E05GtoSh5MBytEpQAAAACVAvicAAAAEXZZLgDAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAA==', 'AAAAAgAAAAMAAAA8AAAAAAAAAAChl+0U/eniJ9tObqFB2J6i27dnD0TTka2hKHkwHK0SlAAAAAJUC+LUAAAARdlkuAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA9AAAAAAAAAAChl+0U/eniJ9tObqFB2J6i27dnD0TTka2hKHkwHK0SlAAAAAJUC+JwAAAARdlkuAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{nCOnsdA6umAIemiteIx8bgL4byhtvjbs26ACq32AmgtWUkO+wWB/+TIIT1/eyTvVl1de3oTSu3dLpsQYGiY/AA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('c8132b95c0063cafd20b26d27f06c12e688609d2d9d3724b840821e861870b8e', 60, 1, 'GCQZP3IU7XU6EJ63JZXKCQOYT2RNXN3HB5CNHENNUEUHSMA4VUJJJSEN', 300000000002, 100, 1, '2020-01-13 14:37:28.809338', '2020-01-13 14:37:28.809339', 257698041856, 'AAAAAKGX7RT96eIn205uoUHYnqLbt2cPRNORraEoeTAcrRKUAAAAZAAAAEXZZLgCAAAAAAAAAAAAAAABAAAAAAAAAAsAAABF2WS4AQAAAAAAAAABHK0SlAAAAEC4H7TDntOUXDMg4MfoCPlbLRQZH7VwNpUHMvtnRWqWIiY/qnYYu0bvgYUVtoFOOeqElRKLYqtOW3Fz9iKl0WQJ', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAALAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAPAAAAAAAAAAAoZftFP3p4ifbTm6hQdieotu3Zw9E05GtoSh5MBytEpQAAAACVAvi1AAAAEXZZLgBAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAPAAAAAAAAAAAoZftFP3p4ifbTm6hQdieotu3Zw9E05GtoSh5MBytEpQAAAACVAvi1AAAAEXZZLgCAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAA==', 'AAAAAgAAAAMAAAA7AAAAAAAAAAChl+0U/eniJ9tObqFB2J6i27dnD0TTka2hKHkwHK0SlAAAAAJUC+M4AAAARdlkuAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA8AAAAAAAAAAChl+0U/eniJ9tObqFB2J6i27dnD0TTka2hKHkwHK0SlAAAAAJUC+LUAAAARdlkuAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{uB+0w57TlFwzIODH6Aj5Wy0UGR+1cDaVBzL7Z0VqliImP6p2GLtG74GFFbaBTjnqhJUSi2KrTltxc/YipdFkCQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('74b62d52311ea3f47359f74790595343f976afa4fd306caaefee5efdbbb104ff', 59, 1, 'GCQZP3IU7XU6EJ63JZXKCQOYT2RNXN3HB5CNHENNUEUHSMA4VUJJJSEN', 300000000001, 100, 1, '2020-01-13 14:37:28.821478', '2020-01-13 14:37:28.821478', 253403074560, 'AAAAAKGX7RT96eIn205uoUHYnqLbt2cPRNORraEoeTAcrRKUAAAAZAAAAEXZZLgBAAAAAAAAAAAAAAABAAAAAAAAAAsAAAAAAAAAZAAAAAAAAAABHK0SlAAAAEAOrvZSFnT3JvmT1P5lJ/lggpZe4nxH5WvJ9K/SLOD49wfqq84suncoZIn3IAf0PExMw3etu5FiDVw3c3jYYhAL', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAALAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAOwAAAAAAAAAAoZftFP3p4ifbTm6hQdieotu3Zw9E05GtoSh5MBytEpQAAAACVAvjOAAAAEXZZLgAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAOwAAAAAAAAAAoZftFP3p4ifbTm6hQdieotu3Zw9E05GtoSh5MBytEpQAAAACVAvjOAAAAEXZZLgBAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAA==', 'AAAAAgAAAAMAAAA6AAAAAAAAAAChl+0U/eniJ9tObqFB2J6i27dnD0TTka2hKHkwHK0SlAAAAAJUC+OcAAAARdlkuAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA7AAAAAAAAAAChl+0U/eniJ9tObqFB2J6i27dnD0TTka2hKHkwHK0SlAAAAAJUC+M4AAAARdlkuAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{Dq72UhZ09yb5k9T+ZSf5YIKWXuJ8R+VryfSv0izg+PcH6qvOLLp3KGSJ9yAH9DxMTMN3rbuRYg1cN3N42GIQCw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('829d53f2dceebe10af8007564b0aefde819b95734ad431df84270651e7ed8a90', 58, 1, 'GCQZP3IU7XU6EJ63JZXKCQOYT2RNXN3HB5CNHENNUEUHSMA4VUJJJSEN', 244813135873, 100, 1, '2020-01-13 14:37:28.83462', '2020-01-13 14:37:28.83462', 249108107264, 'AAAAAKGX7RT96eIn205uoUHYnqLbt2cPRNORraEoeTAcrRKUAAAAZAAAADkAAAABAAAAAAAAAAAAAAABAAAAAAAAAAsAAABF2WS4AAAAAAAAAAABHK0SlAAAAEDq0JVhKNIq9ag0sR+R/cv3d9tEuaYEm2BazIzILRdGj9alaVMZBhxoJ3ZIpP3rraCJzyoKZO+p5HBVe10a2+UG', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAALAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAOgAAAAAAAAAAoZftFP3p4ifbTm6hQdieotu3Zw9E05GtoSh5MBytEpQAAAACVAvjnAAAADkAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAOgAAAAAAAAAAoZftFP3p4ifbTm6hQdieotu3Zw9E05GtoSh5MBytEpQAAAACVAvjnAAAADkAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAA6AAAAAAAAAAChl+0U/eniJ9tObqFB2J6i27dnD0TTka2hKHkwHK0SlAAAAAJUC+OcAAAAOQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA6AAAAAAAAAAChl+0U/eniJ9tObqFB2J6i27dnD0TTka2hKHkwHK0SlAAAAAJUC+OcAAAARdlkuAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAA5AAAAAAAAAAChl+0U/eniJ9tObqFB2J6i27dnD0TTka2hKHkwHK0SlAAAAAJUC+QAAAAAOQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA6AAAAAAAAAAChl+0U/eniJ9tObqFB2J6i27dnD0TTka2hKHkwHK0SlAAAAAJUC+OcAAAAOQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{6tCVYSjSKvWoNLEfkf3L93fbRLmmBJtgWsyMyC0XRo/WpWlTGQYcaCd2SKT9662gic8qCmTvqeRwVXtdGtvlBg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('389cc515ee964e341dcef519807e9189834b58494df394ec8b7d9c3f6fe5b413', 57, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 25, 100, 1, '2020-01-13 14:37:28.848462', '2020-01-13 14:37:28.848462', 244813139968, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAZAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAoZftFP3p4ifbTm6hQdieotu3Zw9E05GtoSh5MBytEpQAAAACVAvkAAAAAAAAAAABVvwF9wAAAEC459NBUTY5sFkEl2h1E9ipjY00w+e90pAy5tp9AjLD3EL2PSNyXY0SnqsrrfPO6Fwoler6si1J1ERVpQhXAJoB', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAOQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiuUabBBdAAAAAAAAAAYAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAOQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiuUabBBdAAAAAAAAAAZAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAA5AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5RpsEF0AAAAAAAAABkAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA5AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5IVpF10AAAAAAAAABkAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAA5AAAAAAAAAAChl+0U/eniJ9tObqFB2J6i27dnD0TTka2hKHkwHK0SlAAAAAJUC+QAAAAAOQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAA3AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5RpsEHYAAAAAAAAABgAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA5AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5RpsEF0AAAAAAAAABgAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{uOfTQVE2ObBZBJdodRPYqY2NNMPnvdKQMubafQIyw9xC9j0jcl2NEp6rK63zzuhcKJXq+rItSdREVaUIVwCaAQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('2a805712c6d10f9e74bb0ccf54ae92a2b4b1e586451fe8133a2433816f6b567c', 56, 1, 'GANFZDRBCNTUXIODCJEYMACPMCSZEVE4WZGZ3CZDZ3P2SXK4KH75IK6Y', 236223201281, 100, 1, '2020-01-13 14:37:28.862022', '2020-01-13 14:37:28.862022', 240518172672, 'AAAAABpcjiETZ0uhwxJJhgBPYKWSVJy2TZ2LI87fqV1cUf/UAAAAZAAAADcAAAABAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAAGlyOIRNnS6HDEkmGAE9gpZJUnLZNnYsjzt+pXVxR/9QAAAAAAAAAAAX14QAAAAAAAAAAAVxR/9QAAABAK6pcXYMzAEmH08CZ1LWmvtNDKauhx+OImtP/Lk4hVTMJRVBOebVs5WEPj9iSrgGT0EswuDCZ2i5AEzwgGof9Ag==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAOAAAAAAAAAAAGlyOIRNnS6HDEkmGAE9gpZJUnLZNnYsjzt+pXVxR/9QAAAACVAvjnAAAADcAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAOAAAAAAAAAAAGlyOIRNnS6HDEkmGAE9gpZJUnLZNnYsjzt+pXVxR/9QAAAACVAvjnAAAADcAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAA==', 'AAAAAgAAAAMAAAA3AAAAAAAAAAAaXI4hE2dLocMSSYYAT2ClklSctk2diyPO36ldXFH/1AAAAAJUC+QAAAAANwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA4AAAAAAAAAAAaXI4hE2dLocMSSYYAT2ClklSctk2diyPO36ldXFH/1AAAAAJUC+OcAAAANwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{K6pcXYMzAEmH08CZ1LWmvtNDKauhx+OImtP/Lk4hVTMJRVBOebVs5WEPj9iSrgGT0EswuDCZ2i5AEzwgGof9Ag==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('faa970f5254ac4aeba2265f5edd9c892a72b616c28cfcb0610abefdda77898ca', 55, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 24, 100, 1, '2020-01-13 14:37:28.873427', '2020-01-13 14:37:28.873427', 236223205376, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAYAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAGlyOIRNnS6HDEkmGAE9gpZJUnLZNnYsjzt+pXVxR/9QAAAACVAvkAAAAAAAAAAABVvwF9wAAAEC7VR/FZZ73DW/v/DKVc2SqfP1W9/JD7ySBqRxqns5pjtErQNLfQNSHyr6IA9kSw68VBI4sGRojEQZgXhwjTHkP', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAANwAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiuWvbwl2AAAAAAAAAAXAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAANwAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiuWvbwl2AAAAAAAAAAYAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAA3AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5a9vCXYAAAAAAAAABgAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA3AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5RpsEHYAAAAAAAAABgAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAA3AAAAAAAAAAAaXI4hE2dLocMSSYYAT2ClklSctk2diyPO36ldXFH/1AAAAAJUC+QAAAAANwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAA2AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5a9vCY8AAAAAAAAABcAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA3AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5a9vCXYAAAAAAAAABcAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{u1UfxWWe9w1v7/wylXNkqnz9VvfyQ+8kgakcap7OaY7RK0DS30DUh8q+iAPZEsOvFQSOLBkaIxEGYF4cI0x5Dw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('a95b8ce18e80c105bf90eb05ca8cb817d7f47c05ecb74ddce28f66d80501e027', 54, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 23, 200, 2, '2020-01-13 14:37:28.884037', '2020-01-13 14:37:28.884037', 231928238080, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAyAAAAAAAAAAXAAAAAAAAAAAAAAACAAAAAAAAAAEAAAAABJeTmKR1qr+CZoIyjAfGxrIXZ/tI1VId2OfZkRowDz4AAAAAAAAAAAX14QAAAAABAAAAAASXk5ikdaq/gmaCMowHxsayF2f7SNVSHdjn2ZEaMA8+AAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAABfXhAAAAAAAAAAACVvwF9wAAAEB1XujqTJxEw6qlOrlX/YjVNqqKekjaIMOyd2TRJdpcMnw3152KdLC9R9uhsYXuEEdVRO7KD39MReGLfJiir+YIGjAPPgAAAEAOc3poxHxBoY+5oW5cPXnYQeHSIPflJOr93xqFOQFsKWPjuuYOAlJst/fO8iIBXZP327aJS5cBqSHZ8iJdaOoJ', 'AAAAAAAAAMgAAAAAAAAAAgAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAANgAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiuWvbwmPAAAAAAAAAAWAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAANgAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiuWvbwmPAAAAAAAAAAXAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAACAAAABAAAAAMAAAA1AAAAAAAAAAAEl5OYpHWqv4JmgjKMB8bGshdn+0jVUh3Y59mRGjAPPgAAAAJUC+QAAAAANQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA2AAAAAAAAAAAEl5OYpHWqv4JmgjKMB8bGshdn+0jVUh3Y59mRGjAPPgAAAAJaAcUAAAAANQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAMAAAA2AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5a9vCY8AAAAAAAAABcAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA2AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5a3xkU8AAAAAAAAABcAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAQAAAADAAAANgAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiuWt8ZFPAAAAAAAAAAXAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAANgAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiuWvbwmPAAAAAAAAAAXAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAADAAAANgAAAAAAAAAABJeTmKR1qr+CZoIyjAfGxrIXZ/tI1VId2OfZkRowDz4AAAACWgHFAAAAADUAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAANgAAAAAAAAAABJeTmKR1qr+CZoIyjAfGxrIXZ/tI1VId2OfZkRowDz4AAAACVAvkAAAAADUAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAA=', 'AAAAAgAAAAMAAAA1AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5a9vCcEAAAAAAAAABYAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA2AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5a9vCY8AAAAAAAAABYAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{dV7o6kycRMOqpTq5V/2I1TaqinpI2iDDsndk0SXaXDJ8N9edinSwvUfbobGF7hBHVUTuyg9/TEXhi3yYoq/mCA==,DnN6aMR8QaGPuaFuXD152EHh0iD35STq/d8ahTkBbClj47rmDgJSbLf3zvIiAV2T99u2iUuXAakh2fIiXWjqCQ==}', 'none', NULL, NULL, true, 200);
INSERT INTO history_transactions VALUES ('ec3d4d6084321f0342b7809d9a2fac8cd7c467ad5efdd55ef46d87698d55339a', 53, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 22, 100, 1, '2020-01-13 14:37:28.896886', '2020-01-13 14:37:28.896886', 227633270784, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAWAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAABJeTmKR1qr+CZoIyjAfGxrIXZ/tI1VId2OfZkRowDz4AAAACVAvkAAAAAAAAAAABVvwF9wAAAEA4lBHazfDbFONb6w33aPOFbbVVppPpxdzdg97i+yjMKpP959snRTvjgSVJUrbHaTKVTUflmqUyBIiPS7IuEecD', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAANQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiuZEcgLBAAAAAAAAAAVAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAANQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiuZEcgLBAAAAAAAAAAWAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAA1AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5kRyAsEAAAAAAAAABYAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA1AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5a9vCcEAAAAAAAAABYAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAA1AAAAAAAAAAAEl5OYpHWqv4JmgjKMB8bGshdn+0jVUh3Y59mRGjAPPgAAAAJUC+QAAAAANQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAwAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5kRyAtoAAAAAAAAABUAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA1AAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5kRyAsEAAAAAAAAABUAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{OJQR2s3w2xTjW+sN92jzhW21VaaT6cXc3YPe4vsozCqT/efbJ0U744ElSVK2x2kylU1H5ZqlMgSIj0uyLhHnAw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('c8a28fb25d4784f37a7a078e1feef0eb30ca64e994734625ac4ea067cc621464', 52, 1, 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD', 206158430214, 100, 1, '2020-01-13 14:37:28.908889', '2020-01-13 14:37:28.908889', 223338303488, 'AAAAADEhMVDHiYXdz5z8l73XGyrQ2RN85ZRW1uLsCNQumfsZAAAAZAAAADAAAAAGAAAAAAAAAAAAAAABAAAAAAAAAAoAAAAFbmFtZTEAAAAAAAABAAAABDAwMDAAAAAAAAAAAS6Z+xkAAABA3ExJNH79wGSRYZerPP1zMYlepMsuhoJF5vHn2gCsHmDpWfgO8VKC3BRImO+ne9spUXlVHMjEuhOHoPhl1hrMCg==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAKAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAANAAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAvhqAAAADAAAAAFAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAANAAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAvhqAAAADAAAAAGAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAzAAAAAwAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAVuYW1lMQAAAAAAAAQxMjM0AAAAAAAAAAAAAAABAAAANAAAAAMAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAAFbmFtZTEAAAAAAAAEMDAwMAAAAAAAAAAA', 'AAAAAgAAAAMAAAAzAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+IMAAAAMAAAAAUAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAA0AAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+GoAAAAMAAAAAUAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{3ExJNH79wGSRYZerPP1zMYlepMsuhoJF5vHn2gCsHmDpWfgO8VKC3BRImO+ne9spUXlVHMjEuhOHoPhl1hrMCg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('1d7833c4faab08e62609acf3714d1babe27621a2b328edf37465e99aaf389cab', 51, 1, 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD', 206158430213, 100, 1, '2020-01-13 14:37:28.921386', '2020-01-13 14:37:28.921386', 219043336192, 'AAAAADEhMVDHiYXdz5z8l73XGyrQ2RN85ZRW1uLsCNQumfsZAAAAZAAAADAAAAAFAAAAAAAAAAAAAAABAAAAAAAAAAoAAAAFbmFtZTEAAAAAAAABAAAABDEyMzQAAAAAAAAAAS6Z+xkAAABAIW4yrFdk66fgDDir7YFATEd2llOubzx/iaJcM2wkF3ouqJQN+Aziy2rVtK5AoyphokiwsYXvHS6UF9MhdnUADQ==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAKAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAMwAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAviDAAAADAAAAAEAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAMwAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAviDAAAADAAAAAFAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAxAAAAAwAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAVuYW1lMQAAAAAAAAQxMjM0AAAAAAAAAAAAAAABAAAAMwAAAAMAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAAFbmFtZTEAAAAAAAAEMTIzNAAAAAAAAAAA', 'AAAAAgAAAAMAAAAyAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+JwAAAAMAAAAAQAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAzAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+IMAAAAMAAAAAQAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{IW4yrFdk66fgDDir7YFATEd2llOubzx/iaJcM2wkF3ouqJQN+Aziy2rVtK5AoyphokiwsYXvHS6UF9MhdnUADQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('616c609047ef8f9ca908a47a47aa4bb018449c569549ad2ca60590aab74267e8', 50, 1, 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD', 206158430212, 100, 1, '2020-01-13 14:37:28.930451', '2020-01-13 14:37:28.930452', 214748368896, 'AAAAADEhMVDHiYXdz5z8l73XGyrQ2RN85ZRW1uLsCNQumfsZAAAAZAAAADAAAAAEAAAAAAAAAAAAAAABAAAAAAAAAAoAAAAFbmFtZTIAAAAAAAAAAAAAAAAAAAEumfsZAAAAQAYRZNPhJCTwjJgAJ9beE3ZO/H3kYJhYmV1pCmy7c8Zr2sKdKOmaLn4fmA5qaL+lQMKwOShtjwkZ8JHxPUd8GAk=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAKAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAMgAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAvicAAAADAAAAADAAAAAwAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAMgAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAvicAAAADAAAAAEAAAAAwAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAMAAAAxAAAAAwAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAVuYW1lMgAAAAAAAAQ1Njc4AAAAAAAAAAAAAAACAAAAAwAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAVuYW1lMgAAAAAAAAMAAAAyAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+JwAAAAMAAAAAQAAAADAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAyAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+JwAAAAMAAAAAQAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAxAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+LUAAAAMAAAAAMAAAADAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAyAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+JwAAAAMAAAAAMAAAADAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{BhFk0+EkJPCMmAAn1t4Tdk78feRgmFiZXWkKbLtzxmvawp0o6Zoufh+YDmpov6VAwrA5KG2PCRnwkfE9R3wYCQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('9fff61916716fb2550043fac968ac6c13802af5176a10fc29108fcfc445ef513', 49, 1, 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD', 206158430209, 100, 1, '2020-01-13 14:37:28.943039', '2020-01-13 14:37:28.943039', 210453401600, 'AAAAADEhMVDHiYXdz5z8l73XGyrQ2RN85ZRW1uLsCNQumfsZAAAAZAAAADAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAoAAAAFbmFtZTEAAAAAAAABAAAABDEyMzQAAAAAAAAAAS6Z+xkAAABAxKiHYYNLJiW3r5+kCJm8ucaoV7BcrEnQXFb3s1RyRyUbAkDlaCvE+RKwMZoNUfbkQUGrouyVKy1ZpUeccByqDg==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAKAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAMQAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAvi1AAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAMQAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAvi1AAAADAAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAxAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+LUAAAAMAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAxAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+LUAAAAMAAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAxAAAAAwAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAVuYW1lMQAAAAAAAAQxMjM0AAAAAAAAAAA=', 'AAAAAgAAAAMAAAAwAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+QAAAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAxAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+OcAAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{xKiHYYNLJiW3r5+kCJm8ucaoV7BcrEnQXFb3s1RyRyUbAkDlaCvE+RKwMZoNUfbkQUGrouyVKy1ZpUeccByqDg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('e4609180751e7702466a8845857df43e4d154ec84b6bad62ce507fe12f1daf99', 49, 2, 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD', 206158430210, 100, 1, '2020-01-13 14:37:28.943237', '2020-01-13 14:37:28.943237', 210453405696, 'AAAAADEhMVDHiYXdz5z8l73XGyrQ2RN85ZRW1uLsCNQumfsZAAAAZAAAADAAAAACAAAAAAAAAAAAAAABAAAAAAAAAAoAAAAFbmFtZTIAAAAAAAABAAAABDU2NzgAAAAAAAAAAS6Z+xkAAABAjxgnTRBCa0n1efZocxpEjXeITQ5sEYTVd9fowuto2kPw5eFwgVnz6OrKJwCRt5L8ylmWiATXVI3Zyfi3yTKqBA==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAKAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAMQAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAvi1AAAADAAAAABAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAMQAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAvi1AAAADAAAAACAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAxAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+LUAAAAMAAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAxAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+LUAAAAMAAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAxAAAAAwAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAVuYW1lMgAAAAAAAAQ1Njc4AAAAAAAAAAA=', 'AAAAAgAAAAMAAAAxAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+OcAAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAxAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+M4AAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{jxgnTRBCa0n1efZocxpEjXeITQ5sEYTVd9fowuto2kPw5eFwgVnz6OrKJwCRt5L8ylmWiATXVI3Zyfi3yTKqBA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('48415cd0fda9bc9aeb1f0b419bfb2997f7a2aa1b1ef2e51a0602c61104fc23cc', 49, 3, 'GAYSCMKQY6EYLXOPTT6JPPOXDMVNBWITPTSZIVWW4LWARVBOTH5RTLAD', 206158430211, 100, 1, '2020-01-13 14:37:28.943409', '2020-01-13 14:37:28.943409', 210453409792, 'AAAAADEhMVDHiYXdz5z8l73XGyrQ2RN85ZRW1uLsCNQumfsZAAAAZAAAADAAAAADAAAAAAAAAAAAAAABAAAAAAAAAAoAAAAFbmFtZSAAAAAAAAABAAAAD2l0cyBnb3Qgc3BhY2VzIQAAAAAAAAAAAS6Z+xkAAABANmYginYhX+6VAsl1JumfxkB57y2LHraWDUkR+KDxWW8l5pfTViLxx7J85KrOV0qNCY4RfasgqxF0FC3ErYceCQ==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAKAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAMQAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAvi1AAAADAAAAACAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAMQAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAvi1AAAADAAAAADAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAxAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+LUAAAAMAAAAAMAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAxAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+LUAAAAMAAAAAMAAAADAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAxAAAAAwAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAVuYW1lIAAAAAAAAA9pdHMgZ290IHNwYWNlcyEAAAAAAAAAAAA=', 'AAAAAgAAAAMAAAAxAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+M4AAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAxAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+LUAAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{NmYginYhX+6VAsl1JumfxkB57y2LHraWDUkR+KDxWW8l5pfTViLxx7J85KrOV0qNCY4RfasgqxF0FC3ErYceCQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('5fc08a4741ca751476f7e94001246e536a8b48deb253a0597f931d8a23860005', 48, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 21, 100, 1, '2020-01-13 14:37:28.956502', '2020-01-13 14:37:28.956503', 206158434304, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAVAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAMSExUMeJhd3PnPyXvdcbKtDZE3zllFbW4uwI1C6Z+xkAAAACVAvkAAAAAAAAAAABVvwF9wAAAEDBlD6ouFcUnTWLsxmzDFTPzF+3j3l+RPO+Qmi6RXqams+cPButaUG8bHV9JvmyMFowiNKd46chPBBwxNNNqsAC', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAMAAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiubZdPvaAAAAAAAAAAUAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAMAAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiubZdPvaAAAAAAAAAAVAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAwAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5tl0+9oAAAAAAAAABUAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAwAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5kRyAtoAAAAAAAAABUAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwAAAAAAAAAAAxITFQx4mF3c+c/Je91xsq0NkTfOWUVtbi7AjULpn7GQAAAAJUC+QAAAAAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAuAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5tl0+/MAAAAAAAAABQAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAwAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5tl0+9oAAAAAAAAABQAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{wZQ+qLhXFJ01i7MZswxUz8xft495fkTzvkJoukV6mprPnDwbrWlBvGx1fSb5sjBaMIjSneOnITwQcMTTTarAAg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('7207de5b75243e0b062c3833f587036b7e9f64453be49ff50f3f3fdc7516ec6b', 46, 1, 'GDR53WAEIKOU3ZKN34CSHAWH7HV6K63CBJRUTWUDBFSMY7RRQK3SPKOS', 193273528321, 100, 1, '2020-01-13 14:37:28.973911', '2020-01-13 14:37:28.973911', 197568499712, 'AAAAAOPd2ARCnU3lTd8FI4LH+evle2IKY0nagwlkzH4xgrcnAAAAZAAAAC0AAAABAAAAAAAAAAAAAAABAAAAAAAAAAUAAAABAAAAAOPd2ARCnU3lTd8FI4LH+evle2IKY0nagwlkzH4xgrcnAAAAAQAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABMYK3JwAAAEAOkGOPTOBDSQ7nW2Zn+bls2PDUebk2/k3/gqHKQ8eYOFsD6nBeEvyMD858vo5BabjQwB9injABIM8esDh7bEkC', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAALgAAAAAAAAAA493YBEKdTeVN3wUjgsf56+V7YgpjSdqDCWTMfjGCtycCxorwuxP/nAAAAC0AAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAALgAAAAAAAAAA493YBEKdTeVN3wUjgsf56+V7YgpjSdqDCWTMfjGCtycCxorwuxP/nAAAAC0AAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAuAAAAAAAAAADj3dgEQp1N5U3fBSOCx/nr5XtiCmNJ2oMJZMx+MYK3JwLGivC7E/+cAAAALQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAuAAAAAAAAAADj3dgEQp1N5U3fBSOCx/nr5XtiCmNJ2oMJZMx+MYK3JwLGivC7E/+cAAAALQAAAAEAAAAAAAAAAQAAAADj3dgEQp1N5U3fBSOCx/nr5XtiCmNJ2oMJZMx+MYK3JwAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAtAAAAAAAAAADj3dgEQp1N5U3fBSOCx/nr5XtiCmNJ2oMJZMx+MYK3JwLGivC7FAAAAAAALQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAuAAAAAAAAAADj3dgEQp1N5U3fBSOCx/nr5XtiCmNJ2oMJZMx+MYK3JwLGivC7E/+cAAAALQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{DpBjj0zgQ0kO51tmZ/m5bNjw1Hm5Nv5N/4KhykPHmDhbA+pwXhL8jA/OfL6OQWm40MAfYp4wASDPHrA4e2xJAg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('d24f486bd722fd1875b843839e880bdeea324e25db706a26af5e4daa8c5071eb', 46, 2, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 20, 100, 1, '2020-01-13 14:37:28.974048', '2020-01-13 14:37:28.974048', 197568503808, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAUAAAAAAAAAAAAAAABAAAAAAAAAAUAAAABAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAQAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABVvwF9wAAAEBYI0TMQVWPvnC2KPbDph9Myz5UMuBRIYt2YQdtlPYC4UHamYnHsMghpIMfaS7MWdHuGY81+FBozOsS+/HGohQD', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAALgAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiubZdPvzAAAAAAAAAATAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAALgAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcLGiubZdPvzAAAAAAAAAAUAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAuAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5tl0+/MAAAAAAAAABQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAuAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5tl0+/MAAAAAAAAABQAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAtAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5tl0/AwAAAAAAAAABMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAuAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5tl0+/MAAAAAAAAABMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{WCNEzEFVj75wtij2w6YfTMs+VDLgUSGLdmEHbZT2AuFB2pmJx7DIIaSDH2kuzFnR7hmPNfhQaMzrEvvxxqIUAw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('5b42c77042f04bf716659a05e7ca3f4703af038a7da75b10b8538707c9ff172f', 45, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 19, 100, 1, '2020-01-13 14:37:28.985339', '2020-01-13 14:37:28.98534', 193273532416, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAATAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAA493YBEKdTeVN3wUjgsf56+V7YgpjSdqDCWTMfjGCtycCxorwuxQAAAAAAAAAAAABVvwF9wAAAECGClRePcAExQ/WKroo3/3dfchP/yI8TRDrrjt/chZ83ULiTc54l5wcz1AkbLa6CAapdSGpUWXk5ksTqDXLn4AA', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAALQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaMIOfwMAAAAAAAAAASAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAALQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaMIOfwMAAAAAAAAAATAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAtAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtowg5/AwAAAAAAAAABMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAtAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wsaK5tl0/AwAAAAAAAAABMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAtAAAAAAAAAADj3dgEQp1N5U3fBSOCx/nr5XtiCmNJ2oMJZMx+MYK3JwLGivC7FAAAAAAALQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAsAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtowg5/CUAAAAAAAAABIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAtAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtowg5/AwAAAAAAAAABIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{hgpUXj3ABMUP1iq6KN/93X3IT/8iPE0Q6647f3IWfN1C4k3OeJecHM9QJGy2uggGqXUhqVFl5OZLE6g1y5+AAA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('700fa44bb40e6ad2c5888656cd2e7b8d86de3d3557b653ae6874466175d64927', 27, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 14, 100, 1, '2020-01-13 14:37:29.185599', '2020-01-13 14:37:29.185599', 115964121088, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAOAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvkAAAAAAAAAAABVvwF9wAAAEBq3GPDVeRPfwqtW45GZNiUdQ9j6E9Nsz/lMYWcWDWGCZADSsEiEoXar1HWFK6drptsGEl9P6I9f7C2GBKb4YQM', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAGwAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaVcReCiAAAAAAAAAANAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAGwAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaVcReCiAAAAAAAAAAOAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAbAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpVxF4KIAAAAAAAAAA4AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAbAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpMdC56IAAAAAAAAAA4AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAbAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+QAAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAZAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpVxF4LsAAAAAAAAAA0AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAbAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpVxF4KIAAAAAAAAAA0AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{atxjw1XkT38KrVuORmTYlHUPY+hPTbM/5TGFnFg1hgmQA0rBIhKF2q9R1hSuna6bbBhJfT+iPX+wthgSm+GEDA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('e0773d07aba23d11e6a06b021682294be1f9f202a2926827022539662ce2c7fc', 44, 1, 'GCHPXGVDKPF5KT4CNAT7X77OXYZ7YVE4JHKFDUHCGCVWCL4K4PQ67KKZ', 184683593729, 100, 1, '2020-01-13 14:37:28.996529', '2020-01-13 14:37:28.996529', 188978565120, 'AAAAAI77mqNTy9VPgmgn+//uvjP8VJxJ1FHQ4jCrYS+K4+HvAAAAZAAAACsAAAABAAAAAAAAAAAAAAABAAAAAAAAAAgAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAYrj4e8AAABA3jJ7wBrRpsrcnqBQWjyzwvVz2v5UJ56G60IhgsaWQFSf+7om462KToc+HJ27aLVOQ83dGh1ivp+VIuREJq/SBw==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAIAAAAAAAAAAJUC+OcAAAAAA==', 'AAAAAQAAAAIAAAADAAAALAAAAAAAAAAAjvuao1PL1U+CaCf7/+6+M/xUnEnUUdDiMKthL4rj4e8AAAACVAvjnAAAACsAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAALAAAAAAAAAAAjvuao1PL1U+CaCf7/+6+M/xUnEnUUdDiMKthL4rj4e8AAAACVAvjnAAAACsAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAMAAAArAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtonM3Az4AAAAAAAAABIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAsAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtowg5/CUAAAAAAAAABIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAMAAAAsAAAAAAAAAACO+5qjU8vVT4JoJ/v/7r4z/FScSdRR0OIwq2EviuPh7wAAAAJUC+OcAAAAKwAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAAAI77mqNTy9VPgmgn+//uvjP8VJxJ1FHQ4jCrYS+K4+Hv', 'AAAAAgAAAAMAAAArAAAAAAAAAACO+5qjU8vVT4JoJ/v/7r4z/FScSdRR0OIwq2EviuPh7wAAAAJUC+QAAAAAKwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAsAAAAAAAAAACO+5qjU8vVT4JoJ/v/7r4z/FScSdRR0OIwq2EviuPh7wAAAAJUC+OcAAAAKwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{3jJ7wBrRpsrcnqBQWjyzwvVz2v5UJ56G60IhgsaWQFSf+7om462KToc+HJ27aLVOQ83dGh1ivp+VIuREJq/SBw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('945b6171de747ab323b3cda52290933df39edd7061f6e260762663efc51bccb0', 43, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 18, 100, 1, '2020-01-13 14:37:29.006964', '2020-01-13 14:37:29.006964', 184683597824, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAASAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAjvuao1PL1U+CaCf7/+6+M/xUnEnUUdDiMKthL4rj4e8AAAACVAvkAAAAAAAAAAABVvwF9wAAAEBFbS2c5rrYNGslNVslTHH8j8x0ggew1eHHOUTNajMPy8GYn52RSwRncwwvv1ejEfA+g/mTXMpXrBO847C46KoA', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAKwAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaMIOfw+AAAAAAAAAARAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAKwAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaMIOfw+AAAAAAAAAASAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAArAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtowg5/D4AAAAAAAAABIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAArAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtonM3Az4AAAAAAAAABIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAArAAAAAAAAAACO+5qjU8vVT4JoJ/v/7r4z/FScSdRR0OIwq2EviuPh7wAAAAJUC+QAAAAAKwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAmAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtowg5/FcAAAAAAAAABEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAArAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtowg5/D4AAAAAAAAABEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{RW0tnOa62DRrJTVbJUxx/I/MdIIHsNXhxzlEzWozD8vBmJ+dkUsEZ3MML79XoxHwPoP5k1zKV6wTvOOwuOiqAA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('d67cfb271a889e7854ffd61b08eacde76d56e758466fc37a8eec2d3a40ef8b14', 42, 1, 'GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF', 163208757252, 100, 1, '2020-01-13 14:37:29.020269', '2020-01-13 14:37:29.020269', 180388630528, 'AAAAAPkmOJur5F/mOxTJDb+0bMLCJGDRl3meP2MBEDVKSPP4AAAAZAAAACYAAAAEAAAAAAAAAAAAAAABAAAAAAAAAAcAAAAAq26sUclf95G3mAzqohcAxtpe+UiaovKwDpCv20t6bF8AAAABRVVSAAAAAAAAAAAAAAAAAUpI8/gAAABAEPKcQmATGpevrtlAcZnNI/GjfLLQEp9aODGGRFV+2C4UO8dU+UAMTkCSXQLD+xPaRQxzw93ScEok6GzYCtt7Bg==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAHAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAKgAAAAAAAAAA+SY4m6vkX+Y7FMkNv7RswsIkYNGXeZ4/YwEQNUpI8/gAAAACVAvicAAAACYAAAADAAAAAAAAAAAAAAADAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAKgAAAAAAAAAA+SY4m6vkX+Y7FMkNv7RswsIkYNGXeZ4/YwEQNUpI8/gAAAACVAvicAAAACYAAAAEAAAAAAAAAAAAAAADAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAApAAAAAQAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAFFVVIAAAAAAPkmOJur5F/mOxTJDb+0bMLCJGDRl3meP2MBEDVKSPP4AAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAqAAAAAQAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAFFVVIAAAAAAPkmOJur5F/mOxTJDb+0bMLCJGDRl3meP2MBEDVKSPP4AAAAAAAAAAB//////////wAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAApAAAAAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+AAAAAJUC+LUAAAAJgAAAAMAAAAAAAAAAAAAAAMAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAqAAAAAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+AAAAAJUC+JwAAAAJgAAAAMAAAAAAAAAAAAAAAMAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{EPKcQmATGpevrtlAcZnNI/GjfLLQEp9aODGGRFV+2C4UO8dU+UAMTkCSXQLD+xPaRQxzw93ScEok6GzYCtt7Bg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('6d2e30fd57492bf2e2b132e1bc91a548a369189bebf77eb2b3d829121a9d2c50', 41, 1, 'GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF', 163208757250, 100, 1, '2020-01-13 14:37:29.031439', '2020-01-13 14:37:29.031439', 176093663232, 'AAAAAPkmOJur5F/mOxTJDb+0bMLCJGDRl3meP2MBEDVKSPP4AAAAZAAAACYAAAACAAAAAAAAAAAAAAABAAAAAAAAAAcAAAAAq26sUclf95G3mAzqohcAxtpe+UiaovKwDpCv20t6bF8AAAABVVNEAAAAAAEAAAAAAAAAAUpI8/gAAABA6O2fe1gQBwoO0fMNNEUKH0QdVXVjEWbN5VL51DmRUedYMMXtbX5JKVSzla2kIGvWgls1dXuXHZY/IOlaK01rBQ==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAHAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAKQAAAAAAAAAA+SY4m6vkX+Y7FMkNv7RswsIkYNGXeZ4/YwEQNUpI8/gAAAACVAvi1AAAACYAAAABAAAAAAAAAAAAAAADAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAKQAAAAAAAAAA+SY4m6vkX+Y7FMkNv7RswsIkYNGXeZ4/YwEQNUpI8/gAAAACVAvi1AAAACYAAAACAAAAAAAAAAAAAAADAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAoAAAAAQAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAFVU0QAAAAAAPkmOJur5F/mOxTJDb+0bMLCJGDRl3meP2MBEDVKSPP4AAAAAAAAAAB//////////wAAAAAAAAAAAAAAAAAAAAEAAAApAAAAAQAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAFVU0QAAAAAAPkmOJur5F/mOxTJDb+0bMLCJGDRl3meP2MBEDVKSPP4AAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAnAAAAAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+AAAAAJUC+OcAAAAJgAAAAEAAAAAAAAAAAAAAAMAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAApAAAAAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+AAAAAJUC+M4AAAAJgAAAAEAAAAAAAAAAAAAAAMAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{6O2fe1gQBwoO0fMNNEUKH0QdVXVjEWbN5VL51DmRUedYMMXtbX5JKVSzla2kIGvWgls1dXuXHZY/IOlaK01rBQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('a832ff67085cb9eb6f1c4b740f6e033ba9b508af725fbf203469729a64a199ff', 41, 2, 'GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF', 163208757251, 100, 1, '2020-01-13 14:37:29.031568', '2020-01-13 14:37:29.031568', 176093667328, 'AAAAAPkmOJur5F/mOxTJDb+0bMLCJGDRl3meP2MBEDVKSPP4AAAAZAAAACYAAAADAAAAAAAAAAAAAAABAAAAAAAAAAcAAAAAq26sUclf95G3mAzqohcAxtpe+UiaovKwDpCv20t6bF8AAAABRVVSAAAAAAEAAAAAAAAAAUpI8/gAAABA1Qe8ngwANz4fLqYChwRjR5xng6cIqU5WBtjkZgF4ugVhi8J6kTpACvnvXso3IVym6Rfd6JdQW8QcLkFTX1MGCg==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAHAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAKQAAAAAAAAAA+SY4m6vkX+Y7FMkNv7RswsIkYNGXeZ4/YwEQNUpI8/gAAAACVAvi1AAAACYAAAACAAAAAAAAAAAAAAADAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAKQAAAAAAAAAA+SY4m6vkX+Y7FMkNv7RswsIkYNGXeZ4/YwEQNUpI8/gAAAACVAvi1AAAACYAAAADAAAAAAAAAAAAAAADAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAoAAAAAQAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAFFVVIAAAAAAPkmOJur5F/mOxTJDb+0bMLCJGDRl3meP2MBEDVKSPP4AAAAAAAAAAB//////////wAAAAAAAAAAAAAAAAAAAAEAAAApAAAAAQAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAFFVVIAAAAAAPkmOJur5F/mOxTJDb+0bMLCJGDRl3meP2MBEDVKSPP4AAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAApAAAAAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+AAAAAJUC+M4AAAAJgAAAAEAAAAAAAAAAAAAAAMAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAApAAAAAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+AAAAAJUC+LUAAAAJgAAAAEAAAAAAAAAAAAAAAMAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{1Qe8ngwANz4fLqYChwRjR5xng6cIqU5WBtjkZgF4ugVhi8J6kTpACvnvXso3IVym6Rfd6JdQW8QcLkFTX1MGCg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('6fa467b53f5386d77ad35c2502ed2cd3dd8b460a5be22b6b2818b81bcd3ed2da', 40, 1, 'GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG', 163208757249, 100, 1, '2020-01-13 14:37:29.043104', '2020-01-13 14:37:29.043104', 171798695936, 'AAAAAKturFHJX/eRt5gM6qIXAMbaXvlImqLysA6Qr9tLemxfAAAAZAAAACYAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+H//////////AAAAAAAAAAFLemxfAAAAQKN8LftAafeoAGmvpsEokqm47jAuqw4g1UWjmL0j6QPm1jxoalzDwDS3W+N2HOHdjSJlEQaTxGBfQKHhr6nNsAA=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAKAAAAAAAAAAAq26sUclf95G3mAzqohcAxtpe+UiaovKwDpCv20t6bF8AAAACVAvjOAAAACYAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAKAAAAAAAAAAAq26sUclf95G3mAzqohcAxtpe+UiaovKwDpCv20t6bF8AAAACVAvjOAAAACYAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAoAAAAAAAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAJUC+M4AAAAJgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAoAAAAAAAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAJUC+M4AAAAJgAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAoAAAAAQAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAFVU0QAAAAAAPkmOJur5F/mOxTJDb+0bMLCJGDRl3meP2MBEDVKSPP4AAAAAAAAAAB//////////wAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAmAAAAAAAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAJUC+QAAAAAJgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAoAAAAAAAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAJUC+OcAAAAJgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{o3wt+0Bp96gAaa+mwSiSqbjuMC6rDiDVRaOYvSPpA+bWPGhqXMPANLdb43Yc4d2NImURBpPEYF9AoeGvqc2wAA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('0bcb67aa365446fd244fecff3a0c397f81f3a9b13428688965e776d447c0b1ea', 40, 2, 'GCVW5LCRZFP7PENXTAGOVIQXADDNUXXZJCNKF4VQB2IK7W2LPJWF73UG', 163208757250, 100, 1, '2020-01-13 14:37:29.043351', '2020-01-13 14:37:29.043351', 171798700032, 'AAAAAKturFHJX/eRt5gM6qIXAMbaXvlImqLysA6Qr9tLemxfAAAAZAAAACYAAAACAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABRVVSAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+H//////////AAAAAAAAAAFLemxfAAAAQMPVgYf+w09depDSxMcJnjVZHA2FlkBmhPmi0N66FuhAzTekWcCOMdCI0cUc+xJhywLXSMiKA6wP6K94NRlFlQE=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAKAAAAAAAAAAAq26sUclf95G3mAzqohcAxtpe+UiaovKwDpCv20t6bF8AAAACVAvjOAAAACYAAAABAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAKAAAAAAAAAAAq26sUclf95G3mAzqohcAxtpe+UiaovKwDpCv20t6bF8AAAACVAvjOAAAACYAAAACAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAoAAAAAAAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAJUC+M4AAAAJgAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAoAAAAAAAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAJUC+M4AAAAJgAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAoAAAAAQAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAFFVVIAAAAAAPkmOJur5F/mOxTJDb+0bMLCJGDRl3meP2MBEDVKSPP4AAAAAAAAAAB//////////wAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAoAAAAAAAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAJUC+OcAAAAJgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAoAAAAAAAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAJUC+M4AAAAJgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{w9WBh/7DT116kNLExwmeNVkcDYWWQGaE+aLQ3roW6EDNN6RZwI4x0IjRxRz7EmHLAtdIyIoDrA/or3g1GUWVAQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('11705f94cd65d7b673a124a85ce368c80f8458ffaedff719304d8f849535b4e0', 39, 1, 'GD4SMOE3VPSF7ZR3CTEQ3P5UNTBMEJDA2GLXTHR7MMARANKKJDZ7RPGF', 163208757249, 100, 1, '2020-01-13 14:37:29.053762', '2020-01-13 14:37:29.053762', 167503728640, 'AAAAAPkmOJur5F/mOxTJDb+0bMLCJGDRl3meP2MBEDVKSPP4AAAAZAAAACYAAAABAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABSkjz+AAAAECyjDa1e+jtXukTrHluO7x0Mx7Wj4mRoM4S5UAFmRV+2rVoxjMwqFJhtYnEAUV19+C5ycp5jOLLpWxrCeRKJQUG', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAJwAAAAAAAAAA+SY4m6vkX+Y7FMkNv7RswsIkYNGXeZ4/YwEQNUpI8/gAAAACVAvjnAAAACYAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAJwAAAAAAAAAA+SY4m6vkX+Y7FMkNv7RswsIkYNGXeZ4/YwEQNUpI8/gAAAACVAvjnAAAACYAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAnAAAAAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+AAAAAJUC+OcAAAAJgAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAnAAAAAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+AAAAAJUC+OcAAAAJgAAAAEAAAAAAAAAAAAAAAMAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAmAAAAAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+AAAAAJUC+QAAAAAJgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAnAAAAAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+AAAAAJUC+OcAAAAJgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{sow2tXvo7V7pE6x5bju8dDMe1o+JkaDOEuVABZkVftq1aMYzMKhSYbWJxAFFdffgucnKeYziy6VsawnkSiUFBg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('afeb8080522eba71ca328225bbcf731029edcfa254c827c45be580bae95c7231', 38, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 16, 100, 1, '2020-01-13 14:37:29.064246', '2020-01-13 14:37:29.064246', 163208761344, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAQAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAq26sUclf95G3mAzqohcAxtpe+UiaovKwDpCv20t6bF8AAAACVAvkAAAAAAAAAAABVvwF9wAAAEDnzvNgEYB1u3BGTHFDlIWnk0GOq7BMpfcyewJRsJK9lT4HTMEwMQ2jSJyrWmB7xdBxHKaNMXQaAIx6CShLXpQH', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAJgAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaQyP+5XAAAAAAAAAAPAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAJgAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaQyP+5XAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAmAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpDI/7lcAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAmAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gto5089VcAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAmAAAAAAAAAACrbqxRyV/3kbeYDOqiFwDG2l75SJqi8rAOkK/bS3psXwAAAAJUC+QAAAAAJgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAhAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpDI/7okAAAAAAAAAA8AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAmAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpDI/7nAAAAAAAAAAA8AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{587zYBGAdbtwRkxxQ5SFp5NBjquwTKX3MnsCUbCSvZU+B0zBMDENo0icq1pge8XQcRymjTF0GgCMegkoS16UBw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('2354df802111418a999e31c2964d16b8efe8e492b7d74de54939825190e1041f', 38, 2, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 17, 100, 1, '2020-01-13 14:37:29.06446', '2020-01-13 14:37:29.06446', 163208765440, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAARAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAA+SY4m6vkX+Y7FMkNv7RswsIkYNGXeZ4/YwEQNUpI8/gAAAACVAvkAAAAAAAAAAABVvwF9wAAAEDD6WvAYL1wilsd7zYDJt0iFO/lppQ6GJJn/A8UJl9jTjMNOjuQPBtA7fSxR5KT0BZLbtQy8qFlys0I6fTe/cwO', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAJgAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaOdPPVXAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAJgAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaOdPPVXAAAAAAAAAARAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAmAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gto5089VcAAAAAAAAABEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAmAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtowg5/FcAAAAAAAAABEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAmAAAAAAAAAAD5Jjibq+Rf5jsUyQ2/tGzCwiRg0Zd5nj9jARA1Skjz+AAAAAJUC+QAAAAAJgAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAmAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpDI/7nAAAAAAAAAAA8AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAmAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpDI/7lcAAAAAAAAAA8AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{w+lrwGC9cIpbHe82AybdIhTv5aaUOhiSZ/wPFCZfY04zDTo7kDwbQO30sUeSk9AWS27UMvKhZcrNCOn03v3MDg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('52388a98e4e36c17749a94374270cc65bdb7271cb51277f095aaa8f1ca9d322c', 37, 1, 'GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG', 141733920772, 100, 1, '2020-01-13 14:37:29.075344', '2020-01-13 14:37:29.075345', 158913794048, 'AAAAAJKk3eoJUHc7fO9texuiGHN4NwWMTIFhj6Q30T4ctWW1AAAAZAAAACEAAAAEAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAAAAAAAAAAEctWW1AAAAQM5SCoW10EJoKBBwwMu0Vw+f+bQ0GjQ9FO6w3l9Q/FIctm87248t9jXTbl0Rd4NgGcom0yoGxgcJiERwZGBMXQc=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAJQAAAAAAAAAAkqTd6glQdzt87217G6IYc3g3BYxMgWGPpDfRPhy1ZbUAAAACVAvicAAAACEAAAADAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAJQAAAAAAAAAAkqTd6glQdzt87217G6IYc3g3BYxMgWGPpDfRPhy1ZbUAAAACVAvicAAAACEAAAAEAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAMAAAAkAAAAAQAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAFVU0QAAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAAAAAAAAAAAAO5rKAAAAAAEAAAAAAAAAAAAAAAIAAAABAAAAAJKk3eoJUHc7fO9texuiGHN4NwWMTIFhj6Q30T4ctWW1AAAAAVVTRAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAJQAAAAAAAAAAkqTd6glQdzt87217G6IYc3g3BYxMgWGPpDfRPhy1ZbUAAAACVAvicAAAACEAAAAEAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAJQAAAAAAAAAAkqTd6glQdzt87217G6IYc3g3BYxMgWGPpDfRPhy1ZbUAAAACVAvicAAAACEAAAAEAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAA=', 'AAAAAgAAAAMAAAAkAAAAAAAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAJUC+LUAAAAIQAAAAMAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAlAAAAAAAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAJUC+JwAAAAIQAAAAMAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{zlIKhbXQQmgoEHDAy7RXD5/5tDQaND0U7rDeX1D8Uhy2bzvbjy32NdNuXRF3g2AZyibTKgbGBwmIRHBkYExdBw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('44cb6c8ed4dbec542af1aad23001dd9d678cf19c8c461a653e762a7253eded82', 36, 1, 'GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG', 141733920771, 100, 1, '2020-01-13 14:37:29.086211', '2020-01-13 14:37:29.086211', 154618826752, 'AAAAAJKk3eoJUHc7fO9texuiGHN4NwWMTIFhj6Q30T4ctWW1AAAAZAAAACEAAAADAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAA7msoAAAAAAAAAAAEctWW1AAAAQO+eTIPXUZk+GAq7O6H8d1/WT5buo0apjLhGgtBeSyl37UV7LCpZfCn6DYVc7lQOVNWhBc7KDA7Ne83AR41kYAk=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAJAAAAAAAAAAAkqTd6glQdzt87217G6IYc3g3BYxMgWGPpDfRPhy1ZbUAAAACVAvi1AAAACEAAAACAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAJAAAAAAAAAAAkqTd6glQdzt87217G6IYc3g3BYxMgWGPpDfRPhy1ZbUAAAACVAvi1AAAACEAAAADAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAjAAAAAQAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAFVU0QAAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAAAAAAAAAAAAO5rKAAAAAAEAAAAAAAAAAAAAAAEAAAAkAAAAAQAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAFVU0QAAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAAAAAAAAAAAAO5rKAAAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAjAAAAAAAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAJUC+M4AAAAIQAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAkAAAAAAAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAJUC+LUAAAAIQAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{755Mg9dRmT4YCrs7ofx3X9ZPlu6jRqmMuEaC0F5LKXftRXssKll8KfoNhVzuVA5U1aEFzsoMDs17zcBHjWRgCQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('4e2442fe2e8dd8c686570c9f537acb2f50153a9883f8d199b6f4701eb289b3a0', 35, 1, 'GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG', 141733920770, 100, 1, '2020-01-13 14:37:29.095919', '2020-01-13 14:37:29.095919', 150323859456, 'AAAAAJKk3eoJUHc7fO9texuiGHN4NwWMTIFhj6Q30T4ctWW1AAAAZAAAACEAAAACAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAA7msoAAAAAAAAAAAEctWW1AAAAQNugq+B30pdbzvVVGz9RO3+DMeRdWqc/Xsd2NYdg6NBu7esvOdTWQ3nvoBEJyeGz8EE9zRQiSiqorwHlm+AGfwI=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAIwAAAAAAAAAAkqTd6glQdzt87217G6IYc3g3BYxMgWGPpDfRPhy1ZbUAAAACVAvjOAAAACEAAAABAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAIwAAAAAAAAAAkqTd6glQdzt87217G6IYc3g3BYxMgWGPpDfRPhy1ZbUAAAACVAvjOAAAACEAAAACAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAiAAAAAQAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAFVU0QAAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAjAAAAAQAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAFVU0QAAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAAAAAAAAAAAAO5rKAAAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAiAAAAAAAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAJUC+OcAAAAIQAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAjAAAAAAAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAJUC+M4AAAAIQAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{26Cr4HfSl1vO9VUbP1E7f4Mx5F1apz9ex3Y1h2Do0G7t6y851NZDee+gEQnJ4bPwQT3NFCJKKqivAeWb4AZ/Ag==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('a05daae230b1f743474e83ab6d4817df1f3f77661a7d815f7620cee2a9809480', 34, 1, 'GCJKJXPKBFIHOO3455WXWG5CDBZXQNYFRRGICYMPUQ35CPQ4WVS3KZLG', 141733920769, 100, 1, '2020-01-13 14:37:29.105575', '2020-01-13 14:37:29.105575', 146028892160, 'AAAAAJKk3eoJUHc7fO9texuiGHN4NwWMTIFhj6Q30T4ctWW1AAAAZAAAACEAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF93//////////AAAAAAAAAAEctWW1AAAAQBYUnV3I1O35EAyay0msjg3MzZfanCtvalKGG+94pe6RxgE/kCk2kTT9HXgXjbraq//Q/0vJ0AoCAXSeT18Ujgk=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAIgAAAAAAAAAAkqTd6glQdzt87217G6IYc3g3BYxMgWGPpDfRPhy1ZbUAAAACVAvjnAAAACEAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAIgAAAAAAAAAAkqTd6glQdzt87217G6IYc3g3BYxMgWGPpDfRPhy1ZbUAAAACVAvjnAAAACEAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAiAAAAAAAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAJUC+OcAAAAIQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAiAAAAAAAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAJUC+OcAAAAIQAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAiAAAAAQAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAFVU0QAAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAhAAAAAAAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAJUC+QAAAAAIQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAiAAAAAAAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAJUC+OcAAAAIQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{FhSdXcjU7fkQDJrLSayODczNl9qcK29qUoYb73il7pHGAT+QKTaRNP0deBeNutqr/9D/S8nQCgIBdJ5PXxSOCQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('6d78f17fafa2317d6af679e1e5420f351207ff61cdff21c600ea8f85155b3ea1', 33, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 15, 100, 1, '2020-01-13 14:37:29.116017', '2020-01-13 14:37:29.116017', 141733924864, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAPAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAkqTd6glQdzt87217G6IYc3g3BYxMgWGPpDfRPhy1ZbUAAAACVAvkAAAAAAAAAAABVvwF9wAAAEC+mgKIzZqflQIKIqWn9LrciuyEx7XPfXGUhvyQ3sIQBnGdOWhkOt57UU/75LtUy4recT+jrY2cHKZj33puue8F', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAIQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaTHQueJAAAAAAAAAAOAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAIQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaTHQueJAAAAAAAAAAPAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAhAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpMdC54kAAAAAAAAAA8AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAhAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpDI/7okAAAAAAAAAA8AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAhAAAAAAAAAACSpN3qCVB3O3zvbXsbohhzeDcFjEyBYY+kN9E+HLVltQAAAAJUC+QAAAAAIQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAbAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpMdC56IAAAAAAAAAA4AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAhAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpMdC54kAAAAAAAAAA4AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{vpoCiM2an5UCCiKlp/S63IrshMe1z31xlIb8kN7CEAZxnTloZDree1FP++S7VMuK3nE/o62NnBymY996brnvBQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('bb9d6654111fae501594400dc901c70d47489a67163d2a34f9b3e32a921a50dc', 32, 1, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES', 115964117003, 100, 1, '2020-01-13 14:37:29.126179', '2020-01-13 14:37:29.126179', 137438957568, 'AAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAZAAAABsAAAALAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAMAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABMJ4wUAAAAEAFytUxjxN4bnJMrEJkSprnES9iGpOxAsNOFYrTP/xtGVk/PZ2oThUW+/hLRIk+hYYEgF21Gf58N/abJKFpqlsI', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAIAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvfUAAAABsAAAAKAAAAAQAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAC2V4YW1wbGUuY29tAAIAAgIAAAABAAAAAHyd2ctWIE8qo8kBxI2FnNzaYft9DtG3MbIUDyYWQxOQAAAABQAAAAAAAAAAAAAAAQAAACAAAAAAAAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAAlQL31AAAAAbAAAACwAAAAEAAAABAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAwAAAAtleGFtcGxlLmNvbQACAAICAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAUAAAAAAAAAAAAAAAEAAAACAAAAAwAAACAAAAAAAAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAAlQL31AAAAAbAAAACwAAAAEAAAABAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAwAAAAtleGFtcGxlLmNvbQACAAICAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAUAAAAAAAAAAAAAAAEAAAAgAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC99QAAAAGwAAAAsAAAABAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAALZXhhbXBsZS5jb20AAgACAgAAAAEAAAAAfJ3Zy1YgTyqjyQHEjYWc3Nph+30O0bcxshQPJhZDE5AAAAAFAAAAAAAAAAA=', 'AAAAAgAAAAMAAAAfAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+AYAAAAGwAAAAoAAAABAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAALZXhhbXBsZS5jb20AAgACAgAAAAEAAAAAfJ3Zy1YgTyqjyQHEjYWc3Nph+30O0bcxshQPJhZDE5AAAAAFAAAAAAAAAAAAAAABAAAAIAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvftAAAABsAAAAKAAAAAQAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAC2V4YW1wbGUuY29tAAIAAgIAAAABAAAAAHyd2ctWIE8qo8kBxI2FnNzaYft9DtG3MbIUDyYWQxOQAAAABQAAAAAAAAAA', '{BcrVMY8TeG5yTKxCZEqa5xEvYhqTsQLDThWK0z/8bRlZPz2dqE4VFvv4S0SJPoWGBIBdtRn+fDf2myShaapbCA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('6b38cdd5c17df2013d5a5e211c4b32218b6be91025316b1aab28bc12316615d5', 32, 2, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES', 115964117004, 100, 1, '2020-01-13 14:37:29.126351', '2020-01-13 14:37:29.126351', 137438961664, 'AAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAZAAAABsAAAAMAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAAAAAAAAAAAATCeMFAAAABAOb0qGWnk1WrSUXS6iQFocaIOY/BDmgG1zTmlPyg0boSid3jTBK3z9U8+IPGAOELNLgkQHtgGYFgFGMio1xY+BQ==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAIAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvfUAAAABsAAAALAAAAAQAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAC2V4YW1wbGUuY29tAAIAAgIAAAABAAAAAHyd2ctWIE8qo8kBxI2FnNzaYft9DtG3MbIUDyYWQxOQAAAABQAAAAAAAAAAAAAAAQAAACAAAAAAAAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAAlQL31AAAAAbAAAADAAAAAEAAAABAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAAAAAAtleGFtcGxlLmNvbQACAAICAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAUAAAAAAAAAAAAAAAEAAAACAAAAAwAAACAAAAAAAAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAAlQL31AAAAAbAAAADAAAAAEAAAABAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAAAAAAtleGFtcGxlLmNvbQACAAICAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAUAAAAAAAAAAAAAAAEAAAAgAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC99QAAAAGwAAAAwAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAALZXhhbXBsZS5jb20AAgACAgAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAgAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC9+0AAAAGwAAAAoAAAABAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAALZXhhbXBsZS5jb20AAgACAgAAAAEAAAAAfJ3Zy1YgTyqjyQHEjYWc3Nph+30O0bcxshQPJhZDE5AAAAAFAAAAAAAAAAAAAAABAAAAIAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvfUAAAABsAAAAKAAAAAQAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAC2V4YW1wbGUuY29tAAIAAgIAAAABAAAAAHyd2ctWIE8qo8kBxI2FnNzaYft9DtG3MbIUDyYWQxOQAAAABQAAAAAAAAAA', '{Ob0qGWnk1WrSUXS6iQFocaIOY/BDmgG1zTmlPyg0boSid3jTBK3z9U8+IPGAOELNLgkQHtgGYFgFGMio1xY+BQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('299dc6631d585a55ae3602f660ec5b5a0088d24a14b344c72eccc2a62d9a8938', 31, 1, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES', 115964117002, 100, 1, '2020-01-13 14:37:29.138053', '2020-01-13 14:37:29.138053', 133143990272, 'AAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAZAAAABsAAAAKAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAUAAAAAAAAAATCeMFAAAABA0wriernSr+5P2QCeon1uj5mrOLNTOrPYPPi5ricLug/nreEUhsgS/k3lA9JGpVbd+tacMEKmXKmFxHCEMjWPBg==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAHwAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvgGAAAABsAAAAJAAAAAQAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAC2V4YW1wbGUuY29tAAIAAgIAAAABAAAAAHyd2ctWIE8qo8kBxI2FnNzaYft9DtG3MbIUDyYWQxOQAAAAAQAAAAAAAAAAAAAAAQAAAB8AAAAAAAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAAlQL4BgAAAAbAAAACgAAAAEAAAABAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAwAAAAtleGFtcGxlLmNvbQACAAICAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAEAAAAAAAAAAAAAAAEAAAACAAAAAwAAAB8AAAAAAAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAAlQL4BgAAAAbAAAACgAAAAEAAAABAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAwAAAAtleGFtcGxlLmNvbQACAAICAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAEAAAAAAAAAAAAAAAEAAAAfAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+AYAAAAGwAAAAoAAAABAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAALZXhhbXBsZS5jb20AAgACAgAAAAEAAAAAfJ3Zy1YgTyqjyQHEjYWc3Nph+30O0bcxshQPJhZDE5AAAAAFAAAAAAAAAAA=', 'AAAAAgAAAAMAAAAeAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+B8AAAAGwAAAAkAAAABAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAALZXhhbXBsZS5jb20AAgACAgAAAAEAAAAAfJ3Zy1YgTyqjyQHEjYWc3Nph+30O0bcxshQPJhZDE5AAAAABAAAAAAAAAAAAAAABAAAAHwAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvgGAAAABsAAAAJAAAAAQAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAC2V4YW1wbGUuY29tAAIAAgIAAAABAAAAAHyd2ctWIE8qo8kBxI2FnNzaYft9DtG3MbIUDyYWQxOQAAAAAQAAAAAAAAAA', '{0wriernSr+5P2QCeon1uj5mrOLNTOrPYPPi5ricLug/nreEUhsgS/k3lA9JGpVbd+tacMEKmXKmFxHCEMjWPBg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('c3cd47a311e025446f72c50426b5b5444e5261431fc5760e8e57467c87cd49fc', 30, 1, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES', 115964117001, 100, 1, '2020-01-13 14:37:29.14793', '2020-01-13 14:37:29.14793', 128849022976, 'AAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAZAAAABsAAAAJAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAEAAAAAAAAAATCeMFAAAABA7ZMKq80ucQSt+55q+6VQrG3Hrv6zHtOLwkfAxxsZdYPIuk7xZsgbyhOCVXjheOQ9ygAW1vtybdXG41AxSFRtAg==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAHgAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvgfAAAABsAAAAIAAAAAQAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAC2V4YW1wbGUuY29tAAIAAgIAAAABAAAAAHyd2ctWIE8qo8kBxI2FnNzaYft9DtG3MbIUDyYWQxOQAAAAAQAAAAAAAAAAAAAAAQAAAB4AAAAAAAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAAlQL4HwAAAAbAAAACQAAAAEAAAABAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAwAAAAtleGFtcGxlLmNvbQACAAICAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAEAAAAAAAAAAAAAAAEAAAACAAAAAwAAAB4AAAAAAAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAAlQL4HwAAAAbAAAACQAAAAEAAAABAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAwAAAAtleGFtcGxlLmNvbQACAAICAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAEAAAAAAAAAAAAAAAEAAAAeAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+B8AAAAGwAAAAkAAAABAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAALZXhhbXBsZS5jb20AAgACAgAAAAEAAAAAfJ3Zy1YgTyqjyQHEjYWc3Nph+30O0bcxshQPJhZDE5AAAAABAAAAAAAAAAA=', 'AAAAAgAAAAMAAAAdAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+DgAAAAGwAAAAgAAAABAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAALZXhhbXBsZS5jb20AAgACAgAAAAEAAAAAfJ3Zy1YgTyqjyQHEjYWc3Nph+30O0bcxshQPJhZDE5AAAAABAAAAAAAAAAAAAAABAAAAHgAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvgfAAAABsAAAAIAAAAAQAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAC2V4YW1wbGUuY29tAAIAAgIAAAABAAAAAHyd2ctWIE8qo8kBxI2FnNzaYft9DtG3MbIUDyYWQxOQAAAAAQAAAAAAAAAA', '{7ZMKq80ucQSt+55q+6VQrG3Hrv6zHtOLwkfAxxsZdYPIuk7xZsgbyhOCVXjheOQ9ygAW1vtybdXG41AxSFRtAg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('69f64ae0f809b08996c1f394ee795001a40eee69adb675ab63bfd1932d3aafb2', 29, 1, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES', 115964117000, 100, 1, '2020-01-13 14:37:29.157076', '2020-01-13 14:37:29.157076', 124554055680, 'AAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAZAAAABsAAAAIAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAEAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAATCeMFAAAABAi69qDHclVS9A8GAaqyk6oIxiMC2KXXEneFijfxH5VyLGIQZNAxOOcCPpIalU6P1pYRX3K4OlKHZ4hIdxJzD6BQ==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAHQAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvg4AAAABsAAAAHAAAAAQAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAC2V4YW1wbGUuY29tAAIAAgIAAAABAAAAAHyd2ctWIE8qo8kBxI2FnNzaYft9DtG3MbIUDyYWQxOQAAAAAQAAAAAAAAAAAAAAAQAAAB0AAAAAAAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAAlQL4OAAAAAbAAAACAAAAAEAAAABAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAwAAAAtleGFtcGxlLmNvbQACAAICAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAEAAAAAAAAAAAAAAAEAAAACAAAAAwAAAB0AAAAAAAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAAlQL4OAAAAAbAAAACAAAAAEAAAABAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAwAAAAtleGFtcGxlLmNvbQACAAICAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAEAAAAAAAAAAAAAAAEAAAAdAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+DgAAAAGwAAAAgAAAABAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAALZXhhbXBsZS5jb20AAgACAgAAAAEAAAAAfJ3Zy1YgTyqjyQHEjYWc3Nph+30O0bcxshQPJhZDE5AAAAABAAAAAAAAAAA=', 'AAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAcAAAABAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAALZXhhbXBsZS5jb20AAgACAgAAAAEAAAAAfJ3Zy1YgTyqjyQHEjYWc3Nph+30O0bcxshQPJhZDE5AAAAABAAAAAAAAAAAAAAABAAAAHQAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvg4AAAABsAAAAHAAAAAQAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAC2V4YW1wbGUuY29tAAIAAgIAAAABAAAAAHyd2ctWIE8qo8kBxI2FnNzaYft9DtG3MbIUDyYWQxOQAAAAAQAAAAAAAAAA', '{i69qDHclVS9A8GAaqyk6oIxiMC2KXXEneFijfxH5VyLGIQZNAxOOcCPpIalU6P1pYRX3K4OlKHZ4hIdxJzD6BQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('fe3707fbd5c844395c598f31dc719c61218d4cea4e8dddadb6733f4866089100', 28, 1, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES', 115964116993, 100, 1, '2020-01-13 14:37:29.168284', '2020-01-13 14:37:29.168284', 120259088384, 'AAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAZAAAABsAAAABAAAAAAAAAAAAAAABAAAAAAAAAAUAAAABAAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAAQAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABMJ4wUAAAAEA/GIgE9sYPGwbCiIdLdhoEu25CyB0ZAcmjQonQItu6SE0gaSBVT/le355A/dw1NPaoXY9P/u0ou9D7h5Vb1fcK', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAEAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAbAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+QAAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+OcAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{PxiIBPbGDxsGwoiHS3YaBLtuQsgdGQHJo0KJ0CLbukhNIGkgVU/5Xt+eQP3cNTT2qF2PT/7tKLvQ+4eVW9X3Cg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('345ef7f85c6ea297e3f994feef279b63812628681bd173a1f615185a4368e482', 28, 2, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES', 115964116994, 100, 1, '2020-01-13 14:37:29.168417', '2020-01-13 14:37:29.168417', 120259092480, 'AAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAZAAAABsAAAACAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABMJ4wUAAAAEDYxq3zpaFIC2JcuJUbrQ3MFXzqvu+5G7XUi4NnHlfbLutn76ylQcjuwLgbUG2lqcQfl75doPUZyurKtFP1rkMO', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAABAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAACAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAIAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAIAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAEAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+OcAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+M4AAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{2Mat86WhSAtiXLiVG60NzBV86r7vuRu11IuDZx5X2y7rZ++spUHI7sC4G1BtpanEH5e+XaD1GcrqyrRT9a5DDg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('2a14735d7b05109359444acdd87e7fe92c98e9295d2ba61b05e25d1f7ee10fd3', 28, 3, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES', 115964116995, 100, 1, '2020-01-13 14:37:29.168531', '2020-01-13 14:37:29.168531', 120259096576, 'AAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAZAAAABsAAAADAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABMJ4wUAAAAEAKuQ1exMu8hdf8dOPeULX2DG7DZx5WWIUFHXJMWGG9KmVrQoZDt2S6a/1uYEVJnvvY/EoJM5RpVjh2ZCs30VYA', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAACAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAABAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAADAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAABAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAMAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAEAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAMAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+M4AAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+LUAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{CrkNXsTLvIXX/HTj3lC19gxuw2ceVliFBR1yTFhhvSpla0KGQ7dkumv9bmBFSZ772PxKCTOUaVY4dmQrN9FWAA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('d8b2508123656b1df1ee17c2767829bc22ab41959ad25e6ccc520e849516fba1', 23, 1, 'GBOK7BOUSOWPHBANBYM6MIRYZJIDIPUYJPXHTHADF75UEVIVYWHHONQC', 90194313218, 100, 1, '2020-01-13 14:37:29.239534', '2020-01-13 14:37:29.239534', 98784251904, 'AAAAAFyvhdSTrPOEDQ4Z5iI4ylA0PphL7nmcAy/7QlUVxY53AAAAZAAAABUAAAACAAAAAAAAAAAAAAABAAAAAAAAAAMAAAAAAAAAAVVTRAAAAAAAdQRiekAoVkbqXJa3xIIXnCcZLADk+cVfmZs9SLHWDWEAAAAAC+vCAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAARXFjncAAABATR48xYiKbu8AOoXFwvcvILZ0/pQkfGuwwAoIZNefr7ydIwlcuL44XPM7pJ/6jDSbqBudTNWdE2JRjuq7HI7IAA==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAFyvhdSTrPOEDQ4Z5iI4ylA0PphL7nmcAy/7QlUVxY53AAAAAAAAAAMAAAAAAAAAAVVTRAAAAAAAdQRiekAoVkbqXJa3xIIXnCcZLADk+cVfmZs9SLHWDWEAAAAAC+vCAAAAAAEAAAABAAAAAAAAAAAAAAAA', 'AAAAAQAAAAIAAAADAAAAFwAAAAAAAAAAXK+F1JOs84QNDhnmIjjKUDQ+mEvueZwDL/tCVRXFjncAAAACVAvjOAAAABUAAAABAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAFwAAAAAAAAAAXK+F1JOs84QNDhnmIjjKUDQ+mEvueZwDL/tCVRXFjncAAAACVAvjOAAAABUAAAACAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABQAAAAMAAAAXAAAAAAAAAABcr4XUk6zzhA0OGeYiOMpQND6YS+55nAMv+0JVFcWOdwAAAAJUC+M4AAAAFQAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAXAAAAAAAAAABcr4XUk6zzhA0OGeYiOMpQND6YS+55nAMv+0JVFcWOdwAAAAJUC+M4AAAAFQAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAAAC+vCAAAAAAAAAAAAAAAAAAAAABcAAAACAAAAAFyvhdSTrPOEDQ4Z5iI4ylA0PphL7nmcAy/7QlUVxY53AAAAAAAAAAMAAAAAAAAAAVVTRAAAAAAAdQRiekAoVkbqXJa3xIIXnCcZLADk+cVfmZs9SLHWDWEAAAAAC+vCAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAwAAABYAAAABAAAAAFyvhdSTrPOEDQ4Z5iI4ylA0PphL7nmcAy/7QlUVxY53AAAAAVVTRAAAAAAAdQRiekAoVkbqXJa3xIIXnCcZLADk+cVfmZs9SLHWDWEAAAAAAAAAAH//////////AAAAAQAAAAAAAAAAAAAAAQAAABcAAAABAAAAAFyvhdSTrPOEDQ4Z5iI4ylA0PphL7nmcAy/7QlUVxY53AAAAAVVTRAAAAAAAdQRiekAoVkbqXJa3xIIXnCcZLADk+cVfmZs9SLHWDWEAAAAAAAAAAH//////////AAAAAQAAAAEAAAAAC+vCAAAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAgAAAAMAAAAWAAAAAAAAAABcr4XUk6zzhA0OGeYiOMpQND6YS+55nAMv+0JVFcWOdwAAAAJUC+OcAAAAFQAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAXAAAAAAAAAABcr4XUk6zzhA0OGeYiOMpQND6YS+55nAMv+0JVFcWOdwAAAAJUC+M4AAAAFQAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{TR48xYiKbu8AOoXFwvcvILZ0/pQkfGuwwAoIZNefr7ydIwlcuL44XPM7pJ/6jDSbqBudTNWdE2JRjuq7HI7IAA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('4f9598206ab17cf27b5c3eb9e906d63ebee2626654112eabdd2bce7bf12cccf2', 28, 4, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES', 115964116996, 100, 1, '2020-01-13 14:37:29.16867', '2020-01-13 14:37:29.16867', 120259100672, 'AAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAZAAAABsAAAAEAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAEAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAATCeMFAAAABAAd6MzHDjUdRtHozzDnD3jJA+uRDCar3PQtuH/43pnROzk1HkovJPQ1YyzcpOb/NeuU/LKNzseL0PJNasVX1lAQ==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAADAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAAEAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAQAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAQAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAAAAgAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+LUAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+JwAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{Ad6MzHDjUdRtHozzDnD3jJA+uRDCar3PQtuH/43pnROzk1HkovJPQ1YyzcpOb/NeuU/LKNzseL0PJNasVX1lAQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('852ba25e0e4aa149a22dc193bcb645ae9eba23e7f7432707f3b910474e9b6a5b', 28, 5, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES', 115964116997, 100, 1, '2020-01-13 14:37:29.168831', '2020-01-13 14:37:29.168833', 120259104768, 'AAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAZAAAABsAAAAFAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAEAAAACAAAAAQAAAAIAAAAAAAAAAAAAAAAAAAABMJ4wUAAAAEAnFzc6kqweyIL4TzIDbr+8GUOGGs1W5jcX5iSNw4DeonzQARlejYJ9NOn/XkrcoC9Hvd8hc5lNx+1h991GxJUJ', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAAEAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAABAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAAFAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAAAIAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAUAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAUAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAAAAgACAgAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+JwAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+IMAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{Jxc3OpKsHsiC+E8yA26/vBlDhhrNVuY3F+YkjcOA3qJ80AEZXo2CfTTp/15K3KAvR73fIXOZTcftYffdRsSVCQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('8ccc0c28c3e99a63cc59bad7dec3f5c56eb3942c548ecd40bc39c509d6b081d4', 28, 6, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES', 115964116998, 100, 1, '2020-01-13 14:37:29.169013', '2020-01-13 14:37:29.169014', 120259108864, 'AAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAZAAAABsAAAAGAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAC2V4YW1wbGUuY29tAAAAAAAAAAAAAAAAATCeMFAAAABAkID6CkBHP9eovLQXkMQJ7QkE6NWlmdKGmLxaiI1YaVKZaKJxz5P85x+6wzpYxxbs6Bd2l4qxVjS7Q36DwRiqBA==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAAFAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAAAIAAgIAAAAAAAAAAAAAAAAAAAABAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAAGAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAAAIAAgIAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAYAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAAAAgACAgAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAYAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAALZXhhbXBsZS5jb20AAgACAgAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+IMAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+GoAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{kID6CkBHP9eovLQXkMQJ7QkE6NWlmdKGmLxaiI1YaVKZaKJxz5P85x+6wzpYxxbs6Bd2l4qxVjS7Q36DwRiqBA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('83201014880073f8eff6f21ae76e51c2c4faf533e550ecd3c2205b48a092960a', 28, 7, 'GCIFFRQKHMH6JD7CK5OI4XVCYCMNRNF6PYA7JTCR3FPHPJZQTYYFB5ES', 115964116999, 100, 1, '2020-01-13 14:37:29.16916', '2020-01-13 14:37:29.16916', 120259112960, 'AAAAAJBSxgo7D+SP4ldcjl6iwJjYtL5+AfTMUdled6cwnjBQAAAAZAAAABsAAAAHAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAB8ndnLViBPKqPJAcSNhZzc2mH7fQ7RtzGyFA8mFkMTkAAAAAEAAAAAAAAAATCeMFAAAABAtYtlsqMReQo1UoU2GYjb3h52wEKvnouCSO6LQO1xm/ArhtQO/sX5q35St8BjaYWEiFnp+SQj2FZC89OswCldAw==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAAGAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAC2V4YW1wbGUuY29tAAIAAgIAAAAAAAAAAAAAAAAAAAABAAAAHAAAAAAAAAAAkFLGCjsP5I/iV1yOXqLAmNi0vn4B9MxR2V53pzCeMFAAAAACVAvhRAAAABsAAAAHAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAADAAAAC2V4YW1wbGUuY29tAAIAAgIAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAcAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAALZXhhbXBsZS5jb20AAgACAgAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAcAAAABAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAMAAAALZXhhbXBsZS5jb20AAgACAgAAAAEAAAAAfJ3Zy1YgTyqjyQHEjYWc3Nph+30O0bcxshQPJhZDE5AAAAABAAAAAAAAAAA=', 'AAAAAgAAAAMAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+GoAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAcAAAAAAAAAACQUsYKOw/kj+JXXI5eosCY2LS+fgH0zFHZXnenMJ4wUAAAAAJUC+FEAAAAGwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{tYtlsqMReQo1UoU2GYjb3h52wEKvnouCSO6LQO1xm/ArhtQO/sX5q35St8BjaYWEiFnp+SQj2FZC89OswCldAw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('a76e0260f6b83c6ea93f545d17de721c079dc31e81ee5edc41f159ec5fb48443', 26, 1, 'GB6GN3LJUW6JYR7EDOJ47VBH7D45M4JWHXGK6LHJRAEI5JBSN2DBQY7Q', 107374182401, 100, 1, '2020-01-13 14:37:29.198496', '2020-01-13 14:37:29.198496', 111669153792, 'AAAAAHxm7WmlvJxH5BuTz9Qn+PnWcTY9zK8s6YgIjqQyboYYAAAAZAAAABkAAAABAAAAAAAAAAAAAAABAAAAAAAAAAQAAAABVVNEAAAAAAB8Zu1ppbycR+Qbk8/UJ/j51nE2PcyvLOmICI6kMm6GGAAAAAAAAAAAdzWUAAAAAAEAAAABAAAAAAAAAAEyboYYAAAAQBqzCYDuLYn/jXhfEVxEGigMCJGoOBCK92lUb3Um15PgwSJ63tNl+FpH8+y5c+mCs/rzcvdyo9uXdodd4LXWiQg=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAHxm7WmlvJxH5BuTz9Qn+PnWcTY9zK8s6YgIjqQyboYYAAAAAAAAAAUAAAABVVNEAAAAAAB8Zu1ppbycR+Qbk8/UJ/j51nE2PcyvLOmICI6kMm6GGAAAAAAAAAAAdzWUAAAAAAEAAAABAAAAAQAAAAAAAAAA', 'AAAAAQAAAAIAAAADAAAAGgAAAAAAAAAAfGbtaaW8nEfkG5PP1Cf4+dZxNj3MryzpiAiOpDJuhhgAAAACVAvjOAAAABkAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAGgAAAAAAAAAAfGbtaaW8nEfkG5PP1Cf4+dZxNj3MryzpiAiOpDJuhhgAAAACVAvjOAAAABkAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAaAAAAAAAAAAB8Zu1ppbycR+Qbk8/UJ/j51nE2PcyvLOmICI6kMm6GGAAAAAJUC+M4AAAAGQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAaAAAAAAAAAAB8Zu1ppbycR+Qbk8/UJ/j51nE2PcyvLOmICI6kMm6GGAAAAAJUC+M4AAAAGQAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAHc1lAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABoAAAACAAAAAHxm7WmlvJxH5BuTz9Qn+PnWcTY9zK8s6YgIjqQyboYYAAAAAAAAAAUAAAABVVNEAAAAAAB8Zu1ppbycR+Qbk8/UJ/j51nE2PcyvLOmICI6kMm6GGAAAAAAAAAAAdzWUAAAAAAEAAAABAAAAAQAAAAAAAAAA', 'AAAAAgAAAAMAAAAZAAAAAAAAAAB8Zu1ppbycR+Qbk8/UJ/j51nE2PcyvLOmICI6kMm6GGAAAAAJUC+QAAAAAGQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAaAAAAAAAAAAB8Zu1ppbycR+Qbk8/UJ/j51nE2PcyvLOmICI6kMm6GGAAAAAJUC+OcAAAAGQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{GrMJgO4tif+NeF8RXEQaKAwIkag4EIr3aVRvdSbXk+DBInre02X4Wkfz7Llz6YKz+vNy93Kj25d2h13gtdaJCA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('92a654c76966ac61acc9df0b75f91cbde3b551c9e9766730827af42d1e247cc3', 26, 2, 'GB6GN3LJUW6JYR7EDOJ47VBH7D45M4JWHXGK6LHJRAEI5JBSN2DBQY7Q', 107374182402, 100, 1, '2020-01-13 14:37:29.198755', '2020-01-13 14:37:29.198756', 111669157888, 'AAAAAHxm7WmlvJxH5BuTz9Qn+PnWcTY9zK8s6YgIjqQyboYYAAAAZAAAABkAAAACAAAAAAAAAAAAAAABAAAAAAAAAAQAAAAAAAAAAVVTRAAAAAAAfGbtaaW8nEfkG5PP1Cf4+dZxNj3MryzpiAiOpDJuhhgAAAAAdzWUAAAAAAEAAAABAAAAAAAAAAEyboYYAAAAQBbE9T7oBKoN0/S3AV7GoSRe+xT79SlWNCYEtL1RPExL8FLhw5EDsXLoAvIBbBvHIr9NKcPtWDyhcHlIuaZKIg8=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAHxm7WmlvJxH5BuTz9Qn+PnWcTY9zK8s6YgIjqQyboYYAAAAAAAAAAYAAAAAAAAAAVVTRAAAAAAAfGbtaaW8nEfkG5PP1Cf4+dZxNj3MryzpiAiOpDJuhhgAAAAAdzWUAAAAAAEAAAABAAAAAQAAAAAAAAAA', 'AAAAAQAAAAIAAAADAAAAGgAAAAAAAAAAfGbtaaW8nEfkG5PP1Cf4+dZxNj3MryzpiAiOpDJuhhgAAAACVAvjOAAAABkAAAABAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAB3NZQAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAaAAAAAAAAAAB8Zu1ppbycR+Qbk8/UJ/j51nE2PcyvLOmICI6kMm6GGAAAAAJUC+M4AAAAGQAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAHc1lAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAMAAAADAAAAGgAAAAAAAAAAfGbtaaW8nEfkG5PP1Cf4+dZxNj3MryzpiAiOpDJuhhgAAAACVAvjOAAAABkAAAACAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAB3NZQAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAaAAAAAAAAAAB8Zu1ppbycR+Qbk8/UJ/j51nE2PcyvLOmICI6kMm6GGAAAAAJUC+M4AAAAGQAAAAIAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAHc1lAAAAAAAdzWUAAAAAAAAAAAAAAAAAAAAABoAAAACAAAAAHxm7WmlvJxH5BuTz9Qn+PnWcTY9zK8s6YgIjqQyboYYAAAAAAAAAAYAAAAAAAAAAVVTRAAAAAAAfGbtaaW8nEfkG5PP1Cf4+dZxNj3MryzpiAiOpDJuhhgAAAAAdzWUAAAAAAEAAAABAAAAAQAAAAAAAAAA', 'AAAAAgAAAAMAAAAaAAAAAAAAAAB8Zu1ppbycR+Qbk8/UJ/j51nE2PcyvLOmICI6kMm6GGAAAAAJUC+OcAAAAGQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAaAAAAAAAAAAB8Zu1ppbycR+Qbk8/UJ/j51nE2PcyvLOmICI6kMm6GGAAAAAJUC+M4AAAAGQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{FsT1PugEqg3T9LcBXsahJF77FPv1KVY0JgS0vVE8TEvwUuHDkQOxcugC8gFsG8civ00pw+1YPKFweUi5pkoiDw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('5065cd7c97cfb6fbf7da8493beed47ed2c7efb3b00b77a4c92692ed487fb86a4', 25, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 13, 100, 1, '2020-01-13 14:37:29.209487', '2020-01-13 14:37:29.209487', 107374186496, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAANAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAfGbtaaW8nEfkG5PP1Cf4+dZxNj3MryzpiAiOpDJuhhgAAAACVAvkAAAAAAAAAAABVvwF9wAAAEBthwT3JCg5IZkKRNK3pHBa/eG8zq8Af9gFPWlYvEdRo6jzA5D9fYOcDpKD3dEAuPLNNAHj9tNbZUJA3rwxN94B', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAGQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaXxSNm7AAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAGQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaXxSNm7AAAAAAAAAANAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAZAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpfFI2bsAAAAAAAAAA0AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAZAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpVxF4LsAAAAAAAAAA0AAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZAAAAAAAAAAB8Zu1ppbycR+Qbk8/UJ/j51nE2PcyvLOmICI6kMm6GGAAAAAJUC+QAAAAAGQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAVAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpfFI2dQAAAAAAAAAAwAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAZAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpfFI2bsAAAAAAAAAAwAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{bYcE9yQoOSGZCkTSt6RwWv3hvM6vAH/YBT1pWLxHUaOo8wOQ/X2DnA6Sg93RALjyzTQB4/bTW2VCQN68MTfeAQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('01346de1ca30ce03149d9f54945956a22f9cbed3d81f81c62bb59cf8cdd8b893', 24, 1, 'GB2QIYT2IAUFMRXKLSLLPRECC6OCOGJMADSPTRK7TGNT2SFR2YGWDARD', 90194313217, 100, 1, '2020-01-13 14:37:29.220717', '2020-01-13 14:37:29.220717', 103079219200, 'AAAAAHUEYnpAKFZG6lyWt8SCF5wnGSwA5PnFX5mbPUix1g1hAAAAZAAAABUAAAABAAAAAAAAAAAAAAABAAAAAAAAAAMAAAABVVNEAAAAAAB1BGJ6QChWRupclrfEghecJxksAOT5xV+Zmz1IsdYNYQAAAAAAAAAAEeGjAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAbHWDWEAAABA0L+69D1hxpytAkX6cvPiBuO80ql8SQKZ15POVxx9wYl6mZrL+6UWGab/+6ng2M+a29E7ON+Xs46Y9MNqTh91AQ==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAEAAAAAXK+F1JOs84QNDhnmIjjKUDQ+mEvueZwDL/tCVRXFjncAAAAAAAAAAwAAAAAAAAAAC+vCAAAAAAFVU0QAAAAAAHUEYnpAKFZG6lyWt8SCF5wnGSwA5PnFX5mbPUix1g1hAAAAAAvrwgAAAAAAAAAAAHUEYnpAKFZG6lyWt8SCF5wnGSwA5PnFX5mbPUix1g1hAAAAAAAAAAQAAAABVVNEAAAAAAB1BGJ6QChWRupclrfEghecJxksAOT5xV+Zmz1IsdYNYQAAAAAAAAAABfXhAAAAAAEAAAABAAAAAAAAAAAAAAAA', 'AAAAAQAAAAIAAAADAAAAGAAAAAAAAAAAdQRiekAoVkbqXJa3xIIXnCcZLADk+cVfmZs9SLHWDWEAAAACVAvjnAAAABUAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAGAAAAAAAAAAAdQRiekAoVkbqXJa3xIIXnCcZLADk+cVfmZs9SLHWDWEAAAACVAvjnAAAABUAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAACQAAAAMAAAAXAAAAAgAAAABcr4XUk6zzhA0OGeYiOMpQND6YS+55nAMv+0JVFcWOdwAAAAAAAAADAAAAAAAAAAFVU0QAAAAAAHUEYnpAKFZG6lyWt8SCF5wnGSwA5PnFX5mbPUix1g1hAAAAAAvrwgAAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAIAAAACAAAAAFyvhdSTrPOEDQ4Z5iI4ylA0PphL7nmcAy/7QlUVxY53AAAAAAAAAAMAAAADAAAAFwAAAAAAAAAAXK+F1JOs84QNDhnmIjjKUDQ+mEvueZwDL/tCVRXFjncAAAACVAvjOAAAABUAAAACAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAvrwgAAAAAAAAAAAAAAAAEAAAAYAAAAAAAAAABcr4XUk6zzhA0OGeYiOMpQND6YS+55nAMv+0JVFcWOdwAAAAJIICE4AAAAFQAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwAAABcAAAABAAAAAFyvhdSTrPOEDQ4Z5iI4ylA0PphL7nmcAy/7QlUVxY53AAAAAVVTRAAAAAAAdQRiekAoVkbqXJa3xIIXnCcZLADk+cVfmZs9SLHWDWEAAAAAAAAAAH//////////AAAAAQAAAAEAAAAAC+vCAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAGAAAAAEAAAAAXK+F1JOs84QNDhnmIjjKUDQ+mEvueZwDL/tCVRXFjncAAAABVVNEAAAAAAB1BGJ6QChWRupclrfEghecJxksAOT5xV+Zmz1IsdYNYQAAAAAL68IAf/////////8AAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAAYAAAAAAAAAAB1BGJ6QChWRupclrfEghecJxksAOT5xV+Zmz1IsdYNYQAAAAJUC+OcAAAAFQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAYAAAAAAAAAAB1BGJ6QChWRupclrfEghecJxksAOT5xV+Zmz1IsdYNYQAAAAJf96WcAAAAFQAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAX14QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABgAAAACAAAAAHUEYnpAKFZG6lyWt8SCF5wnGSwA5PnFX5mbPUix1g1hAAAAAAAAAAQAAAABVVNEAAAAAAB1BGJ6QChWRupclrfEghecJxksAOT5xV+Zmz1IsdYNYQAAAAAAAAAABfXhAAAAAAEAAAABAAAAAAAAAAAAAAAA', 'AAAAAgAAAAMAAAAVAAAAAAAAAAB1BGJ6QChWRupclrfEghecJxksAOT5xV+Zmz1IsdYNYQAAAAJUC+QAAAAAFQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAYAAAAAAAAAAB1BGJ6QChWRupclrfEghecJxksAOT5xV+Zmz1IsdYNYQAAAAJUC+OcAAAAFQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{0L+69D1hxpytAkX6cvPiBuO80ql8SQKZ15POVxx9wYl6mZrL+6UWGab/+6ng2M+a29E7ON+Xs46Y9MNqTh91AQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('be05e4bd966d58689e1b6fae013e5aa77bde56e6acd2db9b96870e5e746a4ab7', 22, 1, 'GBOK7BOUSOWPHBANBYM6MIRYZJIDIPUYJPXHTHADF75UEVIVYWHHONQC', 90194313217, 100, 1, '2020-01-13 14:37:29.251056', '2020-01-13 14:37:29.251056', 94489284608, 'AAAAAFyvhdSTrPOEDQ4Z5iI4ylA0PphL7nmcAy/7QlUVxY53AAAAZAAAABUAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAAB1BGJ6QChWRupclrfEghecJxksAOT5xV+Zmz1IsdYNYX//////////AAAAAAAAAAEVxY53AAAAQDMCWfC0eGNJuYIX3s5AUNLernpcHTn8O6ygq/Nw3S5vny/W42O5G4G6UsihVU1xd5bR4im2+VzQlQYQhe0jhwg=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAFgAAAAAAAAAAXK+F1JOs84QNDhnmIjjKUDQ+mEvueZwDL/tCVRXFjncAAAACVAvjnAAAABUAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAFgAAAAAAAAAAXK+F1JOs84QNDhnmIjjKUDQ+mEvueZwDL/tCVRXFjncAAAACVAvjnAAAABUAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAWAAAAAAAAAABcr4XUk6zzhA0OGeYiOMpQND6YS+55nAMv+0JVFcWOdwAAAAJUC+OcAAAAFQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAWAAAAAAAAAABcr4XUk6zzhA0OGeYiOMpQND6YS+55nAMv+0JVFcWOdwAAAAJUC+OcAAAAFQAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAWAAAAAQAAAABcr4XUk6zzhA0OGeYiOMpQND6YS+55nAMv+0JVFcWOdwAAAAFVU0QAAAAAAHUEYnpAKFZG6lyWt8SCF5wnGSwA5PnFX5mbPUix1g1hAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAVAAAAAAAAAABcr4XUk6zzhA0OGeYiOMpQND6YS+55nAMv+0JVFcWOdwAAAAJUC+QAAAAAFQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAWAAAAAAAAAABcr4XUk6zzhA0OGeYiOMpQND6YS+55nAMv+0JVFcWOdwAAAAJUC+OcAAAAFQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{MwJZ8LR4Y0m5ghfezkBQ0t6uelwdOfw7rKCr83DdLm+fL9bjY7kbgbpSyKFVTXF3ltHiKbb5XNCVBhCF7SOHCA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('2a6987a6930eab7e3becacf9b76ed7a06802668c1f1eb0f82f5671014b4b636a', 21, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 11, 100, 1, '2020-01-13 14:37:29.262176', '2020-01-13 14:37:29.262177', 90194317312, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAALAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAXK+F1JOs84QNDhnmIjjKUDQ+mEvueZwDL/tCVRXFjncAAAACVAvkAAAAAAAAAAABVvwF9wAAAEDfpUesb4kQ/RfBx1UxqNOtZ2+4R4S0XxzggPR1C3YyhZAr/K8KyZCg4ejDTFnhu9qAh4GLZLkbBraGncT9DcYF', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAFQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LacbTsvUAAAAAAAAAAKAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAFQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LacbTsvUAAAAAAAAAALAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAVAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpxtOy9QAAAAAAAAAAsAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAVAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpoZL0tQAAAAAAAAAAsAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVAAAAAAAAAABcr4XUk6zzhA0OGeYiOMpQND6YS+55nAMv+0JVFcWOdwAAAAJUC+QAAAAAFQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAQAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpxtOzAYAAAAAAAAAAoAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAVAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpxtOy+0AAAAAAAAAAoAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{36VHrG+JEP0XwcdVMajTrWdvuEeEtF8c4ID0dQt2MoWQK/yvCsmQoOHow0xZ4bvagIeBi2S5Gwa2hp3E/Q3GBQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('96415ac1d2f79621b26b1568f963fd8dd6c50c20a22c7428cefbfe9dee867588', 21, 2, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 12, 100, 1, '2020-01-13 14:37:29.262384', '2020-01-13 14:37:29.262384', 90194321408, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAMAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAdQRiekAoVkbqXJa3xIIXnCcZLADk+cVfmZs9SLHWDWEAAAACVAvkAAAAAAAAAAABVvwF9wAAAEDdJGdvdZ2S4QoXdO+Odt8ZRdeVu7mBvq7FtP9okqr98pGD/jSAraklQvaRmCyMALIMD2kG8R2KjhKvy7oIL6IB', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAFQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaaGS9LUAAAAAAAAAALAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAFQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaaGS9LUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAVAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpoZL0tQAAAAAAAAAAwAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAVAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpfFI2dQAAAAAAAAAAwAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAVAAAAAAAAAAB1BGJ6QChWRupclrfEghecJxksAOT5xV+Zmz1IsdYNYQAAAAJUC+QAAAAAFQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAVAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpxtOy+0AAAAAAAAAAoAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAVAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpxtOy9QAAAAAAAAAAoAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{3SRnb3WdkuEKF3TvjnbfGUXXlbu5gb6uxbT/aJKq/fKRg/40gK2pJUL2kZgsjACyDA9pBvEdio4Sr8u6CC+iAQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('f08dc1fec150f276562866ce4f5272f658cf0bd9fd8c1d96a22c196be2e1b25a', 20, 1, 'GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD', 68719476739, 100, 1, '2020-01-13 14:37:29.276259', '2020-01-13 14:37:29.276259', 85899350016, 'AAAAAONt/6wGI884Zi6sYDYC1GOV/drnh4OcRrTrqJPoOTUKAAAAZAAAABAAAAADAAAAAAAAAAAAAAABAAAAAAAAAAIAAAAAAAAAADuaygAAAAAABAjoBMEUiZNLUjsWXL1iK59D90Li4w56076b8HKxZfIAAAABRVVSAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAA7msoAAAAAAAAAAAAAAAAB6Dk1CgAAAEB+7jxesBKKrF343onyycjp2tiQLZiGH2ETl+9fuOqotveY2rIgvt9ng+QJ2aDP3+PnDsYEa9ZUaA+Zne2nIGgE', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAACAAAAAAAAAAEAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAAAAAAAAgAAAAFFVVIAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAADuaygAAAAAAAAAAADuaygAAAAAABAjoBMEUiZNLUjsWXL1iK59D90Li4w56076b8HKxZfIAAAABRVVSAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAA7msoAAAAAAA==', 'AAAAAQAAAAIAAAADAAAAFAAAAAAAAAAA423/rAYjzzhmLqxgNgLUY5X92ueHg5xGtOuok+g5NQoAAAACVAvi1AAAABAAAAACAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAFAAAAAAAAAAA423/rAYjzzhmLqxgNgLUY5X92ueHg5xGtOuok+g5NQoAAAACVAvi1AAAABAAAAADAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAACAAAAAMAAAATAAAAAgAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAAAAAACAAAAAUVVUgAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAAAAAAAADuaygAAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAIAAAACAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAAAAAAIAAAADAAAAEwAAAAAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAACVAvi1AAAABAAAAADAAAAAgAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAA7msoAAAAAAHc1lAAAAAAAAAAAAAAAAAEAAAAUAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAKPpqzUAAAAEAAAAAMAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAAAdzWUAAAAAAAAAAAAAAAAAwAAABMAAAABAAAAAAQI6ATBFImTS1I7Fly9YiufQ/dC4uMOetO+m/BysWXyAAAAAUVVUgAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAAAdzWUAH//////////AAAAAQAAAAAAAAAAAAAAAQAAABQAAAABAAAAAAQI6ATBFImTS1I7Fly9YiufQ/dC4uMOetO+m/BysWXyAAAAAUVVUgAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAAAstBeAH//////////AAAAAQAAAAAAAAAAAAAAAwAAABQAAAAAAAAAAONt/6wGI884Zi6sYDYC1GOV/drnh4OcRrTrqJPoOTUKAAAAAlQL4tQAAAAQAAAAAwAAAAEAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAQAAABQAAAAAAAAAAONt/6wGI884Zi6sYDYC1GOV/drnh4OcRrTrqJPoOTUKAAAAAhhxGNQAAAAQAAAAAwAAAAEAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAA', 'AAAAAgAAAAMAAAATAAAAAAAAAADjbf+sBiPPOGYurGA2AtRjlf3a54eDnEa066iT6Dk1CgAAAAJUC+M4AAAAEAAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAUAAAAAAAAAADjbf+sBiPPOGYurGA2AtRjlf3a54eDnEa066iT6Dk1CgAAAAJUC+LUAAAAEAAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{fu48XrASiqxd+N6J8snI6drYkC2Yhh9hE5fvX7jqqLb3mNqyIL7fZ4PkCdmgz9/j5w7GBGvWVGgPmZ3tpyBoBA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('198844c8b472daacc5b717695a4ca16ac799a13fb2cf4152d19e2117ae1c56c3', 19, 1, 'GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD', 68719476738, 100, 1, '2020-01-13 14:37:29.293421', '2020-01-13 14:37:29.293421', 81604382720, 'AAAAAONt/6wGI884Zi6sYDYC1GOV/drnh4OcRrTrqJPoOTUKAAAAZAAAABAAAAACAAAAAAAAAAAAAAABAAAAAAAAAAIAAAABVVNEAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAA7msoAAAAAAAQI6ATBFImTS1I7Fly9YiufQ/dC4uMOetO+m/BysWXyAAAAAUVVUgAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAAAdzWUAAAAAAEAAAAAAAAAAAAAAAHoOTUKAAAAQMs9vNZ518oYUMp38TakovW//DDTbs/9oPj1RAix5ElC/d7gbWaaNNJxKQR7eMNO6rB+ntGqee4WurTJgA4k2ws=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAACAAAAAAAAAAIAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAAAAAAAAQAAAAAAAAAAdzWUAAAAAAFVU0QAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAADuaygAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAAAAAAAAgAAAAFFVVIAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAHc1lAAAAAAAAAAAAHc1lAAAAAAABAjoBMEUiZNLUjsWXL1iK59D90Li4w56076b8HKxZfIAAAABRVVSAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAB3NZQAAAAAAA==', 'AAAAAQAAAAIAAAADAAAAEwAAAAAAAAAA423/rAYjzzhmLqxgNgLUY5X92ueHg5xGtOuok+g5NQoAAAACVAvjOAAAABAAAAABAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAEwAAAAAAAAAA423/rAYjzzhmLqxgNgLUY5X92ueHg5xGtOuok+g5NQoAAAACVAvjOAAAABAAAAACAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAACgAAAAMAAAARAAAAAQAAAAAECOgEwRSJk0tSOxZcvWIrn0P3QuLjDnrTvpvwcrFl8gAAAAFFVVIAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAATAAAAAQAAAAAECOgEwRSJk0tSOxZcvWIrn0P3QuLjDnrTvpvwcrFl8gAAAAFFVVIAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAHc1lAB//////////wAAAAEAAAAAAAAAAAAAAAMAAAASAAAAAgAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAAAAAACAAAAAUVVUgAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAAAAAAAALLQXgAAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAEAAAATAAAAAgAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAAAAAACAAAAAUVVUgAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAAAAAAAADuaygAAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAMAAAASAAAAAgAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAAAAAABAAAAAAAAAAFVU0QAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAO5rKAAAAAABAAAAAgAAAAAAAAAAAAAAAAAAAAEAAAATAAAAAgAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAAAAAABAAAAAAAAAAFVU0QAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAHc1lAAAAAABAAAAAgAAAAAAAAAAAAAAAAAAAAMAAAASAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAJUC+LUAAAAEAAAAAMAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAALLQXgAAAAAA7msoAAAAAAAAAAAAAAAAAQAAABMAAAAAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAlQL4tQAAAAQAAAAAwAAAAIAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAEAAAAAO5rKAAAAAAB3NZQAAAAAAAAAAAAAAAADAAAAEgAAAAEAAAAA423/rAYjzzhmLqxgNgLUY5X92ueHg5xGtOuok+g5NQoAAAABVVNEAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAA7msoAf/////////8AAAABAAAAAAAAAAAAAAABAAAAEwAAAAEAAAAA423/rAYjzzhmLqxgNgLUY5X92ueHg5xGtOuok+g5NQoAAAABVVNEAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAAAAAAAf/////////8AAAABAAAAAAAAAAA=', 'AAAAAgAAAAMAAAARAAAAAAAAAADjbf+sBiPPOGYurGA2AtRjlf3a54eDnEa066iT6Dk1CgAAAAJUC+OcAAAAEAAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAATAAAAAAAAAADjbf+sBiPPOGYurGA2AtRjlf3a54eDnEa066iT6Dk1CgAAAAJUC+M4AAAAEAAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{yz281nnXyhhQynfxNqSi9b/8MNNuz/2g+PVECLHkSUL93uBtZpo00nEpBHt4w07qsH6e0ap57ha6tMmADiTbCw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('902b90c2322b9e6b335e7543389a7446b86e3039ebf59ec66dffb50eaec0dc85', 18, 1, 'GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU', 68719476737, 100, 1, '2020-01-13 14:37:29.313782', '2020-01-13 14:37:29.313782', 77309415424, 'AAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAZAAAABAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAA423/rAYjzzhmLqxgNgLUY5X92ueHg5xGtOuok+g5NQoAAAABVVNEAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAA7msoAAAAAAAAAAAERVFexAAAAQC9X2I3Zz1x3AQMqL4XCzePTlwnokv2BQnWGmT007oH59gai3eNu7/WVoHtW8hsgHjs1mZK709FzzRF2cbD2tQE=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAEgAAAAAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAACVAvi1AAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAEgAAAAAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAACVAvi1AAAABAAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAARAAAAAQAAAADjbf+sBiPPOGYurGA2AtRjlf3a54eDnEa066iT6Dk1CgAAAAFVU0QAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAASAAAAAQAAAADjbf+sBiPPOGYurGA2AtRjlf3a54eDnEa066iT6Dk1CgAAAAFVU0QAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAADuaygB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAQAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAJUC+QAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAASAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAJUC+OcAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{L1fYjdnPXHcBAyovhcLN49OXCeiS/YFCdYaZPTTugfn2BqLd427v9ZWge1byGyAeOzWZkrvT0XPNEXZxsPa1AQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('ca756d1519ceda79f8722042b12cea7ba004c3bd961adb62b59f88a867f86eb3', 18, 2, 'GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU', 68719476738, 100, 1, '2020-01-13 14:37:29.314056', '2020-01-13 14:37:29.314056', 77309419520, 'AAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAZAAAABAAAAACAAAAAAAAAAAAAAABAAAAAAAAAAMAAAAAAAAAAVVTRAAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAAA7msoAAAAAAEAAAACAAAAAAAAAAAAAAAAAAAAARFUV7EAAABALuai5QxceFbtAiC5nkntNVnvSPeWR+C+FgplPAdRgRS+PPESpUiSCyuiwuhmvuDw7kwxn+A6E0M4ca1s2qzMAg==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAAAAAAEAAAAAAAAAAVVTRAAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAAA7msoAAAAAAEAAAACAAAAAAAAAAAAAAAA', 'AAAAAQAAAAIAAAADAAAAEgAAAAAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAACVAvi1AAAABAAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAEgAAAAAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAACVAvi1AAAABAAAAACAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAASAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAJUC+LUAAAAEAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAASAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAJUC+LUAAAAEAAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAAA7msoAAAAAAAAAAAAAAAAAAAAABIAAAACAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAAAAAAEAAAAAAAAAAVVTRAAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAAA7msoAAAAAAEAAAACAAAAAAAAAAAAAAAA', 'AAAAAgAAAAMAAAASAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAJUC+OcAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAASAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAJUC+M4AAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{Luai5QxceFbtAiC5nkntNVnvSPeWR+C+FgplPAdRgRS+PPESpUiSCyuiwuhmvuDw7kwxn+A6E0M4ca1s2qzMAg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('37bb79f6959c0e8e9b3d31f6c9308d8d084d9c6742cfa56ca094cfa6eae99423', 18, 3, 'GAXMF43TGZHW3QN3REOUA2U5PW5BTARXGGYJ3JIFHW3YT6QRKRL3CPPU', 68719476739, 100, 1, '2020-01-13 14:37:29.314334', '2020-01-13 14:37:29.314334', 77309423616, 'AAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAZAAAABAAAAADAAAAAAAAAAAAAAABAAAAAAAAAAMAAAABRVVSAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAAAAAAAstBeAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAARFUV7EAAABArzp9Fxxql+yoysglDjXm9+rsJeNX2GsSa7TOy3AzHOu4Y5Z8ICx52Q885gQGQWMtEP0w6yh83d6+o6kjC/WuAg==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAAAAAAIAAAABRVVSAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAAAAAAAstBeAAAAAAEAAAABAAAAAAAAAAAAAAAA', 'AAAAAQAAAAIAAAADAAAAEgAAAAAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAACVAvi1AAAABAAAAACAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAO5rKAAAAAAAAAAAAAAAAAEAAAASAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAJUC+LUAAAAEAAAAAMAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAAAAAAAAAAAAA7msoAAAAAAAAAAAAAAAAAQAAAAMAAAADAAAAEgAAAAAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAACVAvi1AAAABAAAAADAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAO5rKAAAAAAAAAAAAAAAAAEAAAASAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAJUC+LUAAAAEAAAAAMAAAACAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAABAAAAALLQXgAAAAAA7msoAAAAAAAAAAAAAAAAAAAAABIAAAACAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAAAAAAIAAAABRVVSAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAAAAAAAstBeAAAAAAEAAAABAAAAAAAAAAAAAAAA', 'AAAAAgAAAAMAAAASAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAJUC+M4AAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAASAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAJUC+LUAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{rzp9Fxxql+yoysglDjXm9+rsJeNX2GsSa7TOy3AzHOu4Y5Z8ICx52Q885gQGQWMtEP0w6yh83d6+o6kjC/WuAg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('cdef45dd961d59375351ea7dd7ef6414ff49371a335723e84dafacea1e13665a', 17, 1, 'GDRW375MAYR46ODGF2WGANQC2RRZL7O246DYHHCGWTV2RE7IHE2QUQLD', 68719476737, 100, 1, '2020-01-13 14:37:29.327415', '2020-01-13 14:37:29.327416', 73014448128, 'AAAAAONt/6wGI884Zi6sYDYC1GOV/drnh4OcRrTrqJPoOTUKAAAAZAAAABAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsX//////////AAAAAAAAAAHoOTUKAAAAQIjLqcYXE8EAsH6Dx2hwPjiEfHGZ4jsMNZZc7PynNiJi9kFXjfvvLDlWizGAr2B9MFDrfDRDvjnBxKKhJifEcQM=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAEQAAAAAAAAAA423/rAYjzzhmLqxgNgLUY5X92ueHg5xGtOuok+g5NQoAAAACVAvjnAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAEQAAAAAAAAAA423/rAYjzzhmLqxgNgLUY5X92ueHg5xGtOuok+g5NQoAAAACVAvjnAAAABAAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAARAAAAAAAAAADjbf+sBiPPOGYurGA2AtRjlf3a54eDnEa066iT6Dk1CgAAAAJUC+OcAAAAEAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAARAAAAAAAAAADjbf+sBiPPOGYurGA2AtRjlf3a54eDnEa066iT6Dk1CgAAAAJUC+OcAAAAEAAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAARAAAAAQAAAADjbf+sBiPPOGYurGA2AtRjlf3a54eDnEa066iT6Dk1CgAAAAFVU0QAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAQAAAAAAAAAADjbf+sBiPPOGYurGA2AtRjlf3a54eDnEa066iT6Dk1CgAAAAJUC+QAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAARAAAAAAAAAADjbf+sBiPPOGYurGA2AtRjlf3a54eDnEa066iT6Dk1CgAAAAJUC+OcAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{iMupxhcTwQCwfoPHaHA+OIR8cZniOww1llzs/Kc2ImL2QVeN++8sOVaLMYCvYH0wUOt8NEO+OcHEoqEmJ8RxAw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('d1f593eb5e14f97027bc79821fa46628c107034fba9a5acef6a9da79e051ee73', 17, 2, 'GACAR2AEYEKITE2LKI5RMXF5MIVZ6Q7XILROGDT22O7JX4DSWFS7FDDP', 68719476737, 100, 1, '2020-01-13 14:37:29.327563', '2020-01-13 14:37:29.327563', 73014452224, 'AAAAAAQI6ATBFImTS1I7Fly9YiufQ/dC4uMOetO+m/BysWXyAAAAZAAAABAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABRVVSAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsX//////////AAAAAAAAAAFysWXyAAAAQI7hbwZc1+KWfheVnYAq5TXFX9ancHJmJq0wV0c9ONIfG6U8trhIVeVoiED2eUFFmhx+bBtF9TPSvifF/mfDlQk=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAEQAAAAAAAAAABAjoBMEUiZNLUjsWXL1iK59D90Li4w56076b8HKxZfIAAAACVAvjnAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAEQAAAAAAAAAABAjoBMEUiZNLUjsWXL1iK59D90Li4w56076b8HKxZfIAAAACVAvjnAAAABAAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAARAAAAAAAAAAAECOgEwRSJk0tSOxZcvWIrn0P3QuLjDnrTvpvwcrFl8gAAAAJUC+OcAAAAEAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAARAAAAAAAAAAAECOgEwRSJk0tSOxZcvWIrn0P3QuLjDnrTvpvwcrFl8gAAAAJUC+OcAAAAEAAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAARAAAAAQAAAAAECOgEwRSJk0tSOxZcvWIrn0P3QuLjDnrTvpvwcrFl8gAAAAFFVVIAAAAAAC7C83M2T23Bu4kdQGqdfboZgjcxsJ2lBT23ifoRVFexAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAQAAAAAAAAAAAECOgEwRSJk0tSOxZcvWIrn0P3QuLjDnrTvpvwcrFl8gAAAAJUC+QAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAARAAAAAAAAAAAECOgEwRSJk0tSOxZcvWIrn0P3QuLjDnrTvpvwcrFl8gAAAAJUC+OcAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{juFvBlzX4pZ+F5WdgCrlNcVf1qdwcmYmrTBXRz040h8bpTy2uEhV5WiIQPZ5QUWaHH5sG0X1M9K+J8X+Z8OVCQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('a5a9e3ca63e9cc155359c97337bcb14464cca56b230a4d0c7f27582644d16809', 16, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 8, 100, 1, '2020-01-13 14:37:29.339158', '2020-01-13 14:37:29.339158', 68719480832, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAIAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAA423/rAYjzzhmLqxgNgLUY5X92ueHg5xGtOuok+g5NQoAAAACVAvkAAAAAAAAAAABVvwF9wAAAEBhFD/bYaTZZJ3VJ9xJqXoW5eeLK0AeFaATBH92cRfx0WUTFqp6rXx47fMBUxkWYq8bAHMfYCS5XXPRg86sAGUK', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAEAAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LajaV7cGAAAAAAAAAAHAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAEAAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LajaV7cGAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAQAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqNpXtwYAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAQAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqEVUvgYAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAADjbf+sBiPPOGYurGA2AtRjlf3a54eDnEa066iT6Dk1CgAAAAJUC+QAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAANAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqNpXt1EAAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAQAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqNpXtzgAAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{YRQ/22Gk2WSd1SfcSal6FuXniytAHhWgEwR/dnEX8dFlExaqeq18eO3zAVMZFmKvGwBzH2AkuV1z0YPOrABlCg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('6a056189b45760c607e331c90c5a8b4cd720961df8bc8cecfd4aa388b577a6cb', 16, 2, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 9, 100, 1, '2020-01-13 14:37:29.339326', '2020-01-13 14:37:29.339326', 68719484928, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAJAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAABAjoBMEUiZNLUjsWXL1iK59D90Li4w56076b8HKxZfIAAAACVAvkAAAAAAAAAAABVvwF9wAAAEAxC5cl7tkjQI0cfFZTiIFDuo0SwyYnNqTUH2hxDBtm7h/vUkBG3cgwGXS87ninVkhmvdIpTWfeIeGiw7kgefUA', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAEAAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LahFVL4GAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAEAAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LahFVL4GAAAAAAAAAAJAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAQAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqEVUvgYAAAAAAAAAAkAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAQAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtp7BRxQYAAAAAAAAAAkAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAECOgEwRSJk0tSOxZcvWIrn0P3QuLjDnrTvpvwcrFl8gAAAAJUC+QAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAQAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqNpXtzgAAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAQAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqNpXtx8AAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{MQuXJe7ZI0CNHHxWU4iBQ7qNEsMmJzak1B9ocQwbZu4f71JARt3IMBl0vO54p1ZIZr3SKU1n3iHhosO5IHn1AA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('18bf6cce20cfbb0f9079c4b8783718949d13bd12d173a60363d2b8e3a07efead', 16, 3, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 10, 100, 1, '2020-01-13 14:37:29.33947', '2020-01-13 14:37:29.33947', 68719489024, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAKAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAALsLzczZPbcG7iR1Aap19uhmCNzGwnaUFPbeJ+hFUV7EAAAACVAvkAAAAAAAAAAABVvwF9wAAAEC/RVto6ytAqHpd6ZFWjwXQyXopKORz8QSvz0d8RoPrOEBgNEuAj8+kbyhS7QieOqwbiJrS0AU8YWaBQQ4zc+wL', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAAEAAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaewUcUGAAAAAAAAAAJAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAEAAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaewUcUGAAAAAAAAAAKAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAQAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtp7BRxQYAAAAAAAAAAoAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAQAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtpxtOzAYAAAAAAAAAAoAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAuwvNzNk9twbuJHUBqnX26GYI3MbCdpQU9t4n6EVRXsQAAAAJUC+QAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAQAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqNpXtx8AAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAQAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqNpXtwYAAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{v0VbaOsrQKh6XemRVo8F0Ml6KSjkc/EEr89HfEaD6zhAYDRLgI/PpG8oUu0InjqsG4ia0tAFPGFmgUEOM3PsCw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('142c988b1f67984f74a1581de9caecf499e60f1e0eed496661aa2c559238764c', 15, 1, 'GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG', 55834574850, 100, 1, '2020-01-13 14:37:29.349924', '2020-01-13 14:37:29.349925', 64424513536, 'AAAAAI4uD0KXOiTFreQAeellyBKKdeD5+7Vurn+sRPr2O2TcAAAAZAAAAA0AAAACAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAAG5M9WO2kexu4dljTd0YSuyEnmDUsxKamzJWiv4FGkoQAAAABVVNEAAAAAACOLg9Clzokxa3kAHnpZcgSinXg+fu1bq5/rET69jtk3AAAAAAF9eEAAAAAAAAAAAH2O2TcAAAAQJBUx5tWfjAwXxab9U5HOjZvBRv3u95jXbyzuqeZ/kjsyMsU0jO/g03Rf1zgect1hj4hDYGN8mW4oEot0sSTZgw=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAADwAAAAAAAAAAji4PQpc6JMWt5AB56WXIEop14Pn7tW6uf6xE+vY7ZNwAAAACThYCOAAAAA0AAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAADwAAAAAAAAAAji4PQpc6JMWt5AB56WXIEop14Pn7tW6uf6xE+vY7ZNwAAAACThYCOAAAAA0AAAACAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAOAAAAAQAAAAAbkz1Y7aR7G7h2WNN3RhK7ISeYNSzEpqbMlaK/gUaShAAAAAFVU0QAAAAAAI4uD0KXOiTFreQAeellyBKKdeD5+7Vurn+sRPr2O2TcAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAAAAAAEAAAAPAAAAAQAAAAAbkz1Y7aR7G7h2WNN3RhK7ISeYNSzEpqbMlaK/gUaShAAAAAFVU0QAAAAAAI4uD0KXOiTFreQAeellyBKKdeD5+7Vurn+sRPr2O2TcAAAAAAX14QB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAOAAAAAAAAAACOLg9Clzokxa3kAHnpZcgSinXg+fu1bq5/rET69jtk3AAAAAJOFgKcAAAADQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAPAAAAAAAAAACOLg9Clzokxa3kAHnpZcgSinXg+fu1bq5/rET69jtk3AAAAAJOFgI4AAAADQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{kFTHm1Z+MDBfFpv1Tkc6Nm8FG/e73mNdvLO6p5n+SOzIyxTSM7+DTdF/XOB5y3WGPiENgY3yZbigSi3SxJNmDA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('dbd964fcfdb336a30f21c240fffdaf73d7c75880ed1b99375c62f84e3e592570', 14, 1, 'GANZGPKY5WSHWG5YOZMNG52GCK5SCJ4YGUWMJJVGZSK2FP4BI2JIJN2C', 55834574849, 100, 1, '2020-01-13 14:37:29.360833', '2020-01-13 14:37:29.360833', 60129546240, 'AAAAABuTPVjtpHsbuHZY03dGErshJ5g1LMSmpsyVor+BRpKEAAAAZAAAAA0AAAABAAAAAAAAAAAAAAABAAAAAAAAAAYAAAABVVNEAAAAAACOLg9Clzokxa3kAHnpZcgSinXg+fu1bq5/rET69jtk3H//////////AAAAAAAAAAGBRpKEAAAAQGDAV/5Op2DmFUP84dmyT5G/gxn1WzgdMrkSSU7wfpu39ycq36Sg+gs2ypRjw5hxxeMUj/GVEKipcDGndei38Aw=', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAGAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAADgAAAAAAAAAAG5M9WO2kexu4dljTd0YSuyEnmDUsxKamzJWiv4FGkoQAAAACVAvjnAAAAA0AAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAADgAAAAAAAAAAG5M9WO2kexu4dljTd0YSuyEnmDUsxKamzJWiv4FGkoQAAAACVAvjnAAAAA0AAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAOAAAAAAAAAAAbkz1Y7aR7G7h2WNN3RhK7ISeYNSzEpqbMlaK/gUaShAAAAAJUC+OcAAAADQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAOAAAAAAAAAAAbkz1Y7aR7G7h2WNN3RhK7ISeYNSzEpqbMlaK/gUaShAAAAAJUC+OcAAAADQAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOAAAAAQAAAAAbkz1Y7aR7G7h2WNN3RhK7ISeYNSzEpqbMlaK/gUaShAAAAAFVU0QAAAAAAI4uD0KXOiTFreQAeellyBKKdeD5+7Vurn+sRPr2O2TcAAAAAAAAAAB//////////wAAAAEAAAAAAAAAAA==', 'AAAAAgAAAAMAAAANAAAAAAAAAAAbkz1Y7aR7G7h2WNN3RhK7ISeYNSzEpqbMlaK/gUaShAAAAAJUC+QAAAAADQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAOAAAAAAAAAAAbkz1Y7aR7G7h2WNN3RhK7ISeYNSzEpqbMlaK/gUaShAAAAAJUC+OcAAAADQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{YMBX/k6nYOYVQ/zh2bJPkb+DGfVbOB0yuRJJTvB+m7f3JyrfpKD6CzbKlGPDmHHF4xSP8ZUQqKlwMad16LfwDA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('30880dd42d8e402a30d8a3527b56c1e33e18e87c46e1332ea5cfc1721fd87cfb', 14, 2, 'GCHC4D2CS45CJRNN4QAHT2LFZAJIU5PA7H53K3VOP6WEJ6XWHNSNZKQG', 55834574849, 100, 1, '2020-01-13 14:37:29.361044', '2020-01-13 14:37:29.361044', 60129550336, 'AAAAAI4uD0KXOiTFreQAeellyBKKdeD5+7Vurn+sRPr2O2TcAAAAZAAAAA0AAAABAAAAAAAAAAAAAAABAAAAAAAAAAEAAAAAG5M9WO2kexu4dljTd0YSuyEnmDUsxKamzJWiv4FGkoQAAAAAAAAAAAX14QAAAAAAAAAAAfY7ZNwAAABAieZSSuOZqlwtyjnj5d/S0GUSGiQvy0ipPLynpl4UvO8qc7CDz3vsLROlN2g50qXirydSOdao56hvRhrEfRsGCA==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAADgAAAAAAAAAAji4PQpc6JMWt5AB56WXIEop14Pn7tW6uf6xE+vY7ZNwAAAACVAvjnAAAAA0AAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAADgAAAAAAAAAAji4PQpc6JMWt5AB56WXIEop14Pn7tW6uf6xE+vY7ZNwAAAACVAvjnAAAAA0AAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAMAAAAOAAAAAAAAAAAbkz1Y7aR7G7h2WNN3RhK7ISeYNSzEpqbMlaK/gUaShAAAAAJUC+OcAAAADQAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAOAAAAAAAAAAAbkz1Y7aR7G7h2WNN3RhK7ISeYNSzEpqbMlaK/gUaShAAAAAJaAcScAAAADQAAAAEAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAMAAAAOAAAAAAAAAACOLg9Clzokxa3kAHnpZcgSinXg+fu1bq5/rET69jtk3AAAAAJUC+OcAAAADQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAOAAAAAAAAAACOLg9Clzokxa3kAHnpZcgSinXg+fu1bq5/rET69jtk3AAAAAJOFgKcAAAADQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAANAAAAAAAAAACOLg9Clzokxa3kAHnpZcgSinXg+fu1bq5/rET69jtk3AAAAAJUC+QAAAAADQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAOAAAAAAAAAACOLg9Clzokxa3kAHnpZcgSinXg+fu1bq5/rET69jtk3AAAAAJUC+OcAAAADQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{ieZSSuOZqlwtyjnj5d/S0GUSGiQvy0ipPLynpl4UvO8qc7CDz3vsLROlN2g50qXirydSOdao56hvRhrEfRsGCA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('cd8a8e9eb53fd268d1294e228995c27f422d90783c4054e44ab0028fc1da210a', 13, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 6, 100, 1, '2020-01-13 14:37:29.37119', '2020-01-13 14:37:29.37119', 55834578944, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAGAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAji4PQpc6JMWt5AB56WXIEop14Pn7tW6uf6xE+vY7ZNwAAAACVAvkAAAAAAAAAAABVvwF9wAAAEAUtdYWyr64yv/rKPr0/vV4vYyonfsWxpxHsiYLHKJ3bm6k+ypiAByc8t0K+7bzxSLPjmjKKN5Prw7AdenlC7MB', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAADQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaoEXalRAAAAAAAAAAFAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAADQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaoEXalRAAAAAAAAAAGAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAANAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqgRdqVEAAAAAAAAAAYAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAANAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqW9asFEAAAAAAAAAAYAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAANAAAAAAAAAACOLg9Clzokxa3kAHnpZcgSinXg+fu1bq5/rET69jtk3AAAAAJUC+QAAAAADQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAALAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqgRdqYMAAAAAAAAAAUAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAANAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqgRdqWoAAAAAAAAAAUAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{FLXWFsq+uMr/6yj69P71eL2MqJ37FsacR7ImCxyid25upPsqYgAcnPLdCvu288Uiz45oyijeT68OwHXp5QuzAQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('bfbd5e9457d717bcf847291a6c24b7cd8db4ff784ecd4592be30d08146c0c264', 13, 2, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 7, 100, 1, '2020-01-13 14:37:29.371328', '2020-01-13 14:37:29.371328', 55834583040, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAHAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAG5M9WO2kexu4dljTd0YSuyEnmDUsxKamzJWiv4FGkoQAAAACVAvkAAAAAAAAAAABVvwF9wAAAEDY1TiMj+qj8+zYb2Vb60h+qWxZtFfSGwb0kvKttSFAHQhGOjIddiVQopx9LDRO6UgPmLLxFvQpIzeGnagh3vQD', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAADQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LalvWrBRAAAAAAAAAAGAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAADQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LalvWrBRAAAAAAAAAAHAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAANAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqW9asFEAAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAANAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqNpXt1EAAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAANAAAAAAAAAAAbkz1Y7aR7G7h2WNN3RhK7ISeYNSzEpqbMlaK/gUaShAAAAAJUC+QAAAAADQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAANAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqgRdqWoAAAAAAAAAAUAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAANAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqgRdqVEAAAAAAAAAAUAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{2NU4jI/qo/Ps2G9lW+tIfqlsWbRX0hsG9JLyrbUhQB0IRjoyHXYlUKKcfSw0TulID5iy8Rb0KSM3hp2oId70Aw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('0e128647b2b93786b6b76e182dcda0173757066f8caf0523d1ba3b47fd6f720d', 12, 1, 'GDCVTBGSEEU7KLXUMHMSXBALXJ2T4I2KOPXW2S5TRLKDRIAXD5UDHAYO', 47244640257, 100, 1, '2020-01-13 14:37:29.381812', '2020-01-13 14:37:29.381812', 51539611648, 'AAAAAMVZhNIhKfUu9GHZK4QLunU+I0pz721Ls4rUOKAXH2gzAAAAZAAAAAsAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAg/K/Blr9FO/nVEGLdmCzChMYpmcQzxIhFm6NBzxznX0AAAAAHc1lAAAAAAAAAAABFx9oMwAAAEBwY9HQAR2SMPe3JPvmBBtBk2jfog0GFEFYkLNFzQNqvYl7iZitmO5FQmkKlv/NO5ZcaWBqXcHhOQpk0s2XSBQF', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAADAAAAAAAAAAAxVmE0iEp9S70YdkrhAu6dT4jSnPvbUuzitQ4oBcfaDMAAAACVAvjnAAAAAsAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAADAAAAAAAAAAAxVmE0iEp9S70YdkrhAu6dT4jSnPvbUuzitQ4oBcfaDMAAAACVAvjnAAAAAsAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAMAAAAAAAAAADFWYTSISn1LvRh2SuEC7p1PiNKc+9tS7OK1DigFx9oMwAAAAJUC+OcAAAACwAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAMAAAAAAAAAADFWYTSISn1LvRh2SuEC7p1PiNKc+9tS7OK1DigFx9oMwAAAAI2Pn6cAAAACwAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMAAAAAAAAAACD8r8GWv0U7+dUQYt2YLMKEximZxDPEiEWbo0HPHOdfQAAAAAdzWUAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAALAAAAAAAAAADFWYTSISn1LvRh2SuEC7p1PiNKc+9tS7OK1DigFx9oMwAAAAJUC+QAAAAACwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAMAAAAAAAAAADFWYTSISn1LvRh2SuEC7p1PiNKc+9tS7OK1DigFx9oMwAAAAJUC+OcAAAACwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{cGPR0AEdkjD3tyT75gQbQZNo36INBhRBWJCzRc0Dar2Je4mYrZjuRUJpCpb/zTuWXGlgal3B4TkKZNLNl0gUBQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('67601a2ca212b84092a7d3c521172b67f4b93d72b726a06c540917d2ab83c1a1', 11, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 5, 100, 1, '2020-01-13 14:37:29.392081', '2020-01-13 14:37:29.392081', 47244644352, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAFAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAxVmE0iEp9S70YdkrhAu6dT4jSnPvbUuzitQ4oBcfaDMAAAACVAvkAAAAAAAAAAABVvwF9wAAAEBHLko6/Tbv0v/5CWHkixXnbyoU6qQ6yewZGqPHFSzNxMfud86eYGkN0j4msMCXfLAou7iKOVn0MWyzlpvYRA0B', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAACwAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaqZYKKDAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAACwAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaqZYKKDAAAAAAAAAAFAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAALAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqplgooMAAAAAAAAAAUAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAALAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqgRdqYMAAAAAAAAAAUAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAALAAAAAAAAAADFWYTSISn1LvRh2SuEC7p1PiNKc+9tS7OK1DigFx9oMwAAAAJUC+QAAAAACwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAKAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqplgopwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAALAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqplgooMAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{Ry5KOv0279L/+Qlh5IsV528qFOqkOsnsGRqjxxUszcTH7nfOnmBpDdI+JrDAl3ywKLu4ijlZ9DFss5ab2EQNAQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('fdb696a797b769176cbaed3a50e4a6a8671119621f65a3f954a3bcf100c7ef0c', 10, 1, 'GAG52TW6QAB6TGNMOTL32Y4M3UQQLNNNHPEHYAIYRP6SFF6ZAVRF5ZQY', 38654705665, 200, 2, '2020-01-13 14:37:29.401785', '2020-01-13 14:37:29.401786', 42949677056, 'AAAAAA3dTt6AA+mZrHTXvWOM3SEFta07yHwBGIv9IpfZBWJeAAAAyAAAAAkAAAABAAAAAAAAAAAAAAACAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAAX14QAAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAABfXhAAAAAAAAAAAB2QViXgAAAEAxyl5gvCCDC7l0pq9b/Btd3cOUUcY9Rv0ALxVjul4EVSL1Vygr107GjDo11+YswdmlCuWf7KItU0chlogpns4L', 'AAAAAAAAAMgAAAAAAAAAAgAAAAAAAAABAAAAAAAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAACgAAAAAAAAAADd1O3oAD6ZmsdNe9Y4zdIQW1rTvIfAEYi/0il9kFYl4AAAACVAvjOAAAAAkAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAACgAAAAAAAAAADd1O3oAD6ZmsdNe9Y4zdIQW1rTvIfAEYi/0il9kFYl4AAAACVAvjOAAAAAkAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAACAAAABAAAAAMAAAAJAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqpZlshwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAKAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqpfjKlwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAMAAAAKAAAAAAAAAAAN3U7egAPpmax0171jjN0hBbWtO8h8ARiL/SKX2QViXgAAAAJUC+M4AAAACQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAKAAAAAAAAAAAN3U7egAPpmax0171jjN0hBbWtO8h8ARiL/SKX2QViXgAAAAJOFgI4AAAACQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAQAAAADAAAACgAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaqX4ypcAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAACgAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaqZYKKcAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAADAAAACgAAAAAAAAAADd1O3oAD6ZmsdNe9Y4zdIQW1rTvIfAEYi/0il9kFYl4AAAACThYCOAAAAAkAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAACgAAAAAAAAAADd1O3oAD6ZmsdNe9Y4zdIQW1rTvIfAEYi/0il9kFYl4AAAACSCAhOAAAAAkAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAA=', 'AAAAAgAAAAMAAAAJAAAAAAAAAAAN3U7egAPpmax0171jjN0hBbWtO8h8ARiL/SKX2QViXgAAAAJUC+QAAAAACQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAKAAAAAAAAAAAN3U7egAPpmax0171jjN0hBbWtO8h8ARiL/SKX2QViXgAAAAJUC+M4AAAACQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{McpeYLwggwu5dKavW/wbXd3DlFHGPUb9AC8VY7peBFUi9VcoK9dOxow6NdfmLMHZpQrln+yiLVNHIZaIKZ7OCw==}', 'none', NULL, NULL, true, 200);
INSERT INTO history_transactions VALUES ('66c28c0ccd5a2e47026aacafa2ecd3c501fe5de349ef376c0f8afb893c7bb55d', 9, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 4, 100, 1, '2020-01-13 14:37:29.41184', '2020-01-13 14:37:29.41184', 38654709760, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAAEAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAADd1O3oAD6ZmsdNe9Y4zdIQW1rTvIfAEYi/0il9kFYl4AAAACVAvkAAAAAAAAAAABVvwF9wAAAEARD6MVWgEASusfhr6JdF9K3Rie2XCRJKl/NoKyJcrd1kGs3ygpp55xu80YlFwgNVErZ/cEAHYOq06CwNfnE2sC', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAACQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LasraKscAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAACQAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LasraKscAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAJAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqytoqxwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAJAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqpZlshwAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJAAAAAAAAAAAN3U7egAPpmax0171jjN0hBbWtO8h8ARiL/SKX2QViXgAAAAJUC+QAAAAACQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAIAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqytoqzUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAJAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqytoqxwAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{EQ+jFVoBAErrH4a+iXRfSt0YntlwkSSpfzaCsiXK3dZBrN8oKaeecbvNGJRcIDVRK2f3BAB2DqtOgsDX5xNrAg==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('dd74eee27a59843b28a05ad08abf65eaa231b7debe4d05550c0a7a424cca5929', 8, 1, 'GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB', 30064771073, 100, 1, '2020-01-13 14:37:29.421981', '2020-01-13 14:37:29.421981', 34359742464, 'AAAAADnqxUES0av4d13+BBKxKs+6A/cJNtM1/nf4eHV3Ow06AAAAZAAAAAcAAAABAAAAAAAAAAIAAAAAAAAAewAAAAEAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAJiWgAAAAAAAAAABdzsNOgAAAEBjk5EFqV8GiL9xU62OUCKeScXxGMTMqJoD7ryiGf5jLPZJRSphbWC3ZycHE+pDuu/6EKSqcNUri5AXzQmM+GYB', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAACAAAAAAAAAAAOerFQRLRq/h3Xf4EErEqz7oD9wk20zX+d/h4dXc7DToAAAACVAvicAAAAAcAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAACAAAAAAAAAAAOerFQRLRq/h3Xf4EErEqz7oD9wk20zX+d/h4dXc7DToAAAACVAvicAAAAAcAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAMAAAAHAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqyrQFLUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqyr2OlUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAMAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJUC+JwAAAABwAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJTc0vwAAAABwAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAHAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJUC+QAAAAABwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJUC+OcAAAABwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{Y5ORBalfBoi/cVOtjlAinknF8RjEzKiaA+68ohn+Yyz2SUUqYW1gt2cnBxPqQ7rv+hCkqnDVK4uQF80JjPhmAQ==}', 'id', '123', NULL, true, 100);
INSERT INTO history_transactions VALUES ('2551e76a3ce4881b7bc73fdfd89d670d511ea7d4e56156252b51777023202de7', 8, 2, 'GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB', 30064771074, 100, 1, '2020-01-13 14:37:29.422131', '2020-01-13 14:37:29.422131', 34359746560, 'AAAAADnqxUES0av4d13+BBKxKs+6A/cJNtM1/nf4eHV3Ow06AAAAZAAAAAcAAAACAAAAAAAAAAEAAAAFaGVsbG8AAAAAAAABAAAAAAAAAAEAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcAAAAAAAAAAACYloAAAAAAAAAAAXc7DToAAABAS2+MaPA79AjD0B7qjl0qEz0N6CkDmoS4kgnXjZfbvdc9IkqNm0S+vKBNgV80pSfixY147L+jvS/ganovqbLiAQ==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAACAAAAAAAAAAAOerFQRLRq/h3Xf4EErEqz7oD9wk20zX+d/h4dXc7DToAAAACU3NL8AAAAAcAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAACAAAAAAAAAAAOerFQRLRq/h3Xf4EErEqz7oD9wk20zX+d/h4dXc7DToAAAACU3NL8AAAAAcAAAACAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAMAAAAIAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqyr2OlUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqyscX/UAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAMAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJTc0vwAAAABwAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJS2rVwAAAABwAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJUC+OcAAAABwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJUC+M4AAAABwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{S2+MaPA79AjD0B7qjl0qEz0N6CkDmoS4kgnXjZfbvdc9IkqNm0S+vKBNgV80pSfixY147L+jvS/ganovqbLiAQ==}', 'text', 'hello', NULL, true, 100);
INSERT INTO history_transactions VALUES ('3b36ecfbcc2adb0cfff08ae86199f64e12984f084bb03be9bb249611df82322b', 8, 3, 'GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB', 30064771075, 100, 1, '2020-01-13 14:37:29.422252', '2020-01-13 14:37:29.422252', 34359750656, 'AAAAADnqxUES0av4d13+BBKxKs+6A/cJNtM1/nf4eHV3Ow06AAAAZAAAAAcAAAADAAAAAAAAAAMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQAAAAEAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAJiWgAAAAAAAAAABdzsNOgAAAEDC9hMtMYZ6hbx1iAdXngRcCYQmf8eu4zcB9SLH2998tVYca6QYig5Dsgy2oCMD1J7khIL9jz/VWjcPhvTVvC8L', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAACAAAAAAAAAAAOerFQRLRq/h3Xf4EErEqz7oD9wk20zX+d/h4dXc7DToAAAACUtq1cAAAAAcAAAACAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAACAAAAAAAAAAAOerFQRLRq/h3Xf4EErEqz7oD9wk20zX+d/h4dXc7DToAAAACUtq1cAAAAAcAAAADAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAMAAAAIAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqyscX/UAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqytChZUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAMAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJS2rVwAAAABwAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJSQh7wAAAABwAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJUC+M4AAAABwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJUC+LUAAAABwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{wvYTLTGGeoW8dYgHV54EXAmEJn/HruM3AfUix9vffLVWHGukGIoOQ7IMtqAjA9Se5ISC/Y8/1Vo3D4b01bwvCw==}', 'hash', 'AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE=', NULL, true, 100);
INSERT INTO history_transactions VALUES ('e14885cb66af5f7f5e991b014eec475c61cc831292cf5526cdd0cda145300837', 8, 4, 'GA46VRKBCLI2X6DXLX7AIEVRFLH3UA7XBE3NGNP6O74HQ5LXHMGTV2JB', 30064771076, 100, 1, '2020-01-13 14:37:29.422414', '2020-01-13 14:37:29.422414', 34359754752, 'AAAAADnqxUES0av4d13+BBKxKs+6A/cJNtM1/nf4eHV3Ow06AAAAZAAAAAcAAAAEAAAAAAAAAAQCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgAAAAEAAAAAAAAAAQAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9wAAAAAAAAAAAJiWgAAAAAAAAAABdzsNOgAAAEBOfq9PQ8EGcpjRWEaqGxvhBjSVuk6K5A2rthLYHnmAXmQ1JjJD3EddjiES3bPZUF5efGQvRjoEKgiB2dU3f2wF', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAACAAAAAAAAAAAOerFQRLRq/h3Xf4EErEqz7oD9wk20zX+d/h4dXc7DToAAAACUkIe8AAAAAcAAAADAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAACAAAAAAAAAAAOerFQRLRq/h3Xf4EErEqz7oD9wk20zX+d/h4dXc7DToAAAACUkIe8AAAAAcAAAAEAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAMAAAAIAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqytChZUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqytoqzUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAMAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJSQh7wAAAABwAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJRqYhwAAAABwAAAAQAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJUC+LUAAAABwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAIAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJUC+JwAAAABwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{Tn6vT0PBBnKY0VhGqhsb4QY0lbpOiuQNq7YS2B55gF5kNSYyQ9xHXY4hEt2z2VBeXnxkL0Y6BCoIgdnVN39sBQ==}', 'return', 'AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI=', NULL, true, 100);
INSERT INTO history_transactions VALUES ('0fb9c2e20946222b23e1d1d660de9d74576c41cfd9b199f9d565a013c1ef89ca', 7, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 3, 100, 1, '2020-01-13 14:37:29.434746', '2020-01-13 14:37:29.434746', 30064775168, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAADAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAOerFQRLRq/h3Xf4EErEqz7oD9wk20zX+d/h4dXc7DToAAAACVAvkAAAAAAAAAAABVvwF9wAAAED8tIFyog9OeCqiaBNfxFdAlneNYTfjoNUMKi6FJCY5BqemnDBxGox3jKS/xx4zpxAToEFp3Y2M+NRJIU4g/H0J', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAABwAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4Lau/0w21AAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABwAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4Lau/0w21AAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAHAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtq7/TDbUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAHAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtqyrQFLUAAAAAAAAAAMAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHAAAAAAAAAAA56sVBEtGr+Hdd/gQSsSrPugP3CTbTNf53+Hh1dzsNOgAAAAJUC+QAAAAABwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAEAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtq7/TDc4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAHAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtq7/TDbUAAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{/LSBcqIPTngqomgTX8RXQJZ3jWE346DVDCouhSQmOQanppwwcRqMd4ykv8ceM6cQE6BBad2NjPjUSSFOIPx9CQ==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('a9085e13fbe9f84e07e320a0d445536de1afc2cfd8c7e4186687807edd2b4897', 6, 1, 'GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB', 17179869188, 100, 1, '2020-01-13 14:37:29.453284', '2020-01-13 14:37:29.453285', 25769807872, 'AAAAAO5QGSKQkcErWDq9iKwemolyxv8LDVZBwWLQSiYp7iDVAAAAZAAAAAQAAAAEAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAEAAAACAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAinuINUAAABA4PRAe0en/05ZH2leCeTOsxbT0cUu3wgUiWUcuDk4ya8G/gI90hlV6pzOYyAB6Zt5fN7pRrPRL/tTlnjgUAjaBvwNxUcAAABAFmdGR6JZukKJUC3Vr2YEJ/24G3tesqTv4cV5UcAozRhS2+w0PYVVqe7QTmOMNSGX/C3LxP1tSvpXdU/OhYsODw==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAABgAAAAAAAAAA7lAZIpCRwStYOr2IrB6aiXLG/wsNVkHBYtBKJinuINUAAAACVAvicAAAAAQAAAADAAAAAQAAAAAAAAAAAAAAAAECAgIAAAABAAAAAPZPnUyLZ+OYJjhn5Hkk43UuW6rOuemZPFQldOn8DcVHAAAAAQAAAAAAAAAAAAAAAQAAAAYAAAAAAAAAAO5QGSKQkcErWDq9iKwemolyxv8LDVZBwWLQSiYp7iDVAAAAAlQL4nAAAAAEAAAABAAAAAEAAAAAAAAAAAAAAAABAgICAAAAAQAAAAD2T51Mi2fjmCY4Z+R5JON1LluqzrnpmTxUJXTp/A3FRwAAAAEAAAAAAAAAAAAAAAEAAAACAAAAAwAAAAYAAAAAAAAAAO5QGSKQkcErWDq9iKwemolyxv8LDVZBwWLQSiYp7iDVAAAAAlQL4nAAAAAEAAAABAAAAAEAAAAAAAAAAAAAAAABAgICAAAAAQAAAAD2T51Mi2fjmCY4Z+R5JON1LluqzrnpmTxUJXTp/A3FRwAAAAEAAAAAAAAAAAAAAAEAAAAGAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+JwAAAABAAAAAQAAAABAAAAAAAAAAAAAAAAAgICAgAAAAEAAAAA9k+dTItn45gmOGfkeSTjdS5bqs656Zk8VCV06fwNxUcAAAABAAAAAAAAAAA=', 'AAAAAgAAAAMAAAAFAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+LUAAAABAAAAAMAAAABAAAAAAAAAAAAAAAAAQICAgAAAAEAAAAA9k+dTItn45gmOGfkeSTjdS5bqs656Zk8VCV06fwNxUcAAAABAAAAAAAAAAAAAAABAAAABgAAAAAAAAAA7lAZIpCRwStYOr2IrB6aiXLG/wsNVkHBYtBKJinuINUAAAACVAvicAAAAAQAAAADAAAAAQAAAAAAAAAAAAAAAAECAgIAAAABAAAAAPZPnUyLZ+OYJjhn5Hkk43UuW6rOuemZPFQldOn8DcVHAAAAAQAAAAAAAAAA', '{4PRAe0en/05ZH2leCeTOsxbT0cUu3wgUiWUcuDk4ya8G/gI90hlV6pzOYyAB6Zt5fN7pRrPRL/tTlnjgUAjaBg==,FmdGR6JZukKJUC3Vr2YEJ/24G3tesqTv4cV5UcAozRhS2+w0PYVVqe7QTmOMNSGX/C3LxP1tSvpXdU/OhYsODw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('e9d1a3000aea36743142f2ede106d3cb37c3d7e88508e3f21b496370b5863858', 5, 1, 'GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB', 17179869185, 100, 1, '2020-01-13 14:37:29.464985', '2020-01-13 14:37:29.464985', 21474840576, 'AAAAAO5QGSKQkcErWDq9iKwemolyxv8LDVZBwWLQSiYp7iDVAAAAZAAAAAQAAAABAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAEAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAASnuINUAAABASz0AtZeNzXSXkjPkKJfOE8aUTAuPR6pxMMbF337wxE3wzOTDaVcDQ2N5P3E9MKc+fbbFhZ9K+07+J0wMGltRBA==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAABQAAAAAAAAAA7lAZIpCRwStYOr2IrB6aiXLG/wsNVkHBYtBKJinuINUAAAACVAvi1AAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABQAAAAAAAAAA7lAZIpCRwStYOr2IrB6aiXLG/wsNVkHBYtBKJinuINUAAAACVAvi1AAAAAQAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAFAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+LUAAAABAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+LUAAAABAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAAEAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+QAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+OcAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{Sz0AtZeNzXSXkjPkKJfOE8aUTAuPR6pxMMbF337wxE3wzOTDaVcDQ2N5P3E9MKc+fbbFhZ9K+07+J0wMGltRBA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('995b9269f9f9c4c1eace75501188766d6e8ae40c5413120811a50437683cb74c', 5, 2, 'GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB', 17179869186, 100, 1, '2020-01-13 14:37:29.465108', '2020-01-13 14:37:29.465108', 21474844672, 'AAAAAO5QGSKQkcErWDq9iKwemolyxv8LDVZBwWLQSiYp7iDVAAAAZAAAAAQAAAACAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAD2T51Mi2fjmCY4Z+R5JON1LluqzrnpmTxUJXTp/A3FRwAAAAEAAAAAAAAAASnuINUAAABADpkMMc7kkkYjDoPwfUlOE9tLYvWHI/m+BBe/gCKN1cVvEF1UBVeCCuGBTjury4TqoxplKl4NZHJST5/Orr4XCA==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAABQAAAAAAAAAA7lAZIpCRwStYOr2IrB6aiXLG/wsNVkHBYtBKJinuINUAAAACVAvi1AAAAAQAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABQAAAAAAAAAA7lAZIpCRwStYOr2IrB6aiXLG/wsNVkHBYtBKJinuINUAAAACVAvi1AAAAAQAAAACAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAgAAAAMAAAAFAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+LUAAAABAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+LUAAAABAAAAAIAAAABAAAAAAAAAAAAAAAAAQAAAAAAAAEAAAAA9k+dTItn45gmOGfkeSTjdS5bqs656Zk8VCV06fwNxUcAAAABAAAAAAAAAAA=', 'AAAAAgAAAAMAAAAFAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+OcAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+M4AAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{DpkMMc7kkkYjDoPwfUlOE9tLYvWHI/m+BBe/gCKN1cVvEF1UBVeCCuGBTjury4TqoxplKl4NZHJST5/Orr4XCA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('f78dca926455579b4a43009ffe35a0229a6da4bed32d3c999d7a06ad26605a25', 5, 3, 'GDXFAGJCSCI4CK2YHK6YRLA6TKEXFRX7BMGVMQOBMLIEUJRJ5YQNLMIB', 17179869187, 100, 1, '2020-01-13 14:37:29.465222', '2020-01-13 14:37:29.465222', 21474848768, 'AAAAAO5QGSKQkcErWDq9iKwemolyxv8LDVZBwWLQSiYp7iDVAAAAZAAAAAQAAAADAAAAAAAAAAAAAAABAAAAAAAAAAUAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAAAAAABAAAAAgAAAAEAAAACAAAAAQAAAAIAAAAAAAAAAAAAAAAAAAABKe4g1QAAAEDglRRymtLjw+ImmGwTiBTKE7X7+2CywlHw8qed+t520SbAggcqboy5KXJaEP51/wRSMxtZUgDOFfaDn9Df04EA', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAABQAAAAAAAAAA7lAZIpCRwStYOr2IrB6aiXLG/wsNVkHBYtBKJinuINUAAAACVAvi1AAAAAQAAAACAAAAAQAAAAAAAAAAAAAAAAEAAAAAAAABAAAAAPZPnUyLZ+OYJjhn5Hkk43UuW6rOuemZPFQldOn8DcVHAAAAAQAAAAAAAAAAAAAAAQAAAAUAAAAAAAAAAO5QGSKQkcErWDq9iKwemolyxv8LDVZBwWLQSiYp7iDVAAAAAlQL4tQAAAAEAAAAAwAAAAEAAAAAAAAAAAAAAAABAAAAAAAAAQAAAAD2T51Mi2fjmCY4Z+R5JON1LluqzrnpmTxUJXTp/A3FRwAAAAEAAAAAAAAAAAAAAAEAAAACAAAAAwAAAAUAAAAAAAAAAO5QGSKQkcErWDq9iKwemolyxv8LDVZBwWLQSiYp7iDVAAAAAlQL4tQAAAAEAAAAAwAAAAEAAAAAAAAAAAAAAAABAAAAAAAAAQAAAAD2T51Mi2fjmCY4Z+R5JON1LluqzrnpmTxUJXTp/A3FRwAAAAEAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+LUAAAABAAAAAMAAAABAAAAAAAAAAAAAAAAAQICAgAAAAEAAAAA9k+dTItn45gmOGfkeSTjdS5bqs656Zk8VCV06fwNxUcAAAABAAAAAAAAAAA=', 'AAAAAgAAAAMAAAAFAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+M4AAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAFAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+LUAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{4JUUcprS48PiJphsE4gUyhO1+/tgssJR8PKnnfredtEmwIIHKm6MuSlyWhD+df8EUjMbWVIAzhX2g5/Q39OBAA==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('66e27fb28870cb5256ea92764bcb222adbbaa5fec2d89a62a9aa8c9c8e2ee9e9', 4, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 2, 100, 1, '2020-01-13 14:37:29.474839', '2020-01-13 14:37:29.474839', 17179873280, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAACAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAA7lAZIpCRwStYOr2IrB6aiXLG/wsNVkHBYtBKJinuINUAAAACVAvkAAAAAAAAAAABVvwF9wAAAECAUpO+hxiga/YgRsV3rFpBJydgOyn0TPImJCaQCMikkiG+sNXrQBsYXjJrlOiGjGsU3rk4uvGl85AriYD9PNYH', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAIAAAADAAAABAAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaxU1gbOAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAAAAAAAYvwdC9CRsrYcDdZWNGsqaNfTR8bywsjubQRHAlb8BfcN4LaxU1gbOAAAAAAAAAACAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAAAwAAAAMAAAAEAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBs4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtq7/TDc4AAAAAAAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAADuUBkikJHBK1g6vYisHpqJcsb/Cw1WQcFi0EomKe4g1QAAAAJUC+QAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAADAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBucAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBs4AAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{gFKTvocYoGv2IEbFd6xaQScnYDsp9EzyJiQmkAjIpJIhvrDV60AbGF4ya5TohoxrFN65OLrxpfOQK4mA/TzWBw==}', 'none', NULL, NULL, true, 100);
INSERT INTO history_transactions VALUES ('9273b053f7bcc689d44cc18040ebd4cedf8f264c369c6262d620d8e69c1068fa', 3, 1, 'GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H', 1, 100, 1, '2020-01-13 14:37:29.484521', '2020-01-13 14:37:29.484521', 12884905984, 'AAAAAGL8HQvQkbK2HA3WVjRrKmjX00fG8sLI7m0ERwJW/AX3AAAAZAAAAAAAAAABAAAAAQAAAAAAAABkAAAAAPSGSPAAAAAAAAAAAQAAAAAAAAAAAAAAAC6N7oJcJiUzTWRDL98Bj3fVrJUB19wFvCzEHh8nn/IOAAAAAlQL5AAAAAAAAAAAAVb8BfcAAABAqCCkC/9n57+cwL+ISzJuvzTQDNMoORfeWZl0RGk+/+EERjbJ5ZDVFqkcjjb8+t4jvd/KkTjykg1Rtx66UyIeDg==', 'AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=', 'AAAAAQAAAAAAAAABAAAAAwAAAAMAAAADAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrFTWBucAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAuje6CXCYlM01kQy/fAY931ayVAdfcBbwsxB4fJ5/yDgAAAAJUC+QAAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', 'AAAAAgAAAAMAAAABAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnZAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAABi/B0L0JGythwN1lY0aypo19NHxvLCyO5tBEcCVvwF9w3gtrOnY/+cAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==', '{qCCkC/9n57+cwL+ISzJuvzTQDNMoORfeWZl0RGk+/+EERjbJ5ZDVFqkcjjb8+t4jvd/KkTjykg1Rtx66UyIeDg==}', 'none', NULL, '[100,4102441200)', true, 100);


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

