PGDMP     &                    {            TGAM    14.2    14.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
       public          postgres    false                       1255    50847 "   fn_bad_proc_avg(character varying)    FUNCTION     V  CREATE FUNCTION public.fn_bad_proc_avg(name_proceso character varying) RETURNS TABLE(proceso character varying, cantidad bigint, promedio double precision)
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
       public          postgres    false                       1255    50776    fn_count_regs(bigint)    FUNCTION     �  CREATE FUNCTION public.fn_count_regs(id_analisis bigint) RETURNS TABLE(no_deseados bigint, prob_no_deseados bigint)
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
       public          postgres    false                       1255    50802    fn_list_bad_dirs(bigint)    FUNCTION     �  CREATE FUNCTION public.fn_list_bad_dirs(id_analisis bigint) RETURNS TABLE(directorio character varying, tipo integer, porcentaje double precision)
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
       public          postgres    false                       1255    50799    fn_list_bad_procs(bigint)    FUNCTION     �  CREATE FUNCTION public.fn_list_bad_procs(id_analisis bigint) RETURNS TABLE(proceso character varying, tipo integer, porcentaje double precision)
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
       public          postgres    false                       1255    50804    fn_list_bad_regs(bigint)    FUNCTION     �  CREATE FUNCTION public.fn_list_bad_regs(id_analisis bigint) RETURNS TABLE(registro character varying, tipo integer, porcentaje double precision)
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
          public          postgres    false    222            �            1259    51011    Virus    TABLE     �   CREATE TABLE public."Virus" (
    "Id" bigint NOT NULL,
    "Nombre" character varying,
    "Ruta" character varying,
    "Descripcion" character varying
);
    DROP TABLE public."Virus";
       public         heap    postgres    false            �            1259    51018    Virus_Id_seq    SEQUENCE     �   ALTER TABLE public."Virus" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Virus_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    251            �            1259    50454 
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
       public          postgres    false    227                        0    0    auth_permission_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;
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
       public          postgres    false    230                       0    0    auth_user_groups_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;
          public          postgres    false    231            �            1259    50475    auth_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.auth_user_id_seq;
       public          postgres    false    229                       0    0    auth_user_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;
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
       public          postgres    false    233                       0    0 !   auth_user_user_permissions_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;
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
       public          postgres    false    235                       0    0    django_admin_log_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;
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
       public          postgres    false    237                       0    0    django_content_type_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;
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
       public          postgres    false    239                       0    0    django_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;
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
       public          postgres    false    242                       0    0    myapp_tipo_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.myapp_tipo_id_seq OWNED BY public.myapp_tipo.id;
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
       public          postgres    false    221    221    217    221    221    211    213    213    221    221    213    213    217    211            �           2604    50511 
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
    public          postgres    false    209         �          0    50757 
   Directorio 
   TABLE DATA           a   COPY public."Directorio" ("Id", "Nombre", "Fk_Tipo", "Fk_Analisis", "Porcentaje_No") FROM stdin;
    public          postgres    false    250   �      �          0    50407    Empresa 
   TABLE DATA           3   COPY public."Empresa" ("Id", "Nombre") FROM stdin;
    public          postgres    false    211   �      �          0    50413    Persona 
   TABLE DATA           c   COPY public."Persona" ("Id", "Nombre", "Apellido", "FechaNac", "DocIdentidad", "Sexo") FROM stdin;
    public          postgres    false    213         �          0    50721    Proceso 
   TABLE DATA           �  COPY public."Proceso" ("Id", "Node", "CommandLine", "CSName", "Description", "ExecutablePath", "ExecutableState", "Handle", "HandleCount", "KernelModeTime", "MaximumWorkingSetSize", "MinimumWorkingSetSize", "OSName", "OtherOperationCount", "OtherTransferCount", "PageFaults", "PageFileUsage", "ParentProcessId", "PeakPageFileUsage", "PeakVirtualSize", "PeakWorkingSetSize", "Priority", "PrivatePageCount", "ProcessId", "QuotaNonPagedPoolUsage", "QuotaPagedPoolUsage", "QuotaPeakNonPagedPoolUsage", "QuotaPeakPagedPoolUsage", "ReadOperationCount", "ReadTransferCount", "SessionId", "ThreadCount", "UserModeTime", "VirtualSize", "WindowsVersion", "WorkingSetSize", "WriteOperationCount", "WriteTransferCount", "Fk_Analisis", "Fk_Tipo", "Porcentaje_No") FROM stdin;
    public          postgres    false    246   �      �          0    50739    Registro 
   TABLE DATA           _   COPY public."Registro" ("Id", "Nombre", "Fk_Tipo", "Fk_Analisis", "Porcentaje_No") FROM stdin;
    public          postgres    false    248   x�      �          0    50435    Rol 
   TABLE DATA           >   COPY public."Rol" ("Id", "Nombre", "Descripcion") FROM stdin;
    public          postgres    false    217   �	      �          0    50418    Sesion 
   TABLE DATA           R   COPY public."Sesion" ("Id", "HoraInicio", "IpConexion", "Fk_Usuario") FROM stdin;
    public          postgres    false    214   U
      �          0    50441    Tipo 
   TABLE DATA           ?   COPY public."Tipo" ("Id", "Nombre", "Descripcion") FROM stdin;
    public          postgres    false    219   �      �          0    50447    Usuario 
   TABLE DATA           |   COPY public."Usuario" ("Id", "Email", "Clave", "FechaCreacion", "Fk_Rol", "Fk_Persona", "Estado", "Fk_Empresa") FROM stdin;
    public          postgres    false    221         �          0    51011    Virus 
   TABLE DATA           H   COPY public."Virus" ("Id", "Nombre", "Ruta", "Descripcion") FROM stdin;
    public          postgres    false    251         �          0    50454 
   auth_group 
   TABLE DATA           .   COPY public.auth_group (id, name) FROM stdin;
    public          postgres    false    223   OG      �          0    50458    auth_group_permissions 
   TABLE DATA           M   COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
    public          postgres    false    225   lG      �          0    50462    auth_permission 
   TABLE DATA           N   COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
    public          postgres    false    227   �G      �          0    50466 	   auth_user 
   TABLE DATA           �   COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
    public          postgres    false    229   9K      �          0    50471    auth_user_groups 
   TABLE DATA           A   COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
    public          postgres    false    230   �K      �          0    50476    auth_user_user_permissions 
   TABLE DATA           P   COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
    public          postgres    false    233   L      �          0    50480    django_admin_log 
   TABLE DATA           �   COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
    public          postgres    false    235   .L      �          0    50487    django_content_type 
   TABLE DATA           C   COPY public.django_content_type (id, app_label, model) FROM stdin;
    public          postgres    false    237   KL      �          0    50491    django_migrations 
   TABLE DATA           C   COPY public.django_migrations (id, app, name, applied) FROM stdin;
    public          postgres    false    239   ,M      �          0    50497    django_session 
   TABLE DATA           P   COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
    public          postgres    false    241   HO      �          0    50502 
   myapp_tipo 
   TABLE DATA           A   COPY public.myapp_tipo (id, "Nombre", "Descripcion") FROM stdin;
    public          postgres    false    242   eP                 0    0    Analisis_Id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Analisis_Id_seq"', 32, true);
          public          postgres    false    210            	           0    0    Directorio_Id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."Directorio_Id_seq"', 415778, true);
          public          postgres    false    249            
           0    0    Empresa_Id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Empresa_Id_seq"', 3, true);
          public          postgres    false    212                       0    0    Persona_Id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Persona_Id_seq"', 139, true);
          public          postgres    false    215                       0    0    Persona_Id_seq1    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Persona_Id_seq1"', 7, true);
          public          postgres    false    216                       0    0    Proceso_Id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Proceso_Id_seq"', 4278, true);
          public          postgres    false    245                       0    0    Registro_Id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public."Registro_Id_seq"', 113068, true);
          public          postgres    false    247                       0    0 
   Rol_Id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public."Rol_Id_seq"', 3, true);
          public          postgres    false    218                       0    0    Tipo_Id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public."Tipo_Id_seq"', 3, true);
          public          postgres    false    220                       0    0    Usuario_Id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Usuario_Id_seq"', 6, true);
          public          postgres    false    222                       0    0    Virus_Id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Virus_Id_seq"', 1363, true);
          public          postgres    false    252                       0    0    auth_group_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);
          public          postgres    false    224                       0    0    auth_group_permissions_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);
          public          postgres    false    226                       0    0    auth_permission_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.auth_permission_id_seq', 96, true);
          public          postgres    false    228                       0    0    auth_user_groups_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);
          public          postgres    false    231                       0    0    auth_user_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);
          public          postgres    false    232                       0    0 !   auth_user_user_permissions_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);
          public          postgres    false    234                       0    0    django_admin_log_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);
          public          postgres    false    236                       0    0    django_content_type_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.django_content_type_id_seq', 24, true);
          public          postgres    false    238                       0    0    django_migrations_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.django_migrations_id_seq', 23, true);
          public          postgres    false    240                       0    0    myapp_tipo_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.myapp_tipo_id_seq', 1, false);
          public          postgres    false    243            �           2606    50527    Analisis Analisis_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Analisis"
    ADD CONSTRAINT "Analisis_pkey" PRIMARY KEY ("Id");
 D   ALTER TABLE ONLY public."Analisis" DROP CONSTRAINT "Analisis_pkey";
       public            postgres    false    209            %           2606    50763    Directorio Directorio_pkey 
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
       public            postgres    false    213            !           2606    50727    Proceso Proceso_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Proceso"
    ADD CONSTRAINT "Proceso_pkey" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Proceso" DROP CONSTRAINT "Proceso_pkey";
       public            postgres    false    246            #           2606    50745    Registro Registro_pkey 
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
       public            postgres    false    221            '           2606    51017    Virus Virus_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Virus"
    ADD CONSTRAINT "Virus_pkey" PRIMARY KEY ("Id");
 >   ALTER TABLE ONLY public."Virus" DROP CONSTRAINT "Virus_pkey";
       public            postgres    false    251            �           2606    50547    auth_group auth_group_name_key 
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
       public            postgres    false    227                       2606    50559 &   auth_user_groups auth_user_groups_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_pkey;
       public            postgres    false    230            	           2606    50561 @   auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);
 j   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq;
       public            postgres    false    230    230                        2606    50563    auth_user auth_user_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_pkey;
       public            postgres    false    229                       2606    50565 :   auth_user_user_permissions auth_user_user_permissions_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_pkey;
       public            postgres    false    233                       2606    50567 Y   auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
       public            postgres    false    233    233                       2606    50569     auth_user auth_user_username_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);
 J   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_username_key;
       public            postgres    false    229                       2606    50571 &   django_admin_log django_admin_log_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
       public            postgres    false    235                       2606    50573 E   django_content_type django_content_type_app_label_model_76bd3d3b_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);
 o   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
       public            postgres    false    237    237                       2606    50575 ,   django_content_type django_content_type_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
       public            postgres    false    237                       2606    50577 (   django_migrations django_migrations_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
       public            postgres    false    239                       2606    50579 "   django_session django_session_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);
 L   ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
       public            postgres    false    241                       2606    50581    myapp_tipo myapp_tipo_pkey 
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
       public            postgres    false    227                       1259    50586 "   auth_user_groups_group_id_97559544    INDEX     c   CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);
 6   DROP INDEX public.auth_user_groups_group_id_97559544;
       public            postgres    false    230                       1259    50587 !   auth_user_groups_user_id_6a12ed8b    INDEX     a   CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);
 5   DROP INDEX public.auth_user_groups_user_id_6a12ed8b;
       public            postgres    false    230            
           1259    50588 1   auth_user_user_permissions_permission_id_1fbb5f2c    INDEX     �   CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);
 E   DROP INDEX public.auth_user_user_permissions_permission_id_1fbb5f2c;
       public            postgres    false    233                       1259    50589 +   auth_user_user_permissions_user_id_a95ead1b    INDEX     u   CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);
 ?   DROP INDEX public.auth_user_user_permissions_user_id_a95ead1b;
       public            postgres    false    233                       1259    50590     auth_user_username_6821ab7c_like    INDEX     n   CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);
 4   DROP INDEX public.auth_user_username_6821ab7c_like;
       public            postgres    false    229                       1259    50591 )   django_admin_log_content_type_id_c4bce8eb    INDEX     q   CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);
 =   DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
       public            postgres    false    235                       1259    50592 !   django_admin_log_user_id_c564eba6    INDEX     a   CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);
 5   DROP INDEX public.django_admin_log_user_id_c564eba6;
       public            postgres    false    235                       1259    50593 #   django_session_expire_date_a5c62663    INDEX     e   CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);
 7   DROP INDEX public.django_session_expire_date_a5c62663;
       public            postgres    false    241                       1259    50594 (   django_session_session_key_c0390e0f_like    INDEX     ~   CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);
 <   DROP INDEX public.django_session_session_key_c0390e0f_like;
       public            postgres    false    241            6           2606    50728    Proceso Analisis    FK CONSTRAINT     �   ALTER TABLE ONLY public."Proceso"
    ADD CONSTRAINT "Analisis" FOREIGN KEY ("Fk_Analisis") REFERENCES public."Analisis"("Id");
 >   ALTER TABLE ONLY public."Proceso" DROP CONSTRAINT "Analisis";
       public          postgres    false    209    3298    246            8           2606    50746    Registro Analisis    FK CONSTRAINT     �   ALTER TABLE ONLY public."Registro"
    ADD CONSTRAINT "Analisis" FOREIGN KEY ("Fk_Analisis") REFERENCES public."Analisis"("Id");
 ?   ALTER TABLE ONLY public."Registro" DROP CONSTRAINT "Analisis";
       public          postgres    false    248    209    3298            :           2606    50764    Directorio Analisis    FK CONSTRAINT     �   ALTER TABLE ONLY public."Directorio"
    ADD CONSTRAINT "Analisis" FOREIGN KEY ("Fk_Analisis") REFERENCES public."Analisis"("Id");
 A   ALTER TABLE ONLY public."Directorio" DROP CONSTRAINT "Analisis";
       public          postgres    false    250    209    3298            *           2606    50610    Usuario Empresa    FK CONSTRAINT     �   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Empresa" FOREIGN KEY ("Fk_Empresa") REFERENCES public."Empresa"("Id") NOT VALID;
 =   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Empresa";
       public          postgres    false    221    211    3300            )           2606    50615    Sesion Fk_Usuario    FK CONSTRAINT     �   ALTER TABLE ONLY public."Sesion"
    ADD CONSTRAINT "Fk_Usuario" FOREIGN KEY ("Fk_Usuario") REFERENCES public."Usuario"("Id") NOT VALID;
 ?   ALTER TABLE ONLY public."Sesion" DROP CONSTRAINT "Fk_Usuario";
       public          postgres    false    3310    214    221            +           2606    50620    Usuario Persona    FK CONSTRAINT     �   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Persona" FOREIGN KEY ("Fk_Persona") REFERENCES public."Persona"("Id") NOT VALID;
 =   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Persona";
       public          postgres    false    221    3302    213            ,           2606    50625    Usuario Rol    FK CONSTRAINT     {   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Rol" FOREIGN KEY ("Fk_Rol") REFERENCES public."Rol"("Id") NOT VALID;
 9   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Rol";
       public          postgres    false    3306    221    217            (           2606    50630    Analisis Sesion    FK CONSTRAINT     {   ALTER TABLE ONLY public."Analisis"
    ADD CONSTRAINT "Sesion" FOREIGN KEY ("Fk_Sesion") REFERENCES public."Sesion"("Id");
 =   ALTER TABLE ONLY public."Analisis" DROP CONSTRAINT "Sesion";
       public          postgres    false    214    209    3304            7           2606    50733    Proceso Tipo    FK CONSTRAINT     t   ALTER TABLE ONLY public."Proceso"
    ADD CONSTRAINT "Tipo" FOREIGN KEY ("Fk_Tipo") REFERENCES public."Tipo"("Id");
 :   ALTER TABLE ONLY public."Proceso" DROP CONSTRAINT "Tipo";
       public          postgres    false    3308    246    219            9           2606    50751    Registro Tipo    FK CONSTRAINT     u   ALTER TABLE ONLY public."Registro"
    ADD CONSTRAINT "Tipo" FOREIGN KEY ("Fk_Tipo") REFERENCES public."Tipo"("Id");
 ;   ALTER TABLE ONLY public."Registro" DROP CONSTRAINT "Tipo";
       public          postgres    false    248    3308    219            ;           2606    50769    Directorio Tipo    FK CONSTRAINT     w   ALTER TABLE ONLY public."Directorio"
    ADD CONSTRAINT "Tipo" FOREIGN KEY ("Fk_Tipo") REFERENCES public."Tipo"("Id");
 =   ALTER TABLE ONLY public."Directorio" DROP CONSTRAINT "Tipo";
       public          postgres    false    219    250    3308            -           2606    50650 O   auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
       public          postgres    false    227    3326    225            .           2606    50655 P   auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
       public          postgres    false    225    223    3315            /           2606    50660 E   auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 o   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
       public          postgres    false    227    237    3351            0           2606    50665 D   auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 n   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id;
       public          postgres    false    223    3315    230            1           2606    50670 B   auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
       public          postgres    false    230    3328    229            2           2606    50675 S   auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
       public          postgres    false    3326    227    233            3           2606    50680 V   auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
       public          postgres    false    3328    229    233            4           2606    50685 G   django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 q   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
       public          postgres    false    237    3351    235            5           2606    50690 B   django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id;
       public          postgres    false    3328    235    229            �   m   x�}̻AE�خbؑ߳�� �%A"��:���]4��ޏ�y??03�~� �Fƪ��*�%�B&g2��..����D���		ź�f��Q[�S�~��� �[&�      �   =  x���Qo�H���_��}�}A���[�4R����i%����xe02�M�}�����9Cҧ�s�;��|\��h��d�����6[g�Qp��������fuY��W?q���f�Z��v�C9�wM��1�l�f7U9���tO���0څ��tqr��1��O�~N��[�6/����,N���ںδ�ϗ��1�Vc29/���ja�������:�_K��c1�x'�@�w�jZϞ����7��Y?�m�\�ý��Ս���.[��ry5�={Ŝn�ܬ���W��'ପl8��ٱz�X����F�K��N�%Y�a��N&���/��*���R��NϊMV�emL?����UM%�t\�o��<�*�)_�߳al���1�VU�4��fn��d��}�;{W?e��|����S� V+���\2�|���e�CN������7��ղ����}��%�сWn�9�9�1z�}��oh�ߏ���M��;�T�f����8���k�o�Us�߅Ԍ�V�~�����m�L���������U%�kt��!t��.��z��� p��ֺ䈡�����>|������C{����Ϥ&v>ѓ��b�˞�.�$�W?�eK	�m17��`#����<�[7ô�j͇p^~��L�\��)�Zy�6���ɗ����-)���"[67���r����R@禠\�_n�i�)����Ţ��@Oc���.�
�0��*�u�{���MzQVun���.���)_�\-�G�1�n�e.���\��c!;8����F u�o��"��!��2SC�_S���U�����	�}b`H��0jð�?���
$�c;��!u�fo`��1���b<��,=��UL�� ;����=8h``�I-�>�w�Tݪ-���b`�S�D����y��Qe``���2uT*C�H	�
v����1���%�S6=�ʦ���Fw��j펁����5�-a����j:�A�b`���3�10�	gm�2�
ȏ���D�o
�� 2\H8������PA�fo``��t�ʌ��PB�
����6�R���7��ŭ+�C*9��aF*����f���&��#���:�A����[ߌ�p��Z���������d����D���m�`�Î���*�Ď�t֦�c7{C��� <�10�8f�10О.�60����60���c`�������y�m��[�e` �}Zq�c����.�ru�*�������RrDJ��ȗ��쩑�h��)��9��]s����������5�-a��7��:�A�b`����҃>��9�v״���5n`(��5�����Ma�!��j���K���PA�fo``��t��y%Tn����*�a`���hJ�fg`@������4����x����nOg`��7���B!� u�o�Q�>Cl}3d8��l����!$�(!Y;10 )10$#�����g�a`v��60@T�$vl�30�����#4�s��X���P�yT�hO�M`O{MX����@=�%�G�N��[�e` �3Ľ�!�ul�EC��Qe``���X��ǰ����#RB�G�d��F(����QS��B10О�c`���v��OgƵ�纯j��k�t5Tg����.C4��9�v״���5n`(��5����=84ЈC����~�K\��
��pg``��t�w�<�*7��P@�00P�p���v�30 Tol����\����]��v�������� ����m�I����7Zr2�      �   +   x�3�qw��2�uvt�2���KI-H�K�L�+I����� �I�      �   �   x�=�1
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
�T �?GhP�A���m���2�X��.�)�+����-ZC� ��d��WJ��T�����Rx`��GP�^�k.�\����Ů �!�HTL�)r5*\!������9�kJ���fs�-Q�	'�Qf�	�v��&ٸ�nd����`�n7�%�y�ܴ�����?��+��3�W0���C�޾TGń�*M[.�)�k&�H 	�I�hsG����L,	��(�]=]mq<�徻�{β^����u�_Ƙ�rq=���&����z����O˧y�����5n[��'�e`]�^h�A���1�!��E�"�}1y +�glh.0E=B0��k��Y��nA�N��G�SRlY'u(����3��%F ���Sǅ1����
�EHˇT]���_�KyV���/�����qx䓀���F+%#)� (�tD5 �҄+�`��|�ëΨ�t�jg-+<�lLBqHRGC�Nd��vKX���T&.,��-�ĢᾺ��U�j�p/���:��-�M�á	�<ˬ��dq��&>��G9��e`%p�;b�fDJ�6�
j�����DI=r�=���pA~�|��oޭ�9zq�4ˮb�.����'��������ݏ�_���?9�ʒ���6�a��ц���d2��܎���䎹I��2R�CE��c�� �c�{���lU�f��� =���5���O�8 H�d�l�������;�J���$A��J{
O��t�#}G�CPq�=�RF!���I��KNfi�����o��Y���Y��r�`\|��D^� Z����7����˷����%� �d�lA�,C��W`<��rѪͬq�.�M���]V������%7Z�c	��d�[��"�D�_���~��7���L�]�߫�#B�m�t%�aoG�
[xM��T��tEY�D�%�6��9U^Qԇ ����bz
LO�P$� sQ���ˋ�q�\	\��3�  ��؎������傊��e~��s�����g2����A#p��AZ�d~qP8�h~����J�n��)_3�"�c��N��r#s
h�f�^�_��H��u�K"�ߊ�ꯝ_��x�0�������C,D��� �V���4��=���6�+?[Ŕ5�ɵftq��-؏28��j+SA�ɐD3�U�8��x�-a5�x�l���瓦���}y5�k��[�����E�-Rh4��4PW	�3h8S�P���Bu�-!ۼQljm�2�m|(��rq˙b�>!m��=���D��l�3�xq�Y*��=��Lɉ@�-6Q��"Ea����c�/�B&��'������R���M%�v���~��ON�L>�+��,?}n>~�cé
����e�ǧr��W�O/��U��X^~�뱎���٘�u����k�����C�Ǘ�z��������R�1G�;a�v��x�!�I�A�qē�8�,��x��� x.y$�SA%p�x	rX+��H��z92[��hś�� ��wEof�c@�� 
�*M4d�ik�<�����tEo���8��Us������Fc�`�wVc��v���7���z|�hީ�K�|���ƿ���x����?ęٷ�n����K�ZL�(z`��l��B7�2�Fs�z@�Aez���Cx����p��[�e�TO%�q�$R �|����� ]�m���weK�.�����~|/��eS��_H��<��/ZV���~F�{(�#���C�EʙmS�
�	p��.�l(הᡦ!��i�� 8��C�>�;�P5�>�hs��{����@�~���$��g"(��M��WE�#���؝k�5�L#j��2+Arz��<1���M�m�u���t����U�[���{=��Loٚ��A�b0��=�F�?M��u���
�#��� |�L�F�����*�
�l=�sT�;ϺO\���82�����輓���YA!t�X�m��>Np�v��n��g�{�.�f�8���r�όz+����I��D������>}�¾�)M/.��(��EI�Γ]4� Ej�P��0'D�i2��N�CB_��|���M��|�]u`� *�Q'�@�S\��@B ��U)�Vy}���g�,g+����%q�~� �h�:����q�$L����R�ԢH��V�sK�b�E,��DZ�/&N\ p�R12@'<H�|<=�Ǡ�F�f�(�I
�(�H^enK�$��F���ϗ/%�����?cݿo�B�?�Ia��ǯ�o���k�_�fy�jğ_�;=�x	��w�n|@2�<rwc+fj���Ew���94px���ɯ���� ��B�I�Q�&y��X˞x�\'T�C�l[��������擬����^���t��/S?m�Y�
�_���S5]^__r���}����3h�
�w `�*�0�!�b�Iyp���:ZRyWW4p��%�#�5<��WG���ð���y�+D���79g���g��NlH����\o��9�]Ǭ���KS_,���m�x���̯~�r�!*a�n�<��(E�a�F��^�X@:0��ؘ�:<����5n�T��׋�Ƴ���|�Vu���lD����{l��K������T6��F�L�D�P�'����c������B��F�j\Oޝ��x5�q��<��c� A,ݺa�r�2S`�G���DI��s�(*�R��`P�K7�a�"�#X�ɍ˕6��R`���jQ�E$��&u�b����z����/?���&��G�7����b~�[�+�<�x�ߢ4�pz,xE������ݒ(��H.��h:0]��5gB1��E�~s!U�T�I$���-Q�I_d~��$v=j3:b�b�5d TF�vۇ��G&-����wyM	�R:�����_u�9�6e6������U�  �ɈΩ<<9!1�`D\�uHm����4�*��2������8D�,Ȭ++��J��3(;���$��2ʭ�}O��&�����5�-�S<��L��l|U��O
 �-�������Y�r�5{�������4��$3LMK�ylPڂ�JJ`J�U.`*�D�Na,�>`^�m��@%�%�Q�"�i�ţM[M�.�;0��]�ҁZ�Ce.:�D�2�^S8��\M��r�����{v����,7 ��SS&�dVh��!,�!9A-ڸ	�f�b-Gq�/Mc�K�Q�k�.μ����MV��)�_���;[    �R�,�c��y}��Ǔ���{���� ��F��X�0)�f��u�E��@��dGfH�8� T�iBy��X����!WЈ(���I?B� z�4�i���^�:��I�(z�=����t_������W��}�������%�H'�� !� ���ʲ&-?\?�/iz5�k�:]H2[�%pg�@;>�Ti�Q`g���~p4m�
&xt]n�'�}Fx˨�J���|_���-P����ڭ	����k��ҁ��0d��QuQ�$M,��tu.D�H�� �
0w�ڀ5�h3M�,P�ׯJs]�h+�u�)1��2�b�f��N�8�,�q'J���0���,�l�<H���A��!�,�tJQ>L��m+%���b�MӜ0#l�XH+!��ZV�8�#���M�@�J�G�D���Î�9���(8�XV�Ckjyt�JE�%����*6G��3[CDh���d�&m=���@�6��&=i��u@b���2�ڂ"�R���i�;���D��e�j �4D]�ń@O)�"�2S����.������p��(${�)�'���1����*�dؑ�h�.;��������I���hծ@�7#i�!��!�hq=s�[Z�*�R�G)G��v7*C��I��_b�6H�
$��.`��(�����r��nk��q�?��o�ͫ��>��F�[�)����(J�C2|�W�4��+���@�2� /�@ g���#ku�4 ��S��WǾ67��2r��V����(�����ob��Z��8yu���`�#�~�)�I��}���7_��,�����](�8��v�I�_��z]d7�F�L���8�d�������9��_40���=��[v�����K�����ОƦ ���]�2��}�d2ed&�"ƛ��,�I��}����r��]Ԛ4@@<� �k�#�m��^��� qS��J�T0يl��7�|w3@�5 �JD'*cC�2.M�;Z&�h /w�ƨ���b#�vQ:������1���O�xq1������p�G�|L����2�@	����\�K�9�
2<xU��8*MHx���!Vf�f��Y��x��؀���5���OFv��������
 OO/���,�gg�����Mu�������/��7[�շ�o)=��}y��,8@g+�����lN��إA�� }�E껀��E\��
gwz,{��h��JP��̴Z� �  �Ӛf%/���9��88a��i�;�S�+J�e���Cf�|єa�w��X�H�"23��+9��Kh/ÑW���]*�m�0��e� ���6-�ɨ�JS�F=I6�ZEA���'D���L�/�!3���)�2�1�s
G�<������/�������j�����dW)h^.^�6�-�|���C3&���wd�o&�?�Y��Mj�UU��\�	���Lg�k@��g��棓��x��������o?����CssQ^�O_���a�*�R2C�z�~�(��AB@�C���I��Y)�b	�%5G`M�ȴ�C(i8��2l�\N�.��z��]tT#3Kk��1������y��lƏz3��t��t��~z��_������|�Ұ�؁ޢ�U�n0�?񇳐%����	�}��6R�0�Vm헁ޟ�>�:��K84h�)���������l���2:�k��>1�G:�y.d͑&w����,�=��翞_\���M3�:=��o��&��ʗ*�i�&B`�\x����dlz��������aR�3pA!�E�0��k �<"P8e�EE��k���_FP9�Q%�i־2�U1�'�@m�=8%;�R�U�l�!z(�Y����~c�\@�{��ݳl���>Nċl����Z��z���8=��#	����'��/�/���N�,�Ѽ�Qy��_��p�e�߼����ɦn��]su$�Q\?�����5<e��������ѣ�|��l��VG���S<U�mb+�&�k��f������#~ʣG�4:>=�>��s�L�ͫ�M�xK����|�#��6�i��P�������� ����D7 7����Hܢ*h5����b4e&p����-�r����[��Y�T1~jTαW'��j�� ):]�Ƿ�5h�C��GZ�_���͌/���nv@�ĘJ|��)�4�����.�V�w���p�����ʚw��'���ǫ���8S3������o�Y5�zW��D<k��AM��m6���hb#����D��xl!��� }�
��zw�Цv��B�8`��sh#���Dش�C�lI`�7z�*2{��d�ڪ嚐���,vx	������j�{�c����[��> �`e���9�,[g�lr}T�/^�o��M���Q���r�ݶM9���,^^�/���b:�W�;RNy�Z��?6����I�rz�;��Sx��3�T�*��e;�d���1�4�͸���Ag(���@]:Z���3�:,�a�`lԽ ��R*=G��F�JG�$(�7
� P�FSƘ%�q��/d����Ʉ�	B���e�z\��L��P4���ďX_�K*����˥%[P�(�(9j6��q��]���}�?F޹�cn����H���yj��$I��MU˖��4if���<�9��%=n ;�1rF=;�4�`}�|V���2��q���]� 8P	��� A�J�89���4���1W�-����GY���tFAt�:�G����o:B�w9 X@4��W�z�ٻΐL��B/�������<Ca�L&U7���ė�)�ո�N�*7�י�!�Y�gH�97�B'�ERr�' �Ơ0 ��4W��XG��a�>䂻@�Q�k3j��y\Fi�aA2�.]i\^+C?���g$�̚�]le����f����*��=@1�z��N�ܭ�����:?����[w�*�g�	;g@fT�D�*7I�=]�iTb� ��=������3��� �\Y�����$-��q��Έ�CT��~�Ι��
n=�)��q�F(ޠ��4Cc��h�t���fA	�	��C�U� !u>$b��Qii�*��B�ubb��f}-�����30 #Bc���J.R\��o�|絔��=VJ��q��4���I���s�$��d\��tf�?]+��k)��*B	q�c�,����	Hn+�YB�W�ፁ>E�7'����)� ��p���N�n�R7�1��w�08�Tы�J����e��ùr�,��}
v�D�y������o��f�'�ȇ�#��>Vo>��M�ؼ�<��4���S�z�����/[�s����2���S�5�e�1��9���)葉�|���0U����y�Gc��h4� 42�HHAE��е�����"&�=�eh]� �A`D�z�ɚD �-�.�>=D���%K^!��E��?/�)��M�Ue찅>� +�,�d�E5�Pz�����!s3���YZ3��#��&|I�9�
�G;�/�LI
n L� @,�p��.��k8ݷ#{e����9�Q�ā�̱3���Ќ��#v��k���B w-�F�@�8ІA�N#�D4ݚ��)��la��eu$�f�Ѻ1YL�WQ��<����h��N�<�������${^ߠ]D��l�+!��'�[j������A��x��@�.��$�"^6-/���Y�9��u3��0d[j�9���X�Y�k�ΉX{V/��SB�峝/&����<���cpM�~���q�C�Gi�"M#�T�ЩÍ4rT�@n���И��\жm��Tfx�� g���3�m^��?�	�U9�WW�U��͸�KĂ��G27� igʲ�zx�������΋�a2��X=���Vħ��������
�I�n��#uP�>�G���҅�;Fk�d:�X��t��B�C�{(��3풯�cJ���'_��F�\ϗ�Ϗ��߽z�8����2GHLxxQ)�y�����y7�����e�>���8�O��w\ßϧg͒����2���b����Ǐ�W����y�ގ��\    5�������� <�{%R��/�0جMG��@byj�R��[.�HGf�cS�@���=�m�[ܣ�m�� ���-����8�zi�w���naҾ��0�Z���+-{�[fk8���	��mA�]1R�\u#��y���f
]�.�����l�FǢ+M.�wƸ��/=
�=+�N
VQo�CѭE+Mё��1:J��?���9�8�-N����T�{�=��O�^�;��ݟz���%|-ޙ����T������j� <0v������������%��x��� ��������d��Z��J^fzR�y6����jg�2y�5���T,,���w�aO*7Y��|����8OBl&P���xZ_M����Oc���|���i�6U�P��˿n��iӤ�����ɲ^6O��Wgb6�~i�'�
u��D>ܤ�U�XW�bv�C�4����|��������0Q�L��5u��i�f�}����&�>��~f˘���麟�/�<��|~������n�go˖y|s��Wfsg�g��l8�&�n#� `X�����d���6�s�qD��ȞG�
'�CΞQOe |K����~G��O"����م|��oo��v�	�7X?���r3#Sd\$\��r-�Q~L�*��:�
أFE\���%�e�!�*�U �>��=���WF��F
 _���(h���$y�䃬A��tA"@k�ַ�m��HX�%��S9���	͝kK{���d��1**ZmOO�d��}�O>v�g���E3���bZ�>��VUN���٬;�`Q���MôfJ�]�8��t$��Ѐ>��F�,���t�LD_fVI �We,���FU�v��-�9h�`�Yup9~T|�P��3���p��c��&�A $c�2��� }��1kq"�o��� ��Ԣ^%�;���]���+��ܜ�!s��v%��F����Xp����z\M���]['q:��*5&zdgӇA���8n}S'3�����~|���
u�ax�����.�a���i���&B�b�Z��nt�0C. ���ә1f0�t�>˜��^c�Өd��_���#5��d����A
��U�rjt�|��W��_��p������i&����Ռ��OgUfJ��Wq[�ö�DJ-H��o��� ��d�0���x�~+T
�Nk<��]#�~�Y�)-Wpf��X�|,;S��X$�I��c׈d�����8<����!����r+�x�P���oaz�8�g��� W���1����8es
s�`vd�2�d:Ł�
	�=Z�r8�"�c�@���,r��n���"����0$<�}zJ�(^�^��O��_M���x��ݏ-SKے��x[���ß���i�n�3��?=z���qy>�ӣ��5�ėk䀏%�M&ڪq�y��ǲ���Ox���<��\�ϡr5.ñ�Tb{�8N�8U�G;��q��T����X���A�A�d8HU���N�7���*�M,�f��b�CN����1�qe�� ��L�xy:T�g'�cR���fU�-T��]�	�n ��4���)o�6��5�����t=���}y��U��?|O���o�,���g'��v���������7��Ǐ;���^氃��X���?�~���S���l]0���I9�A�n1�h���P�j�PAb��y0�R��t@����7�م���D� ��ƪ�TU~�l�#�� �Xh9����?cIȖ�ڈe�E�8z#!ێhB�d_����1l'd��YT��Z�H��W�l�w[�{�D`ϳ��%H� �`S�C�=-)n {�u��@A�5���"gD�Ȧ�ŝf��3V/(�NT;Lԇ�Y<�6�79�"Ec�;�m��P�i����	�%��$(a>�\�(�/��h(������_��?���铷���Ͽ��,�ʁt�q(=qd�����d�$�I�S���a�˸h#��#^���0�mt(�1����� ��=�%,�8�wk~Y ,>��?ժJO�J��Z�����e� &�%"P�"��J3��=�[��3ң8���	��)c�d_ſHRI��
Ur+v�U��V��G��ޢy��2+���s�����&r���vU*C�N�� 3&v"�r�K$�R{�GV:B�(���,xe�/�7�%['xs��β�f��O��cV���2>�o���30�Η� �x� u �pK����UbF�G^��@�iy��$-�2���)pI��[�N�R�'[�%nA%�����}�Vd|�Vg�~�.�=��V��=(�Z[ĳN&7MsUPП�������{���b}��_>���8���_��^6��0��l
	hZ���_ �;���hRܰV�T��u�&(����2�D@m��l?���� ��"�;�_����P&̨�&��&�����Ȃ>M��P�l�ٔ�R�<J�
�u谞��g˶,AQP ��9BK]c�k�;�d D�-��+�>�Z�z�����ے�J��	���M��YNk�B>=�M�A����]@�����o7s���� ���In��؎+7��}�ml��q���� '�#�c7�Ә�3[?!8�+G ��
?4��f���"+��}��m�p7�����X�#�iƖ��r>HR�p�T�N/��]�7�x쎔�]J:�ݗ	�6��	���Ӏ������i��S��{������caAÇ�1\3j�@[�-l�g݁$Sd���]f���]��41�Xiشh�2�^���8��v{��C��חr�@����,�-����셲l>x����8^��ʕ���&�*�iv O;̉�Z�eOK

j���2B�6��⋻���#e4qP%+#r���!�,��G��tu��� �\O��T� �%��m��q-�U��r=0ʊYˡ,�����>�����������r��/~���܀�f���X�x�+a�㏭��y�:��:�x���W}�`���=F�p8��>��oB�A�[~�,k�l4�!��Pt�A'�:ex�]��,*
�x0�kSf�]���2m�Z	���D|Q� QZ��냃N�W~�cs}����=��ӿ���R���k�	��>|����ͻ���f�~�������2�v_z�Q��b��Mz��!�e�b�3�L�v%Ż'x=3	�k� ՎM�� -;4]xJ� �G�K���m-�Fu�O�H�H逬�dR�}�i���q���5q-�@������o[T�X�CE�)�B5��0�eX�T^����]�)����a`�+mr����ݷ#7��O����#����_�Ҵ�xH`Z��@�A�e��J�eن��-�Tq�Y^X���Hg�R0bde=�A��s8�������p��{�;�4���\�T�y_��t6W�p����*=�MRG�������"����F@��� a���Q�����g� ��T��W���'�v�xZ۪1)�gYn��</!���i��V�@cY�ԄYd�L]]7�t����ć���F�\�I��K�h5�s��F�v�����p`�|���4L�E�K/s0���^	gA�F\MxO�Z�ܦ΁4�eT�WL3k�x�1�2C�����ֆ�%v/o��5�.�H�Ny[����S1���* ^��k���uT"�Wۻuˀ�g�р=a��k'�M���� �n�(�����kTuR�>jp�(����f3Wu'$v�<�����&bl̸NUS��ʉ��r����q�ql\��Vk���l��U%�
�}4��F�Jt�f)������\��Yڜ"J)�C������BZ%� �����	�����Jʄ��U��N�+g~��0^��rQ���ffC:��?kMPi�$���udPr���2}DiS�F�O��ɆR��3ɔ|4l�/��n��%�Qh;���e�!�B��q $�d����5p���L�EG����!�,OZ�MP �j'2p�'+~��|�!����Ż��i*�`.Qf=�[��H���B����,P�n    ��m��__?���3
c��Э�p�oİ�Ӛ��5_�띚���es]ߪ�~R�����h�)F>����}���ʪ,��|8�c#8p��nP\?�S�B�gɆ�'o��S�2�L��|��A$9��� �I��d�D�<j?�G���T{\!/����"h,������0�[���{7�ڐmA+E=�E����|��j2 ����m�.��pH�J������)ޟy�������J姏+��I�����z�^x	������t��^���Þ���h��]ʥ�x���Lh��~��Z����T�FȐcW�H2j۽�R|�jiu��W�Ǒ�.���?����]k��y/��sgd&��>�P_}���R^�}���Й��V���w2ܳ<y���Mm��l2����}����MF^ܹ�sCX�@�ƣ�K�/��&0H[�*���ϔ̓�ݻ�xS���=L��A���e�tm
�|�G)$���cVI:e�K�f;)d��E�m�#'vT��eK�q`t��G"'�H�>� ��z��&���E}�;��EF�qf��jWH�T\�ǀ3�T�D���B�������(�TM]��7R���<�d龤�5+�3����NS� |C�VJ˧��S�������-�ϸ4L;4&�15�M"�,����U�G�Ņ���YtK�⶯��
8�Y{�CK<�����jY�u�oD��X�cg�U����죈��y_���ys�r��]�ץ<�b`�l�fd �
#q�\�#�q�@D��jSx�Ƣ;'�CD�Md�*x:
��6 $��sW��r8��o�Ϡ�� �
2���^qy5���y�W��~�t~�<�U�7��o�6ޱe��~'	��W��OOAK��m�}�X<��I���i��˳���X����Y��G)��IL���@�;��>$	��(]�������|"K� \#9 ]+��sF�I�4  ��t6^nB	9�0/^��(��Y�3D�AL�ɞ�i,��N�Tl���a�	�,P8�2D�7��p�޳���2+B��"����f��Uʮ��)��$no[��B#Fc�&nV�r���9U�����s���:m��*AFg�0��PW[��!d���57��i�4R��P�h*)�m���~AW��Ea���	T��s6L��]Y��0�~'�U]I�pdL��ZM+;q�rSc�����?��Lg�#~���F4~����
��џ����|�J��ղ�P���83�:��{Q휶�vǯ�������e�����C�2ۻAf�9�_��Nb����_��g8���d�i�g̲Z�K��j�d�ff��N��p��"�ÖC;<';�-/1�]����T��F��2&yn_� ��܃�M�-Q,�����6F�/�k*)��,fY>ܦ���SI��0�8b���=�͔����-�d��j:��9�>�q��LtEk-Mb��aj3:̨��y�.�`���kF#x�2#ǖ��pZ"q�et���P�`�.gM�`�"[~�!ι��R� G��Ê�e�pw�sd�4���|��|2_���|1�6��ş�oo^\,��{��O�V6�ޓ�.o.�>�E
�H釣G'2�eo��W��Qϣ�G�
������/���������W'/��c�����5~�������x���G[{��0oY�_@A�Ϣ����L.���-N�w͇��Y�\ί픮�����4}D���]]����������jAb��Hl�uْ
H�Ia J��L�����=zJ|$ءuױ����j��`��y� }�;O��u<y�\\<�t-|s5!l��o��[��w2����xҘ,�O�,��c|;�T�Oc�ܗ�����3�C��C�t̋ɸ�#{��n�q�L�e��J�A<�PG��?Ԃ��(#�MxQ���arY�l��@#�Na�،�3���]˥N�����"l�#�n , u�'�ԟ��K5*�e+�v1�u�$� @�x�Б"�YNi�M�r���%/�Y;H�l-Cq��u߬�6��^kq۟|�[0c`(rZA5���U�h��"d�Y��9�2����`�Iҕ�@e|~�+(܄d�,7ע����ۭ�6ń샜�U��q��~����?={��gf�Z}R��vf����|zvWm�i�̀�)�:��fZB�2�a�lm��Fd��(�d�1���%�(�249�<����Ԫ�����y�]�$J/��>^�O���0��~�����ê���|tt]��G���f��z�Gy�N���˧w9?STd�,̺�V��z��Q4�92��A\�'�9:� X��x�M7,̛��%@�6�}�6���3��3r�DA�����귤�8QkB��F�(�D�7�����;ԣ
s�u��^�r�sT�� ������j���I�ʏ��[�����x���l 7��;�=�h����u`?`ԂNQ���,d,XѠk�2&�  ��ٶ�J����z�ʐ��=R^1c���/��2����c�p�<!�MPe7z�|��`�J��KK����#6_��i��"�����@�[{�u������\N|��ԔMs�i�9�)R��Ä���^�nv�e��w�+1�v;���	�������;����ɏ��2�y�L��;����Ҷă6yj��H;?
��T����Ƃ�n' -W�̙5�Lj���G#��FÇl
啼i�zq�'n��V�1I��_gr��|Qc�@����X9� ~l4#6@��Zh��<J�J���jM���g�����t���:���X�&S�b�^$�'Id�3�XMN�ny�ї����ʌh��H�R���&�#xŷ��xR2F��4oR�H��vR��H^c������2�q;���"Xf�oZ��l��ٜ��°p��0����04���Ѱ�hȁF7�pKɞ��{��>���� ��"74���� ��;��#oPH���`����3_�����:�x��W�����o��E\J ?����.���KF2;��y.3�mr�Hd�HEd�� ��
�E9=&u"u�9ة�|a��@�.�J����m	��/�����P P����X���Cb�Lz|b�pk�2�a��Zn���4����^Ԋ"\{�$�G���K�*!t�EGL�N�nǾ�b�Ɯ��c贱�{$�f��*�{t��aT�!�d������Q)�,��ǳd�yC�����;�m}�v�#hr�������u���ü�+�Xr9N��վhd��[����pbq�0:D?U�̀�n~���L��D;I�"g !��-y?��Ծ�hO&T�M�����UŃ ��e���U��r^�ھX����=�/�%��ב���6>^,���e)!����͞�b��'��f2b�L������E�#���BJD����Z�-�xh���ː�#�K�_�?�}����oB�?��/���_M�~����h��sCcN��A"�h�.T�e�q�k�Ň�'Ț[ș _�)LЇAR��D��b�Ⱦ�EAgVnpy���(Ax��A�&�!H�Mw߇mSs�4��ش=��0'_��k�MU�<�䦓���Fn�oo�635�q�f�S�ƓqU;�*�j@�kѴ�p=�4��s�\M5�3ȐA�qZ穛�i{T=����q墚TyjC�م٬�ǳf�i{
����*�)札Ʀ�U�4��љ��xvhA�e�(7�8�	���ѱ�Y��1���kU	z�l�c�nZ�W��pə"Z�l����d˫��am:e��:F,2[0~ZK������W��͇�������a�ie��b��� �����O H�nСG�R�BL�O9n :ء�b	z�H�P�u�G~U��ȋ��m�.��+�]��L{��8���*�..$Ń�T�.�)�e� {�Ó���`��u����D
�nS_�+���7!Q���k������7��al;���ӫ�}�6�eU��ޘ�D�r3cf�-�& Niup�*���X�����R1`��V5    4�z-�-I��g}���I!���ɫC,G`9��Hi	��� ���K*#*SֳG7e���)֡K�Ҽi��]f�!�R��h�V~;��Q��;���[���+�4��i%�((af�Jz�*-n�x*�8��o��j��&+� >�ܦ�8xqi�t������RP��fR�dX�,T9�v��'e�+��<o\����k\q�f�P��$�f�|�I-���u)�5�5tb�SQ�S?n���:�(6�!>�v&��xb��6X,XzB�ЈOB!�@��TԒ��>�xXJ��*�rɅ�(ٸ%>�J^΁� !'�U��?������=���#ErŲ�����ғ����tͶ.-V!{�2�E�Tڌc���4 \p�l1�]�T�^��'3؊Җe�W�^}_���wh�2�����8����[Pi��"�л�Ȥ9`��s��R�t�ct�S+� �Ii1Dd�MF�m�]���m���_��#�
�n�q;��t�^�Ҟ����!�0�(.�^�����ēB�'!t���0��H�&�D��L82W�O�v����	���IB6���'<0͵=틣��y-��A��q ܡF+��(��$�ϴ�� ��̡�
�' Jf8�.P���km
͘h�6^=�K�����������1��������� d�<�΂�f��`ׂsݕ,.��zrP����DG �e��V�r��"�� ����{���A@_c{�,�>�0Y^��S����j�qP�P
h*@���c�\Q�!�B�YT������TEX��z���Nbw\��XLؚv|s�Iwfk�˷��d�i�J6�G �V@g3���U&ο3��`�`���iC�6��'���_���5 	�ioHD��s�'�㳷�CxG!��dFd�c�1B�!���< )&�4�{V��eg,t, � �ɦKX����#ř걠)1H{��[П�T����q�%b���[�P�c�.�q�ד����L��45^[�[7�ꪶ[5�O�D׵�� �MmB�rm�*W7��q����<SM��C��O�
OB�3��zR�;�TbjǓI�3]��b����N'�h���b�FB�1ʢ�_B]� �zك8f�g�t�WJn�/�Z�o�}��ʐ2�h�Ow����S}`YJ�Lb�x_*Ǟ�k����9��+������w�r8'�#�����*��f�#�\<\�]e��l�轱�MI�ȨR��jI���&A��ay|xJ��f>��b���dE"1����A�'��I�k0{G��`Wl̊L�i^�hI��*��l~�@W ���J^�uW0?� ����,>i�[�q��0�q_�ȯ��~2�����UB���~ %@�U�XF��<w q0� �( ����"��C2�+�R�̭���9�[�{Y��g�v���#����U��a��Y-xs� �H&j��Ddd��W�U�H6.4�J4C�����ۥM��$���i��Y�v���)mr��xv����??�z��YI���XX�̆�!z��k�R�̐�c��Y �$'RjH���AWL#�K�Q],�\�*�Vƣ��[m�ߔT�seޞOWR��tto�> @�)�F`W�+_
��^� ���UB~�2&�4���(���*�%����
)!��̧�^X>����َ����ئ̴��6YK����%���V��ĕ�V�^����"@����M@Z(�,K��g�)�;���b����N����Z�og�4)&�K�0}�
d�Y�2�p��.�x��&�!�����7��Ab"&h�-��YƠD�
�K?�%K��=8�'�X�$^_M�����nn�+F�kt�K,�lWU��2����5&�,n�{�yy7�V�E�����'LdMe}����H2iPowb�IB�~��WEW�~��ؕo�_7��/���/_�W�ك.�[�b�JW�G������҆�:I� ���/haT�U����E����?��ad_�@N��.p�����:�2�78!�>���à������H%oW�1�5,��@iG�ZJ;�N��x���m��D{�:Q�
�q#S�=Ȣt_������7����v�'��A��-�@����߆B~"E���]��$��{�}�c�s�]�K�ё?���q�R(��X�t���wQ�>7�k��W�3��d��O�06F�c�U�]���>����F��0Q� `/�LU��|=��$�jl����eڦib��	c��M��Y%�-W�O\�U����t2�594a�8�YV�	 ��Y�j�
^���d���Q˔����I�`�����e#Me��lP;`�'�-x�˭�f�@X31�GE���O$�A�4����O�����lfǿ���t_�����lq0#S�������\�����8nD[�o� ���p��ѥ�Ъ�ȧ{�W�'�s@~`�=J����=ȝ�+�H���T�f똱s�T�R�(�n�Z7�S3?7��oo�z�����܅��񒿞6���W��ޑ��r*�BM[ޱg�HL3*z�L��q�-�({J�AW2i�4�������Hɉc�}K�}��A��)��x��O�i>���V�k�=��8Ҋ)�<Xn�p�:8$2d��I�rZ2:RU�v���=#0b6l�9owFx�+���H}#�q���ϯ�^\���=h�\xi�Y�ǣ���H_�΅.b�Nyv�hJ*�ixw�,QC�����J�,y�b�V._&9�Cu�����9�=�(:6Ty�@� ��]��;��)��mKQ4�EJ��Q*������ɀ�n'$Ź�����L�l��'������A��о�E��H�!	`�dD��Y��5�u<��T�7�*��W	���5�]�.��ih7�sɸȢ����	������կ��+�q(աN���s�X�`
��lt�2r @2��f�*B���;��]��[��	����j5�XN�ڞ仓!ߤ�ː�����͌%{��e8�zD"'�8>H5�cb�,�=�r
���#*�aŕ��A�E%r�FH	�Z��T���ȯ�.ԃ�h ꢼ6X��p��r*���fq��8���kp1\�I`bQ�3� �Hî,=K��d!v��y$�G�V�K�3W:�J�cST:�ݿZ�}Q�n�?47'�9����cs=_��ϟOO�+q�d?�_�����&5�Fd;S-���2���fq������z�
�����`���=��G�"�������m0(#�(����[78"%ow(�$�_v�{�����������.s$f�3��w��m#�gWi8t�M|���$�����&32�WG�-d?Ж��}��G�G�g0��5� :�!��wrf�M�'�\.���ʥ��}'��֋�����	�W�I��dR%�5�n� ��ո���:l�G��D;�}pB'��L.|�b�#'��y��+zHT���i�>+���7�Bϸ�u���e0ߤ/%��➇����W�����U^��	�:pL��0ɒY�e>�L���8"@]Fj�&�{+2Y�H���׀�Ȃ���u>�;�z�q4K.r\�ENd��.��kֲe`�jE�:�h��-�șDy]y�l�#�\�T(i�!)Vv�_b�PKU�����l��6�C��/�%�j.�*8z:����0���А&v9Vr����c{)�fU[ِB��_����� ���+V�00�!��?ޣ*#<�H�U�N)	��ي���	�C�Ͽ?9�LT�4���C+�q;�*eq���Up 2��!ۀf��Bsl	Rx֝�E-6���\��u�j�C7G
��f��b�;��c��?��^��[���(o��A/�A�a��X�	��Y�GY���H�u����F�ě��>fd*��b� �r��+߲�?��{��j
�Z�S���W!ZT,t�1�/�W˧���RGr���i4J
	8%��t�-�� ����v��2��[v ��ܪ28d�<����C��:f�N��:    S���;y;���d6��8P�����j�"B�Q�wd
1_��';�B4��7*8�88"�d��Ѝ���X�L����dw�3�i8@\�qY�/��(s��nD�c=��'��VO��W�g�����پ ��'�N��� ^��a���$'2� �kK٪ �]��F�շF�K��;�H�`������v��ѯ�]�#ך�� ΃��,axek�P�*df+G6Jx�
F4�����8��z��:�����F�i���N� �A �H���64(�P�B�W'�6���f@pe�6�'M��/ǦK	πh�a�r::"#'c����a�v
�!b�o__��Я�+>�'�үŎ 
|�yҺU�v�m8F[@r*�U��I1��퐫16��WԽ2���5����z�e�\R_�ɋ�J�P��М�H7СE39>?,�WyE���#y����2�R��F;�v��a�<g-X�����;uL�b�M�;������eQ0�9�wu9�H��e����.�ޓ���~��Y�l&��8Zk�� �̞���eJE��1w�%h�H���`V�p0��+�c�$���MLs��3ȿ�A�wؙ�����=	�s�Lz��Ӌ��J~X���U�ރ|Q,24^@���7�`p��s HbN�����މ�Ԅ
���V[�c��V2H��|�NlTɬzD�|�{j ���ۦ>`U�~[�����|������?z�4��@TzJt��Y
�A^u���]�-ͽ���\ԞJ���#j���a����� ��R��+A��]�����r���H��$����8��ۭ	f��Jޭ�>��/h� �.���Hd�-��4E�H�B�v=��;`U�Rv����ͪ\�i��4ɀ�H'�~8��o�樞�Y/9p{8��`�3 �ތ��C!SZ�;I��.Т�h_�e�ui��T@� �6[ri]�_o��7�^\���{M��C_�k�2#�);��!n�S����X��:+�oՀ$����h����Ə���P|�E��f�IH�Ǣ8���	���-G꾸5���Z�A"�##�)A�Z\_]�W?����@>QQF�Q�Yqc�.�&� ��+x����R��Ty���L�{^�Z�&g5�莫S���~�N���C�Q\�m�	|�v�\|�t��C����du����U��'Ƕn0w�Ɠ)���!��)�Coဦ{
ڱ'���J)Z����	±]���.y�
��:�Y�׮��ǆ��NT<�x��*�~}�5�>�ɤRV�Y�W!{��\�����Cg�D�0�Uf֎QyD�D�d��0�Y�;�ſ)�D:�]v��,��@\��+B<Z��04�%RK���A"�KN�xM�[�y
P?^��$�Pn'�}[�=4�JJd��AX�]R�*
�h`�G.�ZB)Q�r:��]3CZ�]/�p����;Q�Ϟ|7?+�8z���E����^T���g��c]=~n�W�B�$<}n���������"2��+�R+	�aJ� ta�J��DM�T�{�q��l_0c��F|�"!��h�T���G֦X���C�ZQ�0��]�^!5g��\��B~K�	9���_����} �� �҃�j#@�Gb��X�{�U	΃C�����H�آʡA �P5���LhG �����Be��L�y`x��J
��C��Y�[�C�Z�t����W�UFT�;��(ayіr�d(���F/|7��^��h�6��|v�~o��gA�z�\��ί���؎Ɇ7��W��7` 't)����X��'zk.�#�0KF8'	�W�8�xĐ�לTY�}�e[��եbb���v!U|� ��*���!vo��,qs������4��c���z;:y}-7B�hy�<��}�x�s,"d����û�z��e��U�,�Si����+��z oe\�Բ�wl+�J�n�� ���m��!Q��&T�%A�_N�7���� Z�⢂>^-�ȸ�a�W�_1�Q<����~���w(�q��lnTBC4T$�W'��W�C9�"�@��jX�T$bSy�E����p��`_�����⾓��З���O���Dh^�Fo��E߭�Ֆ
��>!a�Sa����"&G��W+���S9ow��r��+U�
m�B�7�W�nߴ�<|�Wa]q�h�����0O��й��s��K�E`�!�D�ʨ���Gm�����E�U��as�Z�0�q��5�,����/��7���Ͼ?��Y\ϯ���A{��U/��	��AZueC�d�8uI�64�:�
��CݽT�)"%���B!�j�{�-�c�^�N�~���Ц���J��F�#���З��������n���~�J�Է����;3���子~5�� �L��2tP�p���V	G�S� ��olJ-F�R����u)�Lf�̓"˦(��rȻ��s����x�Cfa��� �J��1�|��܍�K�{Ȕ&ǃ�;�Kؙ%q9�9>�.�K�]ր#��H�(y�N�����S4�
i�������+�ECv���R�7�1���O��st���/���͆�yTU7�w��?��o^"����3�>B�
�x$&eɺ+?�>U�F�(����~#S֚�2���^��\�V�+&L��B��C�BnJ�Lp)lE;���ͻ��-a*i��`�DAr�	LG�^�.�o)�˅�cbj������nʐd!zupc�_����� ^M��?7������jS�+޽�.oM�^����6�� l⡊�f��	Dr�x|z��g&rQI���)�x..��� ��(���-���ر(n�iL�w��Y4��BYc:�R+�Q0%�B����� x�i�ɾY|����wy��U�:�ڪ�gbߓ�=��}���}k���o8�J���!�bܘ��1$
JZ��D,��H�ct�Ach�8@
ݑ�IWK�HyX�"?*]�]�g���Sϖ�(� �`Ű�W��f
�\9w�5W����������ӳR�#���){3�&@�df9�`��Z�&�5� Ʈ�0X��%���ʙl�B" �C���хF� �Z��'Ə����!��svP�I�E�Z�!��:���޴�^����g��Wߴ��b?��Ɠ��%�5�t�������i�h�$V���ES�EX#)��R���#^J̅�V�yH��S��x�v�I[�x&��P�]�b�7}�w{)��|,��NO��|������#���X9�i;Tg	�JU�4�m_	�b5#��ѵ�Ɓ�H1��cU�P\Ĕ���J{�Nz�>���>B#��> �F��2�0*|y�)�G=�ZR��'`80�1ڂ�1�y�z̏�u�_r�G�`���Ȍ�}��+ᤴF�q��{�׿('��hǓ#����t|��Ϧ �M�m�9;N���)��������m�@�ힴ�ݛ��k^���j.�4����ǠcX6W���7�w=�߉�^���$�t��T]�`z�
L����"�>zפ�,Q�f2��l�Ȉ�)��[��.M,˪A�f�[!X��83�E�0Pew:�t�f2����+6G�k>/��e�ffc(�iT1:�$>�q�n��=Pn^���h$�=�:��o�����;)j
�HD�:C���݅da,X,�H�Ώ�R��X��������$nt����ޜH/v�An�����?���ޝ��ϯNO���L���n�_-���G�������>Wi��zv��/<���<�cL��z��ʲ"U��@y�Q'�+<�
W��N#$�����h�����G�[�pfBk���� �:r[}C����&���p���8eȃ���łC�]A��ۮ*0{hl��/,r.��X�i�Z�
})&��r���c;6&-Y�R�J!���q�w�ݝ-�q��	T40������w�u��T�T���h�MTf2�U���h�HI6�=r�$f��H��l�ړ20H��d�lc�&ڮ���w���^GQ���v1��F�6h����B$b,�v� ��    9T�r���[Qfߙ>2!y������]���O^�>9�^���+pj��X�9c������v0d`pߒ�̮zh"��b���%�Og�k�	_� 6�ݑē��ma���Ƴ�b�B���=�s�g�ϯ.�.Ьd�XP��j��!��,FF*�<ٯ :�,`���A�ޕ��"��!"#sX�����[6��kQ��]��q`�r���T\�"./n~!	���;�֛��X6�Z�i�]���<i��}=���~�ӝȔ���ƅ�ra�qݝ28ѧT\^ޙ�t��_�@���%��THy�X�nu��iCdR6��9^�n>�x� �sw�#�t��˧����⢹��K���_ͧ�����n�n��ޘk��!G����uhM����u?a�	(�z�Xe�����o��L�ɣN�⁁�'g�Q��>[����ȏ;��v���<D�p� �Y�(즽�$�m��+�!7���tz�Q�=�ͤ��>=���M]�I��OO�>�����Yt�����G�7��#��3��?=z����b~V]�˷ڍ��;
y�G;i=�!>^�Y���]F%9j�����a�L~B��5��f������M)HO"
T"s �L����4P`�����Y'ⶠĪ`�!N�iW����y� P����us�fq{~�g=�ʲ�v���������m��@-�lYQ�D���cے���%�4�~<8���8��f�쿜�ػ�O�������#�!���].&�վ�~�oy.q2�+��������81�W!�/[<�D쮡P�.*�m�ߣS!?����g+�6�T���!�3h c�πn-_�N ��\����dy`�]�0�'�s�3�w�dt�wkW��͋�2���k�6������_~>Y���y���R��S`e9�=��]7$�i�vrg��N1�PVf�۬�_�xn`2R�Z�s�ـ�3��g�ePf�Wf?) �]��k��ZB2�*�&��D��f�qs���aY����������w��?���9�ɤ�s��{��z���k)�CkK"�`MOMc]Ę�����<���H��hs�N�����Ʉ3��uG�u��}��N��R�'�b\'9��P�ڮF�{o��N�����ݝ+���?�{_�k�f�P�y��}�"%r;ց<ʮ��+�s��Uɪ�E�m�Ї�!b��%k�^	٣�Ji,�qd��g	֕�V�Фء��T�k��Q��h��_Ʈ�D7���Λ����߿��Pu۳��\2 �Kum�6��ml���I�V�6�l:��'�"�a�m	�&rx�bJHg�3 ���60��[q����vi2�Dnp-a�X1,���H�}�Y��#Lass� 0a]�����6X�6����rQ��O�b�g5b�[_��������#>�+��~�o �<0��A��8����>�6gi=����$�����FS��㢤��r��X���Aʤw�֦O9�X��ۙ�B<Sf��ӕ��pʌ�Qo"���m��׊:�o`�FY<�H�̾q�a1�J\�nQ/�nBnI�С]���EG)�-��Dv,��T�#lm3M������u}}~r���!I��V"u,�X|2���g$V���P`�ħN��0��X{]eJ�d�vn�?Z���f��q����\�po���Ǿ��.���E�h��T���:�j�p���Q��V��֪��2J\a��w�0����]cʈ3ɑ�EӨ
���?�ϲ��&,������c�'�'���^�~�x.�u���o�px�T���˜�Z� ?�:wj��E�s��A��<GF�b���%",(0s�҉Wr��)�h�A�n����L��ɐM��仿����n$Nz �M�%����_Cm���eՠ�S� 
��@(�á�R��&�X��w`ν-ru ���5G������Z�w�ѣ�X@h�� 3R������͉#QaV������)3�,e6�[G�nYǍW��5��[��'FK�U5�Ӳ_B�p�#b�%B��L��<� B���h7].&L{̱����ŀ�1d[u6���ᛇ��I��?�;����yFl�:��i��Ԯ��mE;�XM�w��	.6'T��p\�]%�.I���	9L�Z4x�:a+	,�o����"��J^�ǉ��t��+�N�/�޸�v'��������rO�W��N}��ۍ�os�7���`L�D� ��ZG򨀦�i�p�B�BԌ�c���&K�A3OM���$Rw{'������j���\H�>����\Y,���*w@������!Ɏ�ǯz\iE��d�
�[I�`O�d���2�h�+2���pl�"���Lř�[���!A,��>{�a�'�1�V�vR��aa���(�dމ>�d�u�xZpJ=�E��X���nCѽJE�.��j�t��4�V7�8�~W,|�T�[�G�4����/߾YL���i\�_~��'�~���啹�}���"�nb�@��I�!���oY<��FA�$���ɅT�4:u'��E��z��Zc��`{�;P��2��=wq'}�۞*@��^*���GfJ�M�,�KTZqv��-uێV�y�ٓ:j���ݗ5�qeI?�CO3E�}q��ͭi�vK���"�@�"	���c��w2o�@��Pr��"�X
u����d�Z
hT��Ʉ>�7tw��;���?_Mƿ<9:��������ņ���v�z=�v�w�h�F��u���Q��+�m�2���F�-K&�-	X*C[�<HI���Tht�G+�v�c�d-��Q"�1�����-��{����D�V��*��LY�.
���
�ȭ+�S��]�ݚǦ��}�v���b�QS�r���`�oL5�ֆ#U��d�0��1��"a�/��P*P�qv2XQ�5ѦZju�,�ϫ^�1��I�-h��z��W�.�W�}%�W=wY�ҙL�o{ĵS凓j���>%��NQr�v��72�n�ިX�)@�`�aZ��\M�e�&;�E֛�q��y+G���yp/�=�{L۸v�l$��r�˶Wl_�[^Y�'e����Q��HI|}rBzi'w�K>�'��������F���+p�t�;hj�����YB�N�1��[��^x���~7?,��_�"��O�eJQ[ӤU&'�4����+֗2t`|s�Q&���%[&�TO��E��7��Į?@����Y���M�>���V#V9�&�
�}�#ٳ�1$4&�؟�������h� �� �Z���2��r��!=��(ˊ�,܇Ժ�l/Cڕai�;�12z]R��'�[���~�����IGt�{���H"�3U>�DW(ѥ	����|ѭB�!�YIY6���a�+��	U:��kQ���f�;z�؄��v8��ov��a�$�/6�wғ�٨���x,7+��H��Ԑ�@y�%:*AᑌM��4���yY�0�e��=.#����Sv8:E��������m\�%�𠆰�n�xW��w����k4qO���UONǍ|���k����,����2�0Q��HA�� Ju!����#�P�[�L6ا��Hݎ.PMat����X��u���$R2(��$we�,7�������˭@�_N��x����oy�*r���*bn�(�n���|f�;��{Z�BB��@rAȱ�o�&#�R]p���
���uKZ2��ׯ6+E������c`P��Ä,ŀ�����.m�x�\F�#yqP)L�M�\�2�˱�cw@��*[�tX�$��F�F1o�����qiK�y��g�����c�Q�d�0�'[1$$�)Ӄ�6NO�f�=��L����2?�c����uT����Up�͏,�Ol~P�l�vk�i�GF�e���%ށ̞-��F�6�V�MP�7^&(�r՛�V�{T�̊�k�R����oOꫳ�Qs!Sd$Fl�B;G%?Z���MW8pQ�iJ���R�Y�c��ppkӔ-���m$��N^d�� ��Rdc7m���5S��	��    ��%�}�L�a�'�a	���R��z��4�J��J��d����n��x�
�r*�5����;�*Gms/[��T��w�"�i.�Q�Ta���q�P�����78�X�E�\�2W�J+QL��gW�0lmCa�<~��Z:=��bi�Z%~�Ƕm���`L�Zz����'߿��HO/����譗!�G��U����۵p���jT�CII� �2َ� �k�h��Йz�$�*�#�it��&]�����b)���H�
�;�ė٥"B]"	{�v��N���gG������h5�"��w�c��L>m���9��,u6	���� ��$��+��1�2L�Tшs��$�U&�Z��1�%;��\�,���	�r�e_(K�0�봼A�&ݳ3�ߦ��ԫ�aN��!���3�F�C@���Ú�"��n(�\��@P$���B2�cPP���j3j��F��P��;Ж�����������t���������_����>ĕ����e�X��D.r���^�3Dsu�b��+
w�ip1;Kջ\�Y@�V��4�֖�% ]���dl@����[=he!0�Ȉ�C`��OYA��YL�YTHב�Ky���@%����w�	�� ���W���V\֞��`jc���H訩�Xr���2��b�^H��q��,��2�>t�dFײ�a) ����fD��y���j�:o� �p��i mO�n7��X���1��H��j"���]b�8�X�+��L��~t��f�?��q�*O��|YP�������l�Z}�}+���p~@i��kĆ�Y�T�R!���*{�taÈE�ȸ"�:���zK�
�m��җ�;�j�*�?�<�=s(j���^8�7r_x�X&�w�XP��mY��ԃ�2Ί%n�eY��iwG���a�5^Э�cG5�G�^>Ū��������J�	J��DC�5��Ե�q��b6,��e�x��.C� ����	6A#�[PT�L~�"@Z\b1����e��B�םTW�u!i��`.кǙ	y���������]7�#�я�w��u��g^��22a���LBGj�U+�����"�B#T�<�}c,L�G[\oM�/t�I[A��y3���Դ!�5:Y�m䦐��v60�^z!�][�����#���W�N/�gg�P�rĽ��:��6��O��l~qZM�j0�W�cz�|#�iث��W�N����7��L���dqV�6��/�Ƒ��a��X@ז��X�HC��!��	o��5L�wۻ��%���GS*=41eh������n���ڽ�HF���������n<P����\ɍ$ȗ5���`��z�	q��%`A���(�T�ۇ^��v`S4'(uCj��F)��]3�lH�"����X��(��f->����d��?���n���>�c�4d��A�3��,i/=NC�LH�A�B�iHד{�J���J����\��5:���f����崎B�7�(G�[�,7�=�?��?+���=w�k�b�� S�ݮ�1��� /��Y(�z��.�Q�G��B9�HO�J�ׁ���K�ڌȼ�|c��=�	�C�]Z�C��ؗ���³�&�;�j�%ٴ��c2���EG�gw�����SE�/�i�㩑:Wm�^�c
��a4ȢR��Ⱥ���P�_2'e	��pp�Ps!���0"SI6�4����~m�&�~k���y1g�dco;v�'�g�9���S�=�q'`;�rS�f��؏H�Y�ȗC#�4�S조��.rd0�.c�=)��S�X� �U���" ���Ø�� :y`��&dm{;��W�9�7�f�}�l���k{@bDvm�eD�d�^��M�Q`ըC$���bp��ϥV�S�p�Tq��ٖ� 9��Z;�()ʈa
")�$��@˽��'M������6K���ru��.����"O���Z���r�>��0N~�mm��[����%��=��P�8G�)�ڪ�k��H�⟠� Kn7�A��o@<qKv�[�D?"�gʊ��ȩA��C�Y�}��,	:����|O�O�/�]���5�?�}�I�vY�$Ɉ��eWd�X��^v�i_:H�<#�i'@���	{����k�cq�Z����oT}�ǻ����\��7?s�=8�W_�������Q��� d��!	�m@�����j\tE�ؒ|��"�B�v��*�`��0ޠ��\V؟�H-h�k"2�@P^�I:���J���J?\��{1�:��'W�b>_�$����BQ��M����zYV���An���V�I��
7�76$�+�ynO������3��k6`�*_�����=�
?6gKG�r�]�v,�h�!��,�_��R/uT!D����w�fXB��9$��5X����En�a#�jH��xܻ��][���Og�b�'o�!mW?�S.���4!��x��A�����^ �������1��$>�,T����e���p�B����P��r����w��otEh��
jy �l��{�h��ħ��D��kw§�x�5���ES/����N0=��Xl�ܵ3D�V&䚗� ���剙�.�	��d&)yZ�����fP��i�E�8���A:���?i��r~�S;�i`����0���D���Bq4	���d� �̠I��\Q�J*�h�#4(� ۏ���xv~��ȝ.�)�+���5JC�z*�d4�Zq��qjK������g��GP���i�^ȿ;๕sA/� ��N�'P����];��K����)qc��¼�D�:$���\X�GdzA2C�gd�Z��e.Bwi���\�8S�ad��;3��7�9�v���s ��a�DY���� ۧՁϏ��D��n��M��Q�����A�����2i_P��^�<���364�"�A�O�5��,$qd��D'��#��)gY'�'���qf�AK� 6P�I�#��}i�����0˗T������yU���-����?qxX=.�G�o����d���� 4K� ���<�S��:�2����<X��H�Zkp$�$ux�D6N�[�b����*na��j�%�,f��]����0Ku~Y[Ȃ��C�~��^~����`C�˗����?�
�F:�6�
ZǴ��I�r*�iL�������~׼?�/�,�{z�4��b�.����'��,�p�z�򫯾{q�|��nzˎGP�����
��C��6O�!����:z��N:斠?$�H�W6�IpR�,�5�j�B䖒I�z��
��@r� ���>��@�$�f�ܜ�gނWP��s�^���r�8��}ўMG>�w<�ǡ�Q���3��F��,���G����jvW7��}rk��s\#�Jz':	�׋�����jq$�zO�Ew�HR��2D��q�CI(�Z�
�R۴���e�ڡ�{O=�Qr���[�v� ^���� v[��@��ix���D����>Ya�=�q_{�*�i��c����&����@6�'�'ó��PEJ�Y�6�� R�
����^{.�I��AxK��J#F�2'Q3���:ĸ�^�ͺ��7]�\\+'���V��>|2�J�9�_]�n2#��/�G�|�����ގ�!qMBؒ�t��"�
K�D%{-NQ�d�� Pr;��/PI�������/��&p��S���;З�{W�K'��3C!��|<�����6Ow��֦��� m^*��m�B3�2Ad)�$FՐ�S~�-> E*�Y��Yi@�Z�Q��{E��/�d{h�%�$v@m5�.�*���T�����+�]LD�~�� �V���4M�=���6�� XŲ�y�]B�d���2���TP~2$��r�Sn#zi	�iE����0w �l��ѳ��ܱ�3�1v�x�/ZLO�����@�=b̠�L!xG�u��Җ�yZu�ѹ��T1O>MPq�dO�<��Bd#<��hd�xНe��.,W#�UrLɎ@�C�D	Z�)
c>�*�<!�b,�aҲ�    �9W�=C�/���XUbl��~�3����_'���>2���w��XB���g�}}�|�HLL}V��l_�����黺������Y�����?b���wo��?����m숟9ޖލ\V�	è�;����HrR���T��d0��	(�	��BA%d�K��Z�E�`�]�]A+�,��7��UoEbB0H ��JY4dLj�����s�������&�%�'ϛ�+q���I�{�1�_����c��>�_�����:<��7��/��w�/�_��]��m������ߨ��r����� rM���V}�(tC:),4���}Tfđ��H�G(Bn*G'^�>�#��J8h)�&O�a�9;�Cn]$�BJ!�f�T@�b�l)���)�-��W�6�t����k�|�23@����ð���O!i2b�X0_��ٺF�6�� �P��(�rMp�v���b��	n;Tp:�������G�15���ݚ� �0����"���bĪ��Q�J�{U>�ZL�ݎ�Z�����)�'�Ǩ��Qz�����ߦZW�:OW
N,�X$
z��Z�i�-�`d)�;���g6�i�b*�d�fp�k���,�ލ́A���%��zJ税�����f)urdp�={���(�-	|��� !�]�/�:�ظ�~�uW��㓓��Τ��<�~���c���#��{���Q=���z��G��ڧ�����&e��8)��y���~�Hm�Jf�	�y���<��ӊ!�/�>�B�W���xa¦ ���`�}uR�$;��f H��:�����l#�2Y̖"w7?sC���@d`��+7D��#����&/K�S�B�Ck��-Ջe�-7Ҋ� d�X}q �sK�� �HpQY�A��1��D=Mj��<�Zq J0����R������qu�x&Q��j�?ƺ����{)�W�������˻|�j���y�z��%�K>oP81Ub������?٢�P\}�xT�{���!$�08H�P~DR���@���w]�sB�<����V{��O��^5�efϯ[�r>�9�M��ч!�5*,~��4O�tq~~��M�϶9��f�X PA�U�a#B��D)�"�H�Y�u԰�h�D�K�+F&k�#MG�ȧð
�B�.D�>��O9g���g��NlH����\,�ݞ��t̺^ٿ5�����9�m|�+?��ń�b xݶ�[yк�]���R�BI��lh��1ux�IkX�T
4��������_Ҳ��@x�F�+2t��7�&ڍ��G�o���vBv��xڢ���AΉd,>YMI]�H���i�Pdh���ɡD:�H3�� �@���-�w����k�$�=�SBO6K��.7��͛�}e�2���ɓ�����(�7Wӟ�;߶�W�z��P<��F����[N	��s�%�k!�#�]�	�����D���གj̅�0�=B'�Q����暼,(�5ݬ��Q�k�,F�$�@�y���q��1آ�n,����xf�w�ip�����p��\^�r�����
��c��;�����m�Rj?e$nFf�!�����iB1N�E�s"UQ��)��p�Q�mD�^y�@NG�axF��,{���Hw��N�<r�h��%��ĥ@��1W�8�|��y'����iS����W_���*5�L�tn��)5���@�(F@��#�YH��̠�E')���!J,F>h�q'ND���J8X���h�5W�����F��.J��hE����}�1�wW�|^O
��������Y>��1��u��A��L�����
s} b�����Jծ�,�K�
I#��Xr# '��v�� vŒ��Z�1��@�Y�J�݁���~mP"�xԬ�8K�r���zN�&�EE�]����`Y�ֻ�|�5�d� �a
�dD�
��D�)�D ��� ��l;±e�.��ձ��:+�5.	�3�y��o�J������Pl�[�R\\���ީ���/�g�x��{�Q����i��=:�mQ
&t�d�/��Tb�@�)bsh��Fk|Aq��b�F�ne���r,�i Z��|��b��O"[�3k�ٲ���e��]�%/���_nK^�����K�6�Nx$������^���뇦;M����[W���S:Q�ӥ�Ni�R����-K3&x�
�9?Ğ4��ҾG)��9rp~~�����^)F�X��-���Pe�@�憡���:�2'�xY"g����� )�������T{Cəl��T��m) ��¨R�l]筀l���wœ܊���r���F`�D�]�����A��!�6�u�f�S��LB�V�L�/&�96��9t���6�v�����Q�����U\��x
���t�DW "���w���{U�@� �����M�*n�I�*�7�bX��1?#7Iu�h)
�=pD���mfB�����������:��'��.��!*q.&zJ��rg���<wYWlXO�3̄�!=f��NI�8bF���R��Ճ�8G֤�$pِI@����8p'��v��_�.���Y}�	=�7���������ǧN�E�g ��%Z!B�,��7�	!�����@FO]&�a[ݨ�1�Q8���t��%@�\_�	�]Q5}����;9��9bIx���ĵC@�Xh�]'H5���&�v �I��eH��+PƋl��L"�Ț��yC�k	e��L�rs�}�2��+��e&��ahtq�QWsޠfڽ� ���SmX]�F�秌�:� ��b�.�v�%��AjdC��t��]��	@(nD�Ae�~�$ܓq��ڜ�v�7e��4P�3�H9P�c�wX�s��e��E"hLb|Vƥ�EȓI�6P���0�	���ׯUG��:�M|O�~���OO��p�W��b�O��!xh�!ia2���L�0��!E�Ʃ^�K�J)�������]��(5١{hO��
Zƣ��F]�3n�7������EI�_�^6�`�"����������y��꫓���]���?�T$Y���Ä����<(�pu� j��\�2�Y�wV4х�IL8��`��g2�\I�%rxf�(xp?jx�PDj�f%�Ưs�na�9٭��y'x�K�2������ �0�̷гF��Z�#C��x) �XB������R�ssx��+�;-cd0���`(��*�+E���[T�\�lO X��ɪ�2ݩvN_�a�a��S����dI�*S쌲����j������yV�JzO��뾬+J�����C/&Oޗ�<��$��81�������*׀3��j5�{/x�ꗃO�+>�����?�m.N���s���߰��F�ܡ��BCZz@�1J
�]�n0��b@�`Y"kɚ��cS�2���@���@�جi ��ָ=��y��� Is�L�sj�.lp}~���U/�s���/䷟^}��G{�F:}�}D	l�`�zNg�%�^�;&��T]S�i��ѕ��Yl{���,�{,Q�`��.�S�����ٖ���cQ�����:g�lTqx�2 �X�����fAi�y>���䤖?/�����׳�˶|�O�TiZ��@<��!�Ybz6r$���QhR
n�FL��e�Ci����܌b�8�@��ဋ�9;�p�#I��mF�ħY����zT�(ߌ���l`M�Vdӑ��i�I����~e�>^%��~SViќ-�}��يP|��i2��ztAȮ
e��	��y�ë���{h�'�k��DyV>��o��Ӳ��#����1Y����k�����g����4{(T)�W��珏/���{�/d9@Ǹ��BN�4T%��V.MT5��W!��Dy3�c�?{��{ 7�����񹬘�f�f^M.��#�4���k�W�aOOӬ�x�O{��W�� t[��fIXp����N��e5��\��b�j&�˓K���_��0=���c;BFL�� ���e2��[@�NY�^��xh��}��K�    2�Kk����?c�%����A�~���ȟ�I�]֭Z_�r\����w�gּ�n>y�L�ߝ��Ǚ��U^��̪�Իj�&�Y�<jr��o���GY���F���[��r�!�HqY�`�'?pj׾	�(*�.e= � d,a$��P�#�L�����#9��nk1bJ֒��`{:]o�Kf�kؼt�Ad��lz>?>[�h.��g�����Vp�{Ն���U��DΨ�r�����A|gjY��F�!`�@bٳ��.tR�ڔr��E�s0��a�j����;xp硿D��hu��p[��⼣�a�OL&�V �+����E1�����هnp���A0d����r��������a92�g���g�<ַ�!��g�o��Ύ����Uy�3`Õ�Z��2���4Ϧ{�n=cww2���b��*��*�����LU���al�Mm��:�i=tM��E=��ht&EKX��٭c �����H /K�ѬuqɞP��rr2ր~�����*c�ލ~Pb��G�
J(t �J�W/�nM���<��8cW���	wҨ��>����T!�6J�b�!�l#s�6rr�o#	���6����m$SZ�<5�d��8uSղdd/M����z��F�{:�I�(2����EH�f�a	���\�܋La�!�4�����p	��� ��L�F����57�An��QW �1��g�TI�/�5�R�y������B�U;`p�.S�����!{����������$,5�;�P�F�+�I�ʹr3��sJu5��өʍx��^{HV��g�����o�r�
T�1(����N�e�ENG���o<���
��)�x��1_
�$d���3�B�v��V�p�m�Q�dM�<����e�zX׻������M/����j�9\�?��#^����/ݳA ��߹��3�n�f�g��$	w�NWj��uY�8���	ٵ�g<S�A��[���5D@����1���z��Kw�H4����B��"A��n����J<�Qh�(6���!�=�K%p2]�'�Χ�6�7k�i��楣Tk��vӱ�6K�)���\;L�Ȉ�ۡ�îC
��ʶʷ����R��ƶr�<�N&Y܊�W΍��v�q5�ә���Z�����n�	�a�rxd�.9d���V�RI�.k�%�g��/����	!���6�lx+U!Sq�|'�T�xJ��^��s���?)�0ԥk�,C�K9����^�����x���N1�ed�(��կ������y�al�i<~'w�/����+�A���_�>�m�����G<���]��C��>o�+[��/�U��B��f�<4̃�@i��i�X�L�+$#2H<��g�����6�24�FF�&!�* �W�:G��c��`��Y,�^Y�,u�衯}?������L��f��.랻-�\e�,�`�H-f%���Eu��	��`Fn�F2R����0����,��]F[�g���M�a �Ոp�ҹF�p�k����e��ԓ!�:�����1��>��êY���[�\��&	�14B�@�����+ʰ����J^�:Ef��>�P(Q E�o���?x��
�.�N��/�^6�
㿜�x�����B[���o��S��B��t8���:$O���������*����9о;̑I`E�lZBv?J]���
��jzaH_��Ȱ���������m3����^ԯ_ /���r2���~->O%g�>F�o��\ynW�Qz�0Ԉ>� :p#�� ��5�Ĩ/'T�n�J���*��=�6���(e�E4LA4�3حr@G
�"�5��#;b�}#b!,��G�O� �p(��(��s������h8�v�峟z���N�{�Fԁ ǎ	F ����H(����9B�t!u��ZJ�s`�_�E&�f� .$?��)F�&��L;��fĘR@�wɗ�ܨ�������������W�Ǔ_���#$&<��~�����Y�fz��ES�M��x��[q ��7\�_���͂����p����r�ۇٻw�g����9JGcc'g�6op�'|�/T��t�G��D*�Qu�䜵鸑�ˡO*��2f�3X�82˔�R%� ַ@2�.�[�Q��X@���f��na�ϨM��M��[��/z &"�d��̓=h�������d��YP�P�"� G����� 4[�)��"���2���f�4]����&���O�[��۷?={���$ެ�@UMs=�@e_���ո�3k�,����U��O�6g��nY���?���Y���.�ɽ�hI=+��8�����lZ����8�be��Ok0�ũ���?�O|���l��r�E��f�<	��@�	��Q}6iN��9�q��md���Lm�ơ֕����ӦI{��󳗋z�<:��e�����XOj�J��|�I��������؇�i�^����fx6���0Q�L��5u圼5M��}����&�ޫ�"g���痫��)O�8���xq<'����QY2�_o�Օu��W���^��:+�Ld˾a	�����I n␃�7�6����;*�u	9{��b�J�~�N�h��*�%m��|~x"_�����t��f�����O}�U[�h$�Ҍ8��B�]�E����ʠ�d+�h�Q��
ǭ.G��*@@�S�I�,�22�֯?<�nFA�r���c�D�8ڐ
2n+ڼ��hú�U���-a��{�Y� !|B��_�C��<t�הS�ھ~m�gQ�}�P�vZ�EG�%�����N}�u����/ԳY%�p��EQƏ'6�_�M(9be�t�Ӟ,�]�=-m�T  ^2х�9$�,�^],�#�f��b�[�RC�o�.G�0�y �*`(���E��;(D�gw� ɠ�6h�UZw�B��cǻ0�}Ϊ���#����ч���KY��g�����{`�z8r������n}��z�\����̌��:��1W�1�#?6��@&����7u2cY�WEv�˟]_�
C�]�������ײ/-@>	�����������uz6�䄷&D�T%]�n��sL�%�#��y, �n�#�?���c�?탷X!@�S��)��_�׿�ɍR�s�K/�4WT��jƓ�OgUfJ�y`q[����V�E�����`��.`K�C�lAB�\�B^��t�-�/Ht�,"��/83l�,�C��]���LiCs�,��5E9����jԘ����o�Y�n�5o�ge��˝�xf:����) �󢸘��R٧�b0c�^GZ)J^NHM-�P�9>�� 5qN;�Ԗ(�pd@�M����&����������?:�_M�:~�w�g�_]v2Us���rpMe7W͡ܓo\]j��8�~�`<q�D3����c�s���j���Iz,�/~��I�;͕ǯr5��XM*9{�8N�8U���q���Ĝ��z��a0j� �A�O9KȒ�d{�JN��/�"�,JDf9wH|)>�&P�F�R�0�Ʉ����CX!�vv��1&����6aP>B�H�몖�2/�J󑹤��jl����{k����_?�=�5�������jq�����^}t�r���C�����7���_����vPt�rF#3m@��ZJI�[(x���Ź�;ڃ�����h���PzA
�#�V;D ΃:�JǦ3 ��R]udf�%�k�׳�6R9_�����%���@nj� ���)%��N�Z2���gS3���`N;��I��KӦ~�z�|�J�U"<�ԏ�@w���꧃����t���L-&���9[	�[i �vL�'K� v�?�At��6.�9{�R��s\�EH����cՃ�[��d�D������n9i�8�+��'�hv��u H��ք�!=o�7l�խ�z+���v8���cs{O��l�����=��a���c�H�*=�O+��H��ʇ��_�Q�ށn���6�'Dw��fT��GV�Za��3R�H�fW�"�8�/�)�b�"1$!s*|���(Ez�=�*{��8m�{}�!��M���v&r���u�*�H��p"cbK�	    �<��Tj�j�"7�@+A*Z� Oſ�bC�,�T)��,����	"<�̲&ߊ�۱]ᅼ5��v'�x�0p��D�myƧ ��̄a��#��\ �l�%6��ޒ�� �P@mi;AWHA�,�Q�,_�&3ت�����Ȳ�fg{�|�0.r,�غ�V�����𪗓��9+8��l���6�q��\�7�>�����"N�o�mȈ���p����᪄$����$4�M���*]�����,$Ŷ��@xW�f=,AN#(���U�e'v�k�� wSj�`SamM۹B�L�:����C����
dS��7%�*D�C�*�s��^��" *j�s��r�̑�\8��89�r~.'4U�)�! H�%�t��
�[��^��!�y
��kXb0�d�Cok�o�6xoС����X�i������䦚���r�`��'���f<�8���q�1	<v��0��>�9���0�BV�_��C��j&gJ�π��H�g
��VH��$�e|Ʋ��aP�l��ԬAb�"n�
�q�ښ��|/9RRwi�����{�����Q@�WW��X��(U��R�=|��ѓ]�ޱ������]�L�-�7�g���"�"�veH��t/���]���I^�����,G��n��v�p����/���X�y�4\����7����#[�#�O��#8;��T[1��&B���W�]i-*4ui�KAA_�=��f�aI|q׵�,��[�aD���2d�Ghp�F3|�,a|A�#��h�d9@%J��D#����3rV�<0ʒ`Y6eA>�\$E��h�g��2�o�Gb�.�'?�b�:7�e�X�L\nx�K���w���qw�I��9��!T�q�{�s5dJY��a�P(`�	�ny�yʲ$���@����Be10�s��1��Ȭ���l�M	�Ug��E�]��Z	��FD|�s�U�O�[�^�;�^y�Es������������TnC��}�+�&�}�V�#��ś�7㷳�[
��Ο��s����pԥ�W$x����P���dQ��� �Bs]I�F��	oΤi���Z�j�&�f�``��:(����&5}D��z+�ߧc�Qھ@�Z2)��
�_.l(b�b����Z���g�}�������L��a�g��Z�eK�q���x�����ټF��J���l3�w�Y��{�^��]Ԭ���S.��2�h�`� �(�!H��/U�Z�mh+YX1�������rWFG:;�Ґ��CV擑��:�Ӏ�-�5�� XX?�dv��G��,׿`��c7�M�U&�;�iv�JOf���4��|���Hc�*�����$H��2����&9��. �6�f�U�t3F�]5�ֶjL
�YKX�]�%;=U�J&h,S��0������릙�z��:L|���j�ϕ�D��c	!��u�~Ҩ�`�|�������r�����ǕP�QXE/ա�r#�&�'��KnS�@�2*��+��5i�e��u��-H���%���@�5�%��P?YqS����� ����*�w^��vK�%,U��G�`�2���e4�e��ډi�!���E���ն �����Q��D�|&���[Y��1���]�?����ac�u��zVWNξ*ש�\?����~|&��&V���z�\U�� �Gi����Ao�ڣ]�
L��U5z��E	�
de|�UZ�% �T�'Ncײ�\UR&��\�Xw�!18�אE���rQ�V�F�}E�淵GPi�#���udPrtP�J,s�>a�;�PYy&������e`r,�%�z	vG��h�I�t���.  ��0�)7ֈ����O�4Ȥ#��T�Ō  �݀�#P4�72p�'+~��|�!��̄ŧ��i*������\T]I�"�N�G���r�Y>��|���5���WO~<xLa���e��B��s�&��/���F�����9�o��/�}�}�ZV��o�o��i_��e9�*�"&c����w\5�Z��O�T�P�^�����[��T���V�9<�� g�r��`�ȹYKQ$�ڏ]�_rNy�=.�������^��燧w�Q�X�ǽw����Rt�	�)ȤD0�C�V�#G&�J�e4p�����!i�V����6K��홷��.(��U*?:��Ç�z��� =�����t��^��> �=�p����w)�"��f�2p�� o�))���5�R�H2j�~�h�s}�j):v��}"��Ѣ?���^��@���g����Cf�V�÷�ه�O�"��oN��܇#U��od��yr���Em��p2���T��E��ȋ;�okH��xtM������aPE����yu�c�o
�������2Hl\9MF�$C�/�(��X�a�2I��x)���BV^]�њ;rr�j�li���ߏfL�%Т|�A��3D�!)O�<�
���m`���}�Y}����z(��1���]2�*+ Y����0:b%�ZG0��Aط��Y���Wstu���3�sm ��A��J˷���:���]9�~ٖ�g���g��&�i#ccȭ&|7�P\պ�A��@�bK
 n�Rx�� 9���8xo���lQv��4�������E��l#��u���w�p�r���ץ<�^��lѝf �
#q�\ۗxq�@D��Kx�Ƣ#&�CD�KdO�l*��}l4@H���]�2��� ]�k�bO�nGA��K��I�x*�w�����G�� ���[to�[~��'Ix��]b}����k��}6��go��&�z��x��k3��fb�,�ֆ����$�P�V �WY6�uh���t#Z����F��5 ���('� ����!H�� ����e��b	%�dW4��Q(���Y1
�"� &�d��mT��������6�� ��Ch@�{5�{�ק��rW:�@[E�^�7>�I��ƫ�U��S��E\޶�B#���Mܬ��PǙs.���,���ŗ��<�5x�3��9�u��r`�.�1�悗c �!y�T&�
E
�n�����? ��D ~EQب6zB��.�U�tZ#��kV��HnUg4�S�V��N���Ԙj쬪l@~:K��������������o����x�\��ղ�T��������}�����)s��|>m.������q;˕:���dv������d"�o����O >Á�%3L3�8c���5*x�Vc- C %.C�w���/ɝl9��s�2���r"�3\�;�
�ب���$���I�"�~�Do:5h�b�ٔ��
(F�/�k*)���,ǲ|�U�y}+׼[b�Wp�>�_��=�͔����%�d��j:��9�>�qs��LtE�+Mb��aj3:̨�Ê|]������,B �beF�-��Ҏgu��9�ѡ2�C��G�;�5僁�lA�-�8�5>(���82H��L[��T�u����/&G�����:%���|bݟ.�]]<=Y�(�����WY��������d��d�`��~�{�R��;Y�+��e��W��`�A;�_�}�����y�8�4�{��ٓ��������_����{xË�x����5_|���,�/� �g�N{uy(�`Zދ��]�9y\7���������4��<��n�x��4�;+l��D#���k��C�z��
�.CS�ds��'A�0��C�f
[&S��)�`��]�B����ZA���y� }ַ�W��/����'����7g¶��[^rc>r�F���O��e�^�˴x�f���~l��7\�1c=� �:�O�����ٝ�jk�k��-���Uj��&��qt�	:�vl�F�&<�(ND--�#[��R��p�0]���� �ۮ�R�}�,����)�wD����n<G���p@w�F�Nw%^ �.���n��ā h���:R�9�溮#������%�Ӭ$~���6���kַ�=��\���O�fE�A��ݷ�MWZ�L �3��� �qz�yzJ�Zb��e7�j�g�g���MH��ts.
�H�!P���';�)&dd�,c'���]{�~z���߲n�ޫ���M���jz &  <��VG[� �*�c@lʲ�F>Ez+�������e*K�Y�"�#��1@м�� eQ�&�9C���fH-{�o]%iW��~eS�o�ߝO����_-ί_?�\�]�����KUs���r���l~qZ/��WmT��?{t���e'���]WT�pCU/�;�7G��:�{�� XF � �/^�醅\��~`%@�V���VY(�3��3r+���m�_V�#ǉjj�3��%
���R����U�ʬ+���҅z׭�o�Y�뷮&eb(?��o������_�?]�'k      �      x��mo�Ȳ�_�~�h�+�s${�y>��������G��\EZ���{V{?�
���?bg&y1�8P]U�U���Uwe�_�u��?o{��������
�'N0��U���?�����������w�;���,˸��Gtmo�dlW�;��z����{����t�X���.���{���s�]���&���ֳ?ڛ�䳱��N���;q��=�~6����I�T`/���)���~�w�V6���˴��X�Cg�͍�O<e�k�[w�A`����ܰ�_����\�cDd$_��m��]	�����C]��zRK^W��|O>脉=���\��Ǜ��ؓ���~����\��]ڽGÙ�3w�m$v��χv~��텃���w�^{�F�Tb���#�?	�<�"ezA�;�:�W?�#���1�C����q����q��ߢ�qw�oO~w�;�Q����e8��Oa6��#ODދ��㝧�{߹l+YC�:�(�k��c�����پy|эo?���do����N�>�(��	��W| F��{�X�g횱$~_�!�������˝��^�z�����O��x���;{>�7��Q��~���v�����mu{;�^�����W{��t�[b���U�S�$i�v����G�Ng�ii����� �]}(�%
�)�I���h��*��c��u�FzW�F��Ԓ���ꋊ���Fʨ�뽡2���	uR+��ggڵeKZ�,������I74�0A�M���:mU�Ҫ6%^�$M�п#��:��&��-EQ�����_9ny���*QK����	�w7\���i�(��@l�G�N��-�-AQ�w:=A��m�^,���=���Y[:9Bw�zv2:\����x�L�%�۷l�1���0ܿj�஥.j)�`�0g-��dAצ]IZ�aǣk�2eU���5E����_�f9k��I^��ܹ���s��8Gc#��ݑ�&�Y��wi��y�e�}��N�M�SWǭ:Q�?���ӎ�#�no�{�2�r7s�S=�������>}��[�2&}vg�W���޽w��k��ި�qFכl:P��g��0�lQV�V�����-IV��)t���()�Б%[W���ρ���@�����$aj�z�p�ҕ�@Ю��,w2����⬛��oo����u���8����L嚆u�>������i�V+Jim���� n"�ԃ��3�N^mt�{�EM��K�~�>M�O��dw�S�|�$a�h���d�����au/ˏw��^�I��6{TS��,lMk��]of+���ᓮ=llc���L%I֍�g�\>ḽ�[&f��
�_��ic�qƯ
�j��p����k��ZB8-�����>[$�A'w�����;gX��F��\�D�P���n�� ��+��*���3�dP���
R��ˑ����[�O��&�̼�5�����V;_��=�������S�q��
�9�P�syf���D8���&#�:��yӻ��SC��;��y�3���4�?jh��54�xMN����f�$D�ؼ�ɦ;��t�����3�g���)��9D�sH���&��4�Q���Bkr'j�6�M˴�GYx�̺�L�פ���~Z����=)�f�R��9�z�g��֔��_N�{8Jt�G#�J{&�4��<~Ѥ�f�
�@
�@�:Vː�nK�ȊԕMT���q�HE��:�k�%E���]����8��Ş�콯�A"���٣��^�T�(��L^�'�����9bެ��|��y�6��?7����r'��-4Ӫ$��iW�ƏN͜V�&
�(�L��4~�if�Ԋ���Q3��L<��"��T������$� ڼZ/�c�Ȥ:Q��p���a�֥�DZ�TWN�~ 򩇓��L�~y��|\/�Ur^�����k�|�_ˌ��#�0���:��F�n�j�P~@F^"�=FW�2�q9iO�K�mL�UsS�E֬�����=�`��˅��Eα��t?�ng?�F^*a=�)�1�(Lo)>��)�?7'�"?If�/X��:\��"�fc���%��tE����m{2i��S9O�,i�pЖ|��@r��B��s����jϻ S��D3;tA�
����(����%vA��ݰ�R���s-�2�Z��@mI�*�z�O������H���r� T�?z�}��kg��ϣ^�xW��p ���:Һ�>�jv�,vA�Z��^�ck�n-��:�צ_�D����w�㓳��O�־���@�[�V���*pa���/�_��=�Q��s��osG��[H��X���E�軦�lk�;�ve�����O/��zc���Z����`�v*���j��v]�b���.��W}��QN( ���G���M�SN�����rK��>L�n�Qn:�`&�V�v>w"Q�
�O�p�p8�E�qƴ�x,"H�b18\��-�q�#� SL�|���Y�� WE�Й�H<�@�K|���S��K�d������	�s(a��!zzw��b��ݭ&9X9��{���ōo/ۏ�ƶ��S�
��A&�$�o^�ŘO�е|�^�:%�X��qf$����	�E��8�̢��
V��x6ȉN�:'}b��N�Lp�ӳ�7��������}����P[`�G;WE	�������-g��ndg|��#��H��~':�:S+Pc�� �%?�}�z2ȡa�g}�u`���=���X�:����<���g䢫�KMy�yԔ���'��V���vc+��yx2&��D[���s^lU��~��G�V>a�6ž����������D�����xͶ���̳�;�+������*����]:A��#w�m��"����{r@$/'��L<����pz�u�f1g�����\w����|D٩��X/�;�����h�j�����ѽ�oI� ��� B�y_D���
��t�H�6ŇW��5�o,�{u�� �5���6Q��.s��a�����7W��]]�m�)���a,(�%zy��Օ�]7�A��a�����3���no�p�eo��y���Z�b��mn�"v������1l�6ܼw�qp�fv8��؆���(���k��:|�ˑs�'�	��p��@ܜ|�d@D*���� ���}N��MtŞ�@8xy��3k�h��u9I��LtcA�_�,��[}E�_��c�_��W���E�_,�O3wu�گ$39��h�W�Wl|�h��,��pC�h?��� �D�I3�r�(�O2 `pV��Z�@}h?5��z���i�4���v 283�OmB� �O��B��`� ��@��+ڟ6�����_Dm5�5��4E3�)��߂h�~� ����$@�����D�ɹE�E�����~�"��E�����	��&�~���S�����~�יh0D ��2�~� NM��O>�3
4Vsh?Y��L4!`!��y��A���G�~fH�M���z Z����^ +��39��V�{ d��~��0�h?ICxY����4�O�PI��P9IC%ʢ�$�D(���4T�,�K�Sy�������~�6�dS���SE���,E��4_ ��)����e*��
���^�O�{r^�O�������z�����c�@���4��4�O�D��y�~j��U�~�]Dh'h: <'E��u�>D�����'���A3h�5�mi�����g���t��~&�g5���E�x�h?u���h�O97گi/!f��h?k�T	�/��S���U�O�5�`*��L(H�C��t�)^��*�fB�I'��^�O�����H��!�Yh�tY��g�A^�D�3�!>1� �;I/��' \+��l<��T�OV�J/��'+`e���|�{��Cmd>�9�2����!.��'�a9��C���<�� �f87���/�S����d�Jx��D��W��gr@�93�w<8K�9d>3�@(H�39®N�鈬�(2_!2_�����7�^z#]'R��=�5��q����2�)�
|2_��t	�c?&�Ψ���g��+��d~j<ʢd>���.H�39 <ʒ��<�Fd~�W   2�Z|��gP��:��(�d��0��<�jT"�TN�D7$���B�q���^��W2���%�_��W2�� �iƫz�|d����UO����W�����J�'�|e>��8�>u�0�O���E�|���������_�O͂M�����4<j�Xӵ���]���g$�- ��,�}�M���`��� �ɀ���A�� �H�;}`}v���12_�����Iu�<!��Z�@^�"��HWl  �Zj��r���3��j�s!���)*n.�Ȁj� )�χ?��� ���Hg<�R�@  �j� Y�S4"����!�t- � ����*B�в�Z ,B������j�V`�Z �G�u)� ��Gj0�@m�@��DWc� �^�TZ� ��OhkPO#n�l- ���� bi��*_��n�t- ��j(���I��P� IC5�� i��B�Z $�P([���
�k�4�#��pT�.�X1#����5U��C��W��-#��E� ����_V- �բh� ���RT���"��W� �ed6\�<�������BXS�Z �wg��H��� �u��>��n����^����!��`]�/4\�������`���/X��A�Y�@*�,�_ �:D����.b�]@%4_F���k�K�|�� ��PʪZ��k�q��`B���Ϫ��Ã�O�.� �*<��T=�	!?/� قjR4T��)�9� ��@�S�Z L2ȋ�j0�Z>1�`- r0D�sT��Z d�k��nuE�U}� �j|�|��k�@���`��HzOA\Y�� �p|R|��S�v�� HkX��֐U�AI-��Ag9���J� plB�Z �d����S��F'����G��@�������`f��k09��^�LG,�E�P��6�������U6��.�kP��|��������8�v��Hu;�Q- v[n��/] 5e�Z �p���`r@x����0� X_�����y��"XϤr`tcA�^�B������5�_��W����`=�xU�r���ә���5��z����דe��`=��u��I3��UQ��d���g������zj쐯����A�Ś��'�rΕ?#XOm���`}��&���z�{��ƅ��d@�A�� &[�#ם>.~o�"��!�/���a��`b���	�_�N��9f��߳a������g#*�a�d�e��p|V��os'�o�� ^<�sO�C�a��Fjs'��a�C�i̝,�;����<� j�sg��&� $5���V��=���;Yr����I�4jsO�� Vjsgz�Sia̝��'���{�� �*���4�D���IB��b�$+_s'i�<@Y����� e1�X���c�$�(���4T�,�N�@y�Ҙ;I�B���4umP"������{�/Z��Nơ3ݫ`�:��
�c^��!5/s'[P���1wR\����cq5�0�4�S�4�N�D��y1wjA�U0w�]|D����b��"'�gnP�0�ȫ*�@��ܓ�Q(�8�N~C��s0wf:����;��³��Ė:�=O�/��S�=����Эx"|Y�]'�\E ��1��AD�4�������ʘ{:�RR	sgB�Q���ܙtx(����a�ԫ�H�F(l�	$����-��BC�;)R�s0w ]V��S�ͩ��3���=1� �;�=/s' k[+�l<UCT�NV��u]�;Y�,Ԍ��ރ5j���p|�z�Ѓ�.s��Fx[��;��N��g�1���u��Up"@5�=������ܙht||A̝�Agşs��I��;3(��39�h���Ǧ�}���넹�`�}a�=�&�Ko��D�t���F̝�$��=O_'�Ǥ�
��c�LgT;�����r��/���ƃ�,����l�.��39��9^���9z�{��Z|��{& a�u���؁[��gC�*����������o�y�      �   �   x�=�K�0��)|�
	87@�ؘ�T������iף7�S���â6\���B�3YeWz��N�`"_XH���8 x��6i:��MxG�#���5O&�
O�=�*���p�q}u���LE>��N�F�7`���>($��UL�]J���V)      �   B  x�u�]�#;��OV��������q��L�q])o�da�E��Ý���������g�5~hz�9���?��ʗ�K�u�^P��t��Di��'9�\,�p��'��(�;]��CMO�ze���| �*;/�6�,Wv��VN6RK� 9��	`���FG��"?Y�&�l�,�z���J�l��Ҫ�_�� p.�����ߊ&�\�0(��;�(HKa9�����X�Ȅ����z�����l49_�#t��n��Y�ě
w�l4�MА�K�ֽ�
,t���6X�ly��+������ ZY�0P��M�l1h[HF�k#��uF��Jv���*7��d�ِR�!�m Toe��j>��Q6�l���<S���reg�
C:�Rٸ��s���xĠ�e�U6�!����ɚ6�]�n���՜��e�*lt:Gzt���F���`t��e��`\YM%�Ӥ�Lّ�:�j���N��x�e㌡K0 g�]��n����Ǹ�1h�d)��{����UK��	���d������f¶�p��[7��;�>2�z��ˎ<עt�� ��X��Wk#���&�=ε]�[o�@��+�2g�ސ����X���$��(��e���ی<���_v��d��!/h
U�m[Qϫ�K(g�8��Q`{�@���1VP�Wv�'WмC
�)����ņ~��diB%��lv�����x���߰H��8Y��;�Hgc�м��1��G9��f`�e[�U0��l*��n�X.l�mo	Ԕ;s����4����&[tfζ��0��Ҟ�+���;�M֓U�(渳��i�õ@��YY˹-H$�n��$6��C�E]��zB���E��p���2�YN���	Ԓ�Yc��
�A�V7�<hس�s��*�i��^XKO��5*ky�.(���y�dX�}�~X���m�(�-��-���CK�y�Nw8"����A�y�Ǐ�+�rᓥ��?�,�	�k���ľ�V�n�U�_kO�+=� ~����~�,�y�����W�m���(Q���6D�LT���"检0Wxd6yNX*<s=g/'�,��ƃr�G��`��� lQD�
�;�f6�B�A������D�
n�֜yqAԡ�
�����^aΧͰ�L8H��1�p8WC�Tx+���'�z��X�����8?�z;�k�����@D|+�e凯hg���x�?;�5��t7��!@�+���E`2�*<�ӓ

C��)v�W;)0�hY�ِo�ҷ�rgm��{�{��Pr�{�mo5*��;�ѣp9�& �|�#J�d,Ԡ�p�x+�D�^�� U�U�      �   \   x�3�tI-NML��t�I�M�+�WH-.H-�(��)�$*$���� �E�\F�~�
���1�(�OR����4U� (��I��ϴ=... |�>�      �   �   x���Kn�0Eѱ��l�I���	�k��頫o�����כC�ZK�K�m�ޏS�g��Qv9`��R\f�T�"��b���p������RK�����#�`~�X�f�@�]t��k���ߵ���y���iK�1�ʉ�CN�F�T\����>h�l�.%Q��irN4���0�{�x�7�]������-kz��#��H��E𯶓���J�x�4���NV(����0��~�      �      x��}Ko�J��:�W�B��B#��G���h[�z]Iv�/�D;�)�.Jr>S�Y6f7������}�؜ )[�����B9m�F��1�>8Ag�>yKw��N���[������N������u?lt}}�����z����������ظ���wu}�rv���`<_�.F�xa�����t69�Y#k~}�:��V�__��l����wg�Nzz����>�K��MG���9�C�FІ�*hO��P���[�E�)���y����/0�۝��E���;?xpv��0X���ɡ����ff/��Ŵ{��H��s��w�-���e`���ggs�m�?:��������}us1�gp����;Xb�x�:�̔��d�Cǲ�!����ky}=򖁿�_��?zXk�Lo�fw�	������W���{r�����Lϓ��)����>:땯�i_����Vy��ܯ��D�=<ރh�z��:ex��o���r	����E�辵w�nV�O�脔���=>8[��v�f��I��l��^h��w~��t��])�H��{$�|T3	�ջ�[\��w[�ۚ�ij������R�hm�����������stw��:7uԃ..��>�ޣ6)������Y__��������n�V�Z��;g��׫�,?���Z�gӝ�O�������;ܰ5�F�wX���M{������W��7����]xG��d~���]̻WW��ò��b�S�[oh[�wD��9��Y��y��z@���6/>�̺0�;m��Y�tpik��3&�-EG���%މ��Q�]�>u?�s7���H��	���pp�@&��z��u��3�ƞwF�n��n�������|�&8�9�#dvaw��O������l2�©q,����x C�2�%�wő=�Y��`��H���Cv�a0Z�Я��pd�/V�]�3��L���\;t�5�@��d�����+����R���w�;$՛?e��g��6p��g���u>9��V���(A���"8�����߽��-jj�EMt�lVNag�xk�v�6��tr1�wa�+j&�̽߻;���]������v��3t4\;7(n���e�νG��,jM��mQ�fh%Kg�׎�n�'��nصa����sԶ�Y����A��ӿ�9?������c����S����z�6��ޭ�g@�����$:\W��`(��s��Y; �ڴ���!��B�1�s[x2��}���b�s`=vE�dh>/f�5��/Ɩ�����"��.��qv�f���L{�
{� �?��`��z[8cش���)�P�{�h�-p������VJ�f*���5�
o�h[��ATץ�*�&G���`M;��K�L��Za�wn�oEmL���S����6��pJ��ho�,�v���@�����>P�6��S6_���0�(�CS�wn�&�o<>k��sg�d<�h���`h͊�[oh�=8
A�����$:�;�"��:
�}�Qr����M��q�t�p���_�����E�(�����q�,�5�j�g2�'w���I�EQ'&��_�� ^N��������H�8S{Fгb�)�GX��������n@bn��+J.`�[�����t@��-p�� H%�A�����xfu���캟�	Fe��N���Ɣ�0����� �-�IE��a��i���)��PL��v��q�k���K8yi�{3}��r���o�A쮁�M���^\X�:��(c�X"�I�$�Q�q������|v����Vp,��Ͻ�n�m��EV@�
3M�����9�_�O�D�u)g�1_Y�����dJ�W2����8�����I�_g'6=�x�,�ٽ�����Gt�:�t�;�$���	%�f¸�F�Zѡ]a�T���NR�v��~������4�|�FDa㕬������e��Z��ټ{9/��3���G��f�v����v0��]C��a^�HI\�����=�|������m־��f����~���i4����l�mgzub�W]�L���堯����ZϚ'�l�L��=�A��깧΃fS)K,S4o���5՗��
5�{P3�?�O�^RD�����|�CSo�_�]�m����*�ʉb=��~�6��]�H��='P���	��+��b}p�K�r��S�<x���H�2@-|���)I�%��rlZ�&���^�'�ހ���
0%^�s[����5y��d�v���R�����S�ٕ�S���XL`�|~ڱp1�*G����v{g�_�M�קO��oy�U���2{����OgS.+8%g�����q_a�Sb�s���S��f厣���!a���������ͭu����k���]^��k'���{I	�Ғ|�ͩӨ�GJ�Fp�.�q)y��d�-��FQ��=dxP����@]}�U�`y')�;t2�Byr�j�2����*	����N@�V!y��#��C�J�w�!����6v�T��>ʔ�*�����,����>���q)�T^ro�š�S5%�Ggu�͓�d��il��y(�'%�g������p����r/����������٬:�`���1�������M��-�4�N�(jO{� A�o���F���id���5UF�uw�6�`k�����$m�+�A��J�w��v�m?{j�K���6�O�+*���u���WL������nf�������~��1kt�_��̗�����=j�ʋ���r����˯�|Co^��5��&WEP4�W�p����AmBw{x�AA֞�n)n(����* ��U����2j�د|Vͯ�^�Eo���_��!���-?+�p��ّ�j����hYm�-�a�x;��(��`�ʮ�����ݰσ�g�Ѥ߅I�:z�����B������n�`Nܨ���R$-ȥ�����^>�����0�{�ǫ6�{rh.���{�tf��"/p��B(Z}ѾFfɭz��4�P#|8����Ok|f���Or�k�����x��=�a�Q�\s{^���05�T�����B�@������'s��/��[.'�(DJtj��l@>�O͖r�:���s��٫���A%= � ��;'o\��+l���
ۛh�/�6(�����5�)l+Qp��<�K�\��&�v�֛��T������L���a�׈�[g�֖><"P(ׅ����+E��%�T�����s�?��(lˎ^����B-���1v�ȴ������]m	�_������ ���B�����`���k[�V���TX�he�� ��sAt��u�#�-����t�b�S6�2:��|�yx�T�8���������)\j�Љ2,��͏�v��=�;��i�t���{1���D:��N��ŠPꤎ������~?)l��N��wn-
7GI1��
z�X:cI�����a[/<@��ଁFSKCI�Li����
A&"X���CЪ�y������D���L"�B�@X$F!�y�D��u�YQt��~���D==x�`eh 3x,����au��Ϡ�qaKa��''C[����)����sr�6\�� �_���,4������Lz�+m�b)%�@���VJV/@�b��b�FЬ85�KPX�O@�9DW�&�� z,z�	����s.�{w笭{�G����`�O�U�v���I�믎b����.T��k�r���N��`r��׆�2E�`Pd��	T_Q_k_E�{��$�&:��fj��w�X�E��� ���]ؐ�Qi/��;��ş�s�i���?�G(V�j�"��@kK��y�_�_{�*E�kw�~�;��^i�����s���X��b�K�}�`�.��z��<k���,l/��� V��8#DG�V,�3KZsm<������%������c�ݒ�R�("��Cߜ��^?���?��""M^�����(5>�H7#�^�Mf89`�+�H���6b"]h;���#�!�k�!�֬P6	�,�V.Ê�|����?��,������E�    ��̽W��a�����u6���ٛh��s���^M	��}��(�0�v߲-��<��jg���v�"-�P�E��=�a*��#���u���S�|Oyq��/Y`�
���#�އ����S{/Ș^��P����6xLsgS�#P��b��M65�_ݟ(��-X�N��������X��@�߇�vj�������+P����pȪw���X=0@���|0�T�5�և�h2�B(����A�٪^\���5D����
J��&�(֋,TϚ/@e-^'���VK�W�͕����N�B�5��kݹ��D��N�蹥��J+:��欱6���B��%v��c���0	Z���׾���o���4)���=�F��3ja[�+5��U!�@/fK��CK8�Gp�'p���X)��03��
/-�t�#�T(�S����6��aP��?YT��)�^�cE ��W�-���'X�=(�eF�T�Ș%�a��������%մ����P�+ќA��R<Ţ^��%*��wY2 �<����s�m�D�w���Z�gh1����6Ɉ�|V��C-��g,�LJU)\��2�m���-&��ׄ�
q��L�O>�v)?A���6�e���[�\i�NH�-G���{^��9F/��$+zi�P%$�\�Wler��p�3-�E�Mcn�P���O����Ǫ8����oa����lP�!s���0��N���)�����b��KD�68�pJ8hT��	Q
���̆����W��=FT@�#�q�+V�ATj��y�	6�����-lc�H����-�R[W!̌a���Y�7�<�k+�����ܞ. }3�3�-.�g�&��X�?-lP�
�*/�VI#J���,���'�(6�3y��+Sޗ��\�I�o�h56�����4�����;k$ofJ�t����T�K�#��:4
�Ib���aDu��aDu��fOu�k���f|�E�s��?��ꇽ�8\)��鸞i�o龑��d�)�5�5=�5�W��(��v�EM=�bY�cO�^ǑF	��H��4�@P�H��+Pb��+P�K�c=)a�������>JDUg%����R����R\�IF)��$�����:�/Jͪ�7J�/p0QZ���TTe�)�5�sj�v��a7��mfj��35h]�F*�f}*���<^��Քij���/5du��z-�����KMR���&�� SӨ��R��e�85Yec����1NMQj�SS�$W)�+����z)e���Nmn�Sf���)3+z�(c5(~�*{%(թ}�dEr�r�<P�r��S@9�A�PN�z(��F�ن��*�z�2U��B�)uB�)�uB����.S��!SA��X��㗩0j�XSa֏y��5v�P����P!Z�Q!�ڇD�^)��J\=n�JR9�JڄW�Ҩ�+Si6�KPɪ�P�ˣ��(E������]/f7t\=���I�hvC��o�U#�ݬn�Qt������.�D(z�`r�&7p�`rW&7p�`r�3l�*�c`V�D��Bk�XT�A1���n(­�Mg0����w�[���*(3U���'l
f�Q��H�K���1!&fBt�u�����8Ukf�ƃE�?�tUQ+��ʡ^9�Be�S�&��9tm��ө�O�,�$Tb�j2�8��t-ha���̞N��lq�U	�aV[I}{u�ʠ߻?ť���h0��fU��7��Uz��
lO{}����?���(&���vѹ}1��	���)<h�� ,���6�L�{���H̏K��V�9)���w�I��3������Q�/UR�tT��G5y齪*������b������\v�6_���߇���bܟ��5��c��߯��wA\�,�V��0ށÈ����PbPj�U�I��0�ժXz��Di:ٷ`�ʹ��q���Ϳ�N�����-�ү�r|��ZSe��+Z�1,vu�T�Y6�@�ɭ���DU���Jr��8Z��i�}��w���� 
K��8˯�C��s���SB`�<��(��(w��m<JV�fr3��=^8˛�d2�u�{�B�:����~M�Ŋ{�(u��������Z�y�~BVG4�i�͝�bo&�`Fw���̺�q-��aQoF;g�u�kG�����Ur�U��|zu3��Qc[����0��Sq*��@��;�y��u!%�'�q�ZD"i�J�?4P���\�h�_��x����.�]����"ݰ~���?�����������$�_���>�@O��A�k����f����w���Ja��(j|��_�]yE�(��ָ2�TЌ"�;g�`�"@ƓK������<oTG_0L�	㟑�?dLDXg6{�k�|j��o�$�Zv7��t0>;4J]��B�������o�0��މ<�'3��e�^�9,�.�V�l������������P�.lM�ڕ&_�Ҍk�݀H��ph��Wqop��Kٝ�T�x�V��?���O���(���z�ŋ<��k6�@�w��d��z�K6�DO�e��V�Y�[�k<�k��&��Wsef0�hz3vw7O�8�G�F�����P�o�71�s��62����+���n���7�i��p�^���5ʬ���'k`�I|3_]��٬~U�4�@��db�R~y�/2��|n�u�P~��2�b��VuB�3�����D�ǥM	<8��F�&a�s�G�����Qk���yԚ��fG���ּ*�k� `��pԖ��DsU�����~M6�zgHM�N�F3c�j�LA?,��ܸ;-�z>�a��l������a֕�D�򑐐Ҧ���ҦFܫ,]>iFM%��M��6�eO[��7��cQ�lH�<�d
��M�L�M�]�Z���+��gB�:��Q��1u��{`��m�߅ݨ�rl0���Iמ�#k�q�e���qԗ7A���ė3����^�T������(��e��h:��鉆��K�0��>���p)S��˵L4ѶAs��L��Oa���L���B���Їk�h�1;�E��2�<DS=���2�"D"��Z&Z�hn�_�B=B33]�Dc���e��2ѡ�I����k��P�d��_�D�������Z&:�5�<_�D��v�c��>\�D��v��^.:���e��'�ǎ�e�CY;�%�E�ײ�4�58�s��õLt(k=LE.:���&��y>:��5e.:���e�g�c��2ѡ��8�_��Z&:���8���2ѡ��,����e�CY����o��Z&:����sw�õ,�ɚMsߒõLt(k}�̽�õLt(k}l���k��P���羡�k�h#B[���p-�Z������Z&�E��I>�G����p-�Z���O,������|tt-m���g<Wg:\�DG����'_�DG��i��t����d����_�DG��E���k��H��I����2ё�������G�f���p-ɚU0s�`摬�q��_�B�H������Z&:����/-�Lt$k}����e�#Y;=���2ѡ��'4ww8\�D����!5x��~U(�3�Ҕ���#��Ij��vz�gv/Й~y:;;�M�?�3��h�br�|Ҵ�>�{�����_hS/%B�1mRFԚ���Ĵ��ӉK	~�t�2���u�/��6,m�g.�h�Boc5��b���$hKMm�Da��Pkc��2�+ dFB�m���01��a�$m�@I��%�6̛dmX?��0�R�a;�|����2]o��2�	�tR�if�
q^��FsR��fM�5�0=m1�+[LO[)t�����ŐD�[�-�:�d8m1�й�i�!�εN[It���p�bH�,�K,�W]U�N[պ*�NX:-�NX�/�NX�/�IX�/�����w��H62�rBPw�������]��_�k]�a�������D	6Voз�Sw�.�'�R{H�����^��+'l^#�F?�3����q���\5�T��m:�w��$z-kKu4��i�g���.�1���g�[oռߌ���,����k_��C`䳗�k���2�|-Y����/��2ёehX���    Z:��f�m_�DG��i��8�k�����Y�õLt�b,��k����N
�'��H�X/�2<\�DG����ި�Z&�����_�DG��Ns��õLt$k\ϵ�ײБ� Z�{�x�5�"AC �<=�,�4� ��C���"AC �<=�,�4� ��C���bA3 �=�<�,�4� ��C���bA3 �<=���-<���@�x c���1��ȸ���8n�d��� 2N[x �Y�� 2n�� 2�Zx Y��7� ���o�d����"&���)&�<�L�7� 2A��Ȅ�@������{K ��=/D{^�}#(�*z�،�"�Q��Ƶ$I�>߾���5,�
��4s8��D�8XɎ��㖹\�䯨�L��>(xോ�y����,�1<�E�~Dէ��Q�\�)�@��,�p��<It���4�=I��'\7R����s����(�������X%��+�^y˒�|o�|�<uIt����2�%L�s���=�	t���G��W��$:�;�#_�+�l���/��W8�.�
����#�D�{�9N{��o8�2^y��|O<Ǽ*�ʱ��nr,!Ẻ^���Q������Z��4pB*�<�xu�#?�Gy�">肈���6I��Mx��*�%�΍t�Q^��(�$:?ʆ���I��#|8�):��;�8f�S�\��y�t
��@�8/���N�sh�3�)t.�㼀c:��g�y��3�)t.�c����N��h���t
��@��?f�S�\�Ǭ�1�B�2�<f���:���1��@�ѹ�������4�Y�c:��g�y����S����F:%��e����AI��hn�sP��|���$:���F:%��g����AI�shn�sP���47�9(It>��tJ��@s3���B�2��L�$��47�9()t.��tJ
�o����$:���f:%��e�9K�$��4g��:���,���D�3М�sPR�\��tJ
��@s��AI�sy\��9(It>�G��(����ڻs���*�T��2�l�����ݠT�f�&[�U���l	�[�9�Ö�oG6`K"޾)[��Mْ��oʖD�}S�$�훲%oߔ-�x��l��m�Aڰ%Q~S�$��oʖD�Mْ8�![G�7dK���lI�ߔ-�"��Q~S� ��o�D�M��(�)sE�7e$k�Hކ9��s e�@�z�@�s "޾!s "޾!s t�s t�s tւ9:o�]�`�.[0�-��q�@D�}C�@`ڂ9oߐ9oߐ9oߐ9QE��́�*5dDT�!s ��@�1��Uj�B[0"b�2��-�1��1��1��1��A�́��s (i�J[0"b�2"b�梉��o��&h?�(M�8~�Q.��q\�\4a�yp�r�D\�Y.������hB1�o��&�Mrфa�e.�0�[�	��e.�0�[�	�W�����s	WQ�=��)LZ��/L�r��0�j!�d�C��S�_y-�D
S�$���
�+.KEf5��׎U�3+�c�E��*B��}�Z�ʁ���� ǯ
�̃�*A���d�aV#����R`���>O'�٨2�����(8oUp@�U|�5�7)� �Q�A�6u{�hS�W�6u{�hS�W�6u{�hS�W�6u{�hS�W�6u{�lS�W�6u{�lS�W�6u{�lS�W�6u{�lS�W�6u{�lS�W�m��J�M�^����+�6u{�ަn���d�K�MV���d�K�MV���d�K�&+_�6Y���ʗ�MV��m��%n��/q��|��d�K�&+_�6Y����ʗ�MV�$m��%i��/I��|I�d�K�&+_�6Y����ʗ�MV��m��%m��/i��|I�d�K�&+_�6Y����ʗ�MV��m��%m��/�6Y��h��/�6Y��h��/�6Y��h��/�6Y��h��/�6Y��h��/�6Y���o��.M�Y�Ҥo��.M�-�ܥi�I��"�ߠ҂4y�h�j|JSV,�&�^ΚJ�1����l�d�BYɌ�7ff��MK�Ѝ��6iIQ ����,m*⦬��	^zGS_֞�5�O�c�sg�l5lj+W��_{������e��LrR�]!UU���&�Yz�'�ײ��Kr�,�mS_{��GJ˗����?1��@ӵ�yZ�K~ѻ��<�W��ހ�Z��`�}\߇��M��i�/lMӆ�lf�a�X����f���҅Ur��������k��Ƅ��ē�5!������t���F04s�?�kw�hv:��/.���	���1�ܠ�y��.���2
^:�<�NY�)u�Ϗ����������4�>=:}��5�?�vN˽�R͓b�4[%�H�W���A(%��J#�h�J#e���XϨb��)�N��SIx�{
� �v�kk鬵�z�:��T/���w����M��-�� n��>8k~p�&�Gбx� $�X�eֱ��!H�?~�$蟼e�O[D��h�
�4kT=�m�q�&���ҽ�Z=`e�f�Ǒ���-1t�]�%��Ƃ'�mb�n�xXɡ���Ĳ�� �5�:9�h�pYc扡$x����:���:��X�"�F�L���f�<��)(ɡy��$V�H�Ibeʩ�ľ8�ظ�K�d�$�N�T['A*��)�i��<Mb���4�}v�&�f��7o�X�ٜ��r��C	�J	|I�H9�SX���5^���Wr��1�:��^-_2�%�X�$�%�"���H�Ԝ͜W)���,{�f*�$5m���e۫%�&�<4���)!f�BA �S-1tT��b�u�S1J�q�c���:�Il�|�$�N�zk�"�أH�$��b�ؗ�$��b��ؗؿ$V�"��X�w@D���b=*�^��Cb�<{��[�ש���N��$�Nݍ$�L��&�/q�Il�\��H�k�=K�DN���:������	ĥ]��Ib��.�
�$�QY�j�l�X��q�lg��OJ�7kh��Gű7��8��f���T' ���A��X�z�2�k�pRC�̀��]ܨ�Yf��J^�5'��[U0x����в�~���y.���6pRCC̀�Zf<О�,f���	x��� �YBG�7��pYCQNã���u� ަh6�Ic�G<~�j\ 7j(���+��o��+�C�?B���f�Ec~��+���U� ^�xKr��+�I�&�.&m����ƟO��W�wqD�7,Npј�Ť�ҟ��)�p\�lȀ���3�1��i�o� ܬY� �1��c�	!�c�	�$~B����D<>Tgo@��Cm�D<~&����@�7 ���o@�c�U-� m�T�O�#��8&훰��L�Ve��Y�6c[�{I,mL}㘱oB}c3��Z���f��Il�/�$��1��c��	w�Y:�*g�Y���I,i�]cVG�Ob��Il:۾*��Y�
�I,o�<㈫o�㈫o�c���P�=ƼN��$�4��q��7�q��7�p1OW�Jc^��d{^�.���<�Z�3L�
�r&4�s��Qx\
�Q!E�ǵURx�	�F���j)<.�ب�"�#V�Y5E�ǩ{��)<��ب�"�2.�ب�"�#�kԌ#�iP3����A�X�oԌe:��Z_%A�X�7jƒ�iP3��M����o�L�T1�C�Y�q������i�rp��@+w�u�?B3���#���qO�>p�e�~�.��aYw��F�2�a��rx��u��q����:K����
���&z~پDKܦ�?���x��� oS��mj��M������6��ަ�?��|  ��  o�	 ��� ��| �m� �6� x��  �͇  ��K  o�) Lh�o ���  ��k  o�Bh�� �� �*	��6� x�o ��G01�| �m> �6� x� �͗T�6�,1�| �m> �6_ x��`b��> ��|  �m� ��D t�6�����#���~% ���@�o�� �_V�O�	k�aP@�������� �_�1�ΨQW��M
+ .�Ph�b	$�~4-�@"H�B$]�>k%co #  G�8
;<F�����0���n���/$�|4��!��a�����;�(Q�i���Ƨ�(W�iTu�?As�&��DN����DT��	4���hl�pgL�U+)-you�@���<�*\�����I���0̙����I���0ě���I���0���:��p^��:�\���@*�o��W��
�Õ�A���w�yp8�*�xQ�@�3��.�'j�@K������l:�?AcK56�ׇ����;���۵{�3�������=����-���Kw��������|n_�n���^����)Cso�-�͝�a��d�e��a�:凙�|����t���Eb��M��l=E��>�y���c:�»�yS7���s}��ƹ�^E��b6y���m(�.f���>MmS?U2%�g��=�_�3F��S9���"��L��Ծ�� )�M���d�iڵ?�a�Ӌqߚ[Ë>���T��|a�,0P&��=N�AQo2���t7Mub�Kkܛ̫�q�Lua"�@t�Z���I�ipԳ�[-:�cӏ���1��F�� CX�e��2�LSpl���>p��x��s���44 {�	I>����v?RB_K�/��H	�/^"�/����/^�׽�*���|��"Kg�q�Fh��.F�����ZtpW�#<��k������'�`sC�fWĜJ.���tBEj���%�'d�����niY����e�n�Np�8�<�c����y��ޏ�� ���S����Z`Ƥq|X�BY�������Li8����l�9�ܫ��9�<���	玛�-���\��;fvƗ�1o���r��;�P���=T5,#
0g �6�7���Wu}�!��m{�N�-_��o���O��y���w��ň��6t�}�����Y� M�UIq�pF�r49�0��w��D�0Z���*��<�������yt�3�y�6�����|��ҍ�5��L�IO��'���	�o`���>��a����𚟘�fV�c&����?�W7�I�ތ���`lÔ��'�>��)5��������������f(�6u��݅�?����^O}�䏗�g��Rϛ3E����$��|�M�'o���^{;7��3��@۝��tf����1p����`I�	&l�~~3�G�I��8�\��<�uR�R�6����;oi�=RJ�k�M=	���bn�`k�wp������o369�}�Sف�s�a��J��������u$��_�ޖX�.aZ�x@����I����~��F��`�����9�����c�b�t��tV�\ul�έ��:.��J���������vP���N����{w3����g�)���.֋����h
w�96����΍|sh�m�0��C��oµ왥�\�S3��h2�lw����)�#yG�9�����	���A��������+�S��f�m�	ۙ�s���iJi�L���X���_�$f�ӷn�1�_g��:[w宵m�K������LG�{�}����g�e����h��`4����_��@+jH�u�69�I��p��r���3'����V�Z�]���"���w���_-�Q      �      x������ � �      �      x������ � �      �   �  x�u�ݎ� ���S�T����kT����u��Q�l�o_�p��^�����0���p{N���|~o��Wa�����.����c��G�\S+O�e|2�"X�9���"�g��q��e�oE)�b�i���������E"�#p�����_����l���~���EOQ;��ъąvW��kE-�Gck�_{uz48�:��8�v�Ԯ�3�Ϸ��W{{~�Ǣڴ�ۣ�VC��W«?��C���b�X\/����bX�LI��0������A�GH\$V�s��E'v�GSRyk�q մj�P��-���X���������[����ʘ@�,�3��
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