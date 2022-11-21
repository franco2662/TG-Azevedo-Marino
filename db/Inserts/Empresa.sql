--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-11-20 22:17:47

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
-- TOC entry 3380 (class 0 OID 41356)
-- Dependencies: 245
-- Data for Name: Empresa; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Empresa" ("Id", "Nombre") OVERRIDING SYSTEM VALUE VALUES (1, 'TGAM');
INSERT INTO public."Empresa" ("Id", "Nombre") OVERRIDING SYSTEM VALUE VALUES (2, 'UCAB');
INSERT INTO public."Empresa" ("Id", "Nombre") OVERRIDING SYSTEM VALUE VALUES (3, 'Independiente');


--
-- TOC entry 3387 (class 0 OID 0)
-- Dependencies: 246
-- Name: Empresa_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Empresa_Id_seq"', 3, true);


-- Completed on 2022-11-20 22:17:47

--
-- PostgreSQL database dump complete
--

