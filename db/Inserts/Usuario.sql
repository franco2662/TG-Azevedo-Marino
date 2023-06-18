--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-11-20 22:18:28

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
-- TOC entry 3386 (class 0 OID 16426)
-- Dependencies: 216
-- Data for Name: Usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Usuario" ("Id", "Email", "Clave", "FechaCreacion", "Fk_Rol", "Fk_Persona", "Estado", "Fk_Empresa") VALUES (5, 'anakarina@ucab.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '2022-11-17 00:00:00', 2, 6, true, 2);
INSERT INTO public."Usuario" ("Id", "Email", "Clave", "FechaCreacion", "Fk_Rol", "Fk_Persona", "Estado", "Fk_Empresa") VALUES (1, 'franco2662@gmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '2022-08-05 12:16:03.382721', 1, 1, true, 1);
INSERT INTO public."Usuario" ("Id", "Email", "Clave", "FechaCreacion", "Fk_Rol", "Fk_Persona", "Estado", "Fk_Empresa") VALUES (2, 'franciscojazevedos@gmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '2022-10-24 00:00:00', 1, 3, true, 1);
INSERT INTO public."Usuario" ("Id", "Email", "Clave", "FechaCreacion", "Fk_Rol", "Fk_Persona", "Estado", "Fk_Empresa") VALUES (6, 'johndoe@outlook.com', '04f8996da763b7a969b1028ee3007569eaf3a635486ddab211d512c85b9df8fb', '2022-11-20 00:00:00', 3, 7, true, 3);


--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 215
-- Name: Usuario_Id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Usuario_Id_seq"', 6, true);


-- Completed on 2022-11-20 22:18:28

--
-- PostgreSQL database dump complete
--

