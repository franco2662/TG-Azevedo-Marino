--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-06-06 23:15:50

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

DROP DATABASE IF EXISTS "TGAM";
--
-- TOC entry 3337 (class 1262 OID 16394)
-- Name: TGAM; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "TGAM" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Venezuela.1252';


ALTER DATABASE "TGAM" OWNER TO postgres;

\connect "TGAM"

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

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 16417)
-- Name: Persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Persona" (
    "Id" integer NOT NULL,
    "Nombre" character varying NOT NULL,
    "Apellido" character varying NOT NULL,
    "FechaNac" date NOT NULL,
    "DocIdentidad" character varying NOT NULL,
    "Sexo" "char" NOT NULL
);


ALTER TABLE public."Persona" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16410)
-- Name: Sesion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sesion" (
    "Id" integer NOT NULL,
    "HoraInicio" timestamp without time zone NOT NULL,
    "HoraFin" timestamp without time zone,
    "IpConexion" character varying(15) NOT NULL
);


ALTER TABLE public."Sesion" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16409)
-- Name: Persona_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Persona_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Persona_Id_seq" OWNER TO postgres;

--
-- TOC entry 3338 (class 0 OID 0)
-- Dependencies: 211
-- Name: Persona_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Persona_Id_seq" OWNED BY public."Sesion"."Id";


--
-- TOC entry 213 (class 1259 OID 16416)
-- Name: Persona_Id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Persona_Id_seq1"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Persona_Id_seq1" OWNER TO postgres;

--
-- TOC entry 3339 (class 0 OID 0)
-- Dependencies: 213
-- Name: Persona_Id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Persona_Id_seq1" OWNED BY public."Persona"."Id";


--
-- TOC entry 210 (class 1259 OID 16401)
-- Name: Rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Rol" (
    "Id" integer NOT NULL,
    "Nombre" character varying NOT NULL,
    "Descripcion" character varying
);


ALTER TABLE public."Rol" OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16400)
-- Name: Rol_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Rol_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Rol_Id_seq" OWNER TO postgres;

--
-- TOC entry 3340 (class 0 OID 0)
-- Dependencies: 209
-- Name: Rol_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Rol_Id_seq" OWNED BY public."Rol"."Id";


--
-- TOC entry 216 (class 1259 OID 16426)
-- Name: Usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Usuario" (
    "Id" integer NOT NULL,
    "Email" character varying NOT NULL,
    "Clave" character varying NOT NULL,
    "FechaCreacion" timestamp without time zone NOT NULL,
    "Fk_Rol" integer,
    "Fk_Persona" integer
);


ALTER TABLE public."Usuario" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16425)
-- Name: Usuario_Id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Usuario_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Usuario_Id_seq" OWNER TO postgres;

--
-- TOC entry 3341 (class 0 OID 0)
-- Dependencies: 215
-- Name: Usuario_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Usuario_Id_seq" OWNED BY public."Usuario"."Id";


--
-- TOC entry 3181 (class 2604 OID 16420)
-- Name: Persona Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Persona" ALTER COLUMN "Id" SET DEFAULT nextval('public."Persona_Id_seq1"'::regclass);


--
-- TOC entry 3179 (class 2604 OID 16404)
-- Name: Rol Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol" ALTER COLUMN "Id" SET DEFAULT nextval('public."Rol_Id_seq"'::regclass);


--
-- TOC entry 3180 (class 2604 OID 16413)
-- Name: Sesion Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sesion" ALTER COLUMN "Id" SET DEFAULT nextval('public."Persona_Id_seq"'::regclass);


--
-- TOC entry 3182 (class 2604 OID 16429)
-- Name: Usuario Id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario" ALTER COLUMN "Id" SET DEFAULT nextval('public."Usuario_Id_seq"'::regclass);


--
-- TOC entry 3186 (class 2606 OID 16415)
-- Name: Sesion Persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sesion"
    ADD CONSTRAINT "Persona_pkey" PRIMARY KEY ("Id");


--
-- TOC entry 3188 (class 2606 OID 16424)
-- Name: Persona Persona_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT "Persona_pkey1" PRIMARY KEY ("Id");


--
-- TOC entry 3184 (class 2606 OID 16406)
-- Name: Rol Rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Rol"
    ADD CONSTRAINT "Rol_pkey" PRIMARY KEY ("Id");


--
-- TOC entry 3190 (class 2606 OID 16433)
-- Name: Usuario Usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_pkey" PRIMARY KEY ("Id");


--
-- TOC entry 3192 (class 2606 OID 16439)
-- Name: Usuario Persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Persona" FOREIGN KEY ("Fk_Persona") REFERENCES public."Persona"("Id") NOT VALID;


--
-- TOC entry 3191 (class 2606 OID 16434)
-- Name: Usuario Rol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Rol" FOREIGN KEY ("Fk_Rol") REFERENCES public."Rol"("Id") NOT VALID;


-- Completed on 2022-06-06 23:15:50

--
-- PostgreSQL database dump complete
--

