--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-11-17 22:43:10

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
-- TOC entry 3382 (class 0 OID 16401)
-- Dependencies: 210
-- Data for Name: Rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Rol" ("Id", "Nombre", "Descripcion") VALUES (2, 'Administrador', 'Usuario con permisos elevados, puede gestionar los usuarios a su cargo');
INSERT INTO public."Rol" ("Id", "Nombre", "Descripcion") VALUES (3, 'Usuario', 'Usuario basico, solo puede visualizar su informacion');
INSERT INTO public."Rol" ("Id", "Nombre", "Descripcion") VALUES (1, 'SuperUsuario', 'Desarrollador, posee todos los permisos para la gestion del sistema');


--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 209
-- Name: Rol_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Rol_Id_seq"', 3, true);


-- Completed on 2022-11-17 22:43:11

--
-- PostgreSQL database dump complete
--

