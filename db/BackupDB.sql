PGDMP         +                {            TGAM    14.2    14.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    50391    TGAM    DATABASE     f   CREATE DATABASE "TGAM" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Venezuela.1252';
    DROP DATABASE "TGAM";
                postgres    false            �            1255    50846 !   fn_bad_dir_avg(character varying)    FUNCTION     P  CREATE FUNCTION public.fn_bad_dir_avg(name_directorio character varying) RETURNS TABLE(directorio character varying, cantidad bigint, promedio double precision)
    LANGUAGE plpgsql
    AS $$
begin
return query
select name_directorio as directorio,coalesce(count(distinct se."Fk_Usuario"),0) cantidad,coalesce(avg(dir."Porcentaje_No"),0) promedio
from "Directorio" dir join "Analisis" ON "Analisis"."Id" = dir."Fk_Analisis"
join "Sesion" se ON se."Id" = "Analisis"."Fk_Sesion"
join "Tipo" ON "Tipo"."Id" = dir."Fk_Tipo"
where dir."Nombre" = name_directorio and "Tipo"."Id" in (2,3)
;
end;$$;
 H   DROP FUNCTION public.fn_bad_dir_avg(name_directorio character varying);
       public          postgres    false                       1255    50847 "   fn_bad_proc_avg(character varying)    FUNCTION     V  CREATE FUNCTION public.fn_bad_proc_avg(name_proceso character varying) RETURNS TABLE(proceso character varying, cantidad bigint, promedio double precision)
    LANGUAGE plpgsql
    AS $$
begin
return query
select name_proceso as proceso,coalesce(count(distinct se."Fk_Usuario"),0) cantidad,coalesce(avg(proc."Porcentaje_No"),0) promedio
from "Proceso" proc join "Analisis" ON "Analisis"."Id" = proc."Fk_Analisis"
join "Sesion" se ON se."Id" = "Analisis"."Fk_Sesion"
join "Tipo" ON "Tipo"."Id" = proc."Fk_Tipo"
where proc."Description" like '%'||name_proceso||'%' and "Tipo"."Id" in (2,3)
;
end;$$;
 F   DROP FUNCTION public.fn_bad_proc_avg(name_proceso character varying);
       public          postgres    false            �            1255    50774    fn_count_dirs(bigint)    FUNCTION     �  CREATE FUNCTION public.fn_count_dirs(id_analisis bigint) RETURNS TABLE(no_deseados bigint, prob_no_deseados bigint)
    LANGUAGE plpgsql
    AS $$
begin
return query
select 
(SELECT count(dir.*) as no_deseados
	FROM public."Analisis" analisis 
	JOIN "Directorio" dir on analisis."Id" = dir."Fk_Analisis"
	JOIN "Tipo" tp on dir."Fk_Tipo" = tp."Id"
where tp."Id" = 2 and analisis."Id" = id_analisis ) as no_deseados,
(SELECT count(dir.*) as prob_no_deseados
	FROM public."Analisis" analisis 
	JOIN "Directorio" dir on analisis."Id" = dir."Fk_Analisis"
	JOIN "Tipo" tp on dir."Fk_Tipo" = tp."Id"
where tp."Id" = 3 and analisis."Id" = id_analisis) as prob_no_deseados
;
end;$$;
 8   DROP FUNCTION public.fn_count_dirs(id_analisis bigint);
       public          postgres    false            �            1255    50775    fn_count_procs(bigint)    FUNCTION     �  CREATE FUNCTION public.fn_count_procs(id_analisis bigint) RETURNS TABLE(no_deseados bigint, prob_no_deseados bigint)
    LANGUAGE plpgsql
    AS $$
begin
return query
select 
(SELECT count(proc.*) as no_deseados
	FROM public."Analisis" analisis 
	JOIN "Proceso" proc on analisis."Id" = proc."Fk_Analisis"
	JOIN "Tipo" tp on proc."Fk_Tipo" = tp."Id"
where tp."Id" = 2 and analisis."Id" = id_analisis ) as no_deseados,
(SELECT count(proc.*) as prob_no_deseados
	FROM public."Analisis" analisis 
	JOIN "Proceso" proc on analisis."Id" = proc."Fk_Analisis"
	JOIN "Tipo" tp on proc."Fk_Tipo" = tp."Id"
where tp."Id" = 3 and analisis."Id" = id_analisis) as prob_no_deseados
;
end;$$;
 9   DROP FUNCTION public.fn_count_procs(id_analisis bigint);
       public          postgres    false            	           1255    50776    fn_count_regs(bigint)    FUNCTION     �  CREATE FUNCTION public.fn_count_regs(id_analisis bigint) RETURNS TABLE(no_deseados bigint, prob_no_deseados bigint)
    LANGUAGE plpgsql
    AS $$
begin
return query
select 
(SELECT count(reg.*) as no_deseados
	FROM public."Analisis" analisis 
	JOIN "Registro" reg on analisis."Id" = reg."Fk_Analisis"
	JOIN "Tipo" tp on reg."Fk_Tipo" = tp."Id"
where tp."Id" = 2 and analisis."Id" = id_analisis ) as no_deseados,
(SELECT count(reg.*) as prob_no_deseados
	FROM public."Analisis" analisis 
	JOIN "Registro" reg on analisis."Id" = reg."Fk_Analisis"
	JOIN "Tipo" tp on reg."Fk_Tipo" = tp."Id"
where tp."Id" = 3 and analisis."Id" = id_analisis) as prob_no_deseados
;
end;$$;
 8   DROP FUNCTION public.fn_count_regs(id_analisis bigint);
       public          postgres    false                       1255    50802    fn_list_bad_dirs(bigint)    FUNCTION     �  CREATE FUNCTION public.fn_list_bad_dirs(id_analisis bigint) RETURNS TABLE(directorio character varying, tipo integer, porcentaje double precision)
    LANGUAGE plpgsql
    AS $$
begin
return query
SELECT dir."Nombre" as directorio,tp."Id" as tipo, dir."Porcentaje_No" as porcentaje
	FROM public."Analisis" analisis 
	JOIN "Directorio" dir on analisis."Id" = dir."Fk_Analisis"
	JOIN "Tipo" tp on dir."Fk_Tipo" = tp."Id"
where tp."Id" = 2 and analisis."Id" = id_analisis
union all
SELECT dir."Nombre" as directorio,tp."Id" as tipo, dir."Porcentaje_No" as porcentaje
	FROM public."Analisis" analisis 
	JOIN "Directorio" dir on analisis."Id" = dir."Fk_Analisis"
	JOIN "Tipo" tp on dir."Fk_Tipo" = tp."Id"
where tp."Id" = 3 and analisis."Id" = id_analisis
;
end;$$;
 ;   DROP FUNCTION public.fn_list_bad_dirs(id_analisis bigint);
       public          postgres    false            
           1255    50799    fn_list_bad_procs(bigint)    FUNCTION     �  CREATE FUNCTION public.fn_list_bad_procs(id_analisis bigint) RETURNS TABLE(proceso character varying, tipo integer, porcentaje double precision)
    LANGUAGE plpgsql
    AS $$
begin
return query
SELECT proc."Description" as proceso,tp."Id" as tipo, proc."Porcentaje_No" as porcentaje
	FROM public."Analisis" analisis 
	JOIN "Proceso" proc on analisis."Id" = proc."Fk_Analisis"
	JOIN "Tipo" tp on proc."Fk_Tipo" = tp."Id"
where tp."Id" = 2 and analisis."Id" = id_analisis
union all
SELECT proc."Description" as proceso,tp."Id" as tipo, proc."Porcentaje_No" as porcentaje
	FROM public."Analisis" analisis 
	JOIN "Proceso" proc on analisis."Id" = proc."Fk_Analisis"
	JOIN "Tipo" tp on proc."Fk_Tipo" = tp."Id"
where tp."Id" = 3 and analisis."Id" = id_analisis
;
end;$$;
 <   DROP FUNCTION public.fn_list_bad_procs(id_analisis bigint);
       public          postgres    false                       1255    50804    fn_list_bad_regs(bigint)    FUNCTION     �  CREATE FUNCTION public.fn_list_bad_regs(id_analisis bigint) RETURNS TABLE(registro character varying, tipo integer, porcentaje double precision)
    LANGUAGE plpgsql
    AS $$
begin
return query
SELECT reg."Nombre" as registro,tp."Id" as tipo, reg."Porcentaje_No" as porcentaje
	FROM public."Analisis" analisis 
	JOIN "Registro" reg on analisis."Id" = reg."Fk_Analisis"
	JOIN "Tipo" tp on reg."Fk_Tipo" = tp."Id"
where tp."Id" = 2 and analisis."Id" = id_analisis
union all
SELECT reg."Nombre" as registro,tp."Id" as tipo, reg."Porcentaje_No" as porcentaje
	FROM public."Analisis" analisis 
	JOIN "Registro" reg on analisis."Id" = reg."Fk_Analisis"
	JOIN "Tipo" tp on reg."Fk_Tipo" = tp."Id"
where tp."Id" = 3 and analisis."Id" = id_analisis
;
end;$$;
 ;   DROP FUNCTION public.fn_list_bad_regs(id_analisis bigint);
       public          postgres    false            �            1259    50395    Analisis    TABLE     �   CREATE TABLE public."Analisis" (
    "Id" integer NOT NULL,
    "NombrePc" character varying,
    "Fecha" timestamp without time zone NOT NULL,
    "Fk_Sesion" integer
);
    DROP TABLE public."Analisis";
       public         heap    postgres    false            �            1259    50400    Analisis_Id_seq    SEQUENCE     �   ALTER TABLE public."Analisis" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Analisis_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    209            �            1259    50757 
   Directorio    TABLE     �   CREATE TABLE public."Directorio" (
    "Id" bigint NOT NULL,
    "Nombre" character varying,
    "Fk_Tipo" integer,
    "Fk_Analisis" integer,
    "Porcentaje_No" double precision
);
     DROP TABLE public."Directorio";
       public         heap    postgres    false            �            1259    50756    Directorio_Id_seq    SEQUENCE     �   ALTER TABLE public."Directorio" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Directorio_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    250            �            1259    50407    Empresa    TABLE     ]   CREATE TABLE public."Empresa" (
    "Id" integer NOT NULL,
    "Nombre" character varying
);
    DROP TABLE public."Empresa";
       public         heap    postgres    false            �            1259    50412    Empresa_Id_seq    SEQUENCE     �   ALTER TABLE public."Empresa" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Empresa_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    211            �            1259    50413    Persona    TABLE     �   CREATE TABLE public."Persona" (
    "Id" integer NOT NULL,
    "Nombre" character varying NOT NULL,
    "Apellido" character varying NOT NULL,
    "FechaNac" date NOT NULL,
    "DocIdentidad" character varying NOT NULL,
    "Sexo" "char" NOT NULL
);
    DROP TABLE public."Persona";
       public         heap    postgres    false            �            1259    50418    Sesion    TABLE     �   CREATE TABLE public."Sesion" (
    "Id" integer NOT NULL,
    "HoraInicio" timestamp without time zone NOT NULL,
    "IpConexion" character varying(15) NOT NULL,
    "Fk_Usuario" integer NOT NULL
);
    DROP TABLE public."Sesion";
       public         heap    postgres    false            �            1259    50421    Persona_Id_seq    SEQUENCE     �   CREATE SEQUENCE public."Persona_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Persona_Id_seq";
       public          postgres    false    214            �           0    0    Persona_Id_seq    SEQUENCE OWNED BY     F   ALTER SEQUENCE public."Persona_Id_seq" OWNED BY public."Sesion"."Id";
          public          postgres    false    215            �            1259    50422    Persona_Id_seq1    SEQUENCE     �   CREATE SEQUENCE public."Persona_Id_seq1"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Persona_Id_seq1";
       public          postgres    false    213            �           0    0    Persona_Id_seq1    SEQUENCE OWNED BY     H   ALTER SEQUENCE public."Persona_Id_seq1" OWNED BY public."Persona"."Id";
          public          postgres    false    216            �            1259    50721    Proceso    TABLE       CREATE TABLE public."Proceso" (
    "Id" bigint NOT NULL,
    "Node" character varying,
    "CommandLine" character varying,
    "CSName" character varying,
    "Description" character varying,
    "ExecutablePath" character varying,
    "ExecutableState" bigint,
    "Handle" bigint,
    "HandleCount" bigint,
    "KernelModeTime" bigint,
    "MaximumWorkingSetSize" bigint,
    "MinimumWorkingSetSize" bigint,
    "OSName" character varying,
    "OtherOperationCount" bigint,
    "OtherTransferCount" bigint,
    "PageFaults" bigint,
    "PageFileUsage" bigint,
    "ParentProcessId" bigint,
    "PeakPageFileUsage" bigint,
    "PeakVirtualSize" bigint,
    "PeakWorkingSetSize" bigint,
    "Priority" bigint,
    "PrivatePageCount" bigint,
    "ProcessId" bigint,
    "QuotaNonPagedPoolUsage" bigint,
    "QuotaPagedPoolUsage" bigint,
    "QuotaPeakNonPagedPoolUsage" bigint,
    "QuotaPeakPagedPoolUsage" bigint,
    "ReadOperationCount" bigint,
    "ReadTransferCount" bigint,
    "SessionId" bigint,
    "ThreadCount" bigint,
    "UserModeTime" bigint,
    "VirtualSize" bigint,
    "WindowsVersion" character varying,
    "WorkingSetSize" bigint,
    "WriteOperationCount" bigint,
    "WriteTransferCount" bigint,
    "Fk_Analisis" integer,
    "Fk_Tipo" integer,
    "Porcentaje_No" double precision
);
    DROP TABLE public."Proceso";
       public         heap    postgres    false            �            1259    50720    Proceso_Id_seq    SEQUENCE     �   ALTER TABLE public."Proceso" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Proceso_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    246            �            1259    50739    Registro    TABLE     �   CREATE TABLE public."Registro" (
    "Id" bigint NOT NULL,
    "Nombre" character varying NOT NULL,
    "Fk_Tipo" integer,
    "Fk_Analisis" integer,
    "Porcentaje_No" double precision
);
    DROP TABLE public."Registro";
       public         heap    postgres    false            �            1259    50738    Registro_Id_seq    SEQUENCE     �   ALTER TABLE public."Registro" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Registro_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    248            �            1259    50435    Rol    TABLE     �   CREATE TABLE public."Rol" (
    "Id" integer NOT NULL,
    "Nombre" character varying NOT NULL,
    "Descripcion" character varying
);
    DROP TABLE public."Rol";
       public         heap    postgres    false            �            1259    50440 
   Rol_Id_seq    SEQUENCE     �   CREATE SEQUENCE public."Rol_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public."Rol_Id_seq";
       public          postgres    false    217            �           0    0 
   Rol_Id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."Rol_Id_seq" OWNED BY public."Rol"."Id";
          public          postgres    false    218            �            1259    50441    Tipo    TABLE     �   CREATE TABLE public."Tipo" (
    "Id" integer NOT NULL,
    "Nombre" character varying NOT NULL,
    "Descripcion" character varying
);
    DROP TABLE public."Tipo";
       public         heap    postgres    false            �            1259    50446    Tipo_Id_seq    SEQUENCE     �   CREATE SEQUENCE public."Tipo_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."Tipo_Id_seq";
       public          postgres    false    219            �           0    0    Tipo_Id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Tipo_Id_seq" OWNED BY public."Tipo"."Id";
          public          postgres    false    220            �            1259    50447    Usuario    TABLE     4  CREATE TABLE public."Usuario" (
    "Id" integer NOT NULL,
    "Email" character varying NOT NULL,
    "Clave" character varying NOT NULL,
    "FechaCreacion" timestamp without time zone NOT NULL,
    "Fk_Rol" integer,
    "Fk_Persona" integer,
    "Estado" boolean DEFAULT true,
    "Fk_Empresa" integer
);
    DROP TABLE public."Usuario";
       public         heap    postgres    false            �            1259    50453    Usuario_Id_seq    SEQUENCE     �   CREATE SEQUENCE public."Usuario_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Usuario_Id_seq";
       public          postgres    false    221            �           0    0    Usuario_Id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Usuario_Id_seq" OWNED BY public."Usuario"."Id";
          public          postgres    false    222            �            1259    50454 
   auth_group    TABLE     f   CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);
    DROP TABLE public.auth_group;
       public         heap    postgres    false            �            1259    50457    auth_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.auth_group_id_seq;
       public          postgres    false    223            �           0    0    auth_group_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;
          public          postgres    false    224            �            1259    50458    auth_group_permissions    TABLE     �   CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);
 *   DROP TABLE public.auth_group_permissions;
       public         heap    postgres    false            �            1259    50461    auth_group_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.auth_group_permissions_id_seq;
       public          postgres    false    225            �           0    0    auth_group_permissions_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;
          public          postgres    false    226            �            1259    50462    auth_permission    TABLE     �   CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);
 #   DROP TABLE public.auth_permission;
       public         heap    postgres    false            �            1259    50465    auth_permission_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.auth_permission_id_seq;
       public          postgres    false    227            �           0    0    auth_permission_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;
          public          postgres    false    228            �            1259    50466 	   auth_user    TABLE     �  CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);
    DROP TABLE public.auth_user;
       public         heap    postgres    false            �            1259    50471    auth_user_groups    TABLE     ~   CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);
 $   DROP TABLE public.auth_user_groups;
       public         heap    postgres    false            �            1259    50474    auth_user_groups_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.auth_user_groups_id_seq;
       public          postgres    false    230            �           0    0    auth_user_groups_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;
          public          postgres    false    231            �            1259    50475    auth_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.auth_user_id_seq;
       public          postgres    false    229            �           0    0    auth_user_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;
          public          postgres    false    232            �            1259    50476    auth_user_user_permissions    TABLE     �   CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);
 .   DROP TABLE public.auth_user_user_permissions;
       public         heap    postgres    false            �            1259    50479 !   auth_user_user_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.auth_user_user_permissions_id_seq;
       public          postgres    false    233            �           0    0 !   auth_user_user_permissions_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;
          public          postgres    false    234            �            1259    50480    django_admin_log    TABLE     �  CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);
 $   DROP TABLE public.django_admin_log;
       public         heap    postgres    false            �            1259    50486    django_admin_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.django_admin_log_id_seq;
       public          postgres    false    235            �           0    0    django_admin_log_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;
          public          postgres    false    236            �            1259    50487    django_content_type    TABLE     �   CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);
 '   DROP TABLE public.django_content_type;
       public         heap    postgres    false            �            1259    50490    django_content_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.django_content_type_id_seq;
       public          postgres    false    237            �           0    0    django_content_type_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;
          public          postgres    false    238            �            1259    50491    django_migrations    TABLE     �   CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);
 %   DROP TABLE public.django_migrations;
       public         heap    postgres    false            �            1259    50496    django_migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.django_migrations_id_seq;
       public          postgres    false    239            �           0    0    django_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;
          public          postgres    false    240            �            1259    50497    django_session    TABLE     �   CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);
 "   DROP TABLE public.django_session;
       public         heap    postgres    false            �            1259    50502 
   myapp_tipo    TABLE     �   CREATE TABLE public.myapp_tipo (
    id bigint NOT NULL,
    "Nombre" character varying(100) NOT NULL,
    "Descripcion" character varying(100) NOT NULL
);
    DROP TABLE public.myapp_tipo;
       public         heap    postgres    false            �            1259    50505    myapp_tipo_id_seq    SEQUENCE     z   CREATE SEQUENCE public.myapp_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.myapp_tipo_id_seq;
       public          postgres    false    242            �           0    0    myapp_tipo_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.myapp_tipo_id_seq OWNED BY public.myapp_tipo.id;
          public          postgres    false    243            �            1259    50506    vw_user_list    VIEW       CREATE VIEW public.vw_user_list AS
 SELECT us."Id" AS id,
    (((per."Nombre")::text || ' '::text) || (per."Apellido")::text) AS nombre_completo,
    us."Email" AS email,
    per."DocIdentidad" AS doc_identidad,
    "Rol"."Nombre" AS rol,
    "Empresa"."Nombre" AS empresa,
    us."Estado" AS estado
   FROM (((public."Usuario" us
     JOIN public."Persona" per ON ((us."Fk_Persona" = per."Id")))
     JOIN public."Rol" ON (("Rol"."Id" = us."Fk_Rol")))
     JOIN public."Empresa" ON (("Empresa"."Id" = us."Fk_Empresa")))
  ORDER BY us."Id";
    DROP VIEW public.vw_user_list;
       public          postgres    false    221    211    221    217    217    213    221    221    221    221    213    213    213    211            �           2604    50511 
   Persona Id    DEFAULT     o   ALTER TABLE ONLY public."Persona" ALTER COLUMN "Id" SET DEFAULT nextval('public."Persona_Id_seq1"'::regclass);
 =   ALTER TABLE public."Persona" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    216    213            �           2604    50512    Rol Id    DEFAULT     f   ALTER TABLE ONLY public."Rol" ALTER COLUMN "Id" SET DEFAULT nextval('public."Rol_Id_seq"'::regclass);
 9   ALTER TABLE public."Rol" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    218    217            �           2604    50513 	   Sesion Id    DEFAULT     m   ALTER TABLE ONLY public."Sesion" ALTER COLUMN "Id" SET DEFAULT nextval('public."Persona_Id_seq"'::regclass);
 <   ALTER TABLE public."Sesion" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    215    214            �           2604    50514    Tipo Id    DEFAULT     h   ALTER TABLE ONLY public."Tipo" ALTER COLUMN "Id" SET DEFAULT nextval('public."Tipo_Id_seq"'::regclass);
 :   ALTER TABLE public."Tipo" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    220    219            �           2604    50515 
   Usuario Id    DEFAULT     n   ALTER TABLE ONLY public."Usuario" ALTER COLUMN "Id" SET DEFAULT nextval('public."Usuario_Id_seq"'::regclass);
 =   ALTER TABLE public."Usuario" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    222    221            �           2604    50516    auth_group id    DEFAULT     n   ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);
 <   ALTER TABLE public.auth_group ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223            �           2604    50517    auth_group_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);
 H   ALTER TABLE public.auth_group_permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225            �           2604    50518    auth_permission id    DEFAULT     x   ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);
 A   ALTER TABLE public.auth_permission ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227            �           2604    50519    auth_user id    DEFAULT     l   ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);
 ;   ALTER TABLE public.auth_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    229            �           2604    50520    auth_user_groups id    DEFAULT     z   ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);
 B   ALTER TABLE public.auth_user_groups ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    230            �           2604    50521    auth_user_user_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);
 L   ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    234    233            �           2604    50522    django_admin_log id    DEFAULT     z   ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);
 B   ALTER TABLE public.django_admin_log ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    236    235            �           2604    50523    django_content_type id    DEFAULT     �   ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);
 E   ALTER TABLE public.django_content_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    237            �           2604    50524    django_migrations id    DEFAULT     |   ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);
 C   ALTER TABLE public.django_migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    240    239            �           2604    50525    myapp_tipo id    DEFAULT     n   ALTER TABLE ONLY public.myapp_tipo ALTER COLUMN id SET DEFAULT nextval('public.myapp_tipo_id_seq'::regclass);
 <   ALTER TABLE public.myapp_tipo ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    243    242            �          0    50395    Analisis 
   TABLE DATA           L   COPY public."Analisis" ("Id", "NombrePc", "Fecha", "Fk_Sesion") FROM stdin;
    public          postgres    false    209   �      �          0    50757 
   Directorio 
   TABLE DATA           a   COPY public."Directorio" ("Id", "Nombre", "Fk_Tipo", "Fk_Analisis", "Porcentaje_No") FROM stdin;
    public          postgres    false    250         �          0    50407    Empresa 
   TABLE DATA           3   COPY public."Empresa" ("Id", "Nombre") FROM stdin;
    public          postgres    false    211   �      �          0    50413    Persona 
   TABLE DATA           c   COPY public."Persona" ("Id", "Nombre", "Apellido", "FechaNac", "DocIdentidad", "Sexo") FROM stdin;
    public          postgres    false    213   5      �          0    50721    Proceso 
   TABLE DATA           �  COPY public."Proceso" ("Id", "Node", "CommandLine", "CSName", "Description", "ExecutablePath", "ExecutableState", "Handle", "HandleCount", "KernelModeTime", "MaximumWorkingSetSize", "MinimumWorkingSetSize", "OSName", "OtherOperationCount", "OtherTransferCount", "PageFaults", "PageFileUsage", "ParentProcessId", "PeakPageFileUsage", "PeakVirtualSize", "PeakWorkingSetSize", "Priority", "PrivatePageCount", "ProcessId", "QuotaNonPagedPoolUsage", "QuotaPagedPoolUsage", "QuotaPeakNonPagedPoolUsage", "QuotaPeakPagedPoolUsage", "ReadOperationCount", "ReadTransferCount", "SessionId", "ThreadCount", "UserModeTime", "VirtualSize", "WindowsVersion", "WorkingSetSize", "WriteOperationCount", "WriteTransferCount", "Fk_Analisis", "Fk_Tipo", "Porcentaje_No") FROM stdin;
    public          postgres    false    246   �      �          0    50739    Registro 
   TABLE DATA           _   COPY public."Registro" ("Id", "Nombre", "Fk_Tipo", "Fk_Analisis", "Porcentaje_No") FROM stdin;
    public          postgres    false    248   �r      �          0    50435    Rol 
   TABLE DATA           >   COPY public."Rol" ("Id", "Nombre", "Descripcion") FROM stdin;
    public          postgres    false    217   �      �          0    50418    Sesion 
   TABLE DATA           R   COPY public."Sesion" ("Id", "HoraInicio", "IpConexion", "Fk_Usuario") FROM stdin;
    public          postgres    false    214   ��      �          0    50441    Tipo 
   TABLE DATA           ?   COPY public."Tipo" ("Id", "Nombre", "Descripcion") FROM stdin;
    public          postgres    false    219   f�      �          0    50447    Usuario 
   TABLE DATA           |   COPY public."Usuario" ("Id", "Email", "Clave", "FechaCreacion", "Fk_Rol", "Fk_Persona", "Estado", "Fk_Empresa") FROM stdin;
    public          postgres    false    221   Ҋ      �          0    50454 
   auth_group 
   TABLE DATA           .   COPY public.auth_group (id, name) FROM stdin;
    public          postgres    false    223   ̋      �          0    50458    auth_group_permissions 
   TABLE DATA           M   COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
    public          postgres    false    225   �      �          0    50462    auth_permission 
   TABLE DATA           N   COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
    public          postgres    false    227   �      �          0    50466 	   auth_user 
   TABLE DATA           �   COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
    public          postgres    false    229   ��      �          0    50471    auth_user_groups 
   TABLE DATA           A   COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
    public          postgres    false    230   q�      �          0    50476    auth_user_user_permissions 
   TABLE DATA           P   COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
    public          postgres    false    233   ��      �          0    50480    django_admin_log 
   TABLE DATA           �   COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
    public          postgres    false    235   ��      �          0    50487    django_content_type 
   TABLE DATA           C   COPY public.django_content_type (id, app_label, model) FROM stdin;
    public          postgres    false    237   Ȑ      �          0    50491    django_migrations 
   TABLE DATA           C   COPY public.django_migrations (id, app, name, applied) FROM stdin;
    public          postgres    false    239   ��      �          0    50497    django_session 
   TABLE DATA           P   COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
    public          postgres    false    241   œ      �          0    50502 
   myapp_tipo 
   TABLE DATA           A   COPY public.myapp_tipo (id, "Nombre", "Descripcion") FROM stdin;
    public          postgres    false    242   �      �           0    0    Analisis_Id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Analisis_Id_seq"', 17, true);
          public          postgres    false    210                        0    0    Directorio_Id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Directorio_Id_seq"', 320, true);
          public          postgres    false    249                       0    0    Empresa_Id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Empresa_Id_seq"', 3, true);
          public          postgres    false    212                       0    0    Persona_Id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Persona_Id_seq"', 70, true);
          public          postgres    false    215                       0    0    Persona_Id_seq1    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Persona_Id_seq1"', 7, true);
          public          postgres    false    216                       0    0    Proceso_Id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Proceso_Id_seq"', 1370, true);
          public          postgres    false    245                       0    0    Registro_Id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Registro_Id_seq"', 630, true);
          public          postgres    false    247                       0    0 
   Rol_Id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public."Rol_Id_seq"', 3, true);
          public          postgres    false    218                       0    0    Tipo_Id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public."Tipo_Id_seq"', 3, true);
          public          postgres    false    220                       0    0    Usuario_Id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Usuario_Id_seq"', 6, true);
          public          postgres    false    222            	           0    0    auth_group_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);
          public          postgres    false    224            
           0    0    auth_group_permissions_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);
          public          postgres    false    226                       0    0    auth_permission_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.auth_permission_id_seq', 96, true);
          public          postgres    false    228                       0    0    auth_user_groups_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);
          public          postgres    false    231                       0    0    auth_user_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);
          public          postgres    false    232                       0    0 !   auth_user_user_permissions_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);
          public          postgres    false    234                       0    0    django_admin_log_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);
          public          postgres    false    236                       0    0    django_content_type_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.django_content_type_id_seq', 24, true);
          public          postgres    false    238                       0    0    django_migrations_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.django_migrations_id_seq', 23, true);
          public          postgres    false    240                       0    0    myapp_tipo_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.myapp_tipo_id_seq', 1, false);
          public          postgres    false    243            �           2606    50527    Analisis Analisis_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Analisis"
    ADD CONSTRAINT "Analisis_pkey" PRIMARY KEY ("Id");
 D   ALTER TABLE ONLY public."Analisis" DROP CONSTRAINT "Analisis_pkey";
       public            postgres    false    209                        2606    50763    Directorio Directorio_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."Directorio"
    ADD CONSTRAINT "Directorio_pkey" PRIMARY KEY ("Id");
 H   ALTER TABLE ONLY public."Directorio" DROP CONSTRAINT "Directorio_pkey";
       public            postgres    false    250            �           2606    50531    Empresa Empresa_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_pkey" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Empresa" DROP CONSTRAINT "Empresa_pkey";
       public            postgres    false    211            �           2606    50533    Persona Persona_pkey1 
   CONSTRAINT     Y   ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT "Persona_pkey1" PRIMARY KEY ("Id");
 C   ALTER TABLE ONLY public."Persona" DROP CONSTRAINT "Persona_pkey1";
       public            postgres    false    213                       2606    50727    Proceso Proceso_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Proceso"
    ADD CONSTRAINT "Proceso_pkey" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Proceso" DROP CONSTRAINT "Proceso_pkey";
       public            postgres    false    246                       2606    50745    Registro Registro_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Registro"
    ADD CONSTRAINT "Registro_pkey" PRIMARY KEY ("Id");
 D   ALTER TABLE ONLY public."Registro" DROP CONSTRAINT "Registro_pkey";
       public            postgres    false    248            �           2606    50539    Rol Rol_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Rol"
    ADD CONSTRAINT "Rol_pkey" PRIMARY KEY ("Id");
 :   ALTER TABLE ONLY public."Rol" DROP CONSTRAINT "Rol_pkey";
       public            postgres    false    217            �           2606    50541    Sesion Sesion_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Sesion"
    ADD CONSTRAINT "Sesion_pkey" PRIMARY KEY ("Id");
 @   ALTER TABLE ONLY public."Sesion" DROP CONSTRAINT "Sesion_pkey";
       public            postgres    false    214            �           2606    50543    Tipo Tipo_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Tipo"
    ADD CONSTRAINT "Tipo_pkey" PRIMARY KEY ("Id");
 <   ALTER TABLE ONLY public."Tipo" DROP CONSTRAINT "Tipo_pkey";
       public            postgres    false    219            �           2606    50545    Usuario Usuario_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_pkey" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Usuario_pkey";
       public            postgres    false    221            �           2606    50547    auth_group auth_group_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
       public            postgres    false    223            �           2606    50549 R   auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);
 |   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
       public            postgres    false    225    225            �           2606    50551 2   auth_group_permissions auth_group_permissions_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
       public            postgres    false    225            �           2606    50553    auth_group auth_group_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
       public            postgres    false    223            �           2606    50555 F   auth_permission auth_permission_content_type_id_codename_01ab375a_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);
 p   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq;
       public            postgres    false    227    227            �           2606    50557 $   auth_permission auth_permission_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
       public            postgres    false    227                       2606    50559 &   auth_user_groups auth_user_groups_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_pkey;
       public            postgres    false    230                       2606    50561 @   auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);
 j   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq;
       public            postgres    false    230    230            �           2606    50563    auth_user auth_user_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_pkey;
       public            postgres    false    229                       2606    50565 :   auth_user_user_permissions auth_user_user_permissions_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_pkey;
       public            postgres    false    233            
           2606    50567 Y   auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
       public            postgres    false    233    233            �           2606    50569     auth_user auth_user_username_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);
 J   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_username_key;
       public            postgres    false    229                       2606    50571 &   django_admin_log django_admin_log_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
       public            postgres    false    235                       2606    50573 E   django_content_type django_content_type_app_label_model_76bd3d3b_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);
 o   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
       public            postgres    false    237    237                       2606    50575 ,   django_content_type django_content_type_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
       public            postgres    false    237                       2606    50577 (   django_migrations django_migrations_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
       public            postgres    false    239                       2606    50579 "   django_session django_session_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);
 L   ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
       public            postgres    false    241                       2606    50581    myapp_tipo myapp_tipo_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.myapp_tipo
    ADD CONSTRAINT myapp_tipo_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.myapp_tipo DROP CONSTRAINT myapp_tipo_pkey;
       public            postgres    false    242            �           1259    50582    auth_group_name_a6ea08ec_like    INDEX     h   CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);
 1   DROP INDEX public.auth_group_name_a6ea08ec_like;
       public            postgres    false    223            �           1259    50583 (   auth_group_permissions_group_id_b120cbf9    INDEX     o   CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);
 <   DROP INDEX public.auth_group_permissions_group_id_b120cbf9;
       public            postgres    false    225            �           1259    50584 -   auth_group_permissions_permission_id_84c5c92e    INDEX     y   CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);
 A   DROP INDEX public.auth_group_permissions_permission_id_84c5c92e;
       public            postgres    false    225            �           1259    50585 (   auth_permission_content_type_id_2f476e4b    INDEX     o   CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);
 <   DROP INDEX public.auth_permission_content_type_id_2f476e4b;
       public            postgres    false    227            �           1259    50586 "   auth_user_groups_group_id_97559544    INDEX     c   CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);
 6   DROP INDEX public.auth_user_groups_group_id_97559544;
       public            postgres    false    230                       1259    50587 !   auth_user_groups_user_id_6a12ed8b    INDEX     a   CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);
 5   DROP INDEX public.auth_user_groups_user_id_6a12ed8b;
       public            postgres    false    230                       1259    50588 1   auth_user_user_permissions_permission_id_1fbb5f2c    INDEX     �   CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);
 E   DROP INDEX public.auth_user_user_permissions_permission_id_1fbb5f2c;
       public            postgres    false    233                       1259    50589 +   auth_user_user_permissions_user_id_a95ead1b    INDEX     u   CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);
 ?   DROP INDEX public.auth_user_user_permissions_user_id_a95ead1b;
       public            postgres    false    233            �           1259    50590     auth_user_username_6821ab7c_like    INDEX     n   CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);
 4   DROP INDEX public.auth_user_username_6821ab7c_like;
       public            postgres    false    229                       1259    50591 )   django_admin_log_content_type_id_c4bce8eb    INDEX     q   CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);
 =   DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
       public            postgres    false    235                       1259    50592 !   django_admin_log_user_id_c564eba6    INDEX     a   CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);
 5   DROP INDEX public.django_admin_log_user_id_c564eba6;
       public            postgres    false    235                       1259    50593 #   django_session_expire_date_a5c62663    INDEX     e   CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);
 7   DROP INDEX public.django_session_expire_date_a5c62663;
       public            postgres    false    241                       1259    50594 (   django_session_session_key_c0390e0f_like    INDEX     ~   CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);
 <   DROP INDEX public.django_session_session_key_c0390e0f_like;
       public            postgres    false    241            /           2606    50728    Proceso Analisis    FK CONSTRAINT     �   ALTER TABLE ONLY public."Proceso"
    ADD CONSTRAINT "Analisis" FOREIGN KEY ("Fk_Analisis") REFERENCES public."Analisis"("Id");
 >   ALTER TABLE ONLY public."Proceso" DROP CONSTRAINT "Analisis";
       public          postgres    false    209    3293    246            1           2606    50746    Registro Analisis    FK CONSTRAINT     �   ALTER TABLE ONLY public."Registro"
    ADD CONSTRAINT "Analisis" FOREIGN KEY ("Fk_Analisis") REFERENCES public."Analisis"("Id");
 ?   ALTER TABLE ONLY public."Registro" DROP CONSTRAINT "Analisis";
       public          postgres    false    3293    209    248            3           2606    50764    Directorio Analisis    FK CONSTRAINT     �   ALTER TABLE ONLY public."Directorio"
    ADD CONSTRAINT "Analisis" FOREIGN KEY ("Fk_Analisis") REFERENCES public."Analisis"("Id");
 A   ALTER TABLE ONLY public."Directorio" DROP CONSTRAINT "Analisis";
       public          postgres    false    250    209    3293            #           2606    50610    Usuario Empresa    FK CONSTRAINT     �   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Empresa" FOREIGN KEY ("Fk_Empresa") REFERENCES public."Empresa"("Id") NOT VALID;
 =   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Empresa";
       public          postgres    false    3295    221    211            "           2606    50615    Sesion Fk_Usuario    FK CONSTRAINT     �   ALTER TABLE ONLY public."Sesion"
    ADD CONSTRAINT "Fk_Usuario" FOREIGN KEY ("Fk_Usuario") REFERENCES public."Usuario"("Id") NOT VALID;
 ?   ALTER TABLE ONLY public."Sesion" DROP CONSTRAINT "Fk_Usuario";
       public          postgres    false    221    3305    214            $           2606    50620    Usuario Persona    FK CONSTRAINT     �   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Persona" FOREIGN KEY ("Fk_Persona") REFERENCES public."Persona"("Id") NOT VALID;
 =   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Persona";
       public          postgres    false    213    3297    221            %           2606    50625    Usuario Rol    FK CONSTRAINT     {   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Rol" FOREIGN KEY ("Fk_Rol") REFERENCES public."Rol"("Id") NOT VALID;
 9   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Rol";
       public          postgres    false    3301    217    221            !           2606    50630    Analisis Sesion    FK CONSTRAINT     {   ALTER TABLE ONLY public."Analisis"
    ADD CONSTRAINT "Sesion" FOREIGN KEY ("Fk_Sesion") REFERENCES public."Sesion"("Id");
 =   ALTER TABLE ONLY public."Analisis" DROP CONSTRAINT "Sesion";
       public          postgres    false    209    214    3299            0           2606    50733    Proceso Tipo    FK CONSTRAINT     t   ALTER TABLE ONLY public."Proceso"
    ADD CONSTRAINT "Tipo" FOREIGN KEY ("Fk_Tipo") REFERENCES public."Tipo"("Id");
 :   ALTER TABLE ONLY public."Proceso" DROP CONSTRAINT "Tipo";
       public          postgres    false    3303    246    219            2           2606    50751    Registro Tipo    FK CONSTRAINT     u   ALTER TABLE ONLY public."Registro"
    ADD CONSTRAINT "Tipo" FOREIGN KEY ("Fk_Tipo") REFERENCES public."Tipo"("Id");
 ;   ALTER TABLE ONLY public."Registro" DROP CONSTRAINT "Tipo";
       public          postgres    false    219    3303    248            4           2606    50769    Directorio Tipo    FK CONSTRAINT     w   ALTER TABLE ONLY public."Directorio"
    ADD CONSTRAINT "Tipo" FOREIGN KEY ("Fk_Tipo") REFERENCES public."Tipo"("Id");
 =   ALTER TABLE ONLY public."Directorio" DROP CONSTRAINT "Tipo";
       public          postgres    false    3303    219    250            &           2606    50650 O   auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
       public          postgres    false    227    3321    225            '           2606    50655 P   auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
       public          postgres    false    223    3310    225            (           2606    50660 E   auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 o   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
       public          postgres    false    3346    237    227            )           2606    50665 D   auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 n   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id;
       public          postgres    false    230    223    3310            *           2606    50670 B   auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
       public          postgres    false    230    3323    229            +           2606    50675 S   auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
       public          postgres    false    3321    227    233            ,           2606    50680 V   auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
       public          postgres    false    3323    233    229            -           2606    50685 G   django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 q   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
       public          postgres    false    235    237    3346            .           2606    50690 B   django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id;
       public          postgres    false    235    229    3323            �   ]   x�}̱�@�خ�x�Ά�"$		��@��� �q�����B����jF+�Z*�O����Q�����Ͻ%��{� �wQ��O      �   �  x���]o�H���_��^�� ��]B�T�$M+Y�\p�+c#۴ɿ��k8�q��WM�}�`f`�����b�o��x��i�6���_X��ku�8��eSVYY�W!�W�ϴ�i��?��$_�e�:������\�u;ݦ��z�p]%��$�SaV_�F�?�2��fp�l��Kk�9�n�)+V�/aXY�8����j�߇g���rMsx���3J5����,(w�|���f�!��^�]�}���7MYt�ô���|�f��uV���U�/�����.Y6ü\��Ӫ�ሇ�vǚd����ߍv��W�`V÷��a_��_�(��x��JJ9���iS��0�+7�G�J(�ԸZ��d�V��
��v����|���UY!0��ܧe��=.�o�MZ�k�d�)Oh�@Y������VW]���qV���8��E��y>���#ޙWn����zY��G_��g�O�ٔ�и�q\5��.�^o��ݼ%R���	Ռ>VS���-}[㸭��_�i =Uh�Gg��GWM�J�$��^�<�O+=�ǡ���ϟgϖe9������#Sh��8~�.��+��a�C�ꧼl�}�.�-'-�H�|�����'�0�,����U���2�Yf6&�a��.�ڷ�i��d�\�u���5���b�URӜۂ�����2]�=����}��G����o��r�˖}w�mЈC'e�d�)�8�.-�MV��Ckf��s�ф#vs��r������tO���A����K�XCvZS��2�H!�vd`ı,���ز�a�QÚ���U �5���f7'C�	�� c00�hfi0���Y���&������``�ݳ�������H��Z20�9M�8Rc���(�U0�.w�6��y��Li����aZ$��
����e0����<����+�z��XG���k�6./g`�1o	g`�q?V��jX�a4�2���8Z30�!��4�P��P��x8c`]�������C���sN60p�*X�9�jz�ʌ��P��o`(`G00P��֡>k7G��l`A�J��J�h`��O�������&d7��?00 J�?aD&C,}3N��j�����T60��*RȬ�10$�l`Tð�?��b�b�vz��P����!ׄFp�1j4�4h�-�j`��k��6ܮi:<k``�NM�ښ��Х�rTKB9���;j,����F�4����)�R100L��P��O�9�9Q#���p��Xý�f`��k���>�v40��qy9C�yK8C���z�A�3���f]�1��Z���f``��5����Wk�����_3j�����yH00p܅�l`��?00T�^s200����6�f00��r�
X�k8��e��h`@X��,�\ɵY�3���qVv{zÄ�����:�a�v �����o��ei      �   +   x�3�qw��2�uvt�2���KI-H�K�L�+I����� �I�      �   �   x�=�1
�0�Y:E/�")���@�Вt1��,68�!���BA���R���`�}�8��H�(���g/���S�ap9˻l_I�����5x�
K͗�ːJ��n� !"Glg��&"H��
��9�{�y{^��&      �      x��Ys��%��
F=�� ֙w8:4ڊ.���*�������h��������L��2��7n� d�<��^ۻ<x���/_����;��҃��O�,������E}�f>׋�`p�z�����Z��^����l�<zw~5�}Zi����8=}������;�ߧ����������|29_|P��o���|y>���P|�/Ig3H�Y;������ō���ձ1���;����cey����|27�JŁ�*�M�=]��&�k[L�I�h��a�|j��i�1�0�&�$��M��n��9:����u�d�9Ix���asNB6����d�6>��S���$�!����>;_,�_8GFq�c��+��٠e�l��hc���2`��)IN.eM+O�87V��1pL/��lk��JN&S�h�|n���_��)ؐ6���z�b�$Ӝ�F���o7��)2_����bq\�9EZ���\!E����kY��QT�S�v��������D΄��t22K&q`���L�l5�Yq:�n0jsJ�|F�Y&Ѹ��z�د��x1ߜ�r]�[YЀ��n&r��L�Y�<0Yq�CXyh�!sd�w�bP��#�-`N00� �*o��Ta��5n�$�PN��E��Aǭ3e���V��L�����Mѧ�+�w���$����&&cʓ<�<��:�i1Jd���qV& RR�u�r��Hd��kd<d�kvJ�Q����\ڐ�2�wI�훝|Z�1�?n�,+*CNZ�$�,�-����3N��Q9Y��;�Q��F(G���F�JN�5'!ϭ��y[$��P"i{���!�Lɜy|��e��WeK=�3nLY��n�e��=X2P9
�`��&gQ���#{�,Y*G���hm�{�#��%�i�y2�q^��&���f��Zc��U�*�*�15���F&*8K���'����pz������t�=�W��>�+���܊0�	���S998F~��C�������VQċ���DVĸ��Lm�i�7��B�2f1��fK�Eg����BXHӚv��ٺXTͱ�y��_�$��)=���hEt<�"��O��dd%Ţ�9����s�:A4�R�&ǈ�,�ԹlR&���V,��^Nη�y2�V���*���*�Y.� eɠYC�y���L��~�$.>���TG�G�Ƴ˟����������X���+&vW�)�\$Yǫ"RQ�&�:�"dbG���!8 L�Ċ��*&��y�h���k"�6�� zQ���"b�Xl>�-��5ɭ"T����A.'7��L+߇M9�<>fy��ӓ����ً?��?�闗���/�m�k8��x�r��4�~8��X[�NCU��h�r��c}�|3�/_W����W�^<�]^�\��+�^[�ɴ�7l8�0%?���������P��(2�kQ\G�2ԇ��L���q�#��n4+��ЊZ�D���j<���j\_<�>)�R����T9]�p��zX�Ae=���M���gW'�jY?}_]��_�=�~Ӡ�Q�^n�GC�x�'6�$�0���h*�����^�_�/'�(�H*���M&2�G���ik�3Y����?�g7��#������67�}6W�	F�!Dդ:��0%�D996�,
J�5?�HU���I���{n���A�+�0�EU9qU��d˫�ܻ\�*>E��!�8��~�+�O�-'s-*��=Gu:�ZN�ײ�+/��o+�-�Gv�8�^�B���Dh�
jxsFb�j�����?W�R����XV��=�+Z�=��8Ŕp[>�h�֦�v��nϵ�qR��nm�t:��s�S�ug�h�i�"+8�0i��"�<�G��|_����Eq���4O�HmF_|?��''�ho9I�F���}ݚ�rt�|[كP�b���-;P(O��k���5�L��>�7@�C�����`��~k ��%h35zR�1�tNNm��~�5�~#�h�8���U�!�T�>��Hv�����,jD?�K��v��^$���w_�%�aʰ�^��-�M�W6��3⤄m�Uv�{s�����I>M�y�����-�j��8�XH���q:q�o&U"YMV� 5D�p�X3~2k�816�0�����㡞�)��f2�i�\�I����L�x,��h�Jf�N�z�j��C�&���i�2�ƕ��j$vQ�U����1R�TT�ďj�wͤw7��zZ�\,�of���m'�`��U@����b)�K����p֒H1EoS�HHq�y�8,9��~�|E�DC�&AZM$�,��K/~-�q���,T�[Y��T�]'�	īz)Y4��ɳ�'}zo�x��N�A��t��b�!��Ye+��Õ7��*-!{�1�D�/�0��24�a*��Ä���"uQG�佼}Ǐ�����gq��T��E?����I	�������f�/������+���,FB/f�F����91Yu�M�Y
�9GF;�D� v����O7�	��i�֨vʦ�}g9R��'0\�۾�}�\w�Js*��]�E`�X��>,��\[\01�B�ƂkNDd�K%���2	A)DJ82���s�U|j�߬��8g�6��jz�2��������/��Y�VTL'ӎ���A�z�-�0�NC���*!q����e�a��]/�%�fP2��z@�"К9:ێT<��vuZ����[SG��M!�s�X����zB�����;XO͜�5���F|3g�GV�JȵI
e���C�##0���F����Iie(���|S�!��yTi�v�@�Z<X�<Y��q��>�8�b��E�^�qoE���W�dٮ�a�E!@�uH�Sh��2��}U�f14S8����#c��޶{(�ˊ�[��ǃ�`�|�l\'�O��S�I[-.֋u��K�ښ����O<2���Hȗ��,c#t@����G�����
2mS;y���FG�"���ޏ����E�?���8�j �QA$ �'�V1x�#RL^��U���h��b����Q����YtQ�(�u�i�����0��ˮ�hTyqԵX�r���H�O&���̨��w�e&ݸ�pm�j�d����a��$�uU9m�p�m]�P�<��JCW�⭧Q7�w��8�]��Ob��0(g����P�z(rv4=��h�e.��v��v2t���^�?B4�!�wf`+c�����3� �Ii�"��"� K@��a/qeHb���=s"Cک]YJ;�1q�����W�^#��z��U98=i{����d�u��en �V^G 
K4R*Z�+ >`�9�߁A�4B'��e��.��hJ�]\�&y���1�Ļ�Qo�?���\�g����k~� ��_�A��w&���^J�4Q�ȩi���ޗ[P"�	��!(�n������##��\Aʈ��i���#�!�0�f��&����lm��dY���#�.G1��m�����[ݒ�)A$y?Ȫ�����*��(��� �؄Hđ��(x*1��2�thN�ɳ"9���2�eK�Jɥ�c#b�1�{8:�ܶ�ן�g�y7�
 ����Re��,RmĪd��΀]�PbшCF��ҪdT �ZC���ܒ�b|令39ڽ�J��`ɝg����������=�K�.:��-DI�z�����(����,N|�� #�#��	���TF-�e�ii���uᓋQ����H��e�w�R�\��瓎��@4&�m�:Q'i-0\���(�G�v���#6vQ#��2&���8��I�Ƌ\��D� �B ��-��(�����N�/�mG�F0e�h02{L��)�"1��,n��o��O��^9Dz���M����۱Ŝ�X�H\/��X��yN��lޝ`�r4�#IQ�h���P3��?VJ��1�	l���EqO�~�H#�_���eϼޮWH�(�v#]������l,P��W�׳����|1��ù�D��s9N(�]eu:]�� Z�j�H-������R-�Vb��=�������I$�<����<ZK�R��x��W{�t7N�{�߷���˫��    ��:{����f0
j��r��������e�Ԫ@�S��H[��&��Q��6�]�+�"�*�m\NywY�Ntշ���5e���K�S<�~�\�#��^ ���b�?�����4�,�$�� S�EuB���mD�W�м*�ōఉ�@D�n��֙�-�����f�������K�轠l�(p�e�E=�fжŋ�_�k},�aN�� p�2:h4�r" #Snc���Z�E�w<AYE��P6(�L�+r�C��������ai=t��>��S;�.�&a�r�.SOT��<��8���Z=L��Y���u�.b�&O�0�ӡ��<t~�Y�	n�&�Ѵα�q0�l�YM �=O㰲���k,^Q��V�8j�R��z�Щ����eMd�LmP{���c�"��[�����s���,�l4O$�A��0N(4O�����,S��uRF��N6�����S����?/�׏o�3���_��و��߄^�t�A�֠Q��P����{BU��a�ab�)���� `��m��1�i���s�.l�:b�#E��@Q��w����y]-��S1�[��S=Z�ϓzڍ�B�B�Vz�=�eVe#Y�����83�
�qt�L9(Nm�+�PFMǇ�/��9'	E��HKɉM���b�>��ι�(L��ǋ�l|N�ٝ��N����k�%��9,~���K��p���rϾ����SU�Ha.MY$X��IV1oW?x�����c3�:5�'k���������۽@Hl�я�Xb�Q$��BĬBk<Ε�S��<ڇ��ߚ20dU��������ǁ���转`���;X˛�����0��}%sM�w���t��YZ�]p�05���DQ�sL�YT�m�iTȖy���rWac�?0���&���ד��NB��a�S��x �­��oXDжuV��j�B,���������]|tL�Ld`��iaD�Ջ��#*+^;�8���1[q�0��|��P	���w
SJ6h� ���b���v]��d6"@-��f�*��ܤ[N���U�UO��fr�&�NbVy�%L��|%2u�1JW�����vg���eR��E�$��<�/�ncb�*��r
����*�a~���A1������o@�4W2�0LW���\
��jTx���ZXG��}���D���|1?tv_��5��D":ǒX���`Ȱ+)ό_ ����dW%��pTQ�����A��+Q�!/޶�{|a���g����d9�˓�8����g�s������Lv�����W���~Mu��O�ڎ�Dˇ��r�Q&wy^/�?\���~ۡp�9���UA��Ifֽ�(�O. <66²���p(�`�:�WZ�/"o�h�ď#v�nz��]]__�&�E���YO���sG��-���B��5�n��]�N����T�L|ȰZ9��@�-��	�F������h"*, �bC\iv�=8ɶ��bP��H��������I�X-�����0uz5���� �hM��I�����W�a�\D~Ă���ʉ��y���*?p"� �����,�����I�r.j �B+xS20�[�Z��j"�m��B�����et�,^U�W��Y5zQ�9-ձ'���`��_mdd�>mq@ ���x���9�X��>J�?�̀r0�B,��x���DL����@�2�"!�fe�o�ח��k,��:p��tMg�9M3���$'��""�*H�qLHmX:Қ �`41Z�5�2I$��=Q@���4�������lSж�M�M#�!�W�َ��{�+҅eH�9s��E%�s-ۆ�q��9��gw��3����{�tvy=�y�oM,�� .R���V[9�v~�S˷�>���iTQp�30�l��*C���4WTF bh�O���ލ$Sf+���������'l@�Dc̺��c�j V��<�gV-�X$`���-�Wj �8rd�r8�h�rAbo秃#���V�.��N���fr>{~5���_-�ܜ_L�7p�LN@�HW����e1+�v�L���R��9G���W�`@�gC#H���oE@��g =�����@-� {#3����M�LL��]-�V�����| )֠�h0�"��b���A��1�3t�E�^�
X�[ L��Uep�z�)Z`8�!�
>*j�p�7�И���(��{����G�W�'���A�(>���un̓VV!^� ��:h�c�c8 �E(+Y�[8�D3;$H�{'�[���A��Ӳ]��(�r��l�FzFɏ����x+W�w7����١�-o���}A�_Q}u�� �\��Hü��n�n��M[j<�F��7�PTU&\���k��;�9�;`u'�����x��ti{��SLye����VlL�2;�E[*8�-�m c@\�۪Ѧ9�Q���ߍ ��Bu���w�i/��R<#�: ~��F��nBL�E٢肩EyhEv"�α�5 TZp�����ȹ���G�p�KJ�BQ��__R����=������G"	2�ք�%[��,i2�ҁΩ$�9>�
�i�C0Llq��ck�@UEY���?�鐺{��
J����\�ɂQ��i]�D��ВEI>�£���(	�ŭ(��Q��7ڑ�����`���h�T����lR$���͠�s̛c�,���������=�3�s򾾸��g��c:0��Ee{�͠D�(]��D�"�����炫��s��mʱA���M�xú�3�Ӷ�A|v��Jt������,��,3��y��Ӌ��J~Y49��	��xQ��2 �Æ<�/�R� W�[�9����I��P�!��A,B�Z�$Yw"�
�hUk�`��?A�s�Y�N��os���.��_��tw �-i�3�Y��� �;��,!��c�^��A�}�@Yf��1�fp 	�&FMŊ�he Eqwv�)�n)�2� "xW'�	���P��nհ��8��l�f�]i�V�)]WN��~�,��k�th�d�ʈ�4�w�*I�Ą��X;6lJ���^��ra�F%�ho��:y����v���Jk�f*��R!p&%�A4h@T��`��Cf�$Β*D��J���_\e��&�� �i+7�Kn����ڋ���b����|����B�����i�LL�-�c!�kE�6T�q=L���^��m]��!�iK?3�ـà�
V���b�1��eA���]3dQ^7������
��������}��:���J�j/tvV�MKfˁ! ��f���h1<�o����Ab����ψ��r����pD�lJ�$JCv�Zԍ��&���C2��������P���dq�C���z�M���`;gJ'��	Ȣ�2���a$P��y����$�%Ym`p��&�FI�������Ð5|�i}l�H2{�����!����-�ysɞb0��bO��s����Asv(��O��̜<Ҍp�H��Q+&:�S��X6��I��\T�� 8�Tb��Tzx�-�8h)ԉ�g�C2��MS��8�W����P�
��_���@� �$Yn�B��SR��P����BG)��� ��U��ԴZ�� [�y߳/͞/���'?��ʴ.�^<��_�>�ĪC��񳡫b5|��<j�͓������S#�����!��� ᔀ�d?yR`�e�1B)�Vl$�LwK6/��I$VOAJxX�*���?Dj��O^?BԊ"ú"}j��5��3�����捎-��M'i�������8e���^x�a�#�#�l��=$Ҫ���G����sR���д'pأ�*�ٲ.'-jx�|���^��<�)>�qPaqzV/>,g�p��6�)A�E,���L��x�[ű"�1��w�a�2 ���h�޴�h���	��G�S0�#>�r]_���룧���z,��B������q�ӯ�L',����n�sd��g����$���[`�29��*+ю�5B��on�P��,��mgM�lp    p���̈́�9�X��*��[n~{|}}!�j6�ߛ������k�ͫ��Rs�-����q�h3#���uo(3�e��m"�"��
̑����k+��d䅟c�&ǡ��� @oXҲ�����[�+f��Ǜ�X��I�3��)Xd�zAK�m
�M���U 2#�c^�x�FE�#�G�D�wH�q��Dx�΄�2t�/ܷ��c�Z4�(k��b+�HƠ"!��#�y�;�-	�Zk����K��C�f륯��O0�n��v�|F����^[��-U�� �O��_N2�Q.�h!��WKL�]-�i�Nj�>
���zK�x�Ȁ�������
�@p�;뇟1E$�mB�[����(ﱄS�↠y^����I)#IX ��$�Il�\nQh�=.@ټ�`^yGJ?�]�}v3?=�|����zq=����x�7]�1'D����;��h7����%9�h=�VX4:2lO��%eBd�2�P�ΚG�DC��b����h(� ���X�,ػ���a\6�mZ�o���]ƃ�#C"�A�ں�&��bʭp5�b� �QD�eP�i6d�V��G�3�Pǉʚ)#Zw�@��A�LV��c"���$=�E����Z[�����=Pa��2̀,�*Ţ�dr�ݳ-q�m��@�99׉?�7q�H�����w��(��̲F��D�m��^��_��N��&�#����(o�8���R�������+�euv>�ey~q��@��e1v_�uø<�7{��������1$߷���u"S��#)+�j��Y���O<	�	�[�,5Ge
[0л�
�H��`W����.)��B�R{\
[�?�����w:�
���zr���Nl��iY狻�����-ioQV0�8&F#��D,^W@ҍ���N��X"�w#��>�����i-��=�|<_��-��n��syyk�pU�?v#�arz��T�3�}L Bu�����
����%~CrĨ��D�X,*�t��#/�� sr"ĢXD�1����"cQ������7�K���1� @�'�g������J�&�:;5�R���z*�=\�����7/-��K��0doD(!�i��}�D�1'cH
"l�h͊�U�p�B"�ѥ��u���� ��l���Z�Ԕ�=JKmr���$��..�(H r�ŰmQ�7>0�
ȩ����}����L�z�g%pG���[:��DR7�����ZN&x(5��Ʈ8Dx1P�%r��ޙ���d?�h�u��(���mHh��P>>�yF�a��Ar[�H(�F���	��v0�p��x|�A���)�8���o�d�D���v ?��k ?b2��<����r�"$��v˞�Lq�0Pb.Ŀ��A� �\IM4Y���vnǁ��7�N4�C~C6A�t
�����i܉zNf#y��?�:=�������0��+�q,���r��%	�ê���IDfD�;���8�ɔ):�@u�r�k��v	W)}�j���ߧ+K���:@ֈ�0L��Ӭ02��BO�jS��	p�b�� j�F�AH<�D�:gԌ/��Ca�ȧ0����ь�:8)5�w(�C����r��t���;�D"kF�9�^l6̶�u�9g�7laʗ�F��%\��~���GJ��H�A����ꪾxRW�͟�Ah�����{h��z�wމ�V���^�,���١F|��/%f��٩��\8q�b5D���&"�!fK)�PK��aYU](�7��
1%���j�Y3�t_��;���PS�������/�-+Y���5���U�_�8m����(�5~ �\�a�vH0yY�6�)�J��u�F��� a,bL�"%�ҎbL��X�U�W�٩���f��[FBv\�7�Y�����$Zޝ��ίNO��~//���7W�6��������?.���j���������ZV��O�cZ���+����v=ES�GV6|��x\�i����
��҈_�
�r����Lh�4j�v�1����]���Xӿzw��o��Fq/1E ����hWh�m[�146��1�q.��DVb��>�I͉H���Ƌul����c��MF�B��)���k��w�H~^~x��#��C�q��;?]�:�*�^��	�[�=����P8m��'�g9Gn*��	+�B�I�
s[L�"�Ih��bH~k�yvq�J�����EGm�#S������{<p(�i�
�.E���pA��.J��7�D�Y���VC��wf������
S���?�~�����a�r���\�3��"�c?t�8��{!�UK�8����D��S��=�$�&�Lp(�o�FZ��¢���`g�E��"����y~~uyv�A%��"=�1�~� �,p�%�0w��d��� ���r�m@�UL"�/"��L���f���Ɩ�,���-e5l\n� �c��Y�{fGʺ�}��-�Ū"�8i��l�]Wd������$#�n}rX|8߶D���氫�풞C�:2=��{���GT�6ǎɴ�x�H���$	~Y}Vr��7@r�e?���e�����~����FC������/w�u��w���m��{J�oE�Rq
<HwڌzfS$�#F5�s��J���d�R��EmCd���jY*R�ئr7w��#칻�B�y�tv���..��FȾ�|�j6��WǛo�ݯ����ݘKH�*GD���iML���ù f�	�8�L��.�����o���xʫN3��� "ұ"��(�ω���Ԋa�G�>�ۥA�1\�S��2���2/�����y}59�$����nGO�E=�.�OO/g(��n\/��ӧ��>n,�u�A~��>����l� �����Yh�z1;^W���w;�;
��{��J�W6���QIZ Ҩ���l�.��Q�qa��,ɰ��D0I�
�8U�� ��&i�'�B�u  P���Y�kl6�`�!�a��<�f�{�:�����u=�uq{��w=�e�J�\��rY�L��D��6쬥o*�7�� 6��~M��Ĥ�4@�` z��Ђ�zx��?��7���#�A����\.��ա�x����_��A���a����;g@FaR̢1�Hp��6ʌn��Y	-��(����x h�ix�5�e�!��:8��qh��}i���[Ε��pMB�H�˚E���倹b��#���y�4|�����2�;pP�mH���O�1��;YwٛQy�xK�x���X����IX���[/��N�5�
5`D	�vb�*8��n2##ެU9Ř�	���>�tچ&�W�
.�H@��r� ��;R�Ub��������o����^γ����ռ�����og?�\�̜NeN��s����p��.���v]�*Eƚ F�Ʋ�$u�޼��`tG�0D˰$��ٟ��3� BY��-!e��/ c�v�1���id\�����]��1X�1��:�+N��ow.��7?������Ȅ�,�d�M({�����d����p�YH�mYU��cW$Pp��+2m��=�˔V X��S;�,�r�Y4	�h�'a�'1(�%����纺��y�	.���_�H����]�+�y	1���n!�%׆��A����(�ݟN�&�!�g_B�Ҭ�f�.D���"�˃�@�c݊ e�s�Q%���h
�cEb�#T����9.~;����3^�_���4^Ҥ�V7��p*�r��Up:n��������J���&�3@.y`�!z*,��Y�I��7]��H��%N<'�E8.6�#�AD�S�l<���D���e['&<�Ts;�[xw�d~07��2�~:��J�:�P�^�/-�9�s�,FJdk�����BM��̆ ���	�a�B�z	�&;kn�FHd1˖�D�mD'�k�R!����O���E�l�>��i�a�QF�xԬ�:��FW/�{j����♓���W��{(Y��8G��{D/�1�]�nyyq.Sx�}|{���k�y,5��^a4�;!#��7��9Iiᶂz�TC�*�8��g
Y�H,�S    F���^��ʑ0�*���,��)�2����G�&�;��4,���Z���Űp)���p_��a����!9��b���h��~ �ܩU�5��S��������0�92�3��o�@�kբ���]����9B7�\��	ߋĐL��䧿�y=�j�����|]�[�}~^�
����2O�W6Ƒ�J��'�I��:֖��`8gst���3vi�w��z��\^����8@��6�*���{tz�~o0���Z���	��2�g��-�q�,��U�y	7?��󄭉��z�Z�͢'4l�߆��v(��:���JA���y&�JZ��]n����"=Y$���8�v��Q~��Ƚ��v���@�<çA�C��e:^b�A�(�Ee��L�;Fp#��RZ(�.5��j�P	�]��.9L�$�P���²�c�RGgE���\g���ٌ�"VH��Qz����%��������bk�gW+]�>�iȍ�o��7���/��u/dZG�Ȁ�@rtu��cHN��S��{��@zqX���i�F�'3�1u�u�ʊ������`�	*�'Nq�٠M������t�J�=��v��*���Ê���R3:-��@$@�@I�>*����TAh�p?���1|���l��tC�Z|��)�۬��/��U�a�ٍ{R�7>*����[�L;����a�2����z��2�J�.,*�����+�N��VS�6Kk	�aьo劙��ڬů��|O���ϣ�������ɇ�?�4�����m?�����\�>q]���(��'٤����u��\��
�M�*����G2A�q��6��"�o=6G�( ��$�@G�8��n�q/h�۞)�H�;O�Y�-@<}'8!���ة< ����jw�����҄�EN�eD%V-�ko��ɄmH��gw�{��������=��O�S���~ޓ��ٹ�3�k+�[&O��F��[��H1��AU k�bu�3G��NRehGq(�J�
��n=�h���@]�������u��N�o�\'uV���.��%Y���@nz��̕2����n�V��Z�Փ�.�[�,�~��D��q��-�ڭ*Po2� H� � MLU�2�uh
d�\"�6C�eK4��K^%K(���j�}��x �����qm���ݏb���e'�/:� �����T�����ubӘ�/�6��^�@�@�ftY7oTL�ؔ[YC{�4�20j_�zJMN\�87M���V��2oG����L�5m���<>�)9�6�C�8����L33���r IE②�H�G<=�0=���I熏�<ȉ�/2�#���8�u3 �*��p�@�`�Uۮ:���3ER'���:aߞx[C��4;+a��⍷_��eE�J�d��'�&:4���|��f{ �s\P�X'&i����æb6Ġ���G��X��N��. �&�(�T�2f�mY�\*.��ƬnȉEd!�J�Ǎ��bc|����?��~n�I��4a�ƕ��YY�CJ-��;���oY8�27��aC��>�?G���<~J�����5BZ�+@�w��9x�P��^��E{���B	Y��h�,	Ks�U$4��uY�3������x$M(C� M��"j�)D%�݆;�ŦY����}y�i1n�Q�t�T#�Rִ�=��79̔#�)mM�/�Pwf ץ��3&Eʰ��|<t+Ԙ^���ϥ6���I4hN�FK�q�WL��i1��s㪓jN�?O����2W	�ib Z�D��W��U*_��j|�����a��!�v)���:e�0,Bb#im����H.E���jyЉح2�t��,�F���)J���uq���/G�<����56�v��EQRTzq_��G"�.-��cwipG�&*4�����"'+C
�ʛх8*��m/
 _Z�x@����l'����}�_�\}�<��\�轻<3�x���3�u�qyP�=E(r����p�^��/  �������u���(�KC����j��S��(�c`ǖ�2[K���_:�bx�#5�͖p�]��gߏ�\�mO����Z�]DW>mb\d��Z�qE�
�(������)[ps��G&�C�NE9�x��Qط�wqr��؞<\P�quL?-KYj���V�	���ď�S���������Xߒ;syv��������t�h�G��'��<HgV����6�4�#��s�iO<8���%�0E?�&"��Z���|Y������4]�Eì�����-Q�񢺹���BF��ޖ(4K�S�H�d�4���J	���TЍ�Rơ?�,ng��%Z i՜��� ��&l��ݳt ~��.(�z\!b ��D�2Y��/6��	��u,χMIg|.��q5�+���һ�YOB��V�#��G3�qM����͛1�t ��0�wW���Q�H��®Ƒ�Dzb����`2 o$�)K��RYG��x/��]`��q�By�|F��R�K�&S��m� ��R�LΪ�{v��O�_�=dAO|�]��ː�֣�K��6�뺳�c�i�N����8*9�
�ɉ�2�m_tf?�A!��3ǈ�E����/X_��l���k�
r6�R�K�=zV���*�uya��韾_t��5�j�f�k)���G�L�%m�%Cwa6_e\0a���6���dq�匑�a�Ȍ
H��0��l2j o�ؕ����،����*���!��,J1�3�<��{���
�ѩ���5���L��b>��L�ѡń� �sP����A�6d�M.m���P�WѺ��XD���\I�.
(�"�2Q�lWO�J�< �H�3���*��@�W�WO^����;�27��+��b�
��^�O^{�f�Q�Ɋ�Ϯt>T���YuC̥ohK�_ �*���XdcA�#PU�a��N�O�!� �'����Y:Jۋ��#��8�сUa����"sg���뷏g'���v^��XYG�=���#:jv�X;b�-�H<YX�{��0:I�/R�P�2.K̀�m0�m(�+�����QD�٭���
]6B�y/��'K�Ԛzj��Q��Q'l�ߣ��8�QduCdh�%�+�td#Q���Ӷ�ʑ�7}�����/ONJ�B�<2��ŁҰͷ=4C�}.E@��Q��!|��c
FmbҊE^�Ђ�Ҳʸ�5<�]�86 ,���J�����ޖ*��bc�,�T�mQ��I���%O膦����"��	�w��j����M�S�AU��8Ɂ�`�D�p������@����Cg�#�ӧ'/�g��p����nnP�Lp[ ?��胴JT0��m]�/tv�`�̆�0�*�[n�2Z%D(�0*0�d�9Z4gƇ1TG�e/-��Z/�8�690��j3�.$m�(�L�6��x$��H�׫{��*_�Eo��/���0���bDaB?e'Y��#���m���B��zD�;G<��)戡�g,���O[ln��o���u�f 6ȇI�ɚ�U�U��a�F�9�(�_��*@vx65�X��O~|{��^^-�hZP�!�������g��j9��/���z�����X��h�_G����X_�q6�ʯ`»/�������ޓ��7��9���-�1c��j,���7��b�0���ƍ'ڒt %�4f|Єs��ej��[$��d��@�{��(����i�`e��:�L)(�%k#2����o�"�-���y�a���#�]
�8���ھ��hSz��)^(�W�c*lô��rA���Ś�ʱ��*����Wd��}�/��V�-~�曾�6�b����1i?=D!�6
��0 �E�!u���^�ؔ��n`�hv�a�s�Y� Юk��i�i�^x,ji�[A�,��C���_6�aA����	D`����pPS�u퇉�E� ��΢ͮG\9#�me��`��Q��]��:P@X�AU��cL@�¬Gݥ�2�	`K����.n7�O³)�%L�H4"�l�0�a�ޣ�@{�_^�彚˛�o�չ�W	�ųkvh���Ӻ�2
��a43��    #*t�)+P�!߾����H��� �뇍���#���'�C[UԷ4�^���iީ#]�"��Ύ��	�����o���ٛN@u�ng��~�D�;"���F���J}?��B��%C���eL�%�X���� ���yh��z�B;̘�m �6%��MKr�o����ey|���j�Y��Ǉ���[���,&�ٮ�c"3F����J��h�	1��(���#�>���&Faa��b�-lշ
���j�7�t�2����jQ�)޽�Fu���ɳ&.��'�Y�3l|��h�?-y�Ʋ8_L6��GzFɏ����x+W?x_�� ��Q����s$���V�*4��� �Z&Ε�6�cщ�����X�2<�ׂO`@�Ӕ�Y�B�9�-̊im؆�ˎ��H�����	&������b�vtR�-��D�H\�DfB���rO�RT#�C��M�G�������)��k�n7|�j���a��B�}�+����\+�OY4�O�4(��-@�0&$.���O��X>$Z���t��d`bx�BU3F`&0� t͠�uٿ�h�ժn�B���֕pH#��k��ӱ�D�?LA?Y�|}�����ͮ^����l��)�u�
��\�c�z}�cY�;�5�m��X��'K�+�V���sF�A�U�-���ψ<�g ��fWK��Q?��Z�H��ߺ�ul�h����L�C�V�%;�؜�wΞ}�3����� ��!a(����f��REfװ�cӕ�(�ޚr#���oQ�Δ�ru.�y�A,�f��0������B�B9��d����SK�XK�M,S0�p�
�Y�Bo¸
�}�x
Ń��6�ѭ���*��h�Q��Y��J�Z}���}����-���j9����:A�82��|�k3�Z�Tp�V땀����؉��-9	���d�%)�B�u1�S-l�ސRj�� ��}��yw}թ��ԭpZ]O=Rz#�4��B�4I��,�ܙA�>��U*�P���A��}TiG�泰ˀ�H&��46t�r�v�Y���='��Ҋ%&S�����G�; �};�P_=���8~E���)FO\H�)�$*�p�kzE�X%�k0����db�§= �Mb2�L0��*���; �-#KY�vc�z��^V��&���e�y,:���l��{�<g�b��秏�aG���w^�5�~SY��h~�^
�� ��)i_�DD����K^@E����՝Mi�ѣ�HM��Yt�͂�� =_ �&����Xn.�4!�RZ�q �A��TX�.&;�\����g���?ϖ���!7��[~��a�gA�~��d�!�#�|����`�d^��IYc����fp�R��(�����@(�Hj9 Qdl�ޮ��ѳ#2%�AnOT߷��oU��G*���.kc��eB9�2��'Y1�	6�A�@<|Xq�����������2�"|Rb��%�Y>�0�����S����X�p�⢮�mz�u�-��7o������'?���Ϗ_��趏t<������_�|?�Ѩ3�$\2���A4�G?�����K��c��GW_ֆ�WR�+�5�c���-�D%vg��O��������i� (%�&������+X�SA����u�;ˍ�ܽ�=��|��()N��D�H�PÙT���\�o��ņ�s3u�&
�F��6���9ni��څ���Z�̫��7������J��2�S@�*}�W ;��U�� �_]j�T1�PP34���#x��`���FI�������g�f����������������|��u��޴n}��&����b�!���"�� F�;�d(x d�{*���7�Ч�!�Q����CEs�*�$B��hL��^':��$�d�q�h�E�k�E���hp���ŵr�@��^����U:L~�v^}�M��E|���p�v �а�z�1��k�������Il)eP*T�ղ�lcDcL��I�/(D�h�H~E� u�ޗ��r��v�jIch�HI4�k� �i��%dz�G3y�u`��k<�tT����l/U\2��T�XTg��`��%�Ԑ�T��-�~ ?,ǆFB13��x���pne�4���Hg@cǝ��8�!���V@�N����M�u���	4��t�BScK��w�-�t�U��������$[�6ep���7[m�D̟Y-Bv��y-c {xQ�o��}��'u5�y5�	kL�[}������E���0�T����$�)�| �B �-��T�6�6e�2��|(�O�l�ER���P�&�RE��A���07�g0%������(�P8a嵈N7Ƣ!NZէ"�j�%�S�r66�N6�u��<}r�����������ӗv5V��a!�{]]�x*ꥺ�~yy,W��by���F:��/�c�ס���?c���O�?�W���]��9ކ���T����w��-�")KH$�JR-���l�s.]#���%��J* � {�"R�,6�' �h������F5x#�@i��i��/f����,HMr��pdb;N�3����� c򪾺��Z�kL��b~��N��p}�4�W��E�A�]��O�s���?G��!v̡=t�=~�'*�Z��4/�(�I+X��{��!
�̡����jd�\}�აn��|�O�� ^���Y"S_V�:��0�B6���>i�V�Rs0�r ���y�uI|%���{_�,0>0(}?d��S�&�˗�լL#� e�o��eр�YO@�]��0�5v4�i�&b
8d궏<ʈ�S�%ڍn��!<����V$�6󙀕^4�Iɮ�ζ���� '���X����"�(3�&gǨ��Qz ����ɦ#�:O+
�+^X���	z��Z�h�-y�d'�[�׉�kC�e�� �_;Ch�����z�Qa�pod	�Hݬ��ֳ[�j�	�kK@f��&G�׳\���o	ٛ�D'������B��!��I�'{_Tǳ���[θ^,�'�W���Q���#�{��O�z2����>}�¾�K�M..��&��$6
�=��#E6�s!K���d⧐
N+�����i^�f��a��Gd������w s��-��q 0Dd�[%S(���+��t����Wn�׮���Y��]�����c ��7X�e���"1�P��~�.Ͳ��v�y��+�&_t?(k�3�'&�,����!��%�3�F9O�UHC�B�*^�d�����_7�˗�L�Am�c��o����ŭ�V����9=}:���o�\M��}5�'���WNO7.�E̱��z~=%j�X1>��-�&��o8;J @���	�*](�"Ʌc��{��֝>��J�q�-��O��o���֟ea�o�r��Z���I��B�hTX�ݛ�<Q�����g7>��:d��]��AcS��zQ��&#$YK$~-����s-ͫ�Օ�?��슑!�GEu�Q&�ü0Lx�������� �r�{@g�S,m�+��~@�;��7�v(���M�x����o�tQ_�{�I\��v���0�0{�X�]H�c�O6&Bv�I��6K%#S���N� �2~�V�#��N�	�5F��$Y���������]g��܎ _L;��틳�S�s��F�K��	��b����5�m��WbĻ����h*�FS��",��u��SV�Jl� b8�1hmf��*jh�M\h�6�BcQ�u���D_��'\~x|3����a�pT�?��+s5�s6���c���|��я�I��d����7]b�%2JP���y`pS�#j4R	�� jP^h�8@��T-�U���f7�]dr��|[n �rH��W�@�%�z���jR��h��$�׺Z^������'�|�-J�gǂP��.B��2ع�4�e��	L�xКP�(mIqV�vF�|S��q��m��!W��0ȶ9���0��*!4(]@fa�Η�#M�bkږ1�X���G�\�	��x�����c���'u��ݫo���    [�Hx(ce���=1)�@�=�>h�����PՎ��(���#WJMړCߗ�ڲ�N����,���!rxp�/��F-�����ez��6?B���.���|\`��M��f7�z�ǃ��-���q13�L /K��lk0�����8lr��P���Jdg�����%�ghh<8��Z�'��)��IcO���)p�t6~;��k���+��i�$��\ ���j|Y������G�*����=�z͢���ĺxie�e�LQ�ˇd�`s`aky� m��˸|) -�ڢ�6�4�6�8�7���qS�}����d�51_��8\�����''ͫ����g��g�E���tZTf�(z��5�9&�ƒ������
A7�RBd�/�+gC�π��j?@D�# ��i$��9�k��A�̏xVì�#��(�Tx?��jqv(R����?]���zr/N,, �m�
�f'}�e�4h
{�u�?�;�sj�5��)�t
��0A��U����m
�e�\Z�t��Gp�E�<���h��/dgo�|o�%���o���#�׹~X��c/TY�����M�"B�̐�P��,ز�A�l*��>�=T)T� �l�r�$Ɲ&�J1��=t�q�ٹ�q�e1�&s��M�{��32H�:D^��F��+��W�1C>�i
'��MS�0[a� �h+�Pl����n�PD"=:�`�6�h������r#ZL��yλn��Q�V�T����o��#i@4-+�5�$Y�H�}v��&��0��%�U3-P�nkk��n�@j3���.��J��;�q��w�q�e� �G����N)0�"���gn��M����*R $�����!iH���q �Z|i�����";��a��1adM�����3�K��[�H��u�l�&j�Qk�F���V5M��sI�ǂ�������AD'�b����0+0�o�~Q����hP�����w�[ܫ7x�;�����:����[7)�"h��{Aߋ����V�6h{�"�+T�6(�` ���#k:j`V�g�/��K\ݠ���Q<Z���p��O���*o������֊�~s�=g0�	���K:"U!j���(�fٛ
�/ N%�9�a�28H�#K��X(���`+܍| 띤j웕�0�:<�r褞��鷬����B�1w�r�9	�H �����=��٤��L���67�Y�.9��%�I夷�4i����14-D�G��k��.^\�>� l��jȱ� �~(�Qj!�2 kS4�?DO���ǩ�^��R�J'���#�
i3X�Ո��$��By�]6C>=Bõ{���?=}>9��ܗ���E-,+��|t89����������b�{������%3˔�Fc�Џ[�*2���
W'�F����"��E̵@���]��D��+���&�;�#o��T ;ό��K�����b������"����w�Ǹ�� i�~ ��GQf��V=�t|�˄7���s������Á��Gx��ݥf���I��Z��p-x��Cj�`FU�\6���ԾHE��ʿe)~�b�0�:g���H9˔�a	��Ae��*Sr���X��i�¾�\�>���T�oun�z�Qm~�=K�r>~��L�tdR��Ʊ�C9^z82���� ���JM���_^�}����������ӿ|��՗����V�"�	��$8:eXG�MY��`(�
�d�0��d�I@�)�ft0�ы-��6�Fՠ�g�r����]���cr5�Kce�߷a=�N����Lf�������۟��������kݢtI	�faD�g�
Kf^��֢��Tm)�i�ڣ5�aU����Y�
r�Ĉ�Ǉ}��B/�[��sm��>�D��Y0����1[�h3�r�}�Xb�8���\���?�/.*�u^Og�OO��C1񭗾�R�Z*�P����Q��%��-��,���K��E.d�3���{8@D8q��];K� �:��7���GY�@�z0�Q��͐�`z�=���uZ�<H��}(�ƊDPٯW��Iۻ������RǱ؏M��?��G:F��`�N�5NO�F�%��8��\>����b���Jż��<Q^�,��6GZ�}�˫���l��]?�WG���{N��Y!s��Ѱ��~v>?��>�5��n@c��ѿ�񈑡��J�Х������z���������4�:>=�>��sV�?̆�y�x���|�����Qm8ғ4��٧��뛮�?��Щ�c��(���!�"e5�u���\OԨ&��2��#�y_(��0=����WD_D4�X������A�I��.M�b(AD�GD�_����`c�OF�;�: J"I�<�>=�VYĴ����.�V�nv���~�����5~��?ԓg�OW��q��F��0/ۿ����Ļ�ȍŦ�y��a��f��?�&ֲ��{��'��v�>�RIu��h-@��l}��Kx*�@�	�h��i��p�d��V��KD�r[d.JB�N���,ʧխs=������u��ctn �+X����B�1���/{\�/f�'eOmord�v7��m[���o�/^^�/[E�N�O��/�\������bv3�/'G� w���H|O��0��.��Pv�֦���Օ=�� ��hT��e5�����[6��t�8��0h) 	ؼR)�j, �
u�N�Z�h�b��	/K���Iw��o�2A`��P`�����y���F�LaH/�C7�v��@��p�&-?F�X4��@�����<��Sd�:EN���)��m�"�<��y�dE��'f8'���V�c�(�멩R:E�{�_I�j�!��9�K#!�� �<<`��j�U?��p���Z1���	��� AL�B9�0�4�|���r`Qi)�S3fѤ� c_�� Aӳ�=�f�}I�JK��{�"�hI��~�p�,굽�9�~��o�-,m���6U۽M��-����o2݅���K$�� C�4;4�zS&ٻd�l�=����M�$^���S&�I�3㨞�T,�R5U��D�Z�d� �$'UQ&�q�z�I`������$��Wd� Y��*�!ױ�h�8�rP�[+5Ec��
�����*�B��Yn�VF�ZN#�y�l��rYy^:�+�f�z���:?����NΏX*�x������ؼ{�G�yK�������#.��a=�ӡ'�.���IT�: ��>�����3��q/�,l�t�˥{��"G(j�c�����qlb@Cfp6��G����<@u8�����k���T�z@�R�ຖ�JH���.��쐴i6F/�Z��'x��Z�t2uX���A[�C%f	��7NU�S)�h�O�R��8Un�G��8��V��s�$��x4�������R�aJ)4�*��i?�
3R���b3`l+�i+B��9��9�FiM��N�C�3��7�A���^%�c*��o;<�o�J�׭�$`����3 1W��}���fv)����U���I=��ȳȉQV�_?���S����N�h�I&�o=����+�Av��/�1��$�����x��է��/q��� +��M~�Ga��T)�^ʥ=�bF��,'6V&��y\�4̬���� g}f�E	 r���!���åc��;@�T��㈲#K<�.p,���,��?��� ��u���|)�͕Q������ CR(%AڱA�� ������Hw
�^h]����AR�����)���( �t�D5��-1/�Q��*�����AR%��k�Jǲ6X�%Y�0���,Y��&��14§ ���@�'�;A���]3�:E
�-y sQbc���%���қ�������>��~wy�f����]��W��7(�Щ@�z�`�-������O�qy����A��x��xe���ĥ"�b6M��R[n F���'���+>=Bm����SDô�g���̈�{V-��S �����|rz*��P��1�LV>X    ���ZW�(eZ��i����	� ����*��8��('H�X�w(��n*�Tf�v�^���QʉC�w��D�g@� �*]xE�����C��mbѱ��G.� Nr��D[d�C$>��tVCh�s�ի�z��=���
�=Az��=1"�2(p����N�>��t!��I��E΁��і��T	J!�т�=Z;����4+�V!�0O�v�2�N�g����O���^�,�ǿ�c�"$<�~���ד���d��y]��m4��'1��T��{F���Y��8�G�L�z�X����ӧ�+��jzV�O�GƎ��Cv��;��T���z"L��i�VN� �MK��@�����9
oc�>�Z�#���� S<�i���̀-t�s�p;�g(ւ�A���Mt�X�w5���ψ	��~�l�L�4ۥ��̑���´�Yk�9�d��ͳ~�+`&B֙D�x�=�]Fs��бJ%ݷ��m�����g��V��ľj�<�e���D�u��BON[(g텟��������$��ȝ��=�]A0��SfI*��͖ӕ��"��v���vT�+��}���~y�b]-������g����Hǆ�\���X0Lc���PU�>��=�X_-���K
O�U^={�ɛ����-ʍd��͊���0��a����Y;�i�<��
q"��C}�]��Gȡ��� �QN$��t��!�ct��s<�������S�� O#GF�fb�p*=���M|5��t4|=�:YV������L����Fz\�P��Ík=�j�SY{;��|4��|ZC.�����0V�L�#k��s��4�2�&+=�u�#}4,[��b�w7�iSS^x3�]����H�w~��l���?�Y@�;�>�����71����W$k�aN��1��i&���K�&�ǄU�cP�
� 6���J0�X5����$DwX��}����.�����.wk����A�a��w\�a
G�t˛B���RD��1�$���H*�B`���:C�U@�Qlޓ*�}ed��{�F �i4����$�I>Ȫ
(@LW��ᶾ�#���ރx�1[b�A6��A�tBUg�����b~O" k6̲ڞ�Z�qp����N�ɀ��v�M�[4�ćQUUj���z��{��6�,[��?u?�>��7��U�m�]�\��BI�I�PCu��~�Z'3�L�Ee���� pp�=����Tn�0E1?_��84q6�$镉�3��dw��� >��R�a,}��2�xHi��,�#:T��b�[]s��܊�3G�$<��� �+�x(��~^�8��Av�~ɠ��E�UZ7XJ}��x���l�x\�irfQݒ�}���^�ޕpG����p�ͣ^���r������S��rq6�.̙C;K�q,��T�葢<[>)w���7�d��o���ໟ�m(ʎ���]��k������/@"q��/%�]�с���	�ἓ�ݚ1f��4Y��֜��y����d��e�����ޞOm�t�j�0Y�th'G���n���b$��R��{��3qC�5�����˳�,�)q�#���eM���Z�2$��W�m��Ab�l<��*^�-�<�`��9��S��ɰy�\6S�1�����e�Ǧ����W�zw��$�-���B���5��tE�K8���a�L7����zO@�Fq/QE�|S!�`�L���V&�ܨ8���5���+���!"?�v("�H�"	-.j�ߌ�)<	Y�]ĉ�uyH+O������vy��jy�:�+n~ܡ=�j�p�L��w�Z������M�Z��O_߮5~ܜ/���|�*	�ď��x�%�M&�i�5U�s�sx�<Y/r^�e�jq��nK8W��\�fU\���{��q��KrԋYa�V,�8�@(���a
�Q�IH���p��N��!�"��J�f�uH�)�~�_P`1F��`����r���CB#�av��1�P<h�aV�Bՠ�mUQ,Ie��Ȅ^Ny֤O�D�7�}�d��������ߔ�߇������ͯ��ۣٛק�����������W�����X��̰���X��zq�7�J��B�ݴ��ti��d�X�28,Pe@����w��T�6��},5�]�G6a&x#Q�B<��]��*��]w$��I�IB� \�X��e6�z6a�������A��#:�^/P��CT:�z==�����#z��Z�Gk����{��5�;����v;��&�����&h�!�kd��sQ4a#�C6�,�4��A2(@A+��a������Aq:ȹp�9ܤ����.\�$~�z����0X���
g�w�%W������/�ş����ɛ���/�-Y?pK�rI�e9fO�!Y� ��z5�Ip���(�����a�˸xA"8�X��1n�:,��1����e_i`HĆz	ȶ'�0��3 N�}�KL&���HZB2�Q�� �f�ɘXSe��M��j���cШ���T�t�Z���,� ���v�mw�����iEX9�*���A�r���H�8b��H?#��H��V���k�����"�4�:ejɵS�|(�ִ� ģ��D��I�!I�&�׮��	: �Z�]�������,����b��`0�ju�	�:]�T�UA�~tW����^����6�.�������&.�o柇P;o4�p�[:G!C��(���K�W4�6�H9U�x]�<�5$��$�Y�f=�",�U(w��a��UK���1	8;�va6�4��#a��DBÏ�G��.PI�;�v�.Y��(�;#���ʖ(�����x=Gh���� �w��?{�k��+t9���W��(h[�I7��myl
ͬ���)�W� g � �>Z�x_W�|p��k�������?mK���������|�΂��|�m���y�����'�
�s�X��+�3�!�8��t,���22dt�fJ�T���	�L�a[K�0�~���X2 �E����1H��>��3E1X^�G�/o������g�z(��]��' OO
�z*a|���4M�S	�ݓ�O�>��i��`��t�k��
��e����Ȣ��n�ueH�l��n�I�|�I�����}�,C�-t�G-�p0d���jv)&Z����j�v����� Zb��aނ��hJ�{���d�u`FJLR��LK�~c��(eA�7�:ዣ���e�ep��*�"r~�I�!�,��Ȍi�l���S�=#S��d��Ԉ��n��I.���[�#Y��9S15�M���R���]�T�����Ǚؠ�8�6Y����؊��5mϛ�Y�׹���IC��#å��3�:'�$F��
4mBh+�-�`�K���P�xuqR(f� ���2<�ɠ0�$p��e�m
�P5�?�h�K�3�]f���+~�W*��M��b��O����7x�O����K��:�/}#��6�{�N�7�7o߼��;����������^�Ca��K�8�R�*��I�sygH<ل��\��<�F������LvA�ۃ�^�c�83@� ��#��ѐQ'{|D�E�qZ���1�(�,`a%5?T��������(������Y_�LvW8��+!ȅA)H�˰l��#��[9��;O,�\�=.��M��KGgK~h�$�����_?D:���?�yYF���mPɆX�3KT|+USgC��9UE4:�2:2���̋ܰ��� ո�I��kR@��-�|�%v�����xd�����l1�fb��_N��4Ջ�E��h�8�rd�xGs�(qj#���E�x�e����-r�gC �m���Wy�3H8��M�˙�V&��Y+8�C"����;�Ӥ�,�\�*U�ld�,�lVU˳2{>��ٴR>O�"�t�%x��Z�r�J��!���߮����$דC;�8�}�α������c�x�x�� �-M�ٙ˨�a��[�$�S���+mAum�E��N����FN�A\J1����%�b�,��y�T0&:^��	zK�����DC�a���Y�\�2��O2�a㉩��!���y���.���Ȅ�Z-    ){5xS:���������t{D����GRT�j�|����l6ur�M�,US��/�r��8��S�m��z�U�� �'#�廊�7G�"�M�
�LQ�wP��C��jbe|LQ���T�N�^�"������)*���]bX��<���`�����pg��
��V_@���\.c$Ցm@�Qf/��L=�`��l�:�<sK�G�V�20��@ʍ��9*��xR��U��Oݖ��nth=ec��
}�%Gz�	�1
|C���5����1p�'+.���!Q�,�Ż��i
���Q&=�T�H��� ط�nnO��/f���?����?�<�����\�|;��[�݊W��^���|�Wc�a���gw�o���S����_��#����S?���]X�e��E5����V�$q�=�*T}�l(q}�D1Ex�D�	
�TO�+@J| �j�\�V�ȣ�c{,O�)O���L� �d�ǕEy���ᨉ;���z7�x���}�:�L�R (l��|��⑵�$h�-t�t`e��J����I�>�o{x���	 qO�T�'S��I�>����$}�%�'��Z��Xꂵ���4���4�LKQB�J3_�
�O�m��Z�����%F���j)V�I�.j>Z�Io3,���}�L�
r�Er�˛���o�_���Kǹ�a��k������o�/�E�ߝ�<sߨ������u^����ff���b�|c���/����8r�����
�Gg��]hM`���P4�P��~'�6zBK��0y�v�-�ı�k�dG2d�d��G���ƴ�9e�Aɦ���좂��Ӊ�KT�ؤH�q@X�?��L�$P�|�Q�3����N�; 2Q�j��E׊�S�Yn��@Ry(��1Ќ`w2��) ŧ��o9b%��#u�P�Nf [9�z/��)qfHS����.��p��X�R��S�V>�O����n��
�p4���c>�`�zhL8cf�5���<E��fmM�D`q"K����]��VF	H��?��� M%�]�O���j3{� �`�cm��=V͓�O9�Tv��>����X��)��Kyb�д.�ׂW� �&⼹�����/@O�\M�pӍE�G���V�Ȯ19R�g��^k4G�<�8�hh��t�Wq"��VP�CqK&e�?��y�O������:��������=�yǚ��N�ykl���zv4ul��c���-��d=[&;_�|V�ff.W���8�6�<[.b
Ӽ�
��i�����,TJ��r�6��}"K�H[H��q�P0�����Hd .���2.x��j�i=]h�(�
��Y�
����d��4��|��$���@�J�ކ���-M�?�eR@@]5�n�;���|竔M��S��I��v&V/�J���[���Y�x朋jp� ������f�7�)~F��8��8�B�B�kP:����rI��"�ːvʄN�.Axm=<���%��U��÷�U�M�n���+H�Nbd��6ov��^Zjz%�13=�j9���ni�tڀ���,y$�on�f��/n_�_!�8�suUݜ/^H�8C}�G>�<�o�ɬ����V�/���;~�ZV7W��]ր��8�+1f,��]6{�����d�?����w ÁsP%3N��8b�,���j5�2h_2�l'J�6h|BU�ɵ�C=<' -/�a�;�ŷ󩠆��)JL����s�8���A���t��Ui�$#��9�@����������vy���D��E� �}�����L�i�!Le�i�˳��L��2�l�գ�1�ݴ��Y��)�h�)�3���MC��9��b1FN-oZ�~$�C$����
_=�C�:�)d�����9���`�B^@� �~hy�WH<,�}Z�no��oV��6���̽?���ys����GY�k��oeo��{������'�	�@�i�p���L�{��;��6�?*�����z��q���_�����|~Q��ы���c������������j����ם-_���,�/  e�Sx�~-�0Z�����]u�lV]���ޫV��ϛi^��Yk]�n��$�ղ�á��q$�OL�c���M�.C�4j��&AQ2ՃC�f
#'�������U�>�vA�Z�m��qPY�����]\�������k���Ղ �>���S�LCn���7��Ee���>(�N����هY�0��Ci�;^�1c;� �:��Ɓ���١��ck��Y�-뜀Pj���9..�!�SW��r�h�ĢF� "�oɋX�ɗ��D:��a7�Ϭ!��6m�:������)�w�ٍ��l<�L��H@7F�f_%. �-���m�qā�e �MO�1���=������%/�Y0H�l5Kn����\od�����O>�-�*0��E����*�1]i2��Ҭ�s}���24���o�@Җ]�����
�6!*�ͥ(e��l�b��ۦ��v�S�FM:'1��d�wT�N~~��>�3����ؗ��������}����=ep�=iKg�	��2�$t~8e,�O�؀:MȎQ�T�B��L���24��Q�[� ղ��K����Z&yf/\|y�8:�fu������׋���Ŀ������1�.�כ�o�V7��Ϳɳ�
\/�{z���-�ga�u:�X�J����͑|.��¾7y/Ƞ��c�����5Ͱ���"d��δ�®����tx&�M�Í���vH*.��l^-B�:t#8�
=:�C	��pYW��%�~)G�����ݺ�R�?����Pp���r㛽���{��;��u���%��9� �WX����%�PlA[�s�ߠ���� N>gWH7��-������O�
H6$��mm��ُ����6y�j�{���5	bUJb�Ă���ԟ�,|���Lv���G��뢍���2ț�|�s��������z-���I�/���ЀuE$�`�EW&"��Æ�@*y��b=jU�+��H�A���~B)*�9��D��*�
&,�L)�nj^,>Ud�3��XMJ�fy����z�{�^��W i2�C<�y8����T1�����\��(f������'�����'���8��b7� Q�"Pd$zWۍ���A�7��P^��o79adzd�D!�[�H�,�[%�FY�q|$�����D�~��&*\��M�Iÿ4�
�ˢn���w28v��v��B�=��J��-��D�;r����jp0:rU�xG:*hy.2ڶlr�Hd�+놽r�BDwB&GǤF�����H��$�HPA���M$f��E�oFeZ��pR�����(#�hf�-=��			�-p��.�6#�g�LDчi�}%4#�z�5��T��Cs������������O�}��f�9�ar���E�OΈ̈\��d ��t@�ģ����-�7�-��D�n��e{4=MA�"#�ux�"�"�s{K4!�	�\���V�w�P?�b=�wc��;|�/i�xE�'�lL�f��c�J�>E�Q���2��c!ў;�<��%Pd U���m�P�N��kca.kҪ6���=N��B����k,f��hK@i�l���~v{�x�9�w"lK�$	���5C��6hl��4i`jϤ��>pY>�� �mR�$�D6y�4�Σb�����~����g��+Ϋo���a��Q���y�S�`a�e5�ټ���-������_��i����E�Vs��n��OgΥ)
�3��������/����<u!T�y>� �ǖ��tgCvx�5�����|�ZL�҆i\f�Ϊ����tx.A�1sy��RG�N�:�.�"V2Dg�����:�WǢ�fn[�ăRN��qI��`x���Lw��)�su���+�;�p�r��*�h��"��U%fu�)�'����E�"2��7m�J�����j��y���>��᫰��2۠����~��V�DN�IJ�i��C)���F��O-YԂ�ѓb���Zƴ�Ġv*'�-�i4t���b�ѷP��3n���m�IE��X�9=ILӟR��^؍����#f.���x�N�    Ѥі����u�K�#��w��9���>���g������ ��V��Q�8�_Z��F�F��gUI�R"aVy�A�2&��¯��Z������Ƽ�%��'��0j4T�j+��ʺ�\uV@�
<T��>'
Kߟ�b5;N��8
�B��kC�q&�EYK�We=�Rf
�*_$���K����b�H�$AA��iS�n�Q2�ao�Z�#�0ҒbzS��#��4�E�j��Kyǳ��r7i&7��J>H�"�t:^���g&���M
J�b[-�z��3-@}�9��2��O��&�o�Wo>����^�����t�3�\$W�Ŏ�����p夔����
�IWQ͖~^y� �¡}'v� �;��k�N�x
r��ͨ�_Er�C�.˗���i�(�"�9�| �a�`�*ȑb�Ě%*�uD�\�19�E'��v�����Y��<{~���_N�A�F�W&�4�G�u�� NH�H6W�D�����\�B!�g�֐�������r�l��^��<�Gf���ν(�������5=ɪ&(z����b/��[�܏��j$���3�,9��m��#����j]�+HZ�!"Ml�-�"�ijw  45-�����H92�`��9�m����gU�Sq�>b-X�✎�!؜<j�N�(4t�lB�yYƁ����xLd@��#��
;�o���^P���{I��{����ɭ�~�楘�A�[q$��x�P�i҇4�HZ�v��e�P8P����9�n�E�}�֮�� $u!�Y^Rn.<��Н����~K���'�`=����8��!&xKi���Rr���GU
���*0�Q��gD9#��Q�9 �Y�s�λL|h��O��9ϓ͛�w����Ȱ�3���v�ơ!7`����$������ �:$]X���KP�~��@���L�,���6���M���R�,�#�,,�|�p�A����H&��bE4k����w�R��,*9��l(nf+�b4��L?�75��ϩ�R"���GfGB����b�(�"�3���l~l� 7*���l�G�?�DWq�JC�l����@߿^4Y*����Eq�zDIJn������?0d�q>�y	Եx�Sh�Ogsұ��,83�-◇�2�nQ���պ�ROgva�U�˴г��f��jf�,�i��4u�J��4��������*.��!{����0ʙ��z1G���=;_,�>ӳy'd.���r��v9u�B�^I?G4V!@�v��0D�k�':� 7)�xd�Pd�p,��?@-�ʐ2z��Os��9h�����z�1���O�y��w���p��N#Y{��4>��|khA^��*j��@p�X�T�W�"8�qG$[��b*qB�ejK�R�h�G����%���{Ѹ|"��fuv��|���B�b�k�8(��й�� ��܎<$��T��L-�~iqC��p��g�4�*p�)6M�"���ԈzȆ�$mҞ&����0Y�c<y���K�^$�ӌ�#i�Y���:дἠ=��#�"	jY��O�.��:���Y)e�Zϸi��-//�͍��w8H�ܵ/�V�a�*-H5�(��H j�D$a�j2V����H��\b��pP��s�� �$K8|W��ݽ��M�v���(Yr�t����b�����3�U����cq�d6W��  V\%,�K,��� 1zv��ɉ���h���+z������!��%Q���x������R)�.̛��@�$�ZL�5�� �N��,Z`��m�(�N{�6Pp��.f��{eL�u��I���6�%�`0gAfo	�E��|س����\L`ओ9��d-�b)k��\MT�U�[]x=-˽r��,+F��9`�!�d%��Ŝ�x�v/7�?�_�K��,�VW���p�&�h�R�%:k���Gk4�����Tk��	��_,��/A��cϺ��[$D�/�L��0���Akg�H��\-X}wy]ݬWW8w�h{�^�e�mUg��aЂ::��D�I��/���2�h%�(�\_9z��r�#~R�`+2-���:X�����U�Y럞�q*_����>l����ݼ�]�^?����3U��8H�ae�V�W�2L#j�N�ezA�`"��=�*�[�K�#�Z�V=�h�S�/��G���j9lM���·��)�8x.P�G<;rL�VG²f�nMMWs^��%	���Pkm��$����yU��;�a�{�۬6��������c=���� �Ж�O	�lC!F�:(�"�.5u��x=Ȯ��ԇ9�.����H1I��xE)T�m,�9RZہ��|��[�ق��'�9��+�y�?8Gl���u�O���Sw6ǫ/g�3��.Ηa�� �.S-U��|=��Epӹ�z��Lfm��-������B�M�Z�S�n�U^���r1?�r4G�<۳��& ����tfc5��B���X�N�8j�R�!��"j�\al������}�lP{���s�L;��ա	 �����If��D:�� ^��\�<)�G�F���n�2��}�
��:�� #f_dF���\��nV2#>�W��	� 邃!�AC� ��!O�1����;Fǀ�x�f]	x�0�����6�)h��cN���v��ig��W ��R�_���f�gՙ8�M����o��eu6��J�����ǠaW���h��]�F��I^fJ�>)�2i�+�q�9>��|i���9gV�����k�b�>���a�,L����z�8��9\�a���j���?Z���:
L��������p@���SU�Ha.u[n��*˜��^�����C�a�]�[�����������@Hl�4���b��$��B�B�<�;�<�y�%y/q?�$�m�E�"��콟��G�[��;�{Y��o?�����fuUc#U��*���$=д�k��0��B@`���k��
��=Hi�6M�P-򴛄��o����Z醉��7���b�ԻC�=�0Fi3��`Q
���"���m��[ �xbI�D*	UFǯ�J�jJ=���C��HCƕ��K�E�Ԙ�B<4��_/�jak}�_a�C�5�^CO�c�M(�nST����| ��CJ�)�P�'r]
l�~BcWaV���A���85����\&��@�HT�����=��Ͽڝ�dU����/G$J"�˃�RΠL1&6�ء)��V�X{�2�W9>`�N�$FQi2� �K��M� I������p�^�Bi�fa����6�.��.o�7�C����L��X�:�a����Y�@7 ��\;�e8�W
�ק_�	W��겁`�U�E(<�9WݜnV ���O��j}.?|��V�W&������W���~MU�!������?z��G���y�������t�}��U���W��t&d��MDA�|r�!���jUe0x�+m����{�CG���7�G�ݳ���ղ�h�8�1ۉ�rs�x��
�)-^���%�49hHpA��ć�Ց

)�ܢ��m4�����3MĄ��^l��e7`m�]�9Y�bx�ǎ�%\�����l�.�����Ta��r1uv��&��5aV-��/x7[��˰�\d~ă��'��K!�[�U������<�T9$t �AZ��+�᱃7�$��	�uӮ	VڤO��L�xq�<�bv~5�� ��U����#�RG�l&Y�����GѹmB�*�E��d~���I�UZ��u�`&�X`��Χ�D\����@�誈DH�<2��F /�T�� �`�/��y�9�p�M�4ݤ���Tk`��
=��
�!��8&��&li\�F'-���߮@g&7b/ڋÅ�t�k�������S���M�M#o!�W�����{�+ʅeH�5s��X���$�Y�])��kb�����'�_T�br���.�o ���*��E�~*���H9ֶ0�Um��C��K|Ip�#�/XF��af�\߅ª������2S�EeUw7� L�N�A������N؀�j�fۋ5�Y�.��7��i00Zd�|�=��dK�j �n8�-��5&{�o���ڍ    �Y���������?�Z^��k�����}'C�5��b��F�R.`�C�~J �%�#�_ق �T(�a���^�j<Duu�9����ɫ)�E	 ����6
N�D���]]m��oH͉�@R��8�3$���E"��)����ڙϰ�=z�ö�@�S�����LS4�p�C�>*f�p�w�И��g(�a��N}�a �\�����"��HH�b���1O�T�|����)�ql����_��۪�Cu&߼�'"��^�K�?�}`���f6��Q��|�����<̓_d;�z魼�K>�^��N�Ja��?hp��`z?���<܆y�x]��	���fm�N��װPTU&\��H�ktO�| }���]p��<��
h�����)���2��hh�*�փ��YV��!�hCǱe�`���a�� �4�=J=��{�4�� }��xw��(���<#�: ��F�~�SL�E٢邥����݉�:ǦKqԀP�M�z9��sѥ�G�p�/J�/�]��q��5��Qp���z��!�M�� .|߸кT��v�-MF[�9��5Ǉ�O��"��x9�����Ƨ���4j��}:$��m�����8@O����B�ɺz��ϡ'��|||\^� D���c.aE�M��T8�ю��ex�.�Ou�w�흂$!��L��rڂ��n��{�u�D1D�yy������}: ���_~yVm�fa �
y�e7����JX�` �E�v�XH�Hp��`ι�X�q�5��`Ky��.F�f���iݬD���L߽:��T7�]��e���^�WW�ú��,��|�b-���r��ű!���%�C�	S���=�i�����M�O�$��j)\bb�r$ɺ�� ��^[�,@��x���(�4������8_|<y-�=�ŏ�,��y$�0 (-!�bc��n����վVP��)]��$0�����8�P�p��N!���K��;e��� Sy�8u�����gh��9�n�2�w-a�Н��1�p�j,4�X1��H�R��X@L,���Q����z��ף�������ُ�?�m�MVZcvKQ�
�3)��A��� L2��p�T!zl�+jހ7��e�V�
�b�ԩ4͒���P{}�Z]����w��_S�L��8�ͦ>31Y��������B��A��aJ�-$�hl��JfeM[d�l� ���V��+1���x��S��(ڎ��ȏn�8U��<���]�"�_ofyC����:
��U���r B����BƠ�Z̄H*��k��z`z��?�d*�3⥦\��=�蚎�f�P��^ԝ�=.��p��Ňw��w���o'�TGX��nr��9K:^N@����)��a$� PΎ��\�I� ђ�60�Nd�m��$����>2�pd.�z��>6�$�Xx���Е���[?���TV��t*���<ǻb`:YC4h��� ��w2�&�2#�$ҧ%CԊ����, �M�vҡnWji�E�̓��:i*~K��֜��D=��$a����P+n9I3��
P�_���@� "�l7h ��.)�:t�0�#6;�БCJ�����j���Vk�K���}�r/���'߯^�i]}��������O��v���<��Y�MO���S���y�>7���������}F@��WX�SR���I��Ö����ZQ&��\4ؼ '�x=)��a�T���!SS�����#E�(|��~��U�j��g>./e����ʃ���������r ��)h(ӣ���G�G"���{�Hm?N�C7��������ˡA���?����gú������AQϽ�g~dP|�$
�����Z�ݬ��-�m:��$��x*.��@�(���і��+����@3��^��h�4�GݩGa��I��������GOWWW�B.�2���]_-ʯ~g:�`���?譹bt��8+FP=�&�[n!�9b��N��X����2�-_\kP��,��u���68�ՈL�N�,���uo��Y-�r������|����\w��^_�5�-����#uh����u�d8��nx�@�!ȗ!���B�DJ#X#w&"f'�Vƥ�ȋ8��ڽ��릩 Ao�Ҳ[�P���f����{%�n�AʟtM��b5
ZR|S�n�]"3�?�0- �7*�I>�&"8�C��#4$£:Zˠ8#Q�o(N��l%�r�5�X�˰7cP�X�3+��w8�oH �V�/?�~'�x��t��_s�	fэ����g4�i[t�\m)T)��T>�9	�XrD���^_MvX<1�s�5ZV��^i�~����v��/�; �C�����^�e �c����Ϙ"
�6A�D�ƫb�&�{,��!��!�+�b3���%e�@}SB?�-��������=XW���OVW��no^��|���O��zu�<\�9���z9朐mH�"���,�7@n8křKr�!=�8VX���I���V
�Y�q���I2�btr��� /4�`�v�-�l`\v�mz�?>{�:D�L5��yh���`�rH�)o���i�y8G�͐���&[�rDpd8R�	���9N4�������5��6$y3Y�v������w(=��/�^W�^�#�G���m�,�\T�M�)��૧,q�M��@�99L�I<�7	�H���!�w��h��̲F��D�m�6Z��/V���I��k���a'_�|��n����¿�s9{}��ys~q��@��e1����\M�7�{����?蛗cH,�orKC�"d��{G.RV������6>�D$'tn����)l�@�*�&EO`�mD�z�>)��B��{\
�q<��˛����[(��>)�':Q��ӰΗp_E���[��b��ZqL�FB�D<^W@�u��C��m,�0�
>��X��U�~��'�w���M������<��;s��W��c7B��3
_����Y�c��^T�[f"��������M���1ۏ�,@؂���%�# 
�9�&n�;���_�����.M0\m(b��� ���������י�N"�muj9KafU�gr�'�:��=��CK�y�w��#�:��q�r��lL������iy>�e��($�]��'	
/�z�d�D��RRS�hA,��Mhg�I�S��(H r����(�C�K����﫫ջիW��Ŏ]��Y)ܓ�9���ތ�	h"���YMh<�--'<�uc[Q^�m�=�v�L
dhF���!����B?�f@��	5P���O`@�u��9(n�aˢ	���nO��k�`�ᠳqr�I���ڕY��y��d�D��� ?�Fh ?b1��<�5��o�PEܐ�^p�-5�Y,� ��\�5{�tA��R���(��\/���7�L졾!� ��`���4�����\>��O/^�����g7�w��v����N۱:G�Q�p:���`|OreF����)1��L�b�TG[�P\Ô�-\�����Џl+�*K������aX�G�0O2u
ᡧ���|\��-���1�I�ǔh�֌��E �z�������u|h6�5����#s�����wn��N6�Ȟ�z�����6�o1��8�������^���]����~�T�D�^�^]UO������ ��TW��=4��=�߉�V���^�,���T�����D�LL>���υ7)vC����D!{"2bJJ��Z��˪�B)���V�)����z�4n������_Ѕ:��\��^���m�q���&��!4�Q�hܮ�f�x�i��y�@�gh�9�F�{�P!�0�em#S�Z��u�N���a,b,�$�֎�L��X�V�U�mz�w/�~���`&�2�(���Mu����ʻW���W�^]��u���m���Z7I����.O_��b�!��v_M�}��^�63y���������UE~H���)ʣ*>xr<�q�n��j_GiįpL�x9�B%8�[=N}=p���g�B� ��_������@�(#%����
�    �6mN�Cc34�q��I�Kf%E ��I<HjNd����a�Xǆ�J�u�{j2Z�=Oy۸��?�ܟ#�i��	4G0Շ�������2שt��b�L�`�J԰2�N��4M2 ��V���T��V��I�
s�L���Q�҂ߚMj�*N�B�� �i�X$Y2�f$�^6����CMs�����1�:��g�T�6�C��w��BH^�5Y��6����'߽<==U�|�+pf��Xd6c�g�x�f/�]`j�g��Ht�\b���������Ä�i e��D�HKS[X���� �t!�L��`��%�!����חt�;/�'"f5ĐN�"�����[(�	�/��v������!"�"�z�i��ҭ7��R�E��6��Ɓ�����Kp��ޘſgu�Y�����:�7��bS���?u�����m��9��������P?�v
�m�iwՙ�X`+����%��3�~X|����:��v�|i�6�H��J���t��w�Gte+ܟ�h��]>]]mnV��N&�<|�b��n��w�tw�t���{c.!Æ�����5���*�Ď9'�����qdC�~�]d"Ou�%��8���֢l>�GFܡ��������"��m� ��2�l:��g�@n���'�ի�����l]-f�ׯ^]��.ˢ��^�z���Im�ys���z����oV˯��^ˬ���۵Ə������͟�����B^�뽏���l, S����  ����$�.�mP���ua|�mc�D��s(�I��*C	��Ʌ��@���`L� �k��u։���1��6퀧�W�A{�p�7��uu�����]�z��U+�`�����$���u�� �&-r�hJ 9��< �[��:�z| �7t1N���1:�qpןV�ۛ���#��z%��f��]Z�:�}��s5��=9��{���ľ跉Y,�y{���&"t!�G��� ���(�L���ceIÓ�h�-�t8f��h��3��e�I9WtB�q��Q��5��o�倹��;F:s��*ۃِ;��� ﵝ��ի����r��[�x}sG�s��\�ƁW�&aK�J�tU;��l��@�$�Y�6m�K��AFU�r�1������M�hC���l��l�i޵�`��[��KBǡ�ld���b���w�l'����Z��狷/W?�^ɝyv&s��ͽK~��c��]�'o%ۆV�Dz�� N�Ʋ�M궒���`��#��EY���r|&�@�&�)TB�l�jٛ�2���i��� %��[9��>���3�R�ֿ�w�=����q��DC�3O"9�C��C��:�A��p�0'[z��*b��	���ub�%R%d��)�U��ÑN�ǟ%HW�+4�ɛC7=��>��P0�M�l��Ʃ�<W�˿�W�m������]�z�ks� �.��6����Il��nw��4*v:��	���a���rx��S��� l��p��b��4��޺�-EF�ș�$l����:Y�O�V������a���0	9����X�QҲ:��^l��3��N�l���Η��x|~u���'A޾ɗ�K�~H����8~p�����:Qi=���$b�I��䂦N�E�7R�$*ɛdI2�LI�$Z�M�DL��H��nz��ɔ���e���2�q���$:�⇆���I'%Rq)�uD�"EL����sA��k�$t_��dr�Q0�C��Hx%�,��P��N�G��d�y9�>?�y���#F�e���.N(��xĢ����hY��!V�yO��g��-�9I���ۂbJ�dB7�����%�>n./�e
��//��y��_�BK�z�TJ�(�zE=b����(�d-�9����JT%����;S8��Ƃ�1e�����%T����"�^�|(`�I�Sw��1�ۓ0��D�k�R"#�¥�
�9|�pt�9�F��˔�"�}�%w�M������9��E�_P��#ϑ�t��%|��
�\�ܪ����O�>�s���r��	��Đ#��������rVI|�H���OSs�?�����ˢA��P�QT$�'耀a�#��"kM"Ax����{[d�@�M�o�eO�A|�����z��E��kȃ�Hu�D����C��E���:I5��U�	�62��׏[F��XƝW��%��[,�'KbT5
nӲR��#b.U>`�u&�&p@!8�,n�<��=�`[)s�=�����}�vq��C�#vʿ�{����J~f��Ĕ���\EÍ\��A�[�kN(i�����J�]R%�+�7r���O*x�(W�n\�,��N�񮕼N����ٌ�#V(�ȃ�Z9��.y����W������֩{���wy�O�r0A�z�|�#�Q��|4�
�B��	!j��G� ��H|���&��������UVl{��P��=�#��<�a�b�,����'���;����璡����.��#���,�!��Q��u IF0�@D]Ԟɀ�k`g86�D��_|�fL�5wEj`�H��߃�W'�-�n������|T�mqy,6�vB�!;a��rF�R*)��cˀ
����V�" L�B,�{XOH�ff��k*n�難e�i��/I�}�a��uv�y��z���/�/�������T�w1~��2L^W|cJ�)^6)#� >BbR��-k��nX�J��T��#	�ʸ 9��+�� �bc���WA�������V�o�vŽ���{���S���4f�Ə|�8!�*W�(��䰉[<�ݬh�w'5D��HK]��6��Ej�|Qy��ټ�������o�{�_��[|�Ӟ�����z����%�d�gy�E��$@�L�|YS�`���5�
$����@3(I*�	���;tu-]���(�ɛ�9A{i����1NP��lu��`���\��J�P�@	�ZZFf�tFq<�ϐv=_Mgk�R�2�_�r�.������ߙ*"hȧ��"��(�� �^�9UE&\^��נ)p�qq�2�Q�-Q'j�t�,λ�/�h��?����sc|��U����T�������
 �v���t�|q�E����L"�k� ��)0*0�"y!��ፊe�R�B3�7�@]�+���lԤz��s�%��#o���p7��Ŧg҉i;���K���)y�]�,��qx�xf�fO��H]..�aãB4�ď���x���N&�>N'F�������1�l7+���j9���hJB���N<1�9a�_xY��~�z]�$;��w�ˊ���I�6N�Mlhr _�W/5���渠L���KL�$�^L;�l�A!��M} -��	��. �&�(�T�2f+"�r.��1�v'rb�YHh>��{ق�۬��TY��aKV�\��	J����,t��DHR�#����o�N�־7�b`t_�&�5�~o��?o.߯��D;�]�9(vw0E=�U�ȥ��h�|��Bs�!�Y�G�4L�a���	I9��(B�L��;I�AN]i��:��8:�T[�i��l��_��)��J� w�2$�6 ��A��Raa�8����ކ.C�Zq)��@�$�^NQ<l�k`y���"�Eq�=8l��?TA����|�
�ً�u	��/�|�����}��_�,�",b��c�6#�c���Qr��sCn�/�:����t=�P�3��� �����Yw��H͟ԽF��Y������ͻ�A��/��?޼;}��＊̸|P�=E`�����]AI�<�~	'Ä�Ą���Њe��W��q�ߛ���WT���*=q�e5:�����r�?P�TX0_�6��?NH��(��H�n���,&��)�F^<SI�Y4���Ar�%�0��|�H�����dȈ���m�ԋټ,΁���'.�)^�Wǌ�+�~`�N�bD��SVk\�����y���)�gy|������s�S���B�fyd[py�h˃hf;��Z�L�<2ꀨ-��� ���l,�(�!��    �o}j��>������RܓbaB��*.�@K4{w1��Z��nd���&�-Q��h���B���dE�e��e��T�z�򎃈!+\o��E�	����hÁ�aB�T3���ҁh�Q�X]�q���B2k�ˤv��`>&����)vo:�s!v&(�^����}޵gɁ@�.�*�����<;��� �P9j�w3T�@��q��k�2�͟�T+�h�#�d$�a��&�EƐ�T�,�u��J�R*�ٕ��',��./�UK+R,=Y�t.����׳�Nzvz���?�<�A/�|�}���!��G/��Le�8l&�)���@�+N%�PA� �$qKa�#�tͨ͡3E#&I.!�O9F��QM��8T�}��RͮA��lti,�KEC:�d���Y.����Y���jp@l;���Tk&I�6��ȒA�
���F��Q �p	���\�I&Z�h��+fC���l2��" ˎ�+97�`��� e��H j�{/��D"F1m���Ȳ=���� �� �)kwS�v��4��L��A@N�&h�h��硠.^j�&� � �!zw��Y��")�z�,���&T6�^ �b�'$�37�mvz��#��O^�/^<yq����m2�y��^�,��0�H?�RL���4C�V'+?�"O�����J��"��Ҷȍɦ�$� )���� #�����Y����.p"ɕ��v�$��H��������#a��8�с#`��	���� ��'���VXz�XYǈ=���:jJuz1��pe�Q,<��=\m8�E'^�؇f\�D�a�$Z�o�L�^F�"�>$����wR�a/��;KH��FR���e��z5a(`"ΤG�5��Z`n&�bB�JP#�rںA�I��2ǃ��<|yzZp������W�v���zc�E�<�}4�����Bh�g*C��Q8Cъ-K��\Ģ+d\�vN��ǆ����
���6��m�����N��^e�rw Aa�3b��n�2��	�L�j�P��u�S��'�Y�u��A[D�p곑l�l@ӱG�y�lT����[�Y|=���}d�7(A&�P�r�A�$&t]�������`Kӆ�\̾���.CϦ�I��T�	6E"�Z0O�".�"Z|a��S�����ew;��B�B��� -��ǅ	�������vu�}��ǳ����}�_��z1�0a�&��LB���D+�5��Q7Qa���)f^sD���1�h+�->��Fz�$|�B���cr3���´!�5��5RN�AE�H}�nR!>\�G����������wW�������tz��m5���m�V7��ś���eyQ�I��p4��Qal���UZ��ɏ�u�]l�f�՟V�}Q��7�s`�콶l$ǊEK�y0Ixcťaz�9�u/A�e=N����	�(C˴����t�-5��݄0J<~�{<�Vv{�@3��BX��Dƽ���k"�-�����i��%"�?��?qN=f�j����GP���%���>(��v4m�rAv�M���b�^T<�����>o�+���#�9y�:�w�ɻO��a���G��8��$���
�Q�?�1,
5E!�N��$ź1
x-���CS6�2�hf;��v�JМSh�n�Pt�����o��xdJ��?_�u��A;�=�5��ԡ�����n�8L�-v�ˮwZ�R�rF|�7�`�P�9��R�u 4�dǂ�6�)!ǘ��[�.B�e������C�+vջ$���	�	��'ɦ�����C�?� n�:o�?WPq�b\%�/��ơq�/�:�Qh���Y�@┲�D�e��@L�z{K��%����AB��l`@L������}�n���kS61u��uD��yB$��ٱ1:�8�2����s��>�qP	�)$3�HlG�R��adȡoX�թ�PX����/�V�1і���I8|��*�ݬ����pA�0��N�,��k	=ڝ��v~ǌ��nV N~Vm���s�����X������Ȍ�k"s�:��4��T��C�8�/�F��\��71wL��(�hPO�M����TO�<�"�d����K{i�_^��U#����:/��Or���:��G�����j��|���A��y�'��vf��[y���K�2�kG!q�tR�0#݊�
j�p�W+��$���F�'����n��.�+��'d�LY1�)��o�`V\�hC�.;��_�؆�%'q��-@UqL�O:)̖�AHr�LH~[�DfA���M��""��tL=��l�LѓA���V+�uUy���
8L�^�b�c��~�[pޭ��QE��N��� :�9!	����M��C�ո�L�%��C�sT�����ma�A%��Ц��ҵ�,(���F %��N�>|��(�d������7��릺zq[mV�͛��JN^)}��4��$�ǲW�:lkW����xr޹Bug�����>gfTRe���)5���c�<1w�5e��#A	?VW�����i�Y�ƊvfG�)0��+,�QGAD�9{�sg �a�%@2�C�P
	����oo�]�N��P"���3���C�
zS��չ���[�D�Oǔ[~�%�/O3
�5ھXǓ�'�8n�d[Jk�ڴlS�<\�r�e�����T�)��������n�-����@���s��Kv���p���d����x���|�榚m��<�A�;�<Wl���� ����z%લĂpvbfrK�C�zp0�yI^U5�鶙J�4�����=0�9���?���r}5��д�Z�HB�J?r�GK�x��JM��Z wfОA,��YH��x��G�q	<�{d�K�I�C�,��3b�4O-�L�{q��e�k��(�Ȉ��z�z[]=��`��K�.(Fb��N��O�|��];�-ep`S����P^[b?�L�0.����  !H1�q5�E�|�J]�YY
�e���{�f�~��aq�迍1'b��L������yz�������ȇ9������5�Z���*��F�3��p�.lyy�HI�"z�G�4�<���3�4������Ox5��,4md��"'��#婈�(Y��'�����&�v�%PHޤ�y�u1�؉˕KW��>� �WYm�Y�$�0��S���a�8gI�q�6 ca�#`0�H���`�����������P���
��F��Z���"�a�C��q�����l-�la7�g����{u����$���em��1�L(�Y&�|'k#�6A���!H��/+�@����vu�����I��(��K�|��Q�a���p9�y�~s��EUm��0�.�#�\@n�j�|���7�|��ɋ���'���h�t��k��}&��A&�d/�e�`����s�5�~6H���ҫ����Wk c8��-%��-���+��#Gg}�  �$Sg�ۜ�}5���T�LIz&U���pA�-dS���%�=���F�(��Tx��\�o�#'��n�)d�n�.I�8�9�h�� Z?�6�7��������k��9��{_���x���\�j7D��Ku[�*�c�
��&~=�\'�MZ����*�S��� f�R���?\_���9~����'V�c{����2��3����$�𿂷>��vg�/X4�P���k���B%#��2\�l��l���,EfeI�f�R/!5�p������6].\�VN�l)��^�ᳩ�U:L���f��.r�w�wD���	�~�8��	b)�I�"�Yy��S#$Q ɠU��e�)�CgL�	�I��\�)V �-�9@ݠ��E�8����U�XRxRkjy��<2/!�{=_���&&x-�ˁ����4՜��K�7'�Yh7h�B�JGbO8�A�����rl�ŉ���%��Wt�}�$�3@������� ��؊	�<H���Z��P��@�7�.$z-���-t�Ml��V�N 2G�dF��%ق�)��Lg�J���?�.Bv��E-5��hϷ�L��ᴚ�,�|w���}�;�    ���>�E��)��a�u���)��.R�O�n3��w*!�ɇ��)~�)�">�$��m7�*��������i���\Rr ��Q�վ�D�G焕�"�[���KjT�ǲ�Lt��r:vU��:��B�>9�u��_�7f��c��c�-�iZ�~�]V��T��j��w��_o.��fs�����1��0���?���w��|�����~�xk�6�S�"����4�[<�z"IKH$�JR���@�_T$��%��J*0/A6jE�yl�P@N�_�w�o$(�1���D��� ���hȃT��y�''�����7p
�ɋ��V<��FcQa��V�������7������r]�U�/��������?�k�7o�!�̡Mt�{�������**j�c`�5�E��XI����KP�Q��Fm# (a�=x1�DNL�єH�R�̜ȿ��:�K�/t$zᛐ�A�}Һ��,���.�/Ґ?�J�wY���'�^{�}�����N����~
�	S� ~�"���4r�T�J\�g�� $��K�I5����Lp�!eӀM�p��u=Z���6��<���$���Ģ���ZŪ��Q�JkUT/��K�͉�R���
��(�'�Ǩ��Qz��	��ߦjO�:OW
>,h���_�xK��ي���vk��L���N�T~W��WwFIw�������Q�i1��SG5���%�3K}�#���,���K�޴ �4V��e�B�pk��D���g�i΢Z�ϗ���9�gF=�S���I�>���ԟ�o]~��ٷ�۽�����S���~\�D�;�E�`=R�2n%���@<Mzy�S�iň�ZCb��+C�̺0[S����u	�I�42�:��a�� @�(:��T�E��eYl�Z����#o�}P�h�:jÍ�-7�4&�s���R�Ԣ@����F~K�a�E,?�DZ��g�/ �k�����)ˆ<=�qȠwI�f�(�I��Q�����Q���%z���_o�7�IT�oj�?ƺ��B�?�K`���_��!o��w�lgy]뻟_�}�j�%�J�;�d�(p¨�vc+&�y�ED���4Ф"��ɯ���ࠓ�B��23 ��͎xxkO~S�	%� S�ey���g�K/���׷��~9i��ߖ~Y��!�3*l~��2/�rs}}��-^__r��^~�AcW� 4ƑI%`*�#s�� ��ʻ�"g].i����T49e"A:|��'P`�Y�d�W�9���Y��M� �^ַ�4X2}8���5-��f�7�}�1�;�w>�_��0�@ �ݩÊu����oK�� ҭ���T���WD��aђ�]g�q�ĝ�e���֑�{����B[���IX����'�`�8]�ct��>u=q0�u�n����D�RR��,����f?MHffr$��8���;@!��OtM��F�b/���<�C;=Gh'is�٬���*;��\�U^T(+D?�K��y{r�������}:�-޾��j��x�1ƚ�B�~:��\~I��L�!p�%mHs�Se\��&�� L4��(c.L�i�	ڦp�BGo�跴�䶚�t�m��רXбl0���8y�tPb7�/?͖�v�6����b�6���U���ӝg>�-J��ǂ�v�1'�u�(~�D܌��C`����ӄb����:�B�"�!^�)�Pk� �ZN8r�5 ���0<{��6@=��]�S^�s� �щ�-'��ZDP��b����,�_ΗU�����>o��*5Q�L�4n��|�����n#�4Ɗ۪�l���̠�E�(���!J,F�gYq'ND���28����@�w+~H�=��氋-!Z� c5d��f����*_�^�/
|�=�����v]��<���/~#�f&�`OɌS��>P,���RR���jW\�E��Na,��CM/��_p�b�f�-���Y�S���@5l|�6�1U�eV�7���i���W��jqY����6�7G�X��z��}�bYa�w��9�N��h6�P�HSkA3@�>�Lm�9�˸|�l,_�n
��$�p�.��kw���q�_�i����%.��>����~:=�}�+v�!��-��j��^1�ѣ��_GL&�"�J%F4A��"6��jin��X���!&hB�Vfw�� ǂ� ���7�}/���}9��Y{�>�6Z������߬޿X�>���<��.��T;�y��
n 
�<zYS$���4����n]	�KN!D���z|0:��K�1."�^ԖfL�h�{�=#h��Z�c�R�~(r������~+{{�yg��?�ܷ���cf57��T��5�ľ�v7Me9,l � �zm��L|��|J�d�P������h� lJ�=�P�X��歀l9�8�x�{q=?�W�4�&���(-_��}�@P��n��,s�����e�֊er1�αi^'̡�8x�JH�p�G{\h��%����\������˝]q����QZ�ͣ�p}*�A=�ơ��=��3���,U$)<u�M�b~F.n��I+��=�Auf��:3�:�s��'�m�mE�?�����}|k�J��	��R �D����@�=9���]�;�
3adH���s��	Cȉ��BX�<e�#=�0	\�$��6{��}��)#���a@!B#��!��/,|�s��ZUK�����kG�7)�mȘ%Ey��� 1+0�w]�(�Y�+~z㆛��$�\����۫u�bv5{�M�wnS�Y�G��K�C}ȩ@�*�-\�HBF1���W�
%��V� UFO)*��{0ݤ!t�Qb[��AHPW�;W�)Dt��O_b��9a�|�����P�@]l�#��c��,q
s=�%��q.T8#��(}�H�Ϊ"�u/�{�����X�Bl�h`�-�Rq��CʠK������P�Ʀ���s��}��Ged&���7K�Y��.��m$J夻���LU��� �El�#�]���lL�)�T�����lE6́�{��j�����е�K����'����2j|=�M�=v��Q� ��V�n�#�'\{�z����q80�c�AL���k��d�*NEYr���6E�ǩ��^��S�JD_7�Ċ��l�l�<k�cw�D�(� �G��H'#�O������@�zu���e���|&:]�߰	�㟞Ug�ۋM�Ͷ���[����hȾ�q2`#��ة��C�(�6iP1�X�H}5x�하p2)�����dh�:�jKP*�̴Z�`�� �/w_��F�]��}�?$��':&�U�ƥj���jO0B� "K$�&����s�y�  )�ʬ���"E�r�]�=JP�iV�b��-3"'���
��wާW�	Ϊ�o��w�Wf�|%�q������"23��0��Kh�đW� �]*Hw�0��e� ���I-N̨�J�F=I6��EA���' Gi�`Q��	V���x\ʸƐf2������f�)���DC��j���dW)h^.^�������}![Ts����_͞*�����$��83������/*׀A�/j5�G���/�|޾ⳟ<>�ۇ���|�?}�z���xl��E?
LRړ Z	�c�3'��΀#&�42	?�#ӎ��
�1�e��M�*�m������.:
ߑD�5`��K{e��<�m��G�Z.e:�O:ȿ~z�����ohީ4l<6�[��nf��a�qbY2�r1�`1��I�5�V����ޟU���O��";��@l*Q;�/���@"'�B~l�6���Bۦ*Qh��ױ	�K�/��eΗ�������U�X~:>^��M��ʗ*�|�&B�b�\x���=.�dlz��������a�R��pA!�Er;�؝!�<"PF6pQtg��;�T�fRI|��/���'U��ɨ�\�N��iE~!y�XHl?T�K�����MQ����F�Ǚx��ǟ�3B�2X��    ���A�bz$X}%������ųt!���5�}�<*op�WJyh���7/���w���g}�\X%�g����ߚ��=����g�W���W� �\�'BN�4T%���\��j���B����f�����)Al������Rv��f�nYͮ��
$4W8�s�G��@�Ӣ�b�Oo/�} �&��(����nA�UA�Y7�f�����5�c����@A��BC]�驥F_1~*iα}Y'��	[��� ):�Z]ߏ�<�c=�����<��2��>�o�쀌�1��<��cm�S��گ���o��ns��?�^X�����]3��x���jat�V9x��M���s睊��g��<�����͆�Mld�_c�;Q�7[x��=J�$��e�C�Tɩ��&�P �""U�� a�5Lr{A��dh���1���kD�kB���d��K�s�����½آ�����9��@v��Vsr�Y���lr}P�^��zR6U��4����w}�rڿ��~qqz�]Tz*�������Z���^���5/��C�<�Ý����r?�UV�U.�i%�]U���aj�Mm�:;@��wZ��M=����n6Tk��:��1���_�ti�N�*�����(dV@��e�Q#��n��Z�="�¨8	B���e����P㡎7P'v�������\~��\Z�U�r����x���u���7��H�;�y���?�ɒ�1�M5�%�㛺�j�2r�f���u�#�=]�����8F��7d�A���ǀ�$�с�-uP�ΐW��+B �*"� � X��n(Gޚ�a@��#�:��
��0�[eZ�D}�"�R�i t엳��t���r ���	W����w�!�ȝ3���3$����y��<�Y�ͪ8m�[�/�S��i=��Unį3:C��ϐ�sn�3��y���8pO@ڍAa@�@i*��q���T��}�w� ���8<fԀ3d����2�bUh��4.�����6i$�̚�rl�����f��t_փ����ˡ���� ��j�[�8?��#^����ݻ�@��?��Hع 2�jfzQ�Y��H��JͣX6��Ń�OȮ=?Ӆ��r~�.���)=B�h���)DE}c�WB��"D��bw��n��:yJ�8ꑊ�HG�h�� ߑ�8D[%R��A�؛-�1M��Z'&��l���n/�Հ� #�u8Ur��
�~�X�;����R���c��y:�Ͳ�����&q�f�j��#��Zه]K�=VB��+dy�z?ҽ�O0@r[	�����G�o�3�9��NN��p|�� =�vJv�������v��.��ڤ��i/��6��i�s�ʵ(�ݧ`�N�63��}��|:o�opR�|�C0;�C��Spoޤ�ͻ�S;O��G�)>��;${^�|�e?����_�9]}
�ŷ�_|�~��|�{ɾ6����(LU!�E�c<�A�
�d=��2)����`�hq`3����EL8{<��,� ��^xt oDr1���ju�}��Z�#��,qx��ԋ>(��~L^��3DGW��a}��V��,��E5�Pz�����Ao<��������	"Z\��9�
��;�/�LI
n L� @,����E��5��ۑ��{P�P*��z�@`��W�thF��aټǚ�6������X�T�P�it$�n���iqz� 6�D���K/ٺ1���[�>��^^}�n��N9?}u����]x�=���o�.�SA6��.�z���-�Mp�I���� �m<QW��D�rdX�>0����OR׬ ��B]���C�B|��-�(�aQ��|h�K"֞�7��1!���N�g˫���<���C�s�~���q㱡ޣ4z��}�Q���F9*�k 7DT�J��`�bQ��0 ��6��6����6G)g.��B	�(x��r`�����#'҆�K�B��G27� �m��R�6�CGo�᭫ˢ{D���k���W+�複W��	��`؈�Gꠀ}�E���҅=Fk)�́���Aa^�� ��!�=�͖@�3풯�cJ���'_�s��.�7��Ϗ���z���t�F�!1��E����o�����귫��I��t��/� >���?�q9��mn���Γ��]���y����yw�xۜ������f�7��~�Tx��'#q�Dj�Q����鈅h���N��4f�3(�82˔�:%� ��A���u���< N� _��Ì���q����I�"�a�(�F��Ĵ�AS����D��R&8���v�i(��qdX��xG�)�u"f~[D�ed37:]ir�����ӳ��}���_~z��_�S���M�<׳
<�U�y_M8��.B]��A�b��Csq�jyu�#+w��g߁���E�c��d��ZF�J^zV�y1����j�2y��5���\����w�3��+����|����4�Blf�/��xZ_̚���Oc���|Y'�4s��i�u�嫛�z�4��ayqtS�4OOꋷ���~i�g�
u��L>ܬ�U�XW-bv�C�4����t��0�����a���WSk��9��4�2�&+=�M�S}P�M�'��_��mAy��ry���tI*�ӷ'e�<�z��;nsg�g��q��&�l�����w7,�u��T�2	�>9xHpsPk#�x����FY� e#��rW'���֝��v���O��/���3�OO�����3�r���~�^��^F⠈��s�Ma�r-��D�U/u կG놊����*
��pR�H�ŜzO�����q�~-��)3	�/';I�&I����`�ජo�[u�6��p[%��x���e�'�"���>9�o�C�CM!"��񱵞Ea�U�4��i;u�xdB�E`�}��u����@ӋE%v8T��(�3����&��2q���@����3�V<�,��G  �L�Yf	)�WE����J�v�˭nyA�D���C�6�߀\0����T�t�չ�dаI4x*�;��>t���}h�eW�Â�S�ꊜ��×w��l^����7�{`�zHc��7���t��>`y��J8[O��Y�k�$N�|Z��D���b�0 �Xǭo�d����A���?��P��&��n=�~�Υ �!��� �2�g�F�-D�p�y'ޚ1f�|t�AW`�}���0�d**9*���d����D|i��C��*hbաJ�2_��U��=�Sʗ`.���?-���Z�������B����+nkz���Ou��7��什-A�;���s�
ym��}�\PT�YD(Bpf�vW��!�(�����I��c�6c���ͨ1����!�Zβr��'j�ߝ����g׃��xf:����󢸘��R�'0c�[GN&J^NHM!�P�R� ����c�@aV�,2���}���V*^�M��saob������\l8���g�������7{���yr�8~m%d�ݽn+�?����V(�Cpt�؁��*@�ET��9�<r!��_���%��p<|�v�>O��L u�)��%���(�7���JVd��a@���7��b��,��c�������s.�컴�{�W�q����������ry
�Y�����.w�uG#S5��Hn�����y+���G�5~�9����t�	��7b�������j���Iz*fO��'�Y�3;�2J����T�*�\�4Κ8W�G;��q��K�Ջ����x�!��
��rY�C҉��2q��R�N��Bٕ����z�e$ˀ!��D���t�ND��N�y&,�N�䕷P-Tx]��˟��bJ|d�0���~�䲗減�'54��/׿�~�=��O�ٛ���ɛ���������ǟ�����������q�M{��;(���a�'��oPѡXV�9��f��Sp�@�~�E�^�it�sp��!� �#z;�x΃X�Ц�ᣏ�����.��$
@�[�7V}���� 8Ұ�08�ĸ���O�H��v:A�6a������jG4!z&��>m�ܞ���Q    �I�I�?���]+�����Z>[������4��!߱D����.q��%�t+A��#@#w�f�"���)�Ǡ@�L����+�&�+��	�A�;��p9XS�)�[t���g� K'�������	��y�6����P.�O������Ng����ONnfo�c%�Q�(vd�1{���`���d,!
�;ϳtrX�2.�Hd~'P���A�ن�bř�?��4p*r�z���g8���0��t#F�I-ue�M�����u�Uh����b;��Vё��'�]e�*���S����?~�jU�'��J��z�ܘʇ'�?��B@3O.L|p󎢹�J���L�[Q(T�2*
0r�&��@�cʤ��W�um�7�!I%��(��h7�yt(D�a?Z�+P����ח��kIkHh<�P�!���@[�Zp!N2z����Z~�	���2���x��c1��{،�hh��
R�
o����_ ��3�2_��A�8�11���OA<U1�DQ����L��jy'�1��-ɖ
����|�3���֟t�p�kR�m:�A!
���E�����t�-
���n[w���_����YG����(0���b��?l��½���b}��_?��7qn5��6m��0����	�J��rx�b��'�W�hr���Ti�v��.����2�D�t���/��(N��cR,����[�[x7��VUj�dS����`�H�q���c)�Mlb���,�F֡�OWA�����p!]Fh)��'��^�JF |	�s%e�rBO��%%>�	l��&��Ȅ���f�Ь@�5O!�&�$�^V�/tv���z��"����/�����ZL��r�`��'���f:��8�k�r���3u��8��>��ڙ�P�BRjw �@��j��J�ހ�Ҩue�S�VDwYH���%������ׄ�j�<@�-H6�k�f|��ȑs���D���R���{??z �Е3>V9?M��TrO�?y�|�;�;|�Q(�5�˖�S����e?�E*ED<��ʐ0�t/H��]���I���ܦEs%��v��a����b�8?o��O?4O�\]-�^�b��[⨹���zǩXI!~lqO�י�׹���hx��Å�P4U>'�䇠�
�rB�/����a?k�K�d���c�p�IC�N�`9�z=��ϛO��B A����_T�ɘC�����U���{�|_p�:�b������ӓO{\����ѹLC�'n�}'��.~��A����w'���~��?��W��<��w_z�Q�JmQ'Nz��!�e2wr�3�L�v%���#x=3�qp� ՎM�� -;4]xJ�d�!��y�����Fu�OGG�H逬���ⴿ�WYtt=txG!����˼π#��E5���9`�a)T��Ţ�^�eK�a�_��u��b���[���U�ɭ�&�xߎTT���S��>B_���5/M{�0�f�E��	����[���Z�m�NY���*�:��]�� 9D�.FV֓�=��:Ġ��A�P$*�n��#M��$��v_O�|1�V� �����*=[�R�F�����$$��G���hz�ςx�.�G=�n��_ю`Smf^�Jg���U�ym�Ƥ0]d�	k;d;�x�S��JZ�Me�RU��3wu�4�E��3���s�fQ�{*f�ռ�����iG��w��;Hb�:��)sht�%�'V�+�,��LR���zI}�H�\F��6kEo9��Rf��h�qm]b��F�t(~��oKD���/vJ�_�NT���� �����Xa2�$�h_5l��-~��YF��I���M��� J>l6}���L\k�����Q��F��l5���;9�� ���]��$�1cc�u��zQWNl_���T.N��Mc���0��X��.�z�TF���LF���He��.n,eY�T�p��06�B�SD)��̨���1�QHk�$ �T��8!�]C2Sl���ʐ۝\W����i��+��H��b7��o�����M茑~�)��,�G��k��ev��T���A$[����,��_�;����d�*�
���� "ɐ+w��]���@��H�1�2F�;���C�8��\�D��dŏ5�/2$����x�20M� ~�$ʬ�"xK	ub?*��L�� ^߆?����W��Qc/�v�}|%��Ò�D������)����i.�[5�oaCj���-;��'���!��[�c��*�&&���.*&�j�{*[��,�P���-�y�P&��F+T�8<�� g�j���1ɹ���(�Gi�n�k9�<�W5%�y���A�eU^�=�����.�ލ�6d[LC��'�;"����^M$Y,������B�ZR �V�V^�n7�r��g���~�(�'�R����=y�'1=��＄��qz��lg�����F�'�l?�}�r)�)^i�.SA6j�ୖ!%6(d*I#d@	�$�S��Z�[$ZJ��S-��]�j�8��E�����k�#���a���~��~�/>���\^�}���Ѕ�|�j��;��<;��������l6?��}����]F^ܹ�sC��H�ƣ'N�/4M'0H[�ܻ��ϔ̓�%�ҐQ���=L��A���e4��|�G{C���Ǭ�tʊ��M?)d��E���'vT��eK�a@t����ȉ��;�8
�w����( �jꛔl��3r�3�SV�R�GR��2<��Z&Re����C�G�����E_~#E-��C�%Em�Y����G/&n8Mm��<z(,�֧N^�o��
�ytC��o>��0�И|��V�L�\26`D�����Z�!
��?m)�m_	/�H���R��8x	o����~��i�Cm�=Tݓ�O�Gw�������X��,��KyN��� ؂�� �&�¹��$��4@��YԦ�֍E;Lh���ȎI9ThsA�:t������Ze�áA���lř�}R��?��E���T�Cg����O�W�cX��������;��s�w�� ϻ������c�ҩCv;�`��&�z��t��k3k3�zkk�A��|S��L+P�N�,�I�:4J�v����s�>��d|&�������9#Ā�R�p�/7����l��/�`��exV����Ut�geU������.	mC���,P8�2D�7��t�f����2+B��"����f��Uʮև)��$no[��B#Fc�fnQ/r���9U<� �����f��[C� �q�m���P��2H���^�4@)B�	�L���d��~	�����@�Ea���	����n*����.hY���w�[Յ��z�ռ�3�+77��:�*�ߟ/�G2���E�h�����i.����K	"kT�^��)?8��8��{Q�Ĩe�_.������bs&ngy%��e�w��ns��\��,��������p ��֌Cu Θe�=�
�������P�0|h�#Er'�-�vxNv���X������S���r���!<ؿ�A�	'�ћNZ�X2r���m�_t���@u��e�p�B�N%���n�L}���6�|�P��>�J�`���/��B�<�l�̓j3���4�YOǩ�h�0�63���4�MÛ?�9�@��ʌ[��ҭeu��.(�CeƇ"��#�k����h�Ӝ�P� LC��A����	AY&ߝ�\�GM}5;����-�)���-��M���/7'Wߝݼ��{y͟�Oٜo������l��e�`��~8xt$s�Q��Fj{���<:xԮ�ܡ:�������9��5����ы��P�������m�� ��r����G�=_|���,�/� Pb�����[���8=�7��gus��x�S��?w_7�4�yZk�
�hI�+l��F#��Z��C�~�/�m]��*��S�ej���.T���r�#�������#o�;��<P�>ߝ'��:�4gg�?]��\����7�yʭ�țw2����1��n>)s�n>Ɠŧ:�ڛ}��[^�1c?� t3�O������9    �y�����$XV=��T^	ut�.�#A�؎�2��߃�ŉ� &;h��_
4����8>��@h�u��t�A�����3S��wDލ���n<�d���p@w�F�Fh%^ �.���n��ā h��S�1�ޫ�a������%/�Y;H�l-Cq�ە���c�����׾3�"� jT��*XE��+$&�Λuz.�Ӱ�!C��D��$m�0���Y�ٮ�p����\�B RV��*�{�m�	�9'��I���������z��o��º���6�/�2'�����ۻ�h/HSe`�NY��ȖIoe�EH�q�X����~��#0�8�)� �7��G�,���d(��k{�U���O7)���_�$J/��?�����|s���_ͮ?�J�7�n\����������˫���_�Y;ծ�/���8�BQ�ճ0�Z)n��%Z������Cqa˔����` ���6ݰ���7���Ƽo��&I�x��z&n�(���@_��T'jM�18���3�wF�Jzz����Eg]a��x�l�.��nc��Z��fR&����������A��/��{��ۮ�C �>\�	/�#8�HG�A=uΕF��_���|Φ*����6�wRO�?'?
z�!��Nvn�i��<�W"K����q��B0��$��RR$&x@@� g�� ��Pg�^29Ȃ�CX��B��� oZ(\�)�n�ݡ�ɻ�R��v�yR�d�J4`���:���Ӈ�� ��=��^�(*ŌzԪ�Y��䛥���	5�4��@\���*@�h2�Q�yz��)!��j��v���/�/Udϯ�W�Xp��g<�$y8� �fR�4u���\��()�In�t�ng���
ތ��}2I��m��\�2ǫ�VٓK�A^_m�Cya0uƢ�=�T䄡I���iX�1d�u����d�SU;Bd	��-��Eq�+촉
�עԉ�8�X� �PA�Ul��O��N~ؘ���fǓ8������:Qw�N��(r�q�;������X� >��h�ɵ#��2����9��a?
}h���:q����_�')�B�r~m
y��"�hx�3j�
L��VՖ��D�1��̣�4��aLx#��3rÀ/�H����q2E�gEv-a��$i���=�Js�싎��/#>JjcΈ�@�'t����	e�#�J����@�
vH&+��x9rb&T�&�_AZr�ʼ��]^�+vm`�:2�>Pӿ��Wp:lM�%:Kl0S���������b���/p�9�X�(��Fѭ$ۧ����}p| �h'q=Aے)E��ےoAI�Q���B���-R��A<��.���h�(�2���z_���nO���7��_ҍ j�|�1p�b��U��&K		��w��[�0��C����3�H�~�*�8V
��)��o,܋��j�/R��-S�l�B��Hq�����og�Z��ly�}��bv�5⡷��K�y$X���^�t�+s��\�Ѫ yf+-�9�k�,������$/�#a�$�_6�7�G��\^��I����\�A�i�Z �����oj��v��j���l�N��d���5�m�Ur��mf}#�׷7˚���8U3թr�ٴ��K�Ƶ��5C4˂&YOgMe�+BSM��ZP̛�y�C6�.���9{yc?�\T�*�m��<��X4�t���e� �]���C*��jj�E5K�����;�]CKs"��q8��N�hT���ЀJd�H��nX#H��e�#u���ۅK�жº�%���$����.w��c������%:������	Yˋ��Շ�����������t����#��B�;��+a�Ag��JI 1-dS<e�QHggT�%�%Q ��	��UaQ�7�6��dҏ�<v�3��ٟ#�*���Jh�I�V:U�k
��AS6�^��#}*�x��&�,r;�(���}q�s�|��1[�����r�Ò���sK����z�p��J�.H$��(�1�f��[�9@X�*�Up���XQ��;�R1`(�5Ԛ�ZU��|�[�%�/��]�Z��?z9�r��1tl���! �ۙ� e,�U���L��{�d�u(�Һ4�tH�@.`��'><�-:�N�}��$�H�S���@TU%=K�7i:�w\�ݷ�J�XW��|�Dn�j��4~>�(��1���L�mf��;�v@PT/B�sm�!�}RfH_I<��{��׵�^����봘�Z�g�5���f��h���4�P<OU�EU�����^:�C;Pl�A|��Lb����v�b��d��h�~K?��LRJbt�������ި��)��\h��=5W�r=�	9��*�y �~�����O��\�r�bY&��(D@��� �H�HU�����L��B1`�U��R��	(ts�l1�]�J�^��Nf�Ĥ�e�Wu7��x�[��e�� ����lO���0Ź�Ƚ�E=2i�c�O���'�]���2��oA�H�uat��LW��VS��6#n�GʑyK7΅�!�}�]w,K{..�O�X����cx	6'�±O
}1(��е�E�  +�G��2�ȠЃ�|�zŻ�]B�6-��lz�?����4Wگ~��\3��;6�Hx/�����$d�����(��̡�
�'�
�����Z��&���	gyI1^x��ak���C�u�Sr1�~�����@��Ǣ?7�1���̋�u%�!���\��y30�Q��lD(����rjȳ2H��=�� ۝Cp7��؞'7'�?�n.�F��GT�f50(C(4s��	�1B�(�t!K,�BAQ\�c9��K�ӰZ�Qְ+i�8VLؚxc��A�����չA柶y�d��*d1#Z�Ye��;C-&֘�u6o���p�8���?�8-$�˩��"�����<�}X�̆��B,�K#�����Fb� C !iw9x@&RL����4���(�X �
�H��BW1G.�3��>�� ����}a�`��tZ{�صx��1T��d�qZg��,~{�.S�fM�ז���纪��VM��4�u�����M�S���S��F��4�Upsq���s=d���$��,TA9S9�g���M%�v:�������v�8YG;��n�7�OQ�M�����Gq̀#�t�WJn�/�Z�o7���ʐ2���;tbCکm`YJ[�2���n�[-_k��W� &��".�Ɨ;���L���~�B70F��#�%�R*��24��G,���f�b�j;�R��jI��-L���o����)�˫�⼋��ȊDʸ%B�F�H����k�fGb�`W,���7�i^�hI��*��l~���h�Q� �"�����uv{p�=o�B�X��d��xR�?̦_�ܾJh�6ޏ$�eὊ��~��^�V��)(
Ȫ�I���O&u�W�	�����&q+�V���ȸ��1@z��x��&j�Ղ�4�B��d�oCDF֨.yU��P(�dAbAшC}��B��ݔ]ڤ�*H���J��hw�+��&w��g�חg���'pjΛ�v�����5�lT����&,�KL訂�X�zv@�!ɉT�hr���]���jXmc��bTike<���F�MI�;W��t>P\IaJ��l}@��S`����`W�8��(@bk�����eLivީIn��UvKL���*����<0�ZW���ӳ�����&�����6YK����%��WT�����V�T����"@����M@Z�f*K��3���Ct�?�g%�7eU�<G����j8ۤI�]��'U �Κ�y�;duq�#~7���=56��T�e�X1A�l��a��+pD�o�I/Yb���d\�H�<����|q~�\]//yn��0�:�	
�ٮ�<�vb�q��5&��k�{�yy7�V�h3s`��+YSAY��l*R8�ǹM�%	��;l�*rg;��n�ʷx���O7/..�߼�/���o����*ݠc%�����+>,J���`�u�2���DP�V�>�*�Y��V    ��ꆑ}��Hns���w�>0h��qߔٿ��X��[���~�ܲ#��]IuP"H7�"e�R��u�X��+� l�.Q,��*Q�
�q#S���=�"�@�������z����Y}>�F�%j�8��PHgC�،� �K]�$1r�o},cξˀu�2:���"nQ
�sK����z�.*����BRqĕ��L[Kr��?8al���:N�(�r�)^}^W;�.N�a�� `/��U��|=��,�jj����e��if�|�����&���˖+�g��*��fj>�.�M3�v�Ue��y��ƦB��L��4��^�8j�R�U3��a���l��쟅j�5p�؂�Ȱ�:4�" �9=)x�|"��<���o�|RƏ�f3;��K4T,��� h�u~7[lG��Ȕ���������Lɧ��8nD[�o�(���p��ѥ�Ъ�ȧ{�W�'�s@^V�=J����=ȝ�,O����Ǡ�/�9i�����J��B�}`j�f��䪩o�5q����c3����b��*Qs72��^eR7�i�;���i&E�	~:n����aO�8�!���C&͗��ܞp��)9q,��T��}�x��2�����S���Q��jtm�C0�#��bpz�]���C"Cf�ܐD(�%�#U�qiG�K�3#�as��s�3��_�=�|{_������ڇ>�<9����q{�X�a���p<�H���U�\�"2�g������wǁ�Ȃ5��\���ԥ��,��r���y�q�A]^�,/�a�	E���ʻB,�p ���f�	X_M!t0m[��i/���<R�z��W����OH�s�}kc��&Y����줙�?$�@[ ͑QzP$� ��� IFdp����X��KJ%:ps�2:~�`�P�WSV3oȚ�e:m����S|�\2.����W�	��x�t_����w��8��P'�6�;�4�A�B�:[}���9����
��#����@)t�+�Vo�7�ML��|��ٴ'w'C�I��!���&��7��X�VOZv���#9���A�)g���e	�ᔓPx@LlQ+�p�tPE�IR�0��:�L���k;���`5����c�O�	,w_�C}>wt~u}��8l?z���b���`bQ�3� �Hî,=K��d!2��y$�G������wtʕ�Ǧ�o N{�j�/j�������f	"d�Z��\.�O������8g��O/od�{��P#������?z�G�ݛ����ӧ���{��
���_f0�XОP@!v�A��@�@�F�6�kX���q,YZ78"%ow(�$�_v�������<_Λ��2Gbf=��~�;�6�,v���m"����d�&YM.h7����:l!���\t�׍n8�8?�h=��D�1pЙqu����>���s�|\`V��O�]�;����^��.��a�Py5�U��fU2@0Z�f��]m����_X����: $���0�Nn�\�^��'N���#RW��� Dk���EP��`xl����3�l���A��7�K	y����"ly�e}z1�� 7�U��˽�#AT���&Y������G}�uvG�+�H����n���I1V��YЀ|0�B?��x��$|�,���j��ȉ����~$���9o���*@Q�ͣ��a��t:��,u-����z�t�<��oJ]6�t~@�HM̅GqS5�vr;�����[j�N������
F�i
�n�5��+���r�ÁE��I���dK��\E�YXJ�nu:��L��)_6�r�<]�_^A}vyQ8_[J+�$Vʱ� ��VN?v��4��?�!��U�Kf6!�	/tWeH���N�le���ʪ�~$��2�D�?�9D��Gl�DiH�n�Z�-���U� x�׬"10_dmtF�eK�Zt���-
�E&~��x�(�ڏ��"w7�7�wސ�����b~�<mE��Kp�]�(��6�8��޳�"f�ĝ�}�=��]8r�~X��p�O V>h1P��2yV��/��,tD��WS�%��<��� �`���nyq󴞝��'�Z�q iȦ����Dl���S�qaZt�qܲ̭*�CZ�Le���_K�n5\덴4f#�-�	�{�ۏ�ĨNF��t��,!-��ZW�<�hRLwB�o�\Ʊ�b�#B���ݤMt��B�l&!��n+��;½g���M==���,���|#�0��0M~�mm��[y��|v��/����f��?hp�gz?oz`�DļQ�n�qx�KHبh�0��~�xug���[ʺ��F����]���#����(΃v��"�Lb�2I�9n����,�Eѐ��c���2��u"��y�5�
>��D?C� ����w1�(���\#;; ���H��n�M���EOkA�&ъ�D��cӥ^j���J�z9k���ѧ�Gq�S���D�p�����KI"-�`����$�C�ۣ��7�;OZ�
v�β��h�P:�R���� )��d��G}5�I�+�d-���@���{�?��Ԯ|�]�Yf�%���� �:�������*���}td���4�FU���hG��2<̗���E���L{� �],�i}���`P2�_�]�c-=Q|�_�1;:�G�ˑ 4���˳榙ap��H~�Q�3hT��,˔�^'6c�pbH�H���`
�^��+�cÅjHz�7�-=G�`Z�'(�D�3�NV��o�~���ˤ��zzv�\��-`oIn���(/ �Q�^8_�9�Q1�Zb\
O��D*p�2|Ҥ.�lH�zP�̖#�ٝب�HZ5�fXoI/Dʺ�M}��Ҍ[��jyv:������ �\���H��rk WZ�7�A{�}��-�����l�\Ԟr��
��������lu[Ȼ��Kv��^]'�9x�b%/+7���)�h-l�Yh7@]ǻ��Ѝ��1��[���1���?�R��X@e��£�S��o��
�a��%@Dx{��ѳWG?�<�6��1�ũ�{�@��L5���f����RJK�pCv�Ņ��C/3��h�~Z5�m��
��ʭ=~ߠ��r�<�����o>�忦�0���+�q��M{jb�@s9s]gE����Ü[��5A,��ѕ4*��h��L��4�GrS��1��s$!a�[��inm���;�+���/��_���7�@>e(ඎ�g|e� r:��d��fBH�S�-�v;0=Il0BjqVS.���:�����i�:��ՍJ>m�N�h���ӧ�~�;"\Vo'�$KX��<9�Ѓ&�5�_'��F4K��H�0x0P=��d�U�Hђ�60�Nē�R�d����?��gl_�BZ�J;Q����>����-�l�0&��dAlj%^��=Gs10	�!R4g�6|�a�ī�,ԣ�x�tk��b��<w@�S��th[��Z��o��W�x�:0�K����9I��EI�$^S�<8q���*x��C ���mMvh��J�v�/�%]���f{�����EB'�ó�5��o|N���w���>{���m�����h��Ī�*����ձ�?7�+�d�y�>7���`n����z_�m�� ����8�S��i%BB��VT#Ľ̸Kl�/h�YRߧ�'<M��������#1����X+
M���"�k�UH��39����P<�c�AJ�/�����G��
���(�����62�Fiձ���Я#��%o�?)�shP�&.e�.ڱ5'-w��	���n&4>0<�S%�P!}z�\��Y�X[��t����W�UFT�;��(1�іr�>+����@7��^�v��m�)'����
����es���./.��؎Ɇ7����7�['N,���b���'�5�̑sn�%#枇�l�+&"@<b�$�N�,Y���k���-���R�\�_H��!�F��{%��7�ޚ8t`K�������L>���T~n[��_^ʍ�>Z+��j�:������j���Onx����!�!c��ʐtJ#-X7w<"WOୌK���    �m��C	�MW@�ް�e�>� ������������f��h �S��a��\��ja��|F�ȼbX�鍊 FƏ���ޡx�R�Q�	�g�Q��SK�
��J�)GY�-�����8	�Ue�ޑ��wt�㯯�^�,�;9����לb\t��;xA�p�1��UW[�]�����OE2@���Q.Dj!�,X�+L��o���4q�T�*t��
�ޔ߽l�@p��u����
�B�ˈG��1E�y���Νo�O4 Y�,C	G��WF�v!=i��؋�m���
���4f�{[��r��5oY�'ˋ_�﯎�ϟ�p�cs}����/�y�W��OH<$G鋖 \����%9�0��+���ES�L��+���UI�_�̚z1:��[䁆6FlR���tw�}?��F�M����a���yP(����`P.�䡝\u`�Q�!���үf���T��i�
Ζ���!���Hq*wr�M]�	P��r��� �I��yPd��C@1Rn yw�6�����H�Cf3g���(�J��4�|�8��K�{HK'ǃ�;�K�'q 8>�.��mtր���H~.y�N3J��o�iC�0��jB�/���\�>��O)��������O7�g�h��_Vc��7>�AU]��I����A߼DB�}�g�>B�
�x$&eɺ+?��V�F�(�����.S֚�2�e�^����V�+�Q���6��l2I�ҝ\
}�8���ջ_��O$;���������'0c}	�UT����.,���I(����
��(C��ت�K��N>8�'�r�x��g���>�8�^^�6���5����d?�U� ؏����B-!��h�����"W����+xf"��������R�Y��1��R-@N؂�ɉ��ڪp��.�3�N���_֘���Mf����T�i���y�ɾ��8{S��$�X���u
�UY/ľ'�z�w��Ջ}k�{�w�l����[m��1nL������Y���RH�(2������_ UI����4�<�ѦXZ���@�`K�\ޣ�H:Ö_y�L��K ����b�ay|�~>۸�~zVjwd�>e�7�j�H��q�r�)���l�������G(4��%��m���P�" �C���х���:Z��'Ə���g#����F.�v%�[C�zu����i�����Hy����3����6��u/ٮ��t<���H�����X$}Ok�y ��#)��R���#^J̅/X�yH��+����R���mE�V6�	�>�;d�~l�7}�w�R���T>��_�C�����-��G��űr ��v��Re����]��'��U��Z���<S�i�*e(.bJ�&�����Hl?���Kss^���kð�3��a�d��QO��T��	Lc���l��R!$��i]Cj��\�bʰVL��d�o^cu%���;.�}�����#�p#�x2�D6����x񳩾m{sΎSn(=aʗ�V�rS��'����I��9����������IS_m���7������]���w�r�D� x�`�#�g��$%n$�^�S�{&�>U��υK7)6K�����![&2"c�R����K˲��F���V�,!���v�4T�/?ܝN�����|�������=gY���r�U���*	��w��۟�G����~ ��br�+f����e�t�B/��з�rw!Y���(Ң󣸔�:/c�+�6[z7�����ޜ�V��Jn��W�ѿ/W�;>��^_�}3�9��v���K@�p��<��gէ�*�T�����M-O��=��{=`xeY�*�n����Õ����x�²z��`�m�FP�T�#�-��3�5�h��s �����^����}0�/����Fxb x�!��_�iw�Ao�>��족�ɰȹ4���c�ER�	}���I+'n�<ֱ���b����V)�@�S�6n��绳%?޼{���>����]&;�.�Q.:2غe��xոt�& R�H�n��J2I�+り%҆�k7[���R�a҂�ml�:P��x�<���Hc<����H��p�����δ�3S�HHH�X��rq��ƐHX���U��j�2��l#�W������]��O^�>:�^n=x�W����Hs�8�8���`���%��]���O�P��|��];L���Qv�N$���o�r��w0�>X4�%
�\G����[6������ �z@֋E�Ɓ����bd����a���
��&̱��c]UA�9q�Hňm/S�`z��-[굨�ڮ��8�w����T\.2>fq�M4s���~�US��4�Z�i�]���<k �}=���~�ӝȔ���ƅ�&g�qݝ3�>���z��t��L� �&�G��B����_z���$�PV�������%���/V�'��t�^���/Ο./n��gg��F^�<|�r9o�.7�t{�t���{c�!�1�֌T�@5�t?��ud�	(�z�Xe�����o��L�ɣN�⁁�'g�Q(�>[����ȏ;��v���<D}�~_�,OT��^F�{��F}E2䪹�p���;j��'�u3��/��ϗhS��e�����O��~�^z�,�������G�W��#���2m~��Z�ǳ��겾9��nTu�Q�K<��H롌����d�2*�Q@���n�<�2�	���0Ư�q;P3�r`6� =�(Pe� ́*6ys�r��	@�Ǌ�]g�X��A�U�&C�n��:c7݇<a�(�Isv�\���=�r۳�e�J���@���|�r93Pk�J��(:H�ۖd��M���#�}��+l���|б>jf�No>���X�����ط ?�����r'#����{���|�hǉYn�
Y|���&bw��G���a����T�O���@���J��-�x8fr��h��3�[�e�Q9W�F�w��Q��E�8�N�#�g&��0�l�+\wo^���Z���mø����/Gk�%/Ѓ?�R
�}� V������%�yC�i��k'w6��43	ee��*����!#��U9ǘHic|P�&���_yg6e���5�Z�6�-CKH&Q��6��h�ی8o��aY���I}�����ٻ���_��\,dRֿ�s��=y�p�[����B��3X�S�X1�n�]�-�v�B:�b!�\t꽡~-�g2�Dnrݑ;A]$e_ ��ӛ1������1��war(j�Vs1\�I�o:�+~��ww���'?���}5�u�qc���Bd'{(�xhY�(�:ޮ�ɖV%���7�EB>���b��%z%d��*�U��ǑYlǟ%XW�/S�I�Cg=��>��@�n��k�'�uS��|�|D$����;
U�=�A��%��dQW�氵��ncC�]���n������؄>��'hK@5���T�B:K��m M���9��ۊ�\��ɨ�5�����bŰ�e$�ؾϬ������:H ���s���g�6X�7�����u��?��B�j�������Ӌ�G|d�Yb�&�2@�y`"MF��� ·B��ۜ����'�󒈆&�M����q$"3�Y�c�2ǁ���Y�Z�m�1�2d��g*�L��oOW&��)3G*��Kҷ�k ^+~�迁�d�T"%�2�J�9R�Ŵ�|�"D� �	�%UB�vIN&u'{j��Xbi)�G��f�B?��g/�������÷C�
��6F�Xn��d ��H����!w��O�ha.!:����ʔD�
�~n�?Z������v�ws~v*s�7�|}���c���X�F�"p�GaD�@����W�6��n�"n��6�V�D�Q�
˔�3��L��SF�!��l/�F�P�l%�����e�=MX&�O����O�
��;�^�~�x.�u����o�8<d*v���e�`�H��q�;�J��"ń�9��LĠj�##U1�L���V�Uɱ�fH�xN�7
���蝜�d�������8遄6y��f�+��޿�U��Q!0�(PO���
KE~�Db�B߁9��h�    ����
��n���G��B�(�(���S�2;P��*6�D�Y��kz'Sf����|{��u4�u�xկ^�Ϳ��yb�$XU��9-�E��W9"���Q".��d��̣A�!I�����V����J](C��y[����O��޾��m����o��@Ьc��טB���h��i�<����
�K����%i��
$�I�`P���Z'l%�E���t�rV��Z��lq"99����
�� �Ѡ7n����������Ƿ�ܳ���S�v���÷9�O�z0&A"{�F}-�<*��r:����5�s���#`���R�G��S�3�� �����*+�En&��6�-.$t�<vق+���X��r���\3��q��U����V�IVȐ��i���� �Jh�(��p4�r��<�Ǝ)�[���T�I���H���f�� ̡�D7f�E�z'��;&^\��M��sHVX糜D��D�(���2��m(�W�HS¥�Pm���㢙&�u�BEiG�;C���r?Mgo��7'o������<^�_��G�~�����9�c���"�nb�H��I�!���oY<��FA�$���ɅT�4:E>��E��z��Zc��`�
w�P#ehG��ٹ��S��!��2Kd&���єɢ�w@�g����P��hE���=��e�Z
hT��Ʉ>�:l�'����g�_������?t�s|��΂�n'�a�����a-�A�n�Y?	�WbESS�%f�i��%�
,��m���IxI*�
����`;��1]����(�ɛ�?C;	����1�P�(���S�^���$����`ȭ0�L]i��x��"��<6��������Cn�Ը>���k0跦���rkc��*PP2� ���m�U�0�� -�
�y\vC�eO����Z]%K���b�]2i,��"��g4��vY��ݟ�a�S�]��t!K ���#q�T�������ӧDP�)J��b���!��n�ިX�)�=�
�!h�se`�����7��!�M�8v��S��~��Ş�=�m�۟/�~?�ty��j����������+Ll �GBZ��f�<[��'���UH8K�(!=H�8�����2��bg+.�EYf0��r$��E�O��l.�� `�ÄJ�b��I�A>Vn-��e2���oY��31�	P��P��$s��}���Ht�=c����̲�=�@#�!�H6� p^�c����Qr��ivba0r�m���#ӰA0F��:��E/ Ò�����􍡒U'>��p���ͼn��|�|[�V�܋�?8�;�%E}S��n�4�83�E@��x@���2��;1[I��->8�B#8��2v^Nƶ3��"�p��٧�%3kEh�si��!��[=��<OBs���������a�m6��Y���m�� 9I�����j
AQ$XBj�R����аr�:������MK���vR+�?ߜ��ud#��	G"�8@�)#�Z$�2iʑ��7��0�o��u�mêK>2�̸5���3]���$��s��B�>�NW���y'ɫY=H_�f��g2a�i���&/q<mI�)�M^!�RT��fQg���')7*����=]F
A?$�R�K[�[	&a]7�}��'�"Bw	�<�9l�c���*�|�6���h��՗%����O��o�_c�i���*��m�l�(�1��H�AP� vt)����So(�.�>IRPToG
����wr��tL����%��mJ}Kb�˪Z&�����Շ�`�_�O_]}8z��)ｊL�|R�]E�����jiPx>�E�O�V-F��e� ��r�͉�^�R]�v���
�E�u�Z��o���ăB��ry���18�>�q�3��@�hG��C��w�x�\Eg��yqPu$�iѽ�2�,8.p<f���Jg��^�L��P�ݢ��Q.�� �cu�d1�mur��ؑ�g0�qy�8
�����d+	I��򠫐�S��Is�~&����X�1's}�/uT���*�ѭ�l�Om}P��l��~n�i�GF�eӝ�%�AP�m���m�Cݵ@��{Y���ao�Zi�I�e����f��g����Is%Kd$Fm�B�F#%��$��NW+� )˔6�����fqp[˔-0	�/%՞�N����@���e�4���R���݈Kw����]&����1�����i�υ��x�vx�XW2�@^z�:M\m]9����Cq���	������1�{�3|o�4WV<Ta���q��P��8��78^2�:һ��Je��#�Y���xȮ�0l�@a�<E���[�mx�bi��$ߑ��;J��"���Kj����<���>Gz~����G�}��z4��I%;�a;���#���U� �z�����)�����:�Ut���$�BU�c�D�n�l�#Ą/�d�vXޠ���>�hv��AJ���n�4�������0�?�(�_Ǻ�s�>��fr!B�k9_j����FQJ#�I��#[r9c$e��k�%�w`�8�*P�G@��Xrr:�;���ٯ[��@L_f3���.ࡶ5i���~�X��Z����c4:$g��*r�P�AL��G�@��P�7��?����D�����GƠ�{I5f�|{� ���wk�5=!�H�3�������'/�/��<���;{A7��W.+�5nM�"G)�x�e�!\���k?��2���kg�<��:��Jsa �)[����b�B=1ЃVj_�<'��A4>Id�Ig0�WQ!]G�5�ٙ�@簑�q��j�� ��׏�G/�l=8�`i]a��#�Tt$ŧ4<b�-��(�X��{x�p=�</����2.Kvʀ�]^�qG�� �{�vD\����"OP�1�L\����\<!jI_գ�У=�@C��8�	T-Cd����+�Be�p�����֏N��Lܗ�U�C����Qn����ٞn�ͧ=����:�O7N�&�%�u���BF%U,����H�4�qE�;ubE��*8t2 �����76w��GU�o�<U���X��1�{���1��g�2I<<��cz@�K�eEΩh�%�UY��iOG���q�-nֽ�c��ӧG�a������#üA�6A�a���pf�=�5(�����lX��M��m]�"QA����Il*�R
Ġ	�� E����r�W�ˑǋb4��j�.$m��(�L�8$n<� Sv
,��{�/��W����u��7�0֓%d$d�8}.Y���&��!lW
n!���"�B�#T̴tD�B3��h��-����:�$�� �a��1	5٣�5��D��(�n#?�U���������&�8<�I��Gz}~]�����,@!�<8�������Y,�Ϋ�I�J��Ϛ?�s�?(${g͇�����B~����E}��yy��ظ�fC}l��ז��X�Hci�!��o��5L�wǻ��%��d;@c0=41eh�7y�-��� ME
��w�����-�+ۍ���JA!:鹒;I����t��d��&8���_t�Q�zL�	[�M�����eh�W�j*��o��x9� ���ĉ�f�Y���Z|y_��GO~�/�߮��[��'}��0i�&1��g�_R�zXCR}H�A�B�+IדgX��v���	p�h��PT��l:��l��s�� �:�Q4�d��Y����㿽旍��B��{�k�$���ʻ��1��HR ��Y��z���)�X�G��H1u��t���@>a�g���L�~�|c��=�=�	�C�]ZJ��ؗ`��³�)�;�5�l����>Ġ��,z�aqw=ߟ~�0��ŸL01�:աs�/�:�)�,�I�,h �J�Q"�2KX D	~�^�%���ABQ�L����`�&�Ld��� b�����kS61���uD΋9C$�x۱�x�a�=���kT�>{5؎��b$�G�І�b�ˡSY�(�Q��̗yJ�d��I!n/ݪ�Wb�"���W�.hO��w�M� �ut0!-�;1�?y��f	    ��g�M3�Rv�r�k�pb�v#�2�s2H��i��� �(�j�!5}�p��ϥV���)Y8e�8Fe6��ؕ�~9�%8|Q�2�r��B��w����gM�����Y�%�����z��k��D`��Ժ�������i�lk���ʫ�}_�� ���=
}�s$ ��WX+��{�{�� K�-��:�7 ��%�� 2��x5e��V�jB�C�Y�}��l	:����\�|��7��<��t����tY\
IɄ���Td�X�L/��/$b��|d���d̷��zZ��V���U��q�w������r�����CE���8yԠ<R azH�{�; q[c�Pz5.��9mI �L�9U;F�(0����`v����=�n�Ԃ�ĶN$"���&�t���Pyrs����/W���]���}s�\ޜ�$Ve8��PT�:x���P/�J�x9h���l��
�<�
]�'����	�Ng��ge���)e��,��0qܔ��T#4��@�W���Q���i�i']���ӳh
|5t'K��Q	qxΞZ��k\�
 ��!a(�1��v�׆E�׸�&@�;�a�9�Q�o��֜�tq*���8����M?�Pr��ԌBG��0�d�I�S�R��L�QT��p�
H`���"Eą
%������]�L��M��b�,M|�(d�a � ܷ;��Q<����US�̛��A0=��dl����f,�W� ���剙�.9	��d&)i�Z^�u�T�y5��p*�yd��ws<~Ց���b�{B�E��F�$k�-���2h�`uUH���AUͿ�L
�T �?GhP�A���m���2�X��.�)�+����-ZC� ��d��WJ��T�����Rx`��GP�^�k.�\����Ů �!�HTL�)r5*\!������9�kJ���fs�-Q�	'�Qf�	�v��&ٸ�nd����`�n7�%�y�ܴ��������+K��+z�y(��;�A�[Ӗ���v_0BQ(HJ$A�����s2o��E����E$�B��]ϒ'sQ_�A�0�u�Oc�C9�UOe�U���\=��Y�����iF��n��M��~Q��h��A������2i_D+"pj��7P��}�Æ�S��#�F��,����d�{�?� e/��~s1n��i����E���q`L;^a�iy�AՕ���u���:}�]���K���O&�G�o����d���� K� ���<�S�uFe�T�8k���2�����`K(I�iQ�l�^/	��S���ą吳�_4�UW���R�ű4P嗵���x4��g�������ڈ ' X�4�8n�aG�ԌHI؅^A��6q?)Q�F�\o{䱧�~.�o�g���/�N�v�g�Y�pZ��c1�f)G�Տ/���������>���!-t%2�m��Y�œ��d2#9=�|/�s'��e�҇�.���9)N�H�N1xK٪D�HLAz l�/ ��Y�6�  U��y�nN���3��+�&���*y�a(<�<dё���C�>�ؔ21<�L*�]�2K!8������G�j6��d���u�q��s�$�
{Ѫ��^���O�]���<��@ق2Y�(�3��x(��U�Q!�b]�T1!��P�41��;Jn��������!�n��q���lp�vs��tY�i���{�9"�pކLSr�vԫ0��{6���*���$*,���ȩ�>44� �o������d��d,J��r��l�.WW+�L,��*ķ#��Xn]�xO�X��b2��v��|��tOEF`���Rb$���E�������T�l膬��`a�7)R�6����(7"���jF�h��%[��lZ�A$�[��@������?��Sy���(�7��D�
Z���"h�-$�M���V1d�Gr�]��d��4�2���TP~2$��r��v[�sG�GM+(�p�k��e[_6��ϧ�c�Uv�ݼu�oZN�Bk�a����J ĘAÙ���D��#m	��b3P�(���o�C���[��	i�'�q���"
c�AƋ��T)L�Q%۔��۲'�ô�HQ���^�싱P�I��I���n�x=�,�cU���qW�����W�{���������~8�0��p�}W��_?�#�>�~>����jq���':���Gc�����X;������gM�{R����������ƙ0�z��,����$� m��I�A�m<z�O<�8
�����P܂֊�!�� _�Ȗ%�Z�fy:�k�]ћY����!K�z�\-��n�x=\����~ ^��=���E{)�Ѵ����}��T���$��~rYOή�7���.޼���o��6��~��W1fvM�����}�rh`��-uT=� 0kr_��{G�Ra�9T= �2���A�!<�`�~8r�ʩ�4����X���E!�e��c���<�"�נ<> �ʖt]�������V|�����?zٺ��7-#�	�J?#E�=��U�!�"�̲)R��8�J�l6�kJ�ӎ��?��4�z�L0ۡ���p��/z��Rc�5���`�Ё�:��I,��ANu�<z!A�UQ��j19�+�ZhM"҈\<��L���2WZ��%zv��Le�<M)�xc�'(荚_1���,��� S1��[���==���k�:�so	nq��ρ�a�C�w#c`�_Fa�b���9���g�'.X�llL`�z^T��K��,�:i���
a��[�L�ma�:������K�^]�L��g���QOb�W�=�գ�U��z����O��g[�����e��8(��y2���Hm�JT�	Qa���ܧ�ӊ.�/�{>�B�V���M>�.�:�K ��⨗� xQ�!.PP  ������s˸>7��gi�������8��h L�`u冈V�8b���Y`d)~j�$q(�`���z��"&A�#���'. 8V��	$K>.��c�1��Q=l��
ņ(�H^FnK�$m�F���'���U�V�c�������`+��S=���I�M���e/_u�'�oWn�Q��ЍH&�G�n�c�H-�7��.S� ��@��2y	�+4{.��t��n��������jy��c+�]�>�_��� #{�v��.�;�q�zꧭ>
�Qa�ڛ�<U������]��2ηn?L�1+@��	��F�$��4$E��m���iI�[]���.��W��pE*9le"�7l��R����v���U����V�N{�!�^�/ci<�v�p���N�m}�8��]�xk�x�gߺa��J�_�L�W���0��}�Xr/P, �rlLE�vED�'Z*Ɂb�Ej��NH^~I�<����l����5twl��Kw�?	�DW�o�B�L@#�P��a���X܋7�N� []�p5��7Gb'�O�L���m��ĉ�Y7�RNbRf
,��?�(��Rr��E%��=����r�&7�B�~�]br#�r�L!/�X�k6�(�"�4�zp1�]�_<���?���&��{979���t~���+W�\���_Q�J�=���hd���Pݒ(��H�Lo:0\�Q5gB�j�����@��� 6�)�Hlka[�`����BI���=��s˪!�2���6���`�X�؎���k
H��Ҟ8 ~h��~z�D��dږ�ܼ��u{���A@ ��Q�rBb����,B��b��+(fT�3�ebQ�I�K.���Y�YWF�ɑefPv|+�H��(�j���4�ˋ��[��3=ű�@f��f���)�������W��ŝ���}�q43i #If�����,��+����J��T��
!��X<}��BW�φ�K�E�r��4m4E̺�@���j�z�KbT��(s�C'�Y vn��ysV4��׋���˦��_��,' ��S�&�dV(��!
,����e܄A��X�����˗���Ǩ�k�μ����UV��)Ο����[bR\^�    ��]���ɏ/_v���럁CA�jp��`R���Q�j��-�&�Ɏ̐�qA���ӄ�h)��.6�C��Q0���~��"� i2��á�uv�&������/}O�]�/���_\�
Ŭ���O��#�h�Ӄ�0Nr�+˚��0�P��iՔ�a�ta �,ǝ5]��S�|F��&"��Q��L4��Qu�Ξ ��-��:(�=s��8�O;��3��+���7}�s��ҁ��0d��QuQ�$M,���y.x��� �
0w�؀5�h3M�,$PYׯJqM�і��8Sb���T�y��(p�̵pWtĭ(�����	�Fd��A�h�d�b[���K��@���tJ��vBQ�1\̶in'��8ҊKD����(��(�͢���e J��#��T��ak�9�<[I8�XV.�}kjyT�JE�%��v�*G��3[CDh���d�&m=���@�6��Mz�0Z���l;k=d(�E�z;��Ү����ߋ���d� i����	��R`D�i��C=	�!6]�K��2AQ�
S�O6 O���[�����l�6��E8��m���o�Dt8�V���{��1��Jۀ��3Ǽ�U�B*!�pD�ҰU(iw�R0��L�d��wNbV �^7�xgE�dT���~{Y���������z~վ����(��q�2-�H?�2��?$ÇzH�﹤�*4� �2��p&XjزN�M"=� {u�ks��,#G�m�P��!r������׆�^���ag��s�ä����>��rv�����JkXb.�p�Kr�˟��/�Æ�|]d5�F�L���8��ވ��`�,�3��O۽����-+���S뮋�����Э�� ���]�4��}�d2�e&�"�7sY��.��;#J�׫�5i��x�B4=&֌#�e��V��l/qS�J�T0؊h��7�|2@�5 �JD'*c]��.M�;�Lb� ^�7���ӊ�d�I�(F�N맦F���_������=z~���Ac��1û�2<�� %`�*� �rAiS�T�*���U��c�4!�]a4���5C�Ϛ�k�OL�
,�'��N�tw0���çӣv́<<<�j��2D����G���%��>��I;�ߞ.6���S_��%�����m&�� �1�\��w'ٜFr��ʁA�*��w���
�����X֊��1����S��̰Z� �p  ��m�Jn�������`�9'�X4�O1.)	@��3�_-���[��#�C�Ċ@z���U^ɱ/�XBy�����R�m�y�A=�8-����� ��POFU�:V�I2�ԪH
�ԟ=!b,�`�|�	V{�H�8�q�I�S8���d�M6�r�(Kl_���k�JJv����U)s^���z];4�c?͠K���y����lbR���bcr%+LW3�U�1���j�^~��_����㓿�xx������x�;|����5�Xl�JIE?��ţ �q�h3&�d���%���	�5�%ӵ�����`�Is8��إ�=`�y�좣��Y�L�9�wgϿ��g3>��|.�Y��A~���o���o��x��iXyoO_Q�*k7����Y�I����>���
)KD�6���@�O��6>9:��K84h�)���������l�	=He��S�Ĩ� ƹ5G�܁�__g���ށOx����i-^������Y�eWnb��ϼU�N�1: C�³����H&c�#����K�"���
A/r��Z1��� (.*�,]����e��U�f�K"#�Q�<j+���(��:�
e�4�Ci�T�+C�����M�E{��+�S:��>�Z��z���8<��q��K�ԣ�'���OPS'F��(^��|��_��p�e�W^��k2����m��>��׼<��=@Oك���xrry��.�5��� �����p9��P��&�r�Q�D+_�X���f�'����i4><�8��s�6o�UsY_������Ƙ�>�G��@OӬ�B�OGo�� h��� �8��l�o@�YA��7�d�����(3�Ü��,1�S&���LO�*�����F��qu�8bAmP=@"E����Z�%w�����Kr�[��"j8�ddL6S�σ><���Ԃ��5�eު��.�u��lrn͛o�͛v�d�����?����8�r�2��vVM��U׈e��4��~��f��?�&�2����-/���-$� ���P�2�A�N���}�(�Ete��-6]��$[X�M�^���#8���j9&�(�;܂u�4�5�Z�\���w�q|�T7c��d�LuP!�e�4�e��������Q�T����Y.����!�ݳ�����EPL�����rʍj�?��^��^6���ϐ[W����D\P9�*��*����鮪���01��6�{��P��t�`QO��p��d�+� �=:��1P��J��uF�+����(d,@`@eMicƍ~��ֲ�'
�&��J������w�gB����@�ؕ"~���NR�_Gv,��LA�,�����22�-#'���2�έ.#p��{.#�:橩�&���mU˔��Դ3S�}��4�����b9����	F�
��E>��@���XC^�y 
��^ᾁ�f%]�,uXk����P��+Ԗc�ߨ���#��錂��t��Ч��_����r ��hG������!�ȭ5�Z��5$����\Cae�4M'��r3��rJu5��өʭ�u�^kHf��s���P	n��	H�1H��(Mť3.;��a�0^��.�`���ǈp�,�VZFX�,�K��{e�m���%��tK�y��,ўv[p�(�G�E/��d��j[ZY?��#V�����^;��U��~���Q���U�I��9]�iT��V3���	�u�g2S� �\Y�����-��q�����CT��~iΙ��
n=�)֪1�FHޠ��C���h�p��ł��;Lo��B�m:H�z�A����\��։�9���c��l���i�� i
#�uXUr���~eY�[�����R��Ʋr�<�6M����s�$�]3�fz:3�]+{�c)t�*B	q�e�(�:��	Hn+�YBW��a��>E�6'�b��*� ��p��PN�j��7�1����08�Tы\����e�d�ù4�,��]v]Gl�<������O���V����%���W�{�*�o�|��i�L�KO����ϷJ�wܑ��2e?������iN��o�(������8��C�I]��%�ϣ0T���y�Ga�8�(4� 42�HAE��е���R�"[8k<K�,� �������'k�`:t(���0l ���G�-Y��
�6P/z���z�T��34����&�@�����D��ՐB�)Ҏڞ����¢di���@n��#R��($U�ᾨ0%(��0E �ģ"�Ͳ/����^���+�ɀ�6UO�9V���7=��t��ނS�g5��]����6��a��ӈ1Mw�I�I^�0��2�:����0Y��Ϣ�vrq��ݕ:�����w/�ކ'�qL|�r�
�i�<�$F�p�Y
#>��l�����u�� Jt)[&����x��(��
 �)D���=�!�RӀϙ�i �ew�տ���霈�'��><$�Z��䪙_N��do�kb��βǕ����Ћ4�SB�3��
PIL9!�Bah@aHT��p`@۶+�S�e�g�m�R�\D�x�����&�W��ZV��GV 4��~{�X>���0HC8S��ñ�5b�_�:/R2��l�c���ޭ�O�=AM�F�h������A����#xK~����q�.�`M$k�j���g6tǜ���1��X�]��kf�ˋ��d���q�ۋ�W'�+=�>B`�ÊJ�ի�.�����o�m-������7b >�/�n����L������p��Es�x�q���Źys>;j�������e���    ���
����h �H!,��X�`�6=M��5��JT�n��"hl�eH�E��h Z�����lq�:����6 N� _h�qF��쮸�C�¤}�%0a�K�W��ASl���`�djP&8���r�H�rշ��xK�!��$t���@�ˈf�T,�R�b�`��.J�a�2�У �3�"���`��8�IQt�=�aל���:�v����Z��/ؼUU�u�8���ɳ��q����ϟ|�O��k��T5�uS�'�J��դ�{`�,���T��Oߵ��n�bu�x��~o�; >޻*_$�$_�1fVr�I�馪�lZ����$�ber�5���TvX6������Tn6�D9y����$7!�v����=������:���̗���TMB�+/�����m�����/��}|\�ɶq��K��*ԕ2�<\��n��f1;�m�|P}{2k��<�~m}h�6�jbM]9'M�,�o�ҍm��胪�g���g~y;�uu����.O�dv;9:.S�����[���̺��+:�0�M��>�P$��aR�'��^�I K�؀�	��K"{�1*�pT9{z\����5�ǲ�7+��]����G����/�g��,_��\��w����)2.�.yS�v�9у(?�Q��[H�Q�"�zJ���2�G��*�d���A��+#��<��SLf4o'3I�&� cP!-]ЀpPZ����zC�(�8�V�l	e�T���rBq��N{���D�������rT2��>�'��6��Q����t�~1�S&u]�*'`��lV�>�`���Ʀ�aZ�	%�L��|:��o@�Gq�M���@�C&�/3*� ���4��|D����喌u���F0[��:�� *6u(|�[�R8H��Nv��ɠ�1(�UZ��>=v�Z܅��Kfu���Z�d}G>=��d��"'�ߤ��[�n#�9�eOw��{L8��b=�33r��I���J�����~�<�}�������[D?�>�Yi�<�0����E��0M�y�t�Vւh�C1x���@/�o(��l�L�t&D��)}Ġ�2�u �ǘ�4*Y*����H͗�|j��1H�\^�ա��2�;�����sr!�q�����)*�i5��麟�3%�~���~�_<�$�߷��D��A0a~bN<F�2^�k<��]#�~蜙�)%W0fX�X�x,+S���$�I�2�c_�dd�+B��~x�ǇXC(���-��C5�g��A���^��<cG0�)�����QLLd�)�S�(��#˕	%�)��PH(�ъ����G�8��
70�gS3u��`�͕_�� �i�RS�F���t�vz��|z1?�+����Z�������j����l\SY��e{$}�o�4�\�L��`ҸV<���r�,�����D[�N&O��Df.���u�sc���C�j��T���Il�8U�[�uC;���%���daV�aPPq �@RU�콓�f;��xӂ2Y���e�!����@��Ѹ�`��UG&�R�\Ղ(�ى�G��Bl.�QU�
�as��r6�Rf�����W|���N^Ά�P�>��~��s���U�vq��j��>>z9���G�o��������o?n�W��~E�'0+�?�~���S%��h]0���}�r<�.�ݲ��\��C2�sC=�< ���J	[� �ǒf^5df"2��j�+���U�}����'Dc��4J�����% [�,h#�H�蕀lע��}]��Jǰ��wgQ�9k� ���_ɳ���m�[$;���7'���;�M%�������!֡�a�ֈ�/��q"�Rs�O_��`:Q]3�
�f�D� �de8�6S�+o[���N�'��N�/�&N	��`F2�~4�Ǎr�~~�_�5�)�~�쿧����/�FY��(�YǢ�dđ���!�#��N�{P�'�1/��Y������`D��y��;F�׭c�X�9G��e+k�vb�O�ŧ���ZU�}Vi�4@�T><������d{G�ԭ�H2�R�:n���N!���(�dv�(Bm oJ�2�W�/�T⾧B�܉�`A)����Ѯ���@�dٙ�Dw�����M9M�w;�*�!U��T �{�{9�œT�;�#3�!(IET���������9�ngZ|�I�'��1K�EQ��B��N��~<G�?�:o�厔��U��dz��������!I8J>�o��S��H�w���+��V���܂J\�l�t
6�������n��v\�{�M����(ޭK
⪗�e۞�Gw>��W;wo��X������i��S�������E�i.�@`QH@�� \�����	��F�↹B�J��+9A��>.IԖ�Y��K�"+�!¹�������$��Z��D�VԹ��YP��8�J�Ut �_��G	T!2=�SLS�/��,ٖ!(

�¡�;[h�k�xx���B �;�R��儒��CJ� ��m	I%�ˌ�B��&H�L��n�B><�I�A��,�m@��j������c�k�M+�d��u��j6���͂�j��O��d�c��W��{d@z��0��>��B��0�Bqbh��C��j�J.Ҁ���g*��N1gI*K��%?�f`lI��)� 5W\@��r���2�,�bw���Cґ+�L�7�ޏ@ߞ�u匏UΏS�+�ܣ��?݇�n�pM_�c����k�=���$�"�`d��J���4/���]w��I.`�auGs�����m�f��Ǹj��>�S���-g�����b~q��N(����
���q����lB���f���(�J�������-�,#tk��q-���ZyYR@U�b0"�Xqi����zxHWgq�`b��DyN%�Z�0��(�_�kQ��Q��^V�Ze���L�P�Y�fD<?;�q8y�>���r~�C-�Po�l��-�q)�;~�ɻ���i�}.p�-���޳1{���p��6
}2߄x����(k6D�h C��P�脃N�uJ�� �Y$TB�`6צ8̪?/FqeZ_��t3�	��>�@��$���wz1^y���b�������_���L��s6Ǿ~߽{�ͱ�����ɻYx�������^�7gy�s�}�[]�Ek7�a��A.�H��:C@�t�kW�Q�{��3c����PP]���вCх�D�z��t!8QֲY������i)���H���8���68���!��h�w{��<�]�j`�sȈ3�V��F޷4˖��|-��Bʩ+{�a`g+�r����ݵ"'������"����Ϲ5��<$� TO n'Ͳ�`)�ձlCv��s����,/,w�u��@!�de<�A��78�a�%���sK�`7��*wG����󾞸鬙T�p����*�̚'Ѵ��r�Hy�X����	�6��?�$�&?�xަ�4^�Jg���U�im�֤0�e9	k�O� ���JZ� Md�RfU��3uuݶ��x��3UW��rM��j5�s�M�f[����+��g�|�ʡ�i���F�^�`Da�΂ʍ���� �.�M�i�K��w�f֤�e(e��mA�]o�.�zy&�tq_�@*yʛ"ͧg��V���c��@�t�{��6HT�}"��CD��(_5,��~��YZ��Q�?̝�.�2���\(��Z����L\k�����Q��F��l5���[9�� ���]�?�jd�1�:Um=�+'{_���V.N�o&�uu�[h������$V��+`��@r�+�*1�Ś�,k�.cU�fUhs�(�8�	��>ƪ
i���~*�'��/Hf�*)�f�JNwr]�9���I����U.�����̬HG���n*��$�"���R��}Y��(m��(�I�;�P*Zy�������a�-���zqv�NG h��gH����n I$�ƥc�e�#�d��d�l�dF ˓�q@�����Ɋk(_dH�/#a���a�
A��K�^�E�$:���u��gn5����]���4������� �	  �	�1vF�a�������s7�k~5��[9������Q3�6����ï��#O�o`C�[��Y�e�G�l{�ԭ�Kb�{*[�n-�P���-�y�P&�DY҇lDR3@:J� ��\���(�G��n�k9�<��IC�y:��˨�8:�;����=���6d;�J��guvD$%�9*��H�"t���Ʌ��5����y���,�d�=u��@��\��㇕{�(T�bzR=Lϼ���az�����0/u��aO���(��}ȥ�x��Lh��|��Z����T��ːc��H2j��R�:�����Ϧ�#�]�ǿ���mh��|�K��o2�;}�����_��M��o����cU��o��G�9~}vY[�8j�鱝�
����wiy1�"�aM)�
.��P�� m�裢>S2O�nT��M�k���0PZ��+;#�kS�=�����Y�+%�������v9ʄGN�Qmc-M�@��_�DN�%��<� ��z��&$���E~�_��EF�qf��jW�!U\�G�3�T�D���B�������(��&���˯���r=oE�>��5+$�3��e�۟���J-(,O�S�/�7�w?jw;�7�qh��i>�k��D�Y �Z����U��1(2���
�l_
/p����R�?xk�����>�a��4�X۱�c�_�~�.�����ܯ�˗c��f��ؿ.�!8C ÀL`6#�W�	�1���� "RdeP��Z7�9�k"Jn"��dQY�ӑ(F%�� !���\e���|-|�V� �W��?�������P�}{��������!v���&�����7v�s��$���������!h��؆���b�4yb����N�gm]���6�ճX[R��ML�ʍV���TY�uh���tka��9�Ȓ� e�����9�ŀ�B �p~��=^NBq9�0^��(��Y93D�AL�ɜ�n,��^�T�.qm�z!�Y�pe�z�����g���Wz�@�E���7��Y��ƻ�Y��)�r�������Mc�7�g9�q朋�`o������z�{��*AFe�0[����BC6l�A:�ל�M��"$���DS!IA�m�< ��#���įH
�yO�"����`���B�*�Y��[���\��cj=�jZ����M��&ΪJ>���ΒG0���yo�����9���o����y!Nd�l�|���� �����`.���V�n�b>m/����:�ͩ���NtKoo;���8yq�9��1�?���p �z�S�/Ƙe�%�
�՘����P��-h�&Ir'[]��`��숹�R�Χ�%6�c�1�Cxp�H�&X�`Doz5h�b�ַ1�|�^SI��%fٖ��V���Jn�^���%7�t6S��>�J�`���Ϊ�L�4�l'��r3����Ĭ'��f4t������:5�IÓ?\3����Y��kǡ�!�XZ�̌E0 f�r֔.��w�7`���B��� ^X�Z -nu^;�/���9��_̛�uH�����?_}�8�|v��A����¯29_m\�xqy��B0(X#����/sx%����J{<�F�+7V����.���������ϟ����r���	�v=�~�O��|�6�����
|şo�����L�g�z�mߵ�O��l~�`+u���>����G�iQX�絬!I��[�Mш�8�$��1_�Bb��˖T@�N
Q�e���.T��QS�#������]�Vk��u����q�U��������9��󆰭M|�Kn�G.�H����5�^���J���x���&v�+y���h3�C��C�t̋�8�#k�Qn�q�L�e��J�A<��G��%v$���QF���������K�Fܝº���g&���K����_��"�zG�� 6X@��CO�?qtjT��Vb�bh1��-1Hl��?�*�"E޳�Ҿ"�����u�Kn��;H|���8��k�w{~����#����\�VP"�`1����@:o��9@Nc����e��$��Z��>;�nB0T��cQ�L��X^���|�bB�A���w�q�x�ߵ6���O���������0��NO�ӣ��h+7�Ve�ș�̣�ۑ��~!�$�)c����iDF���H�,<�@\��(M�e��̃�cH-k�]��W����&Qza+����98�j�vq�v������2���xppQ���'W���f�˳z�\���z���m��/Y^�^W�JqCe/Q;�7G��z�k�� GG � /V�雅~��,���J���a��[,cZ=#w(���|_��T'jM�!ب��(��F�\zz��|TaN���Ӌ?@u�J`�2�uR]t5(C@�qu~�?����?�/U��d      �      x��[o�H�ǟ3��� �P��e�Iי`s�F��/-��D�%K���d�%���h)��!pd������I��ZT�7��k��?����p�ǧ�o�⟡�F��9]&��4�����O�M��g?o�7���AT��2no��\۝?���x�?7Q.j��W�O��&s׎�C�=�����2"������m@n�&�9�l�~!��3"�}ǝ��)�I���5/��%�d䇽�XF��Wj��� w����,e�kߙ[]�QDB�s=7m�?wHX㊊N$�dk?&fh�Nо��(m8�ev�ףZ������Ap�<2k��2Aqo<߈��Ɲ����?���8��G�kӝ��;w�m"v���$�?\��������3�u��|�G��U]J��FQ�Z��,�G.)�CsJb��n��8�o-��0��ߒV%q33$��n4+>J����S,��G�X�0�Db�d�n��<C�����D�xf|�`��_�]{@&�j�FB��E�!Y����h#�`���m^R�ƍ��W"&��{��wg�1�2�/c�r��h��b�o��F��z�.�)̌w{�����lno''a���~5=gN���m?��?v��{�]������*��ɲ�����ވ��������|��G}���_�B^�uR�4꿽���e�N���7�2'x��I*���#u$Fw�v:	�NZC��&"Ql��E���ۄ3G��o�<�^W��)��qSzӦ�aW�%���;R9�z�.�z����~�����W�Y>�^��/	c��Wױ��T7]�$M�K\o�t���:�KjO��T��x�X��<�{��<K��Bw�O�O;S���2�g�� tMB���8U�n��2��]K"j)�`l0w�,2�UMd��'���e�tv9��hFjVђxkB��v�2��I�N��\���_���#���Hz��H��.�Ƈ���H��}J�Λ��SW�[u�V�/?M;fL����/I9�̛��R� ��ޙ����?�	�ֶMgcLg�)(�I�j������][��F�'n4ܔÁʌ<{���E$E���蛆�p�����N�dU�E&�Z�^�5U��r�3F�������`�j���Þ�(Bi"1cTG��m����_��/Y'�?I� ��`ze.�2���A����� t��%i�q�f Kԃ���>S���{�֊����³������Wx~�g"l'�u�˼��� |0i}��/�e=3�}w�T^[�ti�!ES��Z�V7�`J�ϋ�w����7��z_Tg-ˊan���w�����n�X��a*85v�MMǘ��������CU���e��.�+	�/T�_c���8êbw����Ϋ���ƫ��n�j ��+�d�:Q)���Q�2��'��iP!�7���$̆�:�̺c5��᧺�V;[��=�K�e���S�c�>�3.�P�qY2T��<e��MGY'8�7��8u���g��u��v
�Q�	�́:J7A�IP�ɫ*{e.���#��z S��sS��3�3;��0���Ct�C�L":H"�I٢�Ӌ	���3��ϛ/�m�p����T���.�M<��ɴ�>��f�T�КN# ���Z�d���#��Yb�8�蘽P������M�b	v<r<�-؜��"�;�*�
�K�r4��,���	�!��ɸ���Q�8,H}�'u�^�}��^O�%�����j���{r�M�R!��͚���U�h�{�s=_M�z;i�h�[v#il/�-�H�;uk�@�ĳ�X��F����[U�Kc��n�{�x(��D��i$�=�uk�H��y�Q`��Y
uϞ��o�bȂ��51�co�%���r��$��/$��f���7+�,�k�
�\9��S�u��{zm�9��I��L�{��oɇI�c�l�2ͪ@�Z�^q��k��8s��N����\~�5kwp3ޙ��̱�p�����9֞������%�YJ����l�ԟ��������#s��L��,�p�U��u˾,�`eK�f8�����ֶ�8\h>�fI%m	N�S'߮-m��y���{��ܳ.���2�*����h�:���X�]��~�ݗ�5R�P2u�q��q��)\7��Dq4�C�˚�K9"pՃ�=�9�>��㵳*����,���>�+���F������ϒ�Զ����B�-��:���_WxD�]ی\������a�����8�]o��_-#�zD���#�#��W������_K��ٌ�$"O}ˌ��^�n�]�(r�i��t�;�{Vuk��JӁ�[$�岸\�n��3u��w���	5���v�e��z���.Jq{(��n�#��4�bӑK�Rw�@B!+��n�x�p8�%q�5}:\?v	
��V�ogFy$D
����^�|ֿ�UI:�R�gt�-��{,z}m����ۚ�U����4>$Oﮗ-F>���n-��2����I��&��,\&[c;�Ʉ�Q'~0(�������_��$u];$��[u� �Ϊ�q�$��،C�¢{d��h�/���ATL�D�j��?1ы��Lp'��O���Ѯ ��7����?�Ov�J2��I��j(����Iջ�]�k���؁�wd��3����>D���G��y��bh��Y_k��I�k�s��%��������f䒫�I-e�Y�w7���[��n�j�����`��4��ު�Y���u+�0蘋z_�tCˍB3ܾ7�G�A�[TT�f[�{r@�Y�ɍ�m�w��m�[j��=7J �h��`[���>j����ɞ�������-�36�y�u��$�i����ʜ��$:uޙ+Ϟ��|WG�5͒${_�G��%�����������:9���:�z:�_uѯ���x��:dy�� �5z��m��[��*�������44W��]^�m������ ��������#�:����Ms����t��w���Ϲ�m`�5��[�_,�Q9c�9.a�~���R���nӯz'�:�o��#؍mU��R9�޴���
9z{�0���
�����B ��D@÷\�9��^3��h���I�سp����q)�&��{_�S��In����I��V_��W����h�+�������/����:k�W�L�&!�A�����8+گf;6��:�O�K�J�D��f��p]��� ��Y�~��.���fpY�?m����T; ���mB� ����B�i���~��_���`#5¶D��E�VKX#�,M��E�B�oM�?[?ɀ�V���V2�T^��'��ԸEfy�����~�����2`�^�O� �����6� 23ʀ�j����u&Zt�`���� �����6���B ���O{��L��! �P���(�����=q� �/��h[h���Vkh� �j���v@����#���~*aৢ�T��OE��4�����Si�$©P9��J"���Si�$©h?��J"����� �t:�O���'��T��Ru��Ԟ*���R����B�i��v�Fh�JqjA/
���{r^�O��JK�����!�!ڟ�E�5C�s_FP�h?�$�,ϋ�Ӷx��/�������sr����ԇhq¤/��S���Q;h>4�mi�O톘�'��Eב��D�9�=����X����C�|�&ڟ�.�S΍������rv��h�_���BVS�?�׈�i��BA�x�_H��E���"h�%����C�i_P����~��O!�� �9�_Hq��_E�i����Hz!d>�ă/J�gOe�=]�̧�F�^
�O{+C\��/F�u��O;�9�2����x�d>�����˂>�����&�UJ����fd~���Q	O!�� ��%�9 ��O�%�2����P��/� �9�O����gE櫔̗����d~nM����׉�������鐀��%2�P*�
d����2�����/tF��d~q[e���M��NY��/�#�k��������<�Fd~6V
�Z|��/�J� ��S���d~a1T� #  ��_He�LrcM2_K{�>�75�+��J濒��d�+��J�d>�xM�� ��噼�� �5��Macg%�J�
�Mh��O��:h�̧����u�|*�g%�iK`����|�,��Y2�6�������|�]���g$�i[ 08 �p ���E�} ��_�O;Pq�wH�����X_�� �h����r��e�%^�P��Z�@^T)D
׬��� @�����8Z�;�g�@��evL�Pq{1E4Pk� �R�|��.�~- څ�#�)��\@j=��;��ګ@{�S��"����.�v- ڃ�#�)��e�jSH�9P[���Z�$Bk��s�@{��A-��K ��U _o���Z �^�PZ�@!��j��#���SkPi�?�@*P_���� 7~r- *�P8�B��P�SkPi��©� �4TC��Z T��pj- *�P8� ��v�C�.��+U�Huk���Gm���C��7��Q�ZAы�@̓ΞY� h_P-��kP�PU�f� ��v�5�P�22[�@-�����H�BXS�Z �ug������Z �u��>�P� ��x- jU\!j�@14��B˵ �����Z Eב�׬P�A�٬@.�,Ͽ@:t���[ w]Ĝ��F�|Q2g�P4xR͇�Q��
YMk�E�&� 
����'�(�Ã菭�Q- :���VP�T'����Z �/�&EK� �R �>�@�tj^���b�Z �P-�F� 50D�+T}>� h �|�Z �VWZ]� �5>^��е^ �X�h����FOE\�kЎ��k߳p=!n϶ ����˪ࠉ�@�ؠ���]@�� TplB�Z Y�R��
O�P�F'�׬��G��@:������(���.ԬP�A�w�Z ���~V� 4Z@�k�(����e���.���CRy����GN��d- -��U�s�q-�\g�S�(n�,��k�NY�@>�f�ڵ 
9�=N�P�njc�J�����Ԇ`}&����?�?5K�      �   �   x�=�K�0��)|�
	87@�ؘ�T������iף7�S���â6\���B�3YeWz��N�`"_XH���8 x��6i:��MxG�#���5O&�
O�=�*���p�q}u���LE>��N�F�7`���>($��UL�]J���V)      �   �  x�m�ݑ�0��w����_�c���8䭻�~�W�n����y+3_lO�5�d&ɜ$b4�K^�@�r��PY'��*\Ȑ'*�>��|�v�]�$�'�~Q�f��������pg�A9+���M���ή�����-i���R�_^�6:�`rt�/ɓ�$[��Fc%
'W��'k�g�+��y��PW�dm� ����W�n���`�N22�5V˴����ʣ
΍Fg�2�� ��B��%1Bǉ��A*��n�"P��d+d1A �+�֓�MNֽ�MV;[&ObF�u�Zv�t0�W�&�}���6��#���Q�$VĎή�.��<YW�	�`듭Q��F/���m�o�Or;l˗ؖ{�Dnɖ��vv�Wh��u�~Mj栺�`�*�zp�2=:��CMϓ'�����^����������J���	����$c C���,s$Chg}O�0����(��m�Ts:���Mwl� �";��f���՟����'+{�����_�=�l}�OvG݁f)vv	t����~yle'��n�uJm������׬ӬV<�{�fo��q{\�1e�i��ٵ5�r��R�`s>X�7��=�zX��=v�m�9;��]�ud�=����-ԯ�'��k���[1�C�08^��z��:%m      �   \   x�3�tI-NML��t�I�M�+�WH-.H-�(��)�$*$���� �E�\F�~�
���1�(�OR����4U� (��I��ϴ=... |�>�      �   �   x���Kn�0Eѱ��l�I���	�k��頫o�����כC�ZK�K�m�ޏS�g��Qv9`��R\f�T�"��b���p������RK�����#�`~�X�f�@�]t��k���ߵ���y���iK�1�ʉ�CN�F�T\����>h�l�.%Q��irN4���0�{�x�7�]������-kz��#��H��E𯶓���J�x�4���NV(����0��~�      �      x������ � �      �      x������ � �      �   �  x�u�ݎ� ���S�T����kT����u��Q�l�o_�p��^�����0���p{N���|~o��Wa�����.����c��G�\S+O�e|2�"X�9���"�g��q��e�oE)�b�i���������E"�#p�����_����l���~���EOQ;��ъąvW��kE-�Gck�_{uz48�:��8�v�Ԯ�3�Ϸ��W{{~�Ǣڴ�ۣ�VC��W«?��C���b�X\/����bX�LI��0������A�GH\$V�s��E'v�GSRyk�q մj�P��-���X���������[����ʘ@�,�3��
X(l"� pU�%�ʥ8�c�2U�7��� 4D�ϔ��!�\�d �M�ؑ�=�g�]��w�YyQv�%edY}Hұ(�B��D��X��S�����v�=
�Z'n=|:��;t���%u��n�vA����.�tI��3A@Ey��I%�a-ڊ�m�������8I��P���ۡ�_a7T��|;�0�a�ns��z����t�*�uW�.�k�ih�ɉ�GHu���t�8��f�SI�Tӥ��;i�_˦�dK����L�TM!Q�v9S-D%�M�^��cx�h!kl7m���:
��*������.$!"ʚ4�?\���#F�f����Q�I"�D�.H L���eX�?�g��F�լ#h���:sl�_l�޸گ_����H�(�EJ-q&����Vg �bfTLW�]-�m(ʃ�m����
P�	9�V%p�$\�(rL\i��R���>����v��5���@�aah��,}���2��Y���ry�r�H<�E��x�

:2� /D�����\��������
�1娚�w2堦�ҫ�2��?��+W���%/�H ���q`ԋ2P�����c����u      �   �   x�e��
�@@���-܅2�s�AQ�r��	���ѱ�H��s���<�~<K��V��M ��&I�x�Ƣ�s�s����u)�!M�0�Yv�N���&!O�y0]ET#��饮V0���x$�hD��{r�`�F���t!�Q]�簮Ze^nѷ��`.��'�X7ײ�Ɋ3V      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x�]��� ����a�.���ـP0�����.F�Sz8_9��l,��V6��)��Wa6��Yh6E�<�[�P���٘�����U�F���͋��E���b5ی�g� �_�n��J/��8)�+;4'}�O����#�ve+y)���^C��К�2nfáC+����dv&�r������Y	� ��@[�[�1%L2�<N_���q�ی�G      �     x���]n�0���*��D��6k��e%Nj	05�jvm� R������̙aHu�}�}���� �z�i+�#�#�b�E����G`��?_+��%�̥s�&P�,a�u�o�h��`;�mu:�ks��38C�2���2�N�st�������ӻsJ`�%��,�+.|�y�����Mg�Q�*��K~�MmЃ��l)�ug~tk�[�j�P�:�䂢�4���k_Q@�bH-���K�ㇸ�Ru1B`a�-�5c�ѻT���7I�j,�PDJ�kra���sh���ev��g�p�mZw1ч�4߆����8��}�ԫy�]pr7�W)3�8/$��ԯ��B	�)(�Dx�n�O�{�:��\�X0DOC���!���f ��G�ic�f�۪�.�[�
g?���f^�	
\��V	�mm��jM���oH	(R��P��Q��)QPND��Hw5�ՠ8I%	�W{�����f���xCT��9��%]�</�Ϲ��ݦU��f����;���X�pz��c���������      �     x��Ar�0  �syE?I��(�R@��LG@4PA���W-U.��R�Wg~��b �k��o�;�]��X�lO�%e�!F�eL<������>\Z#�'uJ�$Ԙ�Rvl#����/Ο����k�`i Z� �6�8�{����a��c�[����-���%��Db�WiyzF^��i\[Ә���ۆ���Z�S�Ҝ70tM��������lݪ6������
n%7���}J�4UӀj �kМ#�3c����|�E���_�      �      x������ � �     