--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

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
-- Data for Name: Tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Tipo"("Nombre", "Descripcion") VALUES ('Deseado', 'Elemento esperado en la computadora');
INSERT INTO public."Tipo"("Nombre", "Descripcion") VALUES ('No Deseado', 'Elemento no esperado en la computadora');
INSERT INTO public."Tipo"("Nombre", "Descripcion") VALUES ('Prob No Deseado', 'Elemento que probablemente no es esperado en la computadora');


--
-- Name: Tipo_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--


--
-- PostgreSQL database dump complete
--

