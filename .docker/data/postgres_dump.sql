--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--




--
-- Drop roles
--



--
-- Roles
--

--- CREATE ROLE "user";
--- ALTER ROLE "user" WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5c41badb1d5bb89c8db4fa5f66a4611ea';






--
-- PostgreSQL database dump
--

-- Dumped from database version 11.8 (Debian 11.8-1.pgdg90+1)
-- Dumped by pg_dump version 11.8 (Debian 11.8-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: user
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO "user";

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: user
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: user
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: user
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.8 (Debian 11.8-1.pgdg90+1)
-- Dumped by pg_dump version 11.8 (Debian 11.8-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: user
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO "user";

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: user
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.8 (Debian 11.8-1.pgdg90+1)
-- Dumped by pg_dump version 11.8 (Debian 11.8-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: realworld; Type: DATABASE; Schema: -; Owner: user
--

CREATE DATABASE realworld WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE realworld OWNER TO "user";

\connect realworld

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: article_comments; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.article_comments (
    id integer NOT NULL,
    article_id integer NOT NULL,
    author_image character varying(255) NOT NULL,
    author_id integer NOT NULL,
    author_username character varying(255) NOT NULL,
    body character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.article_comments OWNER TO "user";

--
-- Name: article_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.article_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.article_comments_id_seq OWNER TO "user";

--
-- Name: article_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.article_comments_id_seq OWNED BY public.article_comments.id;


--
-- Name: articles; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.articles (
    id integer NOT NULL,
    author_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    body character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tags character varying(255)
);


ALTER TABLE public.articles OWNER TO "user";

--
-- Name: articles_favorites; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.articles_favorites (
    id integer NOT NULL,
    article_id integer NOT NULL,
    user_id integer NOT NULL,
    value boolean NOT NULL
);


ALTER TABLE public.articles_favorites OWNER TO "user";

--
-- Name: articles_favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.articles_favorites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_favorites_id_seq OWNER TO "user";

--
-- Name: articles_favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.articles_favorites_id_seq OWNED BY public.articles_favorites.id;


--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.articles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.articles_id_seq OWNER TO "user";

--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.articles_id_seq OWNED BY public.articles.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    session_one character varying(255) NOT NULL,
    session_two character varying(255) NOT NULL
);


ALTER TABLE public.sessions OWNER TO "user";

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO "user";

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    email character varying(355) NOT NULL,
    created_on timestamp without time zone,
    last_login timestamp without time zone,
    image character varying DEFAULT 'https://static.productionready.io/images/smiley-cyrus.jpg'::character varying NOT NULL,
    bio character varying(280)
);


ALTER TABLE public.users OWNER TO "user";

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO "user";

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;

-- 
-- Name: follows; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.follows (
    id integer NOT NULL,
    follower_id integer NOT NULL,
    following_id integer NOT NULL
);

ALTER TABLE public.follows OWNER TO "user";

-- 
-- Name: follows_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.follows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.follows_id_seq OWNER TO "user";

-- 
-- Name: follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.follows_id_seq OWNED BY public.follows.id;

-- 
-- Name: follows id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.follows ALTER COLUMN id SET DEFAULT nextval('public.follows_id_seq'::regclass);

--
-- Name: article_comments id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.article_comments ALTER COLUMN id SET DEFAULT nextval('public.article_comments_id_seq'::regclass);


--
-- Name: articles id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.articles ALTER COLUMN id SET DEFAULT nextval('public.articles_id_seq'::regclass);


--
-- Name: articles_favorites id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.articles_favorites ALTER COLUMN id SET DEFAULT nextval('public.articles_favorites_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: article_comments; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.article_comments (id, article_id, author_image, author_id, author_username, body, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.articles (id, author_id, title, description, body, slug, created_at, updated_at, tags) FROM stdin;
\.


--
-- Data for Name: articles_favorites; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.articles_favorites (id, article_id, user_id, value) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.sessions (id, user_id, session_one, session_two) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.users (id, username, password, email, created_on, last_login, image, bio) FROM stdin;
1	user1	$2a$10$kESRkG5V0qicVS52rRkGBOcvS6t93Ass0on8N2XSUkLXClAqLlsYe	test@test.com	2020-05-14 20:03:56.025651	\N	https://static.productionready.io/images/smiley-cyrus.jpg	\N
2	user2	$2a$10$kESRkG5V0qicVS52rRkGBOcvS6t93Ass0on8N2XSUkLXClAqLlsYe	test2@test.com	2020-05-14 20:03:56.025651	\N	https://static.productionready.io/images/smiley-cyrus.jpg	\N
3	user3	$2a$10$Ha7shP2TNTmTR9tC8xdXg.Vta3w6IaHYnMNOxxfl5EG.cdwVFnTlW	user3@hotmail.com	2020-05-14 20:03:56.025651	\N	https://static.productionready.io/images/smiley-cyrus.jpg	\N
4	user4	$2a$10$Ha7shP2TNTmTR9tC8xdXg.Vta3w6IaHYnMNOxxfl5EG.cdwVFnTlW	user4@hotmail.com	2020-05-14 20:03:56.025651	\N	https://static.productionready.io/images/smiley-cyrus.jpg	\N
5	user5	$2a$10$Ha7shP2TNTmTR9tC8xdXg.Vta3w6IaHYnMNOxxfl5EG.cdwVFnTlW	user5@hotmail.com	2020-05-14 20:03:56.025651	\N	https://static.productionready.io/images/smiley-cyrus.jpg	\N
6	user6	$2a$10$Ha7shP2TNTmTR9tC8xdXg.Vta3w6IaHYnMNOxxfl5EG.cdwVFnTlW	user6@hotmail.com	2020-05-14 20:03:56.025651	\N	https://static.productionready.io/images/smiley-cyrus.jpg	\N
7	user7	$2a$10$Ha7shP2TNTmTR9tC8xdXg.Vta3w6IaHYnMNOxxfl5EG.cdwVFnTlW	user7@hotmail.com	2020-05-14 20:03:56.025651	\N	https://static.productionready.io/images/smiley-cyrus.jpg	\N
8	user8	$2a$10$Ha7shP2TNTmTR9tC8xdXg.Vta3w6IaHYnMNOxxfl5EG.cdwVFnTlW	user8@hotmail.com	2020-05-14 20:03:56.025651	\N	https://static.productionready.io/images/smiley-cyrus.jpg	\N
\.


--
-- Name: article_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.article_comments_id_seq', 1, false);


--
-- Name: articles_favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.articles_favorites_id_seq', 1, false);


--
-- Name: articles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.articles_id_seq', 1, true);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.sessions_id_seq', 1, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.users_id_seq', 100, true);


--
-- Name: article_comments article_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.article_comments
    ADD CONSTRAINT article_comments_pkey PRIMARY KEY (id);


--
-- Name: articles_favorites articles_favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.articles_favorites
    ADD CONSTRAINT articles_favorites_pkey PRIMARY KEY (id);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.8 (Debian 11.8-1.pgdg90+1)
-- Dumped by pg_dump version 11.8 (Debian 11.8-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

