--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-11-20 22:18:07

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
-- TOC entry 3382 (class 0 OID 16417)
-- Dependencies: 214
-- Data for Name: Persona; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Persona" ("Id", "Nombre", "Apellido", "FechaNac", "DocIdentidad", "Sexo") VALUES (1, 'Franco', 'Marino', '1997-06-26', '26254452', 'M');
INSERT INTO public."Persona" ("Id", "Nombre", "Apellido", "FechaNac", "DocIdentidad", "Sexo") VALUES (3, 'Francisco', 'Azevedo', '1990-12-06', '19965675', 'M');
INSERT INTO public."Persona" ("Id", "Nombre", "Apellido", "FechaNac", "DocIdentidad", "Sexo") VALUES (6, 'Ana Karina', 'Fernandes', '2000-01-01', '20100300', 'F');
INSERT INTO public."Persona" ("Id", "Nombre", "Apellido", "FechaNac", "DocIdentidad", "Sexo") VALUES (7, 'John', 'Doe', '2000-01-01', '10100200', 'M');


--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 213
-- Name: Persona_Id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Persona_Id_seq1"', 7, true);


-- Completed on 2022-11-20 22:18:07

--
-- PostgreSQL database dump complete
--

