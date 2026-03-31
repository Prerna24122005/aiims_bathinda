--
-- PostgreSQL database dump
--

\restrict swjZggzYsdh5JC92nVwpUc83aSv7zJPmLW6aNzrICXDe1qLHyvceDkZYlxIGw11

-- Dumped from database version 14.18 (Homebrew)
-- Dumped by pg_dump version 17.9 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: kashishgarg
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO kashishgarg;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: kashishgarg
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO kashishgarg;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: kashishgarg
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO kashishgarg;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: kashishgarg
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO kashishgarg;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: kashishgarg
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO kashishgarg;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: kashishgarg
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO kashishgarg;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: kashishgarg
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO kashishgarg;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: kashishgarg
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO kashishgarg;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: kashishgarg
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO kashishgarg;

--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: kashishgarg
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO kashishgarg;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: kashishgarg
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO kashishgarg;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: kashishgarg
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO kashishgarg;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: kashishgarg
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO kashishgarg;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: kashishgarg
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO kashishgarg;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: kashishgarg
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO kashishgarg;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: kashishgarg
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO kashishgarg;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: kashishgarg
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO kashishgarg;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: kashishgarg
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO kashishgarg;

--
-- Name: EventStatus; Type: TYPE; Schema: public; Owner: kashishgarg
--

CREATE TYPE public."EventStatus" AS ENUM (
    'UPCOMING',
    'ACTIVE',
    'COMPLETED',
    'LOCKED'
);


ALTER TYPE public."EventStatus" OWNER TO kashishgarg;

--
-- Name: Gender; Type: TYPE; Schema: public; Owner: kashishgarg
--

CREATE TYPE public."Gender" AS ENUM (
    'MALE',
    'FEMALE',
    'OTHER'
);


ALTER TYPE public."Gender" OWNER TO kashishgarg;

--
-- Name: RecordStatus; Type: TYPE; Schema: public; Owner: kashishgarg
--

CREATE TYPE public."RecordStatus" AS ENUM (
    'PENDING',
    'IN_PROGRESS',
    'COMPLETED'
);


ALTER TYPE public."RecordStatus" OWNER TO kashishgarg;

--
-- Name: RequestStatus; Type: TYPE; Schema: public; Owner: kashishgarg
--

CREATE TYPE public."RequestStatus" AS ENUM (
    'PENDING',
    'ACCEPTED',
    'REJECTED'
);


ALTER TYPE public."RequestStatus" OWNER TO kashishgarg;

--
-- Name: Role; Type: TYPE; Schema: public; Owner: kashishgarg
--

CREATE TYPE public."Role" AS ENUM (
    'ADMIN',
    'MEDICAL_STAFF'
);


ALTER TYPE public."Role" OWNER TO kashishgarg;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: kashishgarg
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO kashishgarg;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: kashishgarg
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO kashishgarg;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: kashishgarg
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO kashishgarg;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: kashishgarg
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO kashishgarg;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: kashishgarg
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO kashishgarg;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: kashishgarg
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO kashishgarg;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: kashishgarg
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO kashishgarg;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: kashishgarg
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO kashishgarg;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: kashishgarg
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO kashishgarg;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: kashishgarg
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO kashishgarg;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: kashishgarg
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO kashishgarg;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: kashishgarg
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO kashishgarg;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: kashishgarg
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO kashishgarg;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: kashishgarg
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO kashishgarg;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: kashishgarg
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO kashishgarg;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: kashishgarg
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO kashishgarg;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: kashishgarg
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO kashishgarg;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO kashishgarg;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO kashishgarg;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO kashishgarg;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO kashishgarg;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO kashishgarg;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO kashishgarg;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO kashishgarg;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO kashishgarg;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO kashishgarg;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO kashishgarg;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO kashishgarg;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO kashishgarg;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO kashishgarg;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO kashishgarg;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: kashishgarg
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO kashishgarg;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: kashishgarg
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO kashishgarg;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO kashishgarg;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO kashishgarg;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO kashishgarg;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO kashishgarg;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO kashishgarg;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO kashishgarg;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO kashishgarg;

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: kashishgarg
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO kashishgarg;

--
-- Name: CategoryAuditLog; Type: TABLE; Schema: public; Owner: kashishgarg
--

CREATE TABLE public."CategoryAuditLog" (
    id text NOT NULL,
    "medicalRecordId" text NOT NULL,
    "userId" text NOT NULL,
    "categoryName" text NOT NULL,
    "timestamp" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    action text DEFAULT 'SAVED'::text NOT NULL
);


ALTER TABLE public."CategoryAuditLog" OWNER TO kashishgarg;

--
-- Name: Event; Type: TABLE; Schema: public; Owner: kashishgarg
--

CREATE TABLE public."Event" (
    id text NOT NULL,
    "schoolDetails" text NOT NULL,
    "eventDate" timestamp(3) without time zone NOT NULL,
    "pocName" text NOT NULL,
    "pocPhone" text NOT NULL,
    status public."EventStatus" DEFAULT 'UPCOMING'::public."EventStatus" NOT NULL,
    "formConfig" jsonb DEFAULT '{}'::jsonb,
    "createdBy" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "headId" text
);


ALTER TABLE public."Event" OWNER TO kashishgarg;

--
-- Name: EventStaff; Type: TABLE; Schema: public; Owner: kashishgarg
--

CREATE TABLE public."EventStaff" (
    "eventId" text NOT NULL,
    "userId" text NOT NULL,
    permissions jsonb DEFAULT '{"canEdit": true}'::jsonb,
    role text DEFAULT 'STAFF'::text
);


ALTER TABLE public."EventStaff" OWNER TO kashishgarg;

--
-- Name: HealthCampRequest; Type: TABLE; Schema: public; Owner: kashishgarg
--

CREATE TABLE public."HealthCampRequest" (
    id text NOT NULL,
    "schoolName" text NOT NULL,
    "pocName" text NOT NULL,
    "pocEmail" text NOT NULL,
    "pocPhone" text NOT NULL,
    "tentativeDate" timestamp(3) without time zone NOT NULL,
    "tentativeStudents" integer NOT NULL,
    status public."RequestStatus" DEFAULT 'PENDING'::public."RequestStatus" NOT NULL,
    "rejectionReason" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."HealthCampRequest" OWNER TO kashishgarg;

--
-- Name: MedicalRecord; Type: TABLE; Schema: public; Owner: kashishgarg
--

CREATE TABLE public."MedicalRecord" (
    id text NOT NULL,
    "studentId" text NOT NULL,
    "eventId" text NOT NULL,
    status public."RecordStatus" DEFAULT 'PENDING'::public."RecordStatus" NOT NULL,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."MedicalRecord" OWNER TO kashishgarg;

--
-- Name: Student; Type: TABLE; Schema: public; Owner: kashishgarg
--

CREATE TABLE public."Student" (
    id text NOT NULL,
    "eventId" text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "classSec" text NOT NULL,
    age integer NOT NULL,
    gender public."Gender" NOT NULL,
    "schoolIdNumber" text
);


ALTER TABLE public."Student" OWNER TO kashishgarg;

--
-- Name: User; Type: TABLE; Schema: public; Owner: kashishgarg
--

CREATE TABLE public."User" (
    id text NOT NULL,
    email text NOT NULL,
    "passwordHash" text NOT NULL,
    "fullName" text NOT NULL,
    role public."Role" DEFAULT 'MEDICAL_STAFF'::public."Role" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    department text
);


ALTER TABLE public."User" OWNER TO kashishgarg;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: kashishgarg
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO kashishgarg;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: kashishgarg
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO kashishgarg;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: kashishgarg
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO kashishgarg;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: kashishgarg
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: kashishgarg
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO kashishgarg;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: kashishgarg
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: kashishgarg
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO kashishgarg;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: kashishgarg
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO kashishgarg;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: kashishgarg
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO kashishgarg;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: kashishgarg
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO kashishgarg;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: kashishgarg
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: kashishgarg
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO kashishgarg;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: kashishgarg
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO kashishgarg;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: kashishgarg
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO kashishgarg;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: kashishgarg
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: CategoryAuditLog; Type: TABLE DATA; Schema: public; Owner: kashishgarg
--

COPY public."CategoryAuditLog" (id, "medicalRecordId", "userId", "categoryName", "timestamp", action) FROM stdin;
07754638-d7b1-47bf-810c-57dca5ada5bb	178b41e1-c4fb-4bb6-9b6d-2b1c06a1f59c	1250479c-d693-42a6-a1b6-c2d4c6457a12	demographics	2026-03-11 04:05:45.43	SAVED
91bfc1c6-3a08-4234-b2ec-5159dce7ac45	178b41e1-c4fb-4bb6-9b6d-2b1c06a1f59c	c8f83338-50e3-43e5-91b6-473686bb1763	vitalsSystemic	2026-03-11 04:12:50.879	SAVED
0c26ba21-7558-4233-b09c-5cd4df1acfa6	178b41e1-c4fb-4bb6-9b6d-2b1c06a1f59c	c8f83338-50e3-43e5-91b6-473686bb1763	vitalsSystemic	2026-03-11 04:13:50.876	SAVED
373a7e48-abc3-4428-8437-2cd266b4ef94	178b41e1-c4fb-4bb6-9b6d-2b1c06a1f59c	c8f83338-50e3-43e5-91b6-473686bb1763	vitalsSystemic	2026-03-11 04:14:34.407	SAVED
d5934889-4a4a-4327-b825-b37f46115270	178b41e1-c4fb-4bb6-9b6d-2b1c06a1f59c	c8f83338-50e3-43e5-91b6-473686bb1763	medicalHistory	2026-03-11 04:16:17.367	SAVED
97dddf1e-7c3e-4b38-a8ba-402d9397fe0d	5964a744-dd0b-41dc-b582-1506a6de572f	1250479c-d693-42a6-a1b6-c2d4c6457a12	demographics	2026-03-11 04:18:09.168	SAVED
26b097a6-c758-498e-ab2f-3ba38f3f8949	5964a744-dd0b-41dc-b582-1506a6de572f	1250479c-d693-42a6-a1b6-c2d4c6457a12	demographics	2026-03-11 04:49:12.562	SAVED
8565813a-ea0c-47ba-ba80-eb39a01374f1	5964a744-dd0b-41dc-b582-1506a6de572f	c8f83338-50e3-43e5-91b6-473686bb1763	demographics	2026-03-11 04:49:35.392	SAVED
db4fa8d2-4376-4d86-89a6-934076960bfe	897bc34f-febe-465e-add0-ba2b65c7b9ba	1250479c-d693-42a6-a1b6-c2d4c6457a12	demographics	2026-03-11 05:41:29.525	SAVED
4f7e8ec5-cd4b-4b63-b355-a545fe68145d	897bc34f-febe-465e-add0-ba2b65c7b9ba	c8f83338-50e3-43e5-91b6-473686bb1763	medicalHistory	2026-03-11 05:43:33.367	SAVED
33f70452-24ae-46dc-9a0f-640f1dfe9fc0	897bc34f-febe-465e-add0-ba2b65c7b9ba	c8f83338-50e3-43e5-91b6-473686bb1763	signsSymptoms	2026-03-11 05:46:39.593	SAVED
06192b31-5e4b-45ea-b6dc-c6ab0a6c1c74	897bc34f-febe-465e-add0-ba2b65c7b9ba	c8f83338-50e3-43e5-91b6-473686bb1763	vitalsSystemic	2026-03-11 05:47:44.145	SAVED
e3c6faa7-10a5-40c1-92e8-9b9f68b9dc0c	b8ce89ba-b5b4-4c7a-a82d-1c45fa95183b	1250479c-d693-42a6-a1b6-c2d4c6457a12	ent	2026-03-23 21:12:18.771	SAVED
98702e91-76ea-4bdf-82dd-4c7c5bd81fd2	b8ce89ba-b5b4-4c7a-a82d-1c45fa95183b	1250479c-d693-42a6-a1b6-c2d4c6457a12	ent	2026-03-23 21:18:44.288	SAVED
b69cd29f-bbbb-4c44-ab2a-31a9a5205d7d	b8ce89ba-b5b4-4c7a-a82d-1c45fa95183b	1250479c-d693-42a6-a1b6-c2d4c6457a12	communityMed	2026-03-23 22:53:01.646	SAVED
6a0f9d51-5c08-4961-9f31-d068bf299118	b8ce89ba-b5b4-4c7a-a82d-1c45fa95183b	87b29387-65f4-4885-8856-8aaaf7e7629d	skin	2026-03-23 23:15:08.633	SAVED
\.


--
-- Data for Name: Event; Type: TABLE DATA; Schema: public; Owner: kashishgarg
--

COPY public."Event" (id, "schoolDetails", "eventDate", "pocName", "pocPhone", status, "formConfig", "createdBy", "createdAt", "headId") FROM stdin;
58236f39-dabd-428e-bbb4-4ef4f2004121	Greenwood High School	2026-10-24 00:00:00	Jane Doe	555-0100	ACTIVE	{}	ed7cc58e-10aa-49a8-8d85-1272968879fe	2026-03-11 03:47:09.807	\N
edeb0a15-ba90-42a4-b101-5d43dea6dda3	IIT ROPAR	2026-03-11 00:00:00	MITALI	2344555	UPCOMING	{"demographics": ["bloodGroup", "fatherName", "motherName", "fatherOccupation", "motherOccupation", "address", "pinCode", "phone", "mobile"], "signsSymptoms": [], "medicalHistory": [], "vitalsSystemic": ["examDate", "height", "weight", "signDoctor"]}	ed7cc58e-10aa-49a8-8d85-1272968879fe	2026-03-11 03:56:37.968	\N
dee20c43-b738-4db8-8624-ee642d580037	Kanya Bharti School	2026-03-18 00:00:00	Sania	9456723456	UPCOMING	{"demographics": ["bloodGroup", "fatherName", "motherName", "fatherOccupation", "motherOccupation", "address", "pinCode", "phone", "mobile"], "signsSymptoms": [], "medicalHistory": [], "vitalsSystemic": ["examDate", "height", "weight", "signDoctor"]}	ed7cc58e-10aa-49a8-8d85-1272968879fe	2026-03-18 06:59:21.713	\N
398b5a65-ff13-40ee-bb16-c865c642ac23	St. Pauls	2026-03-23 00:00:00	Divya	+91 4242533222	UPCOMING	{"demographics": ["bloodGroup", "fatherName", "motherName", "fatherOccupation", "motherOccupation", "address", "pinCode", "phone", "mobile"], "signsSymptoms": ["sym_Child constantly stretches the head", "sym_rubs eyes", "sym_complains of frequent headache", "sym_cannot see what is written on the board", "sym_pokes fingers or pulls ear", "sym_Teeth look black or rotten", "sym_Breath has a bad odour", "sym_Cracks at corners of mouth", "sym_Tends to breath through mouth", "sym_Bites nails", "sym_White Patches", "sym_Limping Gait", "sym_Attacks of breathlessness", "sym_Frequent Urination", "sym_Diarrhoea", "sym_Vomiting", "sym_Blood passed with stools", "sym_Stammers & cannot speak properly", "sym_Episodes of fainting esp. in summers"], "medicalHistory": ["physicianName", "physicianPhone", "past_Jaundice", "past_Allergies", "past_Blood Transfusion", "implant_Dental Implant", "implant_Braces", "implant_Spectacles/Lenses (Rt)", "implant_Spectacles/Lenses (Lt)", "vaccineHepB", "vaccineTyphoid", "vaccinePolio", "vaccineTetanus", "presentComplaint", "currentMedication"], "vitalsSystemic": ["examDate", "height", "weight", "sys_Anaemia", "sys_Skin/Nails/Hair", "sys_Eyes (Rt Vision)", "sys_Eyes (Lt Vision)", "sys_Ear", "sys_Nose", "sys_Throat", "sys_Teeth & Gums", "sys_Locomotor System", "sys_Abdomen", "sys_Respiratory System", "sys_Cardiovascular System", "sys_Central Nervous System", "sys_Others", "doctorRemarks", "signDoctor"]}	ed7cc58e-10aa-49a8-8d85-1272968879fe	2026-03-23 15:57:53.572	\N
cd8d5429-c99a-4ee8-92ee-691444e9ca30	DPS	2026-03-11 00:00:00	Jane Doe	2908308	UPCOMING	{"ent": ["hearing", "earExam", "noseExam", "throatExam", "entRemarks"], "skin": ["skinCondition", "infections", "skin_Acne", "skin_Eczema", "skin_Warts", "skin_Lice", "skinRemarks"], "dental": ["oralHygiene", "gums", "cavities", "dentalFindings", "dentalRemarks"], "optical": ["visionRight", "visionLeft", "colorVision", "opticalIssues", "spectacles", "opticalRemarks"], "communityMed": ["height", "weight", "bloodGroup", "generalAppearance", "majorIllness", "currentMedication", "doctorRemarks"]}	ed7cc58e-10aa-49a8-8d85-1272968879fe	2026-03-11 05:33:50.303	\N
1af38ec3-ef6b-4e3a-8911-2d221fe4e6e3	St. Joseph	2026-03-24 00:00:00	diya	+91 424253999	UPCOMING	{"ent": ["hearing", "earExam", "noseExam", "throatExam", "entRemarks"], "skin": ["skinCondition", "infections", "skin_Acne", "skin_Eczema", "skin_Warts", "skin_Lice", "skinRemarks"], "dental": ["oralHygiene", "gums", "cavities", "dentalFindings", "dentalRemarks"], "optical": ["visionRight", "visionLeft", "colorVision", "opticalIssues", "spectacles", "opticalRemarks"], "eventHeadId": "87b29387-65f4-4885-8856-8aaaf7e7629d", "communityMed": ["height", "weight", "bloodGroup", "generalAppearance", "majorIllness", "currentMedication", "doctorRemarks"], "schoolContactId": "87b29387-65f4-4885-8856-8aaaf7e7629d", "customCategories": [], "sectionAssignments": {"ent": ["87b29387-65f4-4885-8856-8aaaf7e7629d"], "skin": ["87b29387-65f4-4885-8856-8aaaf7e7629d", "1250479c-d693-42a6-a1b6-c2d4c6457a12"], "dental": ["87b29387-65f4-4885-8856-8aaaf7e7629d"], "optical": ["1250479c-d693-42a6-a1b6-c2d4c6457a12"], "communityMed": ["1250479c-d693-42a6-a1b6-c2d4c6457a12"]}}	ed7cc58e-10aa-49a8-8d85-1272968879fe	2026-03-23 17:12:50.961	87b29387-65f4-4885-8856-8aaaf7e7629d
e9191ef2-ba21-432b-bf5f-b4561f4b6a60	Sophia Girls School	2026-03-18 00:00:00	Pihu Gupta	+918619252566	UPCOMING	{"ent": ["hearing", "earExam", "noseExam", "throatExam", "entRemarks"], "skin": ["skinCondition", "infections", "skinRemarks"], "dental": ["oralHygiene", "gums", "cavities", "dentalFindings", "dentalRemarks"], "optical": ["visionRight", "visionLeft", "colorVision", "opticalIssues", "opticalRemarks"], "pocEmail": "2023csb1138@iitrpr.ac.in", "communityMed": ["height", "weight", "bloodGroup", "generalAppearance", "majorIllness", "currentMedication", "doctorRemarks"]}	ed7cc58e-10aa-49a8-8d85-1272968879fe	2026-03-24 00:10:56.057	\N
\.


--
-- Data for Name: EventStaff; Type: TABLE DATA; Schema: public; Owner: kashishgarg
--

COPY public."EventStaff" ("eventId", "userId", permissions, role) FROM stdin;
cd8d5429-c99a-4ee8-92ee-691444e9ca30	1250479c-d693-42a6-a1b6-c2d4c6457a12	{"canEdit": true}	STAFF
edeb0a15-ba90-42a4-b101-5d43dea6dda3	1250479c-d693-42a6-a1b6-c2d4c6457a12	{"canEdit": true}	STAFF
edeb0a15-ba90-42a4-b101-5d43dea6dda3	87b29387-65f4-4885-8856-8aaaf7e7629d	{"canEdit": true}	STAFF
dee20c43-b738-4db8-8624-ee642d580037	87b29387-65f4-4885-8856-8aaaf7e7629d	{"canEdit": true}	STAFF
58236f39-dabd-428e-bbb4-4ef4f2004121	2069f15b-4fec-4922-864e-36b0453501cc	{"canEdit": true}	STAFF
398b5a65-ff13-40ee-bb16-c865c642ac23	2069f15b-4fec-4922-864e-36b0453501cc	{"canEdit": true}	STAFF
1af38ec3-ef6b-4e3a-8911-2d221fe4e6e3	1250479c-d693-42a6-a1b6-c2d4c6457a12	{"canEdit": true, "allowedSections": ["medicalHistory"]}	STAFF
1af38ec3-ef6b-4e3a-8911-2d221fe4e6e3	87b29387-65f4-4885-8856-8aaaf7e7629d	{"canEdit": true, "allowedSections": ["demographics", "signsSymptoms", "vitalsSystemic", "medicalHistory"]}	STAFF
edeb0a15-ba90-42a4-b101-5d43dea6dda3	2069f15b-4fec-4922-864e-36b0453501cc	{"canEdit": true}	STAFF
e9191ef2-ba21-432b-bf5f-b4561f4b6a60	1250479c-d693-42a6-a1b6-c2d4c6457a12	{"canEdit": true}	STAFF
e9191ef2-ba21-432b-bf5f-b4561f4b6a60	87b29387-65f4-4885-8856-8aaaf7e7629d	{"canEdit": true}	STAFF
e9191ef2-ba21-432b-bf5f-b4561f4b6a60	1caaf4d9-d26c-492c-b9e6-48f9689d72b5	{"canEdit": true}	STAFF
\.


--
-- Data for Name: HealthCampRequest; Type: TABLE DATA; Schema: public; Owner: kashishgarg
--

COPY public."HealthCampRequest" (id, "schoolName", "pocName", "pocEmail", "pocPhone", "tentativeDate", "tentativeStudents", status, "rejectionReason", "createdAt") FROM stdin;
258cd387-647e-465e-957a-3e9d0b395005	DPS	Jane Doe	director@gmail.com	2908308	2026-03-11 00:00:00	400	ACCEPTED	\N	2026-03-11 05:31:24.576
87c1b101-2b5c-4648-8c66-436283363f07	Pathfinder Global School	Dinesh Kumar	Dinesh@gmail.com	8799685823	2026-03-12 00:00:00	500	REJECTED	kn	2026-03-11 04:21:49.321
db46471c-a253-4942-a439-59e9116ab799	Sophia Girls School	Pihu 	2023csb1138@iitrpr.ac.in	898w78w	2026-03-20 00:00:00	149	REJECTED	cant 	2026-03-17 17:32:15.762
32e5e6c0-872e-4f3e-b98e-2865e30a49d4	Sophia Girls School	Pihu 	2023csb1138@iitrpr.ac.in	5739cfrvr	2026-03-18 00:00:00	150	REJECTED	so	2026-03-17 17:43:49.456
87b15ad5-9ed8-4214-ad19-c5b2f8c92bb8	Sophia Girls School	Pihu 	2023csb1138@iitrpr.ac.in	575htyn65	2026-03-18 00:00:00	150	REJECTED	no	2026-03-17 18:01:28.471
40bde3ff-513e-4b6b-9d83-dc0a90984477	Sophia Girls School	Pihu 	2023csb1138@iitrpr.ac.in	e509834dfsif	2026-03-27 00:00:00	149	REJECTED	we are full	2026-03-17 19:39:03.915
0edd349f-47d5-4e04-90ce-c79016a1f6ec	Suraj School	Sunita Yadav	suraj@gmail.com	9834234567	2026-03-18 00:00:00	500	REJECTED	abc	2026-03-17 19:49:37.765
187d5130-b3b2-40d3-8bc4-97cdbd1032e3	Govt Boys School	Devender	2023csb1138@iitrpr.ac.in	8679503456	2026-03-28 00:00:00	1000	PENDING	\N	2026-03-23 18:15:02.519
24278a46-fc3e-46e7-84c9-33727382449d	Suraj School	Shruti 	2023csb1148@iitrpr.ac.in	9876789578	2026-03-26 00:00:00	300	REJECTED	aa	2026-03-23 18:05:39.427
2d2a652d-b97b-4d9a-8adc-efd519b5b95e	Sophia Girls School	Pihu Gupta	2023csb1138@iitrpr.ac.in	+918619252566	2026-03-18 00:00:00	150	ACCEPTED	\N	2026-03-18 06:04:12.763
\.


--
-- Data for Name: MedicalRecord; Type: TABLE DATA; Schema: public; Owner: kashishgarg
--

COPY public."MedicalRecord" (id, "studentId", "eventId", status, data, "createdAt", "updatedAt") FROM stdin;
1329b9f4-511c-4639-836e-6f4abdf47480	2a6824b0-009d-4b03-b4eb-924d5357f577	58236f39-dabd-428e-bbb4-4ef4f2004121	PENDING	{}	2026-03-11 03:47:12.589	2026-03-11 03:47:12.589
ffcacc19-394c-4ee5-89f2-ce5ea4910697	8e4d4925-68e9-45e2-9043-8b6090266f3b	edeb0a15-ba90-42a4-b101-5d43dea6dda3	PENDING	{"demographics": {"_lock": {"userId": "c8f83338-50e3-43e5-91b6-473686bb1763", "lockedAt": "2026-03-11T07:05:47.412Z", "userName": "Dr. Sarah"}}, "medicalHistory": {"_lock": {"userId": "c8f83338-50e3-43e5-91b6-473686bb1763", "lockedAt": "2026-03-11T07:06:51.977Z", "userName": "Dr. Sarah"}}, "vitalsSystemic": {"_lock": {"userId": "c8f83338-50e3-43e5-91b6-473686bb1763", "lockedAt": "2026-03-11T07:54:44.756Z", "userName": "Dr. Sarah"}}}	2026-03-11 04:01:17.635	2026-03-11 07:54:44.759
6b776b21-f780-48ec-8b94-31acfeafa552	153f1e3c-f3c0-4386-a69e-26304632a112	edeb0a15-ba90-42a4-b101-5d43dea6dda3	PENDING	{}	2026-03-11 05:20:20.634	2026-03-11 05:20:20.634
5964a744-dd0b-41dc-b582-1506a6de572f	78dca83c-661b-4306-907a-bdf8bdf3c113	edeb0a15-ba90-42a4-b101-5d43dea6dda3	IN_PROGRESS	{"demographics": {"_lock": {"userId": "c8f83338-50e3-43e5-91b6-473686bb1763", "lockedAt": "2026-03-11T05:26:49.621Z", "userName": "Dr. Sarah"}, "_managedBy": "c8f83338-50e3-43e5-91b6-473686bb1763", "bloodGroup": "B+", "fatherName": "XYZ", "_lastUpdated": "2026-03-11T04:49:35.386Z"}}	2026-03-11 04:16:59.414	2026-03-11 05:26:49.624
633dd36a-1265-46a1-85aa-be2710cbace0	85d76ad3-6a01-45cd-990c-b335af121e3c	cd8d5429-c99a-4ee8-92ee-691444e9ca30	PENDING	{}	2026-03-11 05:36:22.212	2026-03-11 05:36:22.212
7fd75390-1d9b-4dad-9e98-912a9e5da2c8	984be9ab-aec2-4e9c-82e4-dc3ff70a828b	cd8d5429-c99a-4ee8-92ee-691444e9ca30	PENDING	{}	2026-03-11 05:37:32.218	2026-03-11 05:37:32.218
178b41e1-c4fb-4bb6-9b6d-2b1c06a1f59c	7564039b-c41b-4628-a97f-d97efe4bc0fb	edeb0a15-ba90-42a4-b101-5d43dea6dda3	COMPLETED	{"demographics": {"_lock": {"userId": "1250479c-d693-42a6-a1b6-c2d4c6457a12", "lockedAt": "2026-03-11T04:06:55.454Z", "userName": "prerna"}, "phone": "erg", "mobile": "ert", "address": "399, jkkk", "pinCode": "geg", "_managedBy": "1250479c-d693-42a6-a1b6-c2d4c6457a12", "bloodGroup": "O+", "fatherName": "Ramesh", "motherName": "Mona", "_lastUpdated": "2026-03-11T04:05:45.413Z", "fatherOccupation": "Teacher", "motherOccupation": "Teacher"}, "signsSymptoms": {}, "medicalHistory": {"_lock": {"userId": "c8f83338-50e3-43e5-91b6-473686bb1763", "lockedAt": "2026-03-11T04:18:33.046Z", "userName": "Dr. Sarah"}, "_managedBy": "c8f83338-50e3-43e5-91b6-473686bb1763", "_lastUpdated": "2026-03-11T04:16:17.362Z", "physicianName": "NA", "physicianPhone": "NA"}, "vitalsSystemic": {"_lock": {"userId": "c8f83338-50e3-43e5-91b6-473686bb1763", "lockedAt": "2026-03-11T04:17:04.327Z", "userName": "Dr. Sarah"}, "height": "156", "weight": "55", "sys_Ear": "N", "examDate": "2026-03-11", "sys_Nose": "N", "_managedBy": "c8f83338-50e3-43e5-91b6-473686bb1763", "signDoctor": "Sarah", "sys_Others": "N", "sys_Throat": "N", "sys_Abdomen": "N", "sys_Anaemia": "N", "_lastUpdated": "2026-03-11T04:14:34.401Z", "doctorRemarks": "All Good", "sys_Teeth & Gums": "N", "sys_Skin/Nails/Hair": "N", "sys_Eyes (Lt Vision)": "N", "sys_Eyes (Rt Vision)": "N", "sys_Locomotor System": "N", "sys_Respiratory System": "N", "sys_Cardiovascular System": "N", "sys_Central Nervous System": "N"}}	2026-03-11 04:02:03.101	2026-03-11 04:18:33.056
9f9dba64-88e1-4f49-9725-d84c0665f821	cf18c771-451d-45b9-9f64-33d417619a22	cd8d5429-c99a-4ee8-92ee-691444e9ca30	PENDING	{}	2026-03-11 05:37:32.218	2026-03-11 05:37:32.218
2f39d110-a245-4b83-89a2-2b5026fcdfd5	cb0819e4-620e-4b60-a25d-3f16a960ef98	cd8d5429-c99a-4ee8-92ee-691444e9ca30	PENDING	{}	2026-03-11 05:37:32.218	2026-03-11 05:37:32.218
5b9d49ad-14ca-43db-8b71-274ee133c89c	e2e5e111-363c-485f-9bce-5a6023abffd9	cd8d5429-c99a-4ee8-92ee-691444e9ca30	PENDING	{}	2026-03-11 05:37:32.218	2026-03-11 05:37:32.218
25c26b96-312c-4f78-a4dd-a1762a65d82a	a585f398-8252-48a7-a254-fb31270419d4	edeb0a15-ba90-42a4-b101-5d43dea6dda3	PENDING	{}	2026-03-11 06:59:17.477	2026-03-11 06:59:17.477
91fc1170-cbd8-410d-9b5a-3b64629b913e	f890d8b0-e953-483d-b599-38966b24cd03	cd8d5429-c99a-4ee8-92ee-691444e9ca30	PENDING	{}	2026-03-11 06:20:54.61	2026-03-11 06:20:54.61
f0e20556-da3b-4d7e-a5b7-dd2960acdb68	60013f2a-d6fd-489c-a0a8-3c0e533351ee	edeb0a15-ba90-42a4-b101-5d43dea6dda3	PENDING	{}	2026-03-11 06:59:17.477	2026-03-11 06:59:17.477
880893d5-e7c0-4ed7-b6f1-ab471fae219c	b224f3c8-2230-4771-a42e-ed51ecd9b257	edeb0a15-ba90-42a4-b101-5d43dea6dda3	PENDING	{}	2026-03-11 06:59:17.477	2026-03-11 06:59:17.477
2eeb9340-a1e3-4a88-8a1e-52d012916d78	9c0f92ae-fffc-4f5b-9e69-d43944f40aa7	edeb0a15-ba90-42a4-b101-5d43dea6dda3	PENDING	{}	2026-03-11 06:59:17.477	2026-03-11 06:59:17.477
f7241196-52cf-410d-adf5-a6d9ee021d94	bcfd124c-fd94-49a8-bee5-704ced0d832a	edeb0a15-ba90-42a4-b101-5d43dea6dda3	PENDING	{}	2026-03-11 06:59:17.477	2026-03-11 06:59:17.477
897bc34f-febe-465e-add0-ba2b65c7b9ba	1d97f013-a765-47f6-9d80-82d27e02ae6b	cd8d5429-c99a-4ee8-92ee-691444e9ca30	IN_PROGRESS	{"demographics": {"_lock": {"userId": "1250479c-d693-42a6-a1b6-c2d4c6457a12", "lockedAt": "2026-03-11T05:42:12.314Z", "userName": "prerna"}, "phone": "23435545", "mobile": "54575677", "address": "dh", "pinCode": "400", "_managedBy": "1250479c-d693-42a6-a1b6-c2d4c6457a12", "fatherName": "ram", "motherName": "piya", "_lastUpdated": "2026-03-11T05:41:29.513Z", "fatherOccupation": "ter\\\\a", "motherOccupation": "teacher"}, "signsSymptoms": {"_lock": {"userId": "c8f83338-50e3-43e5-91b6-473686bb1763", "lockedAt": "2026-03-11T07:05:40.346Z", "userName": "Dr. Sarah"}, "_managedBy": "c8f83338-50e3-43e5-91b6-473686bb1763", "_lastUpdated": "2026-03-11T05:46:39.589Z"}, "medicalHistory": {"_managedBy": "c8f83338-50e3-43e5-91b6-473686bb1763", "_lastUpdated": "2026-03-11T05:43:33.363Z", "physicianName": "Dr Sharma", "physicianPhone": "7872323e2"}, "vitalsSystemic": {"_lock": {"userId": "c8f83338-50e3-43e5-91b6-473686bb1763", "lockedAt": "2026-03-11T07:05:41.051Z", "userName": "Dr. Sarah"}, "height": "180", "weight": "55", "sys_Ear": "N", "sys_Nose": "N", "_managedBy": "c8f83338-50e3-43e5-91b6-473686bb1763", "signDoctor": "DR Sarah", "sys_Others": "N", "sys_Throat": "N", "sys_Abdomen": "N", "sys_Anaemia": "N", "_lastUpdated": "2026-03-11T05:47:44.141Z", "doctorRemarks": "na", "sys_Teeth & Gums": "N", "sys_Skin/Nails/Hair": "O", "sys_Eyes (Lt Vision)": "O", "sys_Eyes (Rt Vision)": "N", "sys_Locomotor System": "N", "sys_Respiratory System": "N", "sys_Cardiovascular System": "N", "sys_Central Nervous System": "N"}}	2026-03-11 05:37:32.218	2026-03-11 17:20:41.225
40da0c30-271f-42aa-a5c9-bd135032d2c4	be0414e6-560b-447a-9bd4-16941536a6d3	dee20c43-b738-4db8-8624-ee642d580037	PENDING	{}	2026-03-18 07:00:09.94	2026-03-18 07:00:09.94
0889948c-6e66-42d5-8fd2-2ad22f79679f	799117ca-246f-4a8a-b0e0-0259ce4c701a	dee20c43-b738-4db8-8624-ee642d580037	PENDING	{}	2026-03-18 07:00:09.94	2026-03-18 07:00:09.94
190fd5cd-986b-42c8-b69d-3f17cee25ed0	c1921f77-e0ed-4787-bc39-c9e5a654c7b4	dee20c43-b738-4db8-8624-ee642d580037	PENDING	{}	2026-03-18 07:00:09.94	2026-03-18 07:00:09.94
6bc32f20-7a6c-408c-ba5f-57e3da72bcdf	279223a5-472e-4bd0-98c5-a0c29af13429	dee20c43-b738-4db8-8624-ee642d580037	PENDING	{}	2026-03-18 07:00:09.94	2026-03-18 07:00:09.94
b4c6a4a2-0f17-4efe-8811-7c0ba1297dbe	6579c401-a108-48a3-b93f-d80a16f0ed99	dee20c43-b738-4db8-8624-ee642d580037	PENDING	{"demographics": {}, "medicalHistory": {}}	2026-03-18 07:00:09.94	2026-03-18 07:02:47.947
96dba9b5-d4fd-480e-8919-045f36aea2f4	75b5968c-1377-407a-aef9-85994a348ae5	398b5a65-ff13-40ee-bb16-c865c642ac23	PENDING	{}	2026-03-23 15:59:20.917	2026-03-23 15:59:20.917
b8ce89ba-b5b4-4c7a-a82d-1c45fa95183b	73cf0094-7a0a-4ef6-8744-e249b316dc5d	1af38ec3-ef6b-4e3a-8911-2d221fe4e6e3	IN_PROGRESS	{"ent": {"_lock": {"userId": "87b29387-65f4-4885-8856-8aaaf7e7629d", "lockedAt": "2026-03-23T23:15:05.129Z", "userName": "Nehal"}, "earExam": "Wax", "hearing": "Impaired Right", "noseExam": "Polyps", "_managedBy": "1250479c-d693-42a6-a1b6-c2d4c6457a12", "entRemarks": "NA", "throatExam": "Enlarged Tonsils", "_lastUpdated": "2026-03-23T21:18:44.286Z"}, "skin": {"_lock": {"userId": "1250479c-d693-42a6-a1b6-c2d4c6457a12", "lockedAt": "2026-03-24T00:00:13.009Z", "userName": "prerna"}, "_managedBy": "87b29387-65f4-4885-8856-8aaaf7e7629d", "_lastUpdated": "2026-03-23T23:15:08.629Z", "skinCondition": "Dry"}, "dental": {"_lock": {"userId": "87b29387-65f4-4885-8856-8aaaf7e7629d", "lockedAt": "2026-03-23T23:15:13.552Z", "userName": "Nehal"}}, "optical": {}, "communityMed": {"_lock": {"userId": "1250479c-d693-42a6-a1b6-c2d4c6457a12", "lockedAt": "2026-03-24T00:09:41.380Z", "userName": "prerna"}, "_managedBy": "1250479c-d693-42a6-a1b6-c2d4c6457a12", "_lastUpdated": "2026-03-23T22:53:01.642Z"}, "demographics": {}, "medicalHistory": {"_lock": {"userId": "1250479c-d693-42a6-a1b6-c2d4c6457a12", "lockedAt": "2026-03-23T18:43:29.709Z", "userName": "prerna"}}}	2026-03-23 17:15:40.763	2026-03-24 00:09:41.382
\.


--
-- Data for Name: Student; Type: TABLE DATA; Schema: public; Owner: kashishgarg
--

COPY public."Student" (id, "eventId", "firstName", "lastName", "classSec", age, gender, "schoolIdNumber") FROM stdin;
2a6824b0-009d-4b03-b4eb-924d5357f577	58236f39-dabd-428e-bbb4-4ef4f2004121	Alice	Johnson	10-A	10	FEMALE	\N
efc391a1-ef93-42e0-b787-83b4e5bf55bf	58236f39-dabd-428e-bbb4-4ef4f2004121	Bob	Smith	10-B	10	MALE	\N
8e4d4925-68e9-45e2-9043-8b6090266f3b	edeb0a15-ba90-42a4-b101-5d43dea6dda3	Ankit	Gupta	10-B	17	MALE	\N
7564039b-c41b-4628-a97f-d97efe4bc0fb	edeb0a15-ba90-42a4-b101-5d43dea6dda3	Udit	Kumar	9-C	16	MALE	\N
78dca83c-661b-4306-907a-bdf8bdf3c113	edeb0a15-ba90-42a4-b101-5d43dea6dda3	Anu	Sharma	9-A	16	FEMALE	\N
153f1e3c-f3c0-4386-a69e-26304632a112	edeb0a15-ba90-42a4-b101-5d43dea6dda3	Siya	Thakur	10-A	20	FEMALE	\N
85d76ad3-6a01-45cd-990c-b335af121e3c	cd8d5429-c99a-4ee8-92ee-691444e9ca30	nehal	gupta	10-C	17	FEMALE	\N
1d97f013-a765-47f6-9d80-82d27e02ae6b	cd8d5429-c99a-4ee8-92ee-691444e9ca30	Arjun	Sharma	10-A	16	MALE	\N
984be9ab-aec2-4e9c-82e4-dc3ff70a828b	cd8d5429-c99a-4ee8-92ee-691444e9ca30	Priya	Patel	10-A	16	FEMALE	\N
cf18c771-451d-45b9-9f64-33d417619a22	cd8d5429-c99a-4ee8-92ee-691444e9ca30	Rohan	Kumar	10-B	17	MALE	\N
cb0819e4-620e-4b60-a25d-3f16a960ef98	cd8d5429-c99a-4ee8-92ee-691444e9ca30	Sneha	Gupta	10-B	16	FEMALE	\N
e2e5e111-363c-485f-9bce-5a6023abffd9	cd8d5429-c99a-4ee8-92ee-691444e9ca30	Vikram	Singh	11-C	17	MALE	\N
f890d8b0-e953-483d-b599-38966b24cd03	cd8d5429-c99a-4ee8-92ee-691444e9ca30	Sania	Sajit	10-A	21	FEMALE	\N
a585f398-8252-48a7-a254-fb31270419d4	edeb0a15-ba90-42a4-b101-5d43dea6dda3	Arjun	Sharma	10-A	16	MALE	\N
60013f2a-d6fd-489c-a0a8-3c0e533351ee	edeb0a15-ba90-42a4-b101-5d43dea6dda3	Priya	Patel	10-A	16	FEMALE	\N
b224f3c8-2230-4771-a42e-ed51ecd9b257	edeb0a15-ba90-42a4-b101-5d43dea6dda3	Rohan	Kumar	10-B	17	MALE	\N
9c0f92ae-fffc-4f5b-9e69-d43944f40aa7	edeb0a15-ba90-42a4-b101-5d43dea6dda3	Sneha	Gupta	10-B	16	FEMALE	\N
bcfd124c-fd94-49a8-bee5-704ced0d832a	edeb0a15-ba90-42a4-b101-5d43dea6dda3	Vikram	Singh	11-C	17	MALE	\N
6579c401-a108-48a3-b93f-d80a16f0ed99	dee20c43-b738-4db8-8624-ee642d580037	Arjun	Sharma	10-A	16	MALE	\N
be0414e6-560b-447a-9bd4-16941536a6d3	dee20c43-b738-4db8-8624-ee642d580037	Priya	Patel	10-A	16	FEMALE	\N
799117ca-246f-4a8a-b0e0-0259ce4c701a	dee20c43-b738-4db8-8624-ee642d580037	Rohan	Kumar	10-B	17	MALE	\N
c1921f77-e0ed-4787-bc39-c9e5a654c7b4	dee20c43-b738-4db8-8624-ee642d580037	Sneha	Gupta	10-B	16	FEMALE	\N
279223a5-472e-4bd0-98c5-a0c29af13429	dee20c43-b738-4db8-8624-ee642d580037	Vikram	Singh	11-C	17	MALE	\N
75b5968c-1377-407a-aef9-85994a348ae5	398b5a65-ff13-40ee-bb16-c865c642ac23	Ram	Gupta	10-A	16	MALE	\N
73cf0094-7a0a-4ef6-8744-e249b316dc5d	1af38ec3-ef6b-4e3a-8911-2d221fe4e6e3	Kashish	Garg	11-B	17	FEMALE	\N
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: kashishgarg
--

COPY public."User" (id, email, "passwordHash", "fullName", role, "createdAt", "isActive", department) FROM stdin;
ed7cc58e-10aa-49a8-8d85-1272968879fe	admin@healthcamp.org	$2b$10$FHwsYr.rhOj9Jamcvc2izuxfoX1Hd/.RHXJMrTK4P4QiGju5oAvyC	System Admin	ADMIN	2026-03-11 03:47:06.489	t	\N
1250479c-d693-42a6-a1b6-c2d4c6457a12	prerna@gmail.com	$2b$10$g6twnc3.aRQTvlxK0S3njuY5j2IO76enmoimlZy1pjONsCpPSYfWa	prerna	MEDICAL_STAFF	2026-03-11 03:52:31.312	t	\N
c8f83338-50e3-43e5-91b6-473686bb1763	dr.sarah@healthcamp.org	$2b$10$CIctCidB3Ek9I2NgSSrlb.8Thl1n3wy0RNXj0BT/VtXg7Ky9jCfsa	Dr. Sarah	MEDICAL_STAFF	2026-03-11 03:47:08.81	f	\N
34082b18-bba1-4f2d-be3b-760f7a733ae3	40342@gmail.com	$2b$10$vSUiP6AXlArXk96DjzU71OEoWDKutWSuFO97/zBugSswcc1B00o5y	neal	MEDICAL_STAFF	2026-03-17 19:24:59.518	f	\N
39e169ba-447a-4833-939d-4d6bc36b4312	siya@gmail.com	$2b$10$twXS7wcIk0ruSwiTtcdgcOQZE/GVOIEInRM8NOE8MORFD7fO.Qhqa	Siya	MEDICAL_STAFF	2026-03-17 19:39:31.386	f	\N
44ffd359-0499-40fa-adb8-a2d3b6be7670	k@gmail.com	$2b$10$ZpAV8/MN/Q5qbWj4rfknk.0f2.WNTNSz6eUoNguiG481qej1IkqUi	Kahshi	MEDICAL_STAFF	2026-03-18 06:29:44.09	f	\N
87b29387-65f4-4885-8856-8aaaf7e7629d	nehal@gmail.com	$2b$10$qcoIzDNvrPC5uQs2zMbCZ.I1VjSA8k6bSYuoobQ7ALjswPDUtTFn2	Nehal	MEDICAL_STAFF	2026-03-18 06:02:27.437	t	\N
2069f15b-4fec-4922-864e-36b0453501cc	staff@gmail.com	$2b$10$SWoVwraaJPNT/aEtl7uaUO5HYkpzhiHjbLNtVZhSb71hd5v54XKLC	staff	MEDICAL_STAFF	2026-03-23 15:49:23.498	t	Dental
1caaf4d9-d26c-492c-b9e6-48f9689d72b5	2023csb1138@iitrpr.ac.in	$2b$10$sX1F5alSeWj5qkL.619q..pBcKJh71wXOYEgcQgKYLP5hEiExbvM.	Pihu Gupta	MEDICAL_STAFF	2026-03-24 00:10:56.09	t	\N
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: kashishgarg
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-03-11 03:35:46
20211116045059	2026-03-11 03:35:46
20211116050929	2026-03-11 03:35:47
20211116051442	2026-03-11 03:35:47
20211116212300	2026-03-11 03:35:47
20211116213355	2026-03-11 03:35:47
20211116213934	2026-03-11 03:35:47
20211116214523	2026-03-11 03:35:47
20211122062447	2026-03-11 03:35:47
20211124070109	2026-03-11 03:35:47
20211202204204	2026-03-11 03:35:47
20211202204605	2026-03-11 03:35:47
20211210212804	2026-03-11 03:35:49
20211228014915	2026-03-11 03:35:50
20220107221237	2026-03-11 03:35:50
20220228202821	2026-03-11 03:35:50
20220312004840	2026-03-11 03:35:50
20220603231003	2026-03-11 03:35:50
20220603232444	2026-03-11 03:35:50
20220615214548	2026-03-11 03:35:50
20220712093339	2026-03-11 03:35:50
20220908172859	2026-03-11 03:35:50
20220916233421	2026-03-11 03:35:50
20230119133233	2026-03-11 03:35:50
20230128025114	2026-03-11 03:35:50
20230128025212	2026-03-11 03:35:50
20230227211149	2026-03-11 03:35:50
20230228184745	2026-03-11 03:35:50
20230308225145	2026-03-11 03:35:50
20230328144023	2026-03-11 03:35:50
20231018144023	2026-03-11 03:35:50
20231204144023	2026-03-11 03:35:51
20231204144024	2026-03-11 03:35:51
20231204144025	2026-03-11 03:35:51
20240108234812	2026-03-11 03:35:51
20240109165339	2026-03-11 03:35:51
20240227174441	2026-03-11 03:35:51
20240311171622	2026-03-11 03:35:51
20240321100241	2026-03-11 03:35:51
20240401105812	2026-03-11 03:35:51
20240418121054	2026-03-11 03:35:51
20240523004032	2026-03-11 03:35:51
20240618124746	2026-03-11 03:35:51
20240801235015	2026-03-11 03:35:51
20240805133720	2026-03-11 03:35:51
20240827160934	2026-03-11 03:35:51
20240919163303	2026-03-11 03:35:51
20240919163305	2026-03-11 03:35:51
20241019105805	2026-03-11 03:35:51
20241030150047	2026-03-11 03:35:51
20241108114728	2026-03-11 03:35:51
20241121104152	2026-03-11 03:35:51
20241130184212	2026-03-11 03:35:51
20241220035512	2026-03-11 03:35:51
20241220123912	2026-03-11 03:35:51
20241224161212	2026-03-11 03:35:51
20250107150512	2026-03-11 03:35:51
20250110162412	2026-03-11 03:35:51
20250123174212	2026-03-11 03:35:51
20250128220012	2026-03-11 03:35:51
20250506224012	2026-03-11 03:35:51
20250523164012	2026-03-11 03:35:51
20250714121412	2026-03-11 03:35:51
20250905041441	2026-03-11 03:35:51
20251103001201	2026-03-11 03:35:51
20251120212548	2026-03-11 03:35:51
20251120215549	2026-03-11 03:35:51
20260218120000	2026-03-11 03:35:51
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: kashishgarg
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: kashishgarg
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: kashishgarg
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: kashishgarg
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: kashishgarg
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-03-11 00:16:42.388478
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-03-11 00:16:42.419534
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-03-11 00:16:42.425716
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-03-11 00:16:42.452372
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-03-11 00:16:42.498447
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-03-11 00:16:42.50127
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-03-11 00:16:42.503933
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-03-11 00:16:42.506677
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-03-11 00:16:42.508633
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-03-11 00:16:42.511752
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-03-11 00:16:42.514006
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-03-11 00:16:42.516782
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-03-11 00:16:42.519951
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-03-11 00:16:42.522072
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-03-11 00:16:42.524274
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-03-11 00:16:42.551463
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-03-11 00:16:42.553787
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-03-11 00:16:42.556596
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-03-11 00:16:42.559383
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-03-11 00:16:42.563244
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-03-11 00:16:42.565316
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-03-11 00:16:42.570294
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-03-11 00:16:42.582403
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-03-11 00:16:42.589901
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-03-11 00:16:42.592226
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-03-11 00:16:42.594745
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-03-11 00:16:42.596885
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-03-11 00:16:42.598444
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-03-11 00:16:42.599753
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-03-11 00:16:42.601146
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-03-11 00:16:42.602581
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-03-11 00:16:42.603865
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-03-11 00:16:42.605266
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-03-11 00:16:42.606508
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-03-11 00:16:42.607931
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-03-11 00:16:42.609385
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-03-11 00:16:42.610816
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-03-11 00:16:42.61226
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-03-11 00:16:42.614484
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-03-11 00:16:42.623639
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-03-11 00:16:42.625237
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-03-11 00:16:42.626873
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-03-11 00:16:42.628282
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-03-11 00:16:42.629791
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-03-11 00:16:42.631119
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-03-11 00:16:42.63347
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-03-11 00:16:42.641137
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-03-11 00:16:42.644263
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-03-11 00:16:42.64599
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-03-11 00:16:42.658941
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-03-11 00:16:42.661468
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-03-11 00:16:43.384458
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-03-11 00:16:43.385346
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-03-11 00:16:43.394826
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-03-11 00:16:43.3962
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-03-11 00:16:43.39692
56	fix-optimized-search-function	cb58526ebc23048049fd5bf2fd148d18b04a2073	2026-03-11 00:16:43.399513
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: kashishgarg
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: kashishgarg
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: kashishgarg
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: kashishgarg
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: kashishgarg
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: kashishgarg
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- Name: CategoryAuditLog CategoryAuditLog_pkey; Type: CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."CategoryAuditLog"
    ADD CONSTRAINT "CategoryAuditLog_pkey" PRIMARY KEY (id);


--
-- Name: EventStaff EventStaff_pkey; Type: CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."EventStaff"
    ADD CONSTRAINT "EventStaff_pkey" PRIMARY KEY ("eventId", "userId");


--
-- Name: Event Event_pkey; Type: CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."Event"
    ADD CONSTRAINT "Event_pkey" PRIMARY KEY (id);


--
-- Name: HealthCampRequest HealthCampRequest_pkey; Type: CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."HealthCampRequest"
    ADD CONSTRAINT "HealthCampRequest_pkey" PRIMARY KEY (id);


--
-- Name: MedicalRecord MedicalRecord_pkey; Type: CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."MedicalRecord"
    ADD CONSTRAINT "MedicalRecord_pkey" PRIMARY KEY (id);


--
-- Name: Student Student_pkey; Type: CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: kashishgarg
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: kashishgarg
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: kashishgarg
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: kashishgarg
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: kashishgarg
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- Name: MedicalRecord_studentId_key; Type: INDEX; Schema: public; Owner: kashishgarg
--

CREATE UNIQUE INDEX "MedicalRecord_studentId_key" ON public."MedicalRecord" USING btree ("studentId");


--
-- Name: Student_eventId_firstName_lastName_classSec_key; Type: INDEX; Schema: public; Owner: kashishgarg
--

CREATE UNIQUE INDEX "Student_eventId_firstName_lastName_classSec_key" ON public."Student" USING btree ("eventId", "firstName", "lastName", "classSec");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: kashishgarg
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: kashishgarg
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: kashishgarg
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_key; Type: INDEX; Schema: realtime; Owner: kashishgarg
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_key ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: kashishgarg
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: kashishgarg
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: kashishgarg
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: kashishgarg
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: kashishgarg
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: kashishgarg
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: kashishgarg
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: kashishgarg
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: kashishgarg
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: CategoryAuditLog CategoryAuditLog_medicalRecordId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."CategoryAuditLog"
    ADD CONSTRAINT "CategoryAuditLog_medicalRecordId_fkey" FOREIGN KEY ("medicalRecordId") REFERENCES public."MedicalRecord"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CategoryAuditLog CategoryAuditLog_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."CategoryAuditLog"
    ADD CONSTRAINT "CategoryAuditLog_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: EventStaff EventStaff_eventId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."EventStaff"
    ADD CONSTRAINT "EventStaff_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES public."Event"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: EventStaff EventStaff_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."EventStaff"
    ADD CONSTRAINT "EventStaff_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Event Event_createdBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."Event"
    ADD CONSTRAINT "Event_createdBy_fkey" FOREIGN KEY ("createdBy") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Event Event_headId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."Event"
    ADD CONSTRAINT "Event_headId_fkey" FOREIGN KEY ("headId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: MedicalRecord MedicalRecord_eventId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."MedicalRecord"
    ADD CONSTRAINT "MedicalRecord_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES public."Event"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: MedicalRecord MedicalRecord_studentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."MedicalRecord"
    ADD CONSTRAINT "MedicalRecord_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES public."Student"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Student Student_eventId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kashishgarg
--

ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES public."Event"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: kashishgarg
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: kashishgarg
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: kashishgarg
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: kashishgarg
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: kashishgarg
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: kashishgarg
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: kashishgarg
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: kashishgarg
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: kashishgarg
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: kashishgarg
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: kashishgarg
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: kashishgarg
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO kashishgarg;

--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: kashishgarg
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict swjZggzYsdh5JC92nVwpUc83aSv7zJPmLW6aNzrICXDe1qLHyvceDkZYlxIGw11

