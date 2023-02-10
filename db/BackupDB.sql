PGDMP     -    0        	        {            TGAM    14.2    14.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16394    TGAM    DATABASE     f   CREATE DATABASE "TGAM" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Venezuela.1252';
    DROP DATABASE "TGAM";
                postgres    false            �            1259    49817    Analisis    TABLE     �   CREATE TABLE public."Analisis" (
    "Id" integer NOT NULL,
    "NombrePc" character varying,
    "Fecha" timestamp without time zone NOT NULL,
    "Fk_Sesion" integer
);
    DROP TABLE public."Analisis";
       public         heap    postgres    false            �            1259    49816    Analisis_Id_seq    SEQUENCE     �   ALTER TABLE public."Analisis" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Analisis_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    244            �            1259    49848 
   Directorio    TABLE     �   CREATE TABLE public."Directorio" (
    "Id" bigint NOT NULL,
    "Nombre" character varying,
    "Fk_Tipo" integer,
    "Fk_Analisis" integer
);
     DROP TABLE public."Directorio";
       public         heap    postgres    false            �            1259    49847    Directorio_Id_seq    SEQUENCE     �   ALTER TABLE public."Directorio" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Directorio_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    246            �            1259    41356    Empresa    TABLE     ]   CREATE TABLE public."Empresa" (
    "Id" integer NOT NULL,
    "Nombre" character varying
);
    DROP TABLE public."Empresa";
       public         heap    postgres    false            �            1259    41376    Empresa_Id_seq    SEQUENCE     �   ALTER TABLE public."Empresa" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Empresa_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    240            �            1259    16417    Persona    TABLE     �   CREATE TABLE public."Persona" (
    "Id" integer NOT NULL,
    "Nombre" character varying NOT NULL,
    "Apellido" character varying NOT NULL,
    "FechaNac" date NOT NULL,
    "DocIdentidad" character varying NOT NULL,
    "Sexo" "char" NOT NULL
);
    DROP TABLE public."Persona";
       public         heap    postgres    false            �            1259    16410    Sesion    TABLE     �   CREATE TABLE public."Sesion" (
    "Id" integer NOT NULL,
    "HoraInicio" timestamp without time zone NOT NULL,
    "IpConexion" character varying(15) NOT NULL,
    "Fk_Usuario" integer NOT NULL
);
    DROP TABLE public."Sesion";
       public         heap    postgres    false            �            1259    16409    Persona_Id_seq    SEQUENCE     �   CREATE SEQUENCE public."Persona_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Persona_Id_seq";
       public          postgres    false    212            �           0    0    Persona_Id_seq    SEQUENCE OWNED BY     F   ALTER SEQUENCE public."Persona_Id_seq" OWNED BY public."Sesion"."Id";
          public          postgres    false    211            �            1259    16416    Persona_Id_seq1    SEQUENCE     �   CREATE SEQUENCE public."Persona_Id_seq1"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Persona_Id_seq1";
       public          postgres    false    214            �           0    0    Persona_Id_seq1    SEQUENCE OWNED BY     H   ALTER SEQUENCE public."Persona_Id_seq1" OWNED BY public."Persona"."Id";
          public          postgres    false    213            �            1259    49866    Proceso    TABLE     �  CREATE TABLE public."Proceso" (
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
    "Fk_Tipo" integer
);
    DROP TABLE public."Proceso";
       public         heap    postgres    false            �            1259    49865    Proceso_Id_seq    SEQUENCE     �   ALTER TABLE public."Proceso" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Proceso_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    248            �            1259    49888    Registro    TABLE     �   CREATE TABLE public."Registro" (
    "Id" bigint NOT NULL,
    "Nombre" character varying NOT NULL,
    "Fk_Tipo" integer,
    "Fk_Analisis" integer
);
    DROP TABLE public."Registro";
       public         heap    postgres    false            �            1259    49887    Registro_Id_seq    SEQUENCE     �   ALTER TABLE public."Registro" ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Registro_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    250            �            1259    16401    Rol    TABLE     �   CREATE TABLE public."Rol" (
    "Id" integer NOT NULL,
    "Nombre" character varying NOT NULL,
    "Descripcion" character varying
);
    DROP TABLE public."Rol";
       public         heap    postgres    false            �            1259    16400 
   Rol_Id_seq    SEQUENCE     �   CREATE SEQUENCE public."Rol_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public."Rol_Id_seq";
       public          postgres    false    210            �           0    0 
   Rol_Id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public."Rol_Id_seq" OWNED BY public."Rol"."Id";
          public          postgres    false    209            �            1259    16507    Tipo    TABLE     �   CREATE TABLE public."Tipo" (
    "Id" integer NOT NULL,
    "Nombre" character varying NOT NULL,
    "Descripcion" character varying
);
    DROP TABLE public."Tipo";
       public         heap    postgres    false            �            1259    16506    Tipo_Id_seq    SEQUENCE     �   CREATE SEQUENCE public."Tipo_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."Tipo_Id_seq";
       public          postgres    false    218            �           0    0    Tipo_Id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Tipo_Id_seq" OWNED BY public."Tipo"."Id";
          public          postgres    false    217            �            1259    16426    Usuario    TABLE     4  CREATE TABLE public."Usuario" (
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
       public         heap    postgres    false            �            1259    16425    Usuario_Id_seq    SEQUENCE     �   CREATE SEQUENCE public."Usuario_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Usuario_Id_seq";
       public          postgres    false    216            �           0    0    Usuario_Id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Usuario_Id_seq" OWNED BY public."Usuario"."Id";
          public          postgres    false    215            �            1259    16636 
   auth_group    TABLE     f   CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);
    DROP TABLE public.auth_group;
       public         heap    postgres    false            �            1259    16635    auth_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.auth_group_id_seq;
       public          postgres    false    226            �           0    0    auth_group_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;
          public          postgres    false    225            �            1259    16645    auth_group_permissions    TABLE     �   CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);
 *   DROP TABLE public.auth_group_permissions;
       public         heap    postgres    false            �            1259    16644    auth_group_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.auth_group_permissions_id_seq;
       public          postgres    false    228            �           0    0    auth_group_permissions_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;
          public          postgres    false    227            �            1259    16629    auth_permission    TABLE     �   CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);
 #   DROP TABLE public.auth_permission;
       public         heap    postgres    false            �            1259    16628    auth_permission_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.auth_permission_id_seq;
       public          postgres    false    224            �           0    0    auth_permission_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;
          public          postgres    false    223            �            1259    16652 	   auth_user    TABLE     �  CREATE TABLE public.auth_user (
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
       public         heap    postgres    false            �            1259    16661    auth_user_groups    TABLE     ~   CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);
 $   DROP TABLE public.auth_user_groups;
       public         heap    postgres    false            �            1259    16660    auth_user_groups_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.auth_user_groups_id_seq;
       public          postgres    false    232            �           0    0    auth_user_groups_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;
          public          postgres    false    231            �            1259    16651    auth_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.auth_user_id_seq;
       public          postgres    false    230            �           0    0    auth_user_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;
          public          postgres    false    229            �            1259    16668    auth_user_user_permissions    TABLE     �   CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);
 .   DROP TABLE public.auth_user_user_permissions;
       public         heap    postgres    false            �            1259    16667 !   auth_user_user_permissions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.auth_user_user_permissions_id_seq;
       public          postgres    false    234            �           0    0 !   auth_user_user_permissions_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;
          public          postgres    false    233            �            1259    16727    django_admin_log    TABLE     �  CREATE TABLE public.django_admin_log (
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
       public         heap    postgres    false            �            1259    16726    django_admin_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.django_admin_log_id_seq;
       public          postgres    false    236            �           0    0    django_admin_log_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;
          public          postgres    false    235            �            1259    16620    django_content_type    TABLE     �   CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);
 '   DROP TABLE public.django_content_type;
       public         heap    postgres    false            �            1259    16619    django_content_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.django_content_type_id_seq;
       public          postgres    false    222            �           0    0    django_content_type_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;
          public          postgres    false    221            �            1259    16611    django_migrations    TABLE     �   CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);
 %   DROP TABLE public.django_migrations;
       public         heap    postgres    false            �            1259    16610    django_migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.django_migrations_id_seq;
       public          postgres    false    220            �           0    0    django_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;
          public          postgres    false    219            �            1259    16763    django_session    TABLE     �   CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);
 "   DROP TABLE public.django_session;
       public         heap    postgres    false            �            1259    16774 
   myapp_tipo    TABLE     �   CREATE TABLE public.myapp_tipo (
    id bigint NOT NULL,
    "Nombre" character varying(100) NOT NULL,
    "Descripcion" character varying(100) NOT NULL
);
    DROP TABLE public.myapp_tipo;
       public         heap    postgres    false            �            1259    16773    myapp_tipo_id_seq    SEQUENCE     z   CREATE SEQUENCE public.myapp_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.myapp_tipo_id_seq;
       public          postgres    false    239            �           0    0    myapp_tipo_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.myapp_tipo_id_seq OWNED BY public.myapp_tipo.id;
          public          postgres    false    238            �            1259    41377    vw_user_list    VIEW       CREATE VIEW public.vw_user_list AS
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
       public          postgres    false    240    216    210    214    214    214    214    216    216    216    216    210    216    240            �           2604    16448 
   Persona Id    DEFAULT     o   ALTER TABLE ONLY public."Persona" ALTER COLUMN "Id" SET DEFAULT nextval('public."Persona_Id_seq1"'::regclass);
 =   ALTER TABLE public."Persona" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    213    214    214            �           2604    16449    Rol Id    DEFAULT     f   ALTER TABLE ONLY public."Rol" ALTER COLUMN "Id" SET DEFAULT nextval('public."Rol_Id_seq"'::regclass);
 9   ALTER TABLE public."Rol" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    210    209    210            �           2604    16450 	   Sesion Id    DEFAULT     m   ALTER TABLE ONLY public."Sesion" ALTER COLUMN "Id" SET DEFAULT nextval('public."Persona_Id_seq"'::regclass);
 <   ALTER TABLE public."Sesion" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    212    211    212            �           2604    16510    Tipo Id    DEFAULT     h   ALTER TABLE ONLY public."Tipo" ALTER COLUMN "Id" SET DEFAULT nextval('public."Tipo_Id_seq"'::regclass);
 :   ALTER TABLE public."Tipo" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    217    218    218            �           2604    16451 
   Usuario Id    DEFAULT     n   ALTER TABLE ONLY public."Usuario" ALTER COLUMN "Id" SET DEFAULT nextval('public."Usuario_Id_seq"'::regclass);
 =   ALTER TABLE public."Usuario" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    215    216    216            �           2604    16639    auth_group id    DEFAULT     n   ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);
 <   ALTER TABLE public.auth_group ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225    226            �           2604    16648    auth_group_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);
 H   ALTER TABLE public.auth_group_permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    228    227    228            �           2604    16632    auth_permission id    DEFAULT     x   ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);
 A   ALTER TABLE public.auth_permission ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    224    224            �           2604    16655    auth_user id    DEFAULT     l   ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);
 ;   ALTER TABLE public.auth_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    230    229    230            �           2604    16664    auth_user_groups id    DEFAULT     z   ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);
 B   ALTER TABLE public.auth_user_groups ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    232    232            �           2604    16671    auth_user_user_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);
 L   ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    234    234            �           2604    16730    django_admin_log id    DEFAULT     z   ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);
 B   ALTER TABLE public.django_admin_log ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    235    236    236            �           2604    16623    django_content_type id    DEFAULT     �   ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);
 E   ALTER TABLE public.django_content_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    16614    django_migrations id    DEFAULT     |   ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);
 C   ALTER TABLE public.django_migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            �           2604    16777    myapp_tipo id    DEFAULT     n   ALTER TABLE ONLY public.myapp_tipo ALTER COLUMN id SET DEFAULT nextval('public.myapp_tipo_id_seq'::regclass);
 <   ALTER TABLE public.myapp_tipo ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    238    239    239            �          0    49817    Analisis 
   TABLE DATA           L   COPY public."Analisis" ("Id", "NombrePc", "Fecha", "Fk_Sesion") FROM stdin;
    public          postgres    false    244   q�       �          0    49848 
   Directorio 
   TABLE DATA           P   COPY public."Directorio" ("Id", "Nombre", "Fk_Tipo", "Fk_Analisis") FROM stdin;
    public          postgres    false    246   ��       �          0    41356    Empresa 
   TABLE DATA           3   COPY public."Empresa" ("Id", "Nombre") FROM stdin;
    public          postgres    false    240   ��       �          0    16417    Persona 
   TABLE DATA           c   COPY public."Persona" ("Id", "Nombre", "Apellido", "FechaNac", "DocIdentidad", "Sexo") FROM stdin;
    public          postgres    false    214   ��       �          0    49866    Proceso 
   TABLE DATA           �  COPY public."Proceso" ("Id", "Node", "CommandLine", "CSName", "Description", "ExecutablePath", "ExecutableState", "Handle", "HandleCount", "KernelModeTime", "MaximumWorkingSetSize", "MinimumWorkingSetSize", "OSName", "OtherOperationCount", "OtherTransferCount", "PageFaults", "PageFileUsage", "ParentProcessId", "PeakPageFileUsage", "PeakVirtualSize", "PeakWorkingSetSize", "Priority", "PrivatePageCount", "ProcessId", "QuotaNonPagedPoolUsage", "QuotaPagedPoolUsage", "QuotaPeakNonPagedPoolUsage", "QuotaPeakPagedPoolUsage", "ReadOperationCount", "ReadTransferCount", "SessionId", "ThreadCount", "UserModeTime", "VirtualSize", "WindowsVersion", "WorkingSetSize", "WriteOperationCount", "WriteTransferCount", "Fk_Analisis", "Fk_Tipo") FROM stdin;
    public          postgres    false    248   ^�       �          0    49888    Registro 
   TABLE DATA           N   COPY public."Registro" ("Id", "Nombre", "Fk_Tipo", "Fk_Analisis") FROM stdin;
    public          postgres    false    250   �a      �          0    16401    Rol 
   TABLE DATA           >   COPY public."Rol" ("Id", "Nombre", "Descripcion") FROM stdin;
    public          postgres    false    210   m      �          0    16410    Sesion 
   TABLE DATA           R   COPY public."Sesion" ("Id", "HoraInicio", "IpConexion", "Fk_Usuario") FROM stdin;
    public          postgres    false    212   /n      �          0    16507    Tipo 
   TABLE DATA           ?   COPY public."Tipo" ("Id", "Nombre", "Descripcion") FROM stdin;
    public          postgres    false    218   �p      �          0    16426    Usuario 
   TABLE DATA           |   COPY public."Usuario" ("Id", "Email", "Clave", "FechaCreacion", "Fk_Rol", "Fk_Persona", "Estado", "Fk_Empresa") FROM stdin;
    public          postgres    false    216   Aq      �          0    16636 
   auth_group 
   TABLE DATA           .   COPY public.auth_group (id, name) FROM stdin;
    public          postgres    false    226   ;r      �          0    16645    auth_group_permissions 
   TABLE DATA           M   COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
    public          postgres    false    228   Xr      �          0    16629    auth_permission 
   TABLE DATA           N   COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
    public          postgres    false    224   ur      �          0    16652 	   auth_user 
   TABLE DATA           �   COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
    public          postgres    false    230   %v      �          0    16661    auth_user_groups 
   TABLE DATA           A   COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
    public          postgres    false    232   �v      �          0    16668    auth_user_user_permissions 
   TABLE DATA           P   COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
    public          postgres    false    234   �v      �          0    16727    django_admin_log 
   TABLE DATA           �   COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
    public          postgres    false    236   w      �          0    16620    django_content_type 
   TABLE DATA           C   COPY public.django_content_type (id, app_label, model) FROM stdin;
    public          postgres    false    222   7w      �          0    16611    django_migrations 
   TABLE DATA           C   COPY public.django_migrations (id, app, name, applied) FROM stdin;
    public          postgres    false    220   x      �          0    16763    django_session 
   TABLE DATA           P   COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
    public          postgres    false    237   4z      �          0    16774 
   myapp_tipo 
   TABLE DATA           A   COPY public.myapp_tipo (id, "Nombre", "Descripcion") FROM stdin;
    public          postgres    false    239   Q{      �           0    0    Analisis_Id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Analisis_Id_seq"', 9, true);
          public          postgres    false    243            �           0    0    Directorio_Id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Directorio_Id_seq"', 256, true);
          public          postgres    false    245            �           0    0    Empresa_Id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Empresa_Id_seq"', 3, true);
          public          postgres    false    241            �           0    0    Persona_Id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Persona_Id_seq"', 70, true);
          public          postgres    false    211            �           0    0    Persona_Id_seq1    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Persona_Id_seq1"', 7, true);
          public          postgres    false    213            �           0    0    Proceso_Id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Proceso_Id_seq"', 1096, true);
          public          postgres    false    247            �           0    0    Registro_Id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Registro_Id_seq"', 378, true);
          public          postgres    false    249            �           0    0 
   Rol_Id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public."Rol_Id_seq"', 3, true);
          public          postgres    false    209            �           0    0    Tipo_Id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public."Tipo_Id_seq"', 8, true);
          public          postgres    false    217                        0    0    Usuario_Id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Usuario_Id_seq"', 6, true);
          public          postgres    false    215                       0    0    auth_group_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);
          public          postgres    false    225                       0    0    auth_group_permissions_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);
          public          postgres    false    227                       0    0    auth_permission_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.auth_permission_id_seq', 96, true);
          public          postgres    false    223                       0    0    auth_user_groups_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);
          public          postgres    false    231                       0    0    auth_user_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);
          public          postgres    false    229                       0    0 !   auth_user_user_permissions_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);
          public          postgres    false    233                       0    0    django_admin_log_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);
          public          postgres    false    235                       0    0    django_content_type_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.django_content_type_id_seq', 24, true);
          public          postgres    false    221            	           0    0    django_migrations_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.django_migrations_id_seq', 23, true);
          public          postgres    false    219            
           0    0    myapp_tipo_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.myapp_tipo_id_seq', 1, false);
          public          postgres    false    238                       2606    49823    Analisis Analisis_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Analisis"
    ADD CONSTRAINT "Analisis_pkey" PRIMARY KEY ("Id");
 D   ALTER TABLE ONLY public."Analisis" DROP CONSTRAINT "Analisis_pkey";
       public            postgres    false    244                       2606    49854    Directorio Directorio_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."Directorio"
    ADD CONSTRAINT "Directorio_pkey" PRIMARY KEY ("Id");
 H   ALTER TABLE ONLY public."Directorio" DROP CONSTRAINT "Directorio_pkey";
       public            postgres    false    246                       2606    41364    Empresa Empresa_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_pkey" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Empresa" DROP CONSTRAINT "Empresa_pkey";
       public            postgres    false    240            �           2606    16424    Persona Persona_pkey1 
   CONSTRAINT     Y   ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT "Persona_pkey1" PRIMARY KEY ("Id");
 C   ALTER TABLE ONLY public."Persona" DROP CONSTRAINT "Persona_pkey1";
       public            postgres    false    214                       2606    49872    Proceso Proceso_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Proceso"
    ADD CONSTRAINT "Proceso_pkey" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Proceso" DROP CONSTRAINT "Proceso_pkey";
       public            postgres    false    248                       2606    49894    Registro Registro_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public."Registro"
    ADD CONSTRAINT "Registro_pkey" PRIMARY KEY ("Id");
 D   ALTER TABLE ONLY public."Registro" DROP CONSTRAINT "Registro_pkey";
       public            postgres    false    250            �           2606    16406    Rol Rol_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public."Rol"
    ADD CONSTRAINT "Rol_pkey" PRIMARY KEY ("Id");
 :   ALTER TABLE ONLY public."Rol" DROP CONSTRAINT "Rol_pkey";
       public            postgres    false    210            �           2606    16415    Sesion Sesion_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Sesion"
    ADD CONSTRAINT "Sesion_pkey" PRIMARY KEY ("Id");
 @   ALTER TABLE ONLY public."Sesion" DROP CONSTRAINT "Sesion_pkey";
       public            postgres    false    212            �           2606    16514    Tipo Tipo_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Tipo"
    ADD CONSTRAINT "Tipo_pkey" PRIMARY KEY ("Id");
 <   ALTER TABLE ONLY public."Tipo" DROP CONSTRAINT "Tipo_pkey";
       public            postgres    false    218            �           2606    16433    Usuario Usuario_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_pkey" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Usuario_pkey";
       public            postgres    false    216            �           2606    16754    auth_group auth_group_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
       public            postgres    false    226            �           2606    16684 R   auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);
 |   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
       public            postgres    false    228    228            �           2606    16650 2   auth_group_permissions auth_group_permissions_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
       public            postgres    false    228            �           2606    16641    auth_group auth_group_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
       public            postgres    false    226            �           2606    16675 F   auth_permission auth_permission_content_type_id_codename_01ab375a_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);
 p   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq;
       public            postgres    false    224    224            �           2606    16634 $   auth_permission auth_permission_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
       public            postgres    false    224            �           2606    16666 &   auth_user_groups auth_user_groups_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_pkey;
       public            postgres    false    232            �           2606    16699 @   auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);
 j   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq;
       public            postgres    false    232    232            �           2606    16657    auth_user auth_user_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_pkey;
       public            postgres    false    230                       2606    16673 :   auth_user_user_permissions auth_user_user_permissions_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_pkey;
       public            postgres    false    234                       2606    16713 Y   auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
       public            postgres    false    234    234            �           2606    16749     auth_user auth_user_username_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);
 J   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_username_key;
       public            postgres    false    230                       2606    16735 &   django_admin_log django_admin_log_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
       public            postgres    false    236            �           2606    16627 E   django_content_type django_content_type_app_label_model_76bd3d3b_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);
 o   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
       public            postgres    false    222    222            �           2606    16625 ,   django_content_type django_content_type_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
       public            postgres    false    222            �           2606    16618 (   django_migrations django_migrations_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
       public            postgres    false    220                       2606    16769 "   django_session django_session_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);
 L   ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
       public            postgres    false    237                       2606    16779    myapp_tipo myapp_tipo_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.myapp_tipo
    ADD CONSTRAINT myapp_tipo_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.myapp_tipo DROP CONSTRAINT myapp_tipo_pkey;
       public            postgres    false    239            �           1259    16755    auth_group_name_a6ea08ec_like    INDEX     h   CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);
 1   DROP INDEX public.auth_group_name_a6ea08ec_like;
       public            postgres    false    226            �           1259    16695 (   auth_group_permissions_group_id_b120cbf9    INDEX     o   CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);
 <   DROP INDEX public.auth_group_permissions_group_id_b120cbf9;
       public            postgres    false    228            �           1259    16696 -   auth_group_permissions_permission_id_84c5c92e    INDEX     y   CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);
 A   DROP INDEX public.auth_group_permissions_permission_id_84c5c92e;
       public            postgres    false    228            �           1259    16681 (   auth_permission_content_type_id_2f476e4b    INDEX     o   CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);
 <   DROP INDEX public.auth_permission_content_type_id_2f476e4b;
       public            postgres    false    224            �           1259    16711 "   auth_user_groups_group_id_97559544    INDEX     c   CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);
 6   DROP INDEX public.auth_user_groups_group_id_97559544;
       public            postgres    false    232            �           1259    16710 !   auth_user_groups_user_id_6a12ed8b    INDEX     a   CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);
 5   DROP INDEX public.auth_user_groups_user_id_6a12ed8b;
       public            postgres    false    232            �           1259    16725 1   auth_user_user_permissions_permission_id_1fbb5f2c    INDEX     �   CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);
 E   DROP INDEX public.auth_user_user_permissions_permission_id_1fbb5f2c;
       public            postgres    false    234                       1259    16724 +   auth_user_user_permissions_user_id_a95ead1b    INDEX     u   CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);
 ?   DROP INDEX public.auth_user_user_permissions_user_id_a95ead1b;
       public            postgres    false    234            �           1259    16750     auth_user_username_6821ab7c_like    INDEX     n   CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);
 4   DROP INDEX public.auth_user_username_6821ab7c_like;
       public            postgres    false    230                       1259    16746 )   django_admin_log_content_type_id_c4bce8eb    INDEX     q   CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);
 =   DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
       public            postgres    false    236                       1259    16747 !   django_admin_log_user_id_c564eba6    INDEX     a   CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);
 5   DROP INDEX public.django_admin_log_user_id_c564eba6;
       public            postgres    false    236            	           1259    16771 #   django_session_expire_date_a5c62663    INDEX     e   CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);
 7   DROP INDEX public.django_session_expire_date_a5c62663;
       public            postgres    false    237                       1259    16770 (   django_session_session_key_c0390e0f_like    INDEX     ~   CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);
 <   DROP INDEX public.django_session_session_key_c0390e0f_like;
       public            postgres    false    237            '           2606    49855    Directorio Analisis    FK CONSTRAINT     �   ALTER TABLE ONLY public."Directorio"
    ADD CONSTRAINT "Analisis" FOREIGN KEY ("Fk_Analisis") REFERENCES public."Analisis"("Id");
 A   ALTER TABLE ONLY public."Directorio" DROP CONSTRAINT "Analisis";
       public          postgres    false    244    246    3346            )           2606    49873    Proceso Analisis    FK CONSTRAINT     �   ALTER TABLE ONLY public."Proceso"
    ADD CONSTRAINT "Analisis" FOREIGN KEY ("Fk_Analisis") REFERENCES public."Analisis"("Id");
 >   ALTER TABLE ONLY public."Proceso" DROP CONSTRAINT "Analisis";
       public          postgres    false    3346    244    248            +           2606    49895    Registro Analisis    FK CONSTRAINT     �   ALTER TABLE ONLY public."Registro"
    ADD CONSTRAINT "Analisis" FOREIGN KEY ("Fk_Analisis") REFERENCES public."Analisis"("Id");
 ?   ALTER TABLE ONLY public."Registro" DROP CONSTRAINT "Analisis";
       public          postgres    false    244    3346    250                       2606    41371    Usuario Empresa    FK CONSTRAINT     �   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Empresa" FOREIGN KEY ("Fk_Empresa") REFERENCES public."Empresa"("Id") NOT VALID;
 =   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Empresa";
       public          postgres    false    3344    216    240                       2606    16781    Sesion Fk_Usuario    FK CONSTRAINT     �   ALTER TABLE ONLY public."Sesion"
    ADD CONSTRAINT "Fk_Usuario" FOREIGN KEY ("Fk_Usuario") REFERENCES public."Usuario"("Id") NOT VALID;
 ?   ALTER TABLE ONLY public."Sesion" DROP CONSTRAINT "Fk_Usuario";
       public          postgres    false    3291    216    212                       2606    16439    Usuario Persona    FK CONSTRAINT     �   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Persona" FOREIGN KEY ("Fk_Persona") REFERENCES public."Persona"("Id") NOT VALID;
 =   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Persona";
       public          postgres    false    3289    214    216                       2606    16434    Usuario Rol    FK CONSTRAINT     {   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Rol" FOREIGN KEY ("Fk_Rol") REFERENCES public."Rol"("Id") NOT VALID;
 9   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Rol";
       public          postgres    false    216    3285    210            &           2606    49824    Analisis Sesion    FK CONSTRAINT     {   ALTER TABLE ONLY public."Analisis"
    ADD CONSTRAINT "Sesion" FOREIGN KEY ("Fk_Sesion") REFERENCES public."Sesion"("Id");
 =   ALTER TABLE ONLY public."Analisis" DROP CONSTRAINT "Sesion";
       public          postgres    false    212    244    3287            (           2606    49860    Directorio Tipo    FK CONSTRAINT     w   ALTER TABLE ONLY public."Directorio"
    ADD CONSTRAINT "Tipo" FOREIGN KEY ("Fk_Tipo") REFERENCES public."Tipo"("Id");
 =   ALTER TABLE ONLY public."Directorio" DROP CONSTRAINT "Tipo";
       public          postgres    false    246    218    3293            *           2606    49878    Proceso Tipo    FK CONSTRAINT     t   ALTER TABLE ONLY public."Proceso"
    ADD CONSTRAINT "Tipo" FOREIGN KEY ("Fk_Tipo") REFERENCES public."Tipo"("Id");
 :   ALTER TABLE ONLY public."Proceso" DROP CONSTRAINT "Tipo";
       public          postgres    false    218    248    3293            ,           2606    49900    Registro Tipo    FK CONSTRAINT     u   ALTER TABLE ONLY public."Registro"
    ADD CONSTRAINT "Tipo" FOREIGN KEY ("Fk_Tipo") REFERENCES public."Tipo"("Id");
 ;   ALTER TABLE ONLY public."Registro" DROP CONSTRAINT "Tipo";
       public          postgres    false    3293    218    250                       2606    16690 O   auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
       public          postgres    false    224    3304    228                       2606    16685 P   auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
       public          postgres    false    226    228    3309                       2606    16676 E   auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 o   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
       public          postgres    false    224    3299    222            !           2606    16705 D   auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 n   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id;
       public          postgres    false    232    3309    226                        2606    16700 B   auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
       public          postgres    false    230    232    3317            #           2606    16719 S   auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
       public          postgres    false    234    224    3304            "           2606    16714 V   auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
       public          postgres    false    234    3317    230            $           2606    16736 G   django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 q   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
       public          postgres    false    236    3299    222            %           2606    16741 B   django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id;
       public          postgres    false    236    3317    230            �   :   x���t����q�74000�4202�50�5�T02�21�24�33762�4����� j	�      �   �  x���Mo�0@��Wp���%J��ހ�T�hi�H(M\�ʱ#�i�߯7;\�'�ߛ�d��N�ޤ?����P.p��Mpv�ЫG#"p*� ���^3���Ƃz잧	]��d��j0<ťʲ�9��d+��;&�d�%�~���5G�]��;IrC�S?��*d�zdMX�?�X�}�xDy�Ms]2���qϷ:�o�Y4���� {m�LE"��iJՂ��+)9��-,)��%.K��4���g��fU=VE�J��-��qf"��"j5d�g�C��",n[����x��)���i2 �X�(h�!���\ꬽ&�}"`�6�'��ߑB�M8&l�E!ӂ��@M�����m
k���V�^f# ���k4
f%"eA�H=�4ej9)�^]c�ʄ�g4�e��_��
>+׾��E�)�Χ=�c!���}�Y�����鍀�1��Pt���ű҅�P�88+��J%����
I�D&�}<���3���Tf�䭞����~��ض�β����c+��/vh���{8V=�ld���!��<��t��^\6�g�>V�wy�����W]�of�����U�:m�OX�7���g�3u�tǼbY��T6g�y��Cu*�<Ws��M��&/����;&~[���^m!�5�B��I�&g�Y�#�;���+����	щ���p���8���w��V����j�F      �   +   x�3�qw��2�uvt�2���KI-H�K�L�+I����� �I�      �   �   x�=�1
�0�Y:E/�")���@�Вt1��,68�!���BA���R���`�}�8��H�(���g/���S�ap9˻l_I�����5x�
K͗�ːJ��n� !"Glg��&"H��
��9�{�y{^��&      �      x�ܽisٵ%��+���:����Me+nI�-�\�FT$��D�h �`����k�L)��,��j� ����������?�y���~�J)=�����j�\���^4'���I�Z�Fg�FJ�MQ��u0����d�X-f�_�����Չ����}����__�z��_O���ٳ����9;�S��N�W�����z�>_�/�ʣ�o�%�lF	?k��7��_���1ߣ�#�Ș`t�����H����Ln��#mU�G��{��M׶*�d����i��ϫ�<��!fF�D���u�I��m�<G�B�r�N�l<�/yc�v>l�F�&X�������g�|�1���4=?7o�W��gN�Q�����J�7;6h�"��(ژ�<����w�����R���0��c��Ǥ��,�.Wr2�:G��s#L��MN���=9F���%��0rUL|����Y]�V��O'Gk���(����x-�n�<�J��o�l�|�)q6�h�O'#�ñ`�Fƌ,��D�>P#��l��'��gd�e����;>�KS0Y-��\T�T�1`"����0,sV!�LV��8�V��B@���]4�����L>�����Ue'ǋ�#�ٓ��q/w�q��h��2��5e~d���I_����s�w}3CI�����AL�|'yZyd�u(sb�Yg�<}�h��"(�P���T�Wx6�Y��J!��V9.&��%^�W�$�6;yJ�-��q�dYKo�:&��`dAm98�ϜqPDjʁ��q�hN��0B91�6��Pr��9��:���Ej��v����L�L��Op����0i�x����26١2�lt��I�(�_I����,�����4�"9�-���9�l%���4&LfȈfyQH�{G���啃g���Jɫ(�?�~Ԙ�2E���X�]�9%w�v��gg+jtk��v������a���P!�̪�yt�$(u''��o���g#�OTV����*JsQٚ(�����V�IM8��fT�_�,Ɓ7�"��4:��d{:eU�&�y�X��!�{��_�$���e��h$�<�"��O��dd�`�9�z�i��_$�R2�&G�0ј�e��0�<�lb�l�rp�E\�l�>����;�V��ew���r9Q+�����N>0�o��ՇɻŊ��z�l������OޝTW�����\�H����EY�"�z^�~"a��l! {��h��1�!_��V��N�PĀ3F������!\FыZ��������hg���b��Hh���5�r9��)b���� �<����f�~��ُ�,~��//���:�VU5���r9�*M���M3��Y���T/�?4����r���l���|��������|Rc��ڪ�H&Tn�:T�xb�x�|%�*T��6Um�5&���FT�IU��𻘙�8	U3֩r�ɸ��K��_�r��5x���|�\<�>I��O���9W.��癮�&���u���I�j1?]����z��|�����U�s�rc?�\T�*Om��4�0�5�x&�����Y�_6/��*q2j���S�g��if�$Mb#Ct&�t�������J>Sv����?(��s��UDe��aE�P��%%L9AΌ��Պ:mD�c)�Tn.f@R���h�V�qt��
~zQLN\O�5���.-��GQ�r����������;ET˙����9[��������������y;jb}/�Y'�ho)�o-�\����D�;:����BB��r�8��Y-֣h~�:��x��j;���nlp{�8�rcwc��:��Y���0�T�����%�
k:-�xdk�'��Ǿ^����ٲ<c�tq��;pp里~����%-ǆ���v*�_�TΩf+��ù�؊�"S
���@��-D�bJ�΢����P�P�"$F��F����L����>`�F�BJ{���ɩ��?p�`%�T���N_���� ��ϩ=�.�xX���͊�L�>�T���� �4�i�H�V�2,Dv�K`��v�;D�d�d����XxY���ā��_��i�؋	��Ln1SUғTi1��S��l���E����A<�h�j��+~:s�8�&������6�JO��p3��z��k;a�2}�Ab�NĖW��e���F̢�$�j:I���;hR�m0��b�$�����ֈ*����~�x�o�z=�=kf��ź��z����8�
J܄R�=�q� ���$�F�Y8�	�,��Rt!�L�Q��ǌÒ���W;4Թa���;����W;ޢg��4QSN*��X���W��	�y����Z	����ӿ<��<zUμ����(�`��D1����Ŭ�h^��۹���/s�G\!�z�l+C���"=�S,�-�P�3J�����C���[��H��4�O�I}qZ�t������������c}qя5 ]�EV�a,V��8.�sb����4S����x�.�s�)�A���!�ݫMF"A�eZ����"�����[��#��6�]���7Pu�z�'a�:�cC�bxa	؜���Q�����0
\{
"3R*�ͅ�1	��$�<82���s�I|jg�l��8[���x^z��u�O�����Wkވ*�e±��h�Qòm��iV%�-��H��L2!"����$�J�6S���!p��E��H��j/���#j����M��@��	�"r~nV���d�L)��<�c�z+�{��t�|��+
0x�z�l\�O0�	�5)2⹐��P�a�1Iə�6Fp�E�7����^e�M�b� ��`1�d�������ä�9�w���Qb@�F�e�2��i���N�!1��������U���`(a�o�^kH��2n��H++�~k�������e�L<��@�!m�L�X&�E�~.�kgl:,�VV|���"!�A㱌��|Q�V&�bc�+H�m��[��/�.ĳw�>l�@+P�L��z��eTy��?��S X����#Ce+��j( Z�� ��SJm�+�(&����N���Q��C���o��ڋ˭��[�P�c-?�8��3�z����9t��Ƶ�?uө�j;�U��4Mt]��߇�m�ڄ:�*�:U�n��N�X7{v��8�}:ߍOb�N�x��T��I%F^S�TO&A�t=�q���c;m����VN7p�����R�&���NB �d�PV��s&MC(m�\�;d�p,�V��z��+C�6�/�i�r�N��Rڎq��1�/ʺV��h��Z���`���EO;�(�����F�������0(�?��ν�tQf�)(&n��ʻdj�)9pq��Obb����F����f\-��·k�!���X��|��%�XWJ�.Q�Hyi:��~�[�!^��!���t���#m5� ̈;����#!�P�v`�&���$-qw��օ(J��ަ�_M�_�lܾ< ��GYn��I�6u9�a��0�8f#��$�/�D- ?Ɂ�	�d� ��^T���\z7�!�u7����m���r�Y�� �h�>*��@�OfHLH�śJ":�d�� &���,d/8(�J��3�q�
�,����n&1���R��w��g竫�����;X,�b?��[����Y{v�H*1W-��C$��&�CN_�E�"$�+"�R��n'������#���$�����pȝK��|ړ~�F�H �&j#���*؍�$�Gh���f.��#XƤ�< �T��M@J��V�*s��#!�ȼ�c��/�]��Ge�\0C�@)!1Ӏ�j�D�o��O��X��V���L�
�ز��1�����]ȫ9�w����!w���f�Z,�CPU)�!P�2��i����F93#f4ar�����)�B>.��JАP�Ι]������~�J֖�u��I'.M!����ŋ˫f�Z��:n-N?�B^-l7Y�^�%(�GhZ#2
g�3j=��T�����x0h90��4Dd��u,����B<!��F���H�)^i�ն1u7^�[��7ͧ������e=��>H��j�2��i9<�@e�ULRdL����)����OC�w�dZ?�    �1o7ZD6TV�ȳ���<����]C��i_�p&,MJ��R�'��`��N[џ`NI�	C�4�JL�kL����v�D�0݄�U�
n�sM܅�]�[�|��Z��'��Y�ԗ�^��cn-Ard��Y��5 X��A�;�N���l9�.<��蠹��  �����ſF(�f�.*��ӡR)2T��Aab��⸗�_*�k���:��(R�r�1�>����F��0Q�H�i��Q^�A�+7	�[��dj��i�X7�#�k�	=�D��������S�LM'�Y�c�Q�`��β�L �<�bU��T������&�ՍZ�T�B�L���
�|^v�T6��u ��9�+"��tԻ��C.�\v�2�V�D��@0��lBϤ�_9�jn|�I�(`O��˜�J��my7`E��O������B����~�2b� �7a�ZpPh�%ԪÑ�м��1�h �@P��nJ�
��1w�,o!�KSJ�EQŜ����Han-��*�6�7�M�~����\ȏ�x�?O�Y?�	!�I�O`yY�Ddq�w,�6�����}a,1��41����C�Ǉ��/U׹=	ՙ�Kɉո��b�>o�aa�HJ��ǫ�brNIٟS�aC@tu�}�*��H]�>�x��Q:Gߢ0�<�r>2*5U�l���u�W&����nU��O�mh{�;�r��"�pzc�_������p�(�",����U<�+Q���S�c@�rvʳ4F̷hޚ20�>�j��i��h�!����H���vL�^���b���2z������@����1�5����r(�o�	��j��`�Y�x��r�U���}��w�����0�C�~T�!�`�p���[f�\������K0$:Q�2:~��3�����K�yW�i�#�QV�v.�YM�f�}C!����c%`�?��)Ln(ٚQ���{r3��#z`r�͈^ =�CJ��P�+r����B�9�8=���)�P4���ɼ;����&&]��o�]�;Z h(���&.��ŜAt(g����,j��_�.Ll�Js���i!�]��U(�̕|6��Ml!����4�uR���!M*,V�/Ġ���u9]��������W��hB�h��a�v#͙�@ ��}�Ū@�*�S�[K�5*�d%r�%��o�ې�x_������fy�^,�~<�h~n��s����ٵ[KvУ���7���~KM���Ǝ�Tˇ���Q�u}ެ��>]���~ߡp}9���S��Gf��@O. ��1���v�p�`�:�T���C��p�G(�関���뫫�Ŵ��45b)7S��
�Q�a��.з�Ldlx���$c�`�E&S2lQG�(,P��RuB�Q&Fq�G�gg|��B�<m�7��x�ݠ�h*A�0ʚ8��z����@sa�Py5�T�N&U2�Z�fE������غ ��Eք!�i�dF�ͽ��9�S���H].B\`o�nO�5�O��������k��B/�u�.��py�7�W_����yͬU^�j��(��{P�${�����O�!<
�� �4xsyGΆz&�3��b �O&/�̨��x�������10"�*˪�0F�Jt�w=�7��fՃ�a��w���u5��9M��~$�����˴4��,㘐z��S�`41�-u�2	o�B.2�ږ9����4�:D��)#d��7���@�F���{��2$�6"nL��"�uAc�)�m�:�U�X5s3�_$P|�\�R=y���Z6����p�&�UVb���c��{#Y�V��ݞ��-�T�`�`jST�� �W*[��ʐ|�?M�>���U�;��X�l��9�b�_���� ��17�L=�s�# B��<
Q6�H��[��-�TjQم�l��,��h߱�@8�&��#��֌�w{�||==_<�O��������W��o�	�v��,޳!f�\����ʮ���+,s�SL�NΆ26���bQ܆���@[0������^vEF��k���?"�\��O�ɻ�ib�j4�Q/�t��y�9D� :���
Ѣ�-a�-g���28�-=��ć~���i��[c�ƶs��	"{����G�Vd�h ���"�(⦘����'A�B���HX���86��p(h��_Y���������A�:�-ɔ�vO���\���eE�W�-���a��$��꩷r�7|w�~/N��A����#�t�~�-p
��}y+�ܲ�*Q��K��D�oїp�L<l������^xB��6<ݝ?�7�@�5=�A,�s7^�ļ��O@γ�i��L�DC�̎�c��PJo~]��h͜H���o��a�z(�#i��p0�O�����n����s������(J?+��o�M�l���&���<t�?F��.�<�i�v~8}��FٷϾ/Y�_�@�ń��AC�#��n�;�X��q�β�hK?8��?��0�)�^4�q,�������e5���P�B��j��e���Y*�S1C�������}�Zu<8��G�_;E>:����P
8�*)Go�#ug&ʏ ���.R|�ީ�ه#AOٚL@&�~�0��ƌYW�A����i�{mN�5��Y�n&x��'ÚJ��Av0�==*{��2ђH�v�+�i�Y�:08\HD�@_rlЖ��=zx�RP�r0���%�r#?����(o���	���#��v��Ӌ�f.�����Ѽ�ދ�(V/g=�A��:8_�1Tl0�YPW\o�&�& �'M���&����b9�܉8*`�MA*�n���h��I�ԝ��f�^\�O>?~+݃�GU���\/0���d��]�������[�ze��Jh���!SK�	���q�}٫K����u:�[��c�i
ƧXɧc�&QU�,��vM03�zȱx�a��d�#�F]YC� �AL�)݃Tɐp,��4����eP�����6�[���[���P��^����66�U����\g��d2��H��]%PY�\�|VR����ؤ�14�M2�k���v��]]a��u�WW�����Q��җ?�i�0E{&�W����d��r>��N`hC���d[��5a"��ѕX�tѲ��!���؅�-�;v��I/C�2�tP�DHR\�/�����պ���I�v �6+�2����F�M���b��x�P�c�O�#�-�s;0=J,�A���=S.@������mi�D9���P��e���
����ӧ���;bH6��e	�0�1D9�������& �E�HȰCD���@P��s,�gf��z�\��!p��l�#L�M�#���@�uKs��N?^�?�?ߢBۗ1��bDlVb*�fs=���,sv(8O�Nl�̼8�~�wH��"&:˃���-��H���t��P�Q�b��TG�-�xZ(k�9���G����R;�����톫��A ����m&�oZ
D�Ѫ���f˟�Bc���
fD)GrH�-#G�C��rH��ۋ��m�������'?-ޖ	]�����F���'V�X駏�U��u���y^iD�̓�������"~���³��&Q����0IK ѰM��A��VlW�K�I�
6,(�I~#M�)x��*���?X��g\4;�Ȋ�M�=��j/���g -�d��]��K���<��7=X�l��+=[6�yDi��4齇��T��8԰�y`��E�u����z�ڄ);��Ej�	v���k���#�I����g���z�sja$�a��E�q�B�Y� �D�$��D� O�3&��u�/�����z�t����c;�j�y����b>o&"&j�~[|��Oʟ~�71W�j{���tk��#/�0kEp:�#��7L:�QĐ�ǜTY�������|s��a��n7�)���gGC��u�7ޛ1���������B��b,��v'��WW"��W�k��[���;�8 �Х�g�<���-�`t~��a���(I#���v�!�%CV�    ��'�Ŷ�rC�M�Gݰd;O��f.m��{�ܻ�z=������%
I�AЈbq�:F*$H�Hc�7d`θQ����Q!��g�!�;��Ođ�A'����@9����CŎ�r0�Hp���R�U8�w��7��O�O_��;+;/}�Ӝx"Ht���0���-�ֺ�Tm�Q�"Ė|*�����>�r��
a#��@�XY*��baYG����;�{�|ٞ���������
�3p����i0E��%B#�;����(��D2��V�?[Kh����"WX��j1l�4��=�n����w�����o������W�?7���|z<)s�_u9��*HH�R,[6�gm֊s����]g4aA�^ǰ�]*V�	�]���B!�j;��-�c�Nd�������э(���|?`ɖ�L�������r���� �-�޾mV�N`j�c!���
�Q�)�	`�d�0] ���-1��c�c�8�n�:f�È^�8׺+!A<6��k�h�z)���@��rw���J=��x ��Y��d��XR��L�{����t{H�&��5�/X&���9>��.�2�dր�Ȋ�HF)�`�<Mp�߫�Ѥ+�(@�4���?��If��?�R��d�ߞO~Y�_��zN�{Y��~�2O�jy}����޼=b�}�[� �� 9���V�>� K�ۈ;T�����ɔE�L�(h<�y"�S�T�'ѱ��R�\�r8�����_��PcR��`����{���]E��%[�Ϣ�`6qL���ر���[�0$Y��Գ�{�h~}�������ڌO?����6�I2��pyyg�pU�<v ڧaZ�K�S/�}L ����������Q%~@r�{��|��,�)�t��#I����+r"���|½y�<P��(F�s�eqi_tF�@]�k�u-t/������m�q�[-�&m4�S���z&2<\��_���/�-��K��0dWD($M��C�E�1�&cH
�l�g͆�շptB"��ѥ ������ �m�����Z6i��=��J�n����5��{��<��b��}}�)�^N�O�|�aqvv=�l�_������o��f\F��HN4�:�G0��B͸�F����/*�D�� :�����s�m�_t��D�,~��m��3�'0 ��:�Y2�4�Cʢ�Ǳ}��5'�?# ���5VV�y����u�l�`:"�����{�p�0?Lӑ~���vY9H�PV
�4�n�L�p�0Ab.���E5�@�\I ����vn���+�N4qCB��[��������.��̏~yv��#���[�<ۯ|�űd`l�v���?�����T0�'�	��ZJ�@�R��*V��0(�^J�UO�Bp�<y`��}��4�˺P��ô�0���(���)Ǆ�������h��ht���ac3��t�.� ���?X+�h���+u�i��C�{��_�3'���ɣYT��6~�b6�ɲM,��9;εa+S��ln/���]��v�vlS�&�o�����IS/�~B�u3K��)���x'��
�u�8rPf�dw�7(��ht�Rg�_�saqM�%el]�52\[�0�-=b˕�ԅ�|����+��2�jݗ��N�����L&r:�����}�y�c����N#�ЙT%T���v�����n�NdJ ��A�A�~À��]{��@�F��Ugh�[�O��B�Ŵ*JDQQE1�	�i*�6{�j�����>��s~_�y�lN��'����l|>?;�z��d}A�����`᫓���W��>Wi��I���{\xZ�ky���1����+��vED�G��y�d+��]�-������ �
Ip����Lhe2���{�+�o���j��ίW�1�F�W���BAq��s�v�A��>c3z�B��R^�Kt$�n4��H����39��a�Wǎ�I���{�L�J!Z�r�h�e�;��������$�������2˩q��L���J�d�H�b�jL � �5k"r��G<LU�"ė����L�@���Z�0��˳wP��L]�OW=���Lcz3�,�[�����"8�"0B��c��r�9�!�1��M��f�2����W۝=��/��WO^�9==��x�+pNa�X�"c��'���(M�L�|f7%&���"�����N��k�	� ���ԑ8��ʴ0�vxt��م]�sH�͜?�F|Ot��/�^�P�$�J8�jH�!��,x�2��.�o�0@
`����;f��c�� ���2͠���,���%i�d���=�������*]��pǊsQ�5D����Oy�jZ7������|��_]>�yYJ�����'x*B��DT�"�_�/'�:�&����@l����_���w1���,��P$�v�l�n���d&�14��l( �ɺo�N�b����}k�n9��\�'Z�F_���_O��s�=��qᬃ�F��� �'��8#l8]>�e���<�JI���	M%|)7�I�Bp苲i�)�B�Y�r7�����;&���_\>]�����E��J ���\L������n�dow7��ѣ�y�a�IZ�m��pj�6�3rzf�Q�	4 �kǉ�r�K�W��"�����R۱ ��(��瑈p(��>�p�-Wb�m��򴗑�VZ���H-����sv֑��<�Wͤ��:;�\��^���Y�ggO��y��(7�
����ừ�b� �[����^i�z�x[]��w?:���\⻃G���W�p��QIW ��f���.�Q,a���Ȱ��H�3��

��U���&��6�<�g  P���n�Y'�8w ��`w!fbS�27��{8�������j���nr����ߠ�W)��^.k�7��(}���
�^f�ؖdx��uj�>�� j8G.t��A��;���\/�ןOH�pv&�r����c+�j�o�<ׁ�"هU����{�FR̢+�KdSg�hF�>r��In�G��B���O��D�kِ�c&�N�A<
�|i3�>TΕ&�p�B��jEw�w�P9��Z�Ij(&g���h|ꖹߛ���lK���}\M���ӛvs�ɓ�o�0����a�2wK����܉jf٠�(!MO���� sd��*���6��c�����B�f��e�#�U,[�D�=�J�*a���ld�@ؗ������i9}W/���~q>y�f���\��l&�q�;�؛� �m�|���>��X��X����<�m�����U�6���L&.��V.8BY�A��\�mtJ����v�hո���b��w~��`�7���m��;��؛~��^�����P�w�h��=�x49�tVvs�]�e$[��1.Z�C�!�!b�X�k��	٣�Lil��qr����hR �
O*�fObx�-���?2�M}����#|����#xۻtm� �%~�q��:d�Ov����7�F}�t26�F�D�X
4����4{W!�(� 29�8��@�ۆu�ew�Q%��
#�+�e,����L���	�Y�$@t�<�����Ŵu�ͬ��X���|tǻyVÛ��R����Ͽ;�+�l�77��r�c	i4Pm�l'�@�d�[�I2<!�(q��9����q�g9���$�d�A�c��Y��6���m}ĉ?N��o'v�Sf4L�,�RI!��	������n����ݔYZ#��"������I��!�+!�lO4��prѱ��N��D�.���G�_Y�=%+zS_��.?|;���l�\CD�� T��#e"M6�ܶhx�O]��BB\�lrr!껁�B�ԇݐ<���V�,�B��ח�2yG=�7�?m���ǂP��D�)��E�2R�^�;1�x0���f�wP�T���M�L�8S��D>A��2⌞�΢(V�����^lx4W������o�k��� M��h��Eɍ�PL�Z���/*�0��Đ��O�H_#�(�'C];�	��Җ	�n�~HA>:GFdB��-��/�{�:\�����邶68>��a    ܁�-	�f�>��]=,�e�-i���~u
k��H_y���WQ�`&-�)�6vS����[P@;�L~$�PL�L�ґ�����i�-'����^�v�������P�n�R�/h�eX��gn,۞�c=*?Q�"g����%Q�2��-���rg�!�N�&�lA 
"7��`-έɤ���k%�٣�qY�H��ra-(Cvv>�����_gg��`��|#է��ی���p-h�"b9HѺ֑�!`�$���
�LQ�?St�<\& �8,E� ̀$�п܆��7Ye���� E[�~s������"'��x�]ܺ҃n��B�v�)�������h���b	�W(�K�`� a2 -�H�o>��I�-�C� �j�5ރ��U�mN�l���x��vy(�1�p���:��\�oaw:D2�1��-lP���>)���lR���H����)�d��0�/si|K����O��o����o����?�4�+����Sm?���rn.�=�<���z �ɤ3�o1~�����ʢ�8`;����EG���q��&���!�k=�����߷{�Ђ�<��9:�\�s@�Wm�K�x8����Thv[b'瀴Nk���s��*�^X�:.Kx���]w&���t�!�q\����f2�����}�ߺ�K|��m��:uztc��K��b��o�B�Q@���4��eAQ���TF���ر�m�� �- R�Н�'>�6a���K֒�i��i���W�������V�n&��"i�����Z��D�Tq<Ǐ�v{����n�Bg�ڠ�����ϗ_���52P�p!�2T�JE"&�d���)�F@`[�B_@�ƕ!��`'D]�C��li�U��o[T �����H"�������vߋ���,��L�����^S囓o� �ԋ�KC�Y�{��Ѡ-d��Q1�oS
l�-����[���e-��4�L-B�4wcg�[<�d�����3Y�P�.�A,��[���@�F[r�����w�	�DTF�"i(<Ҏ���?��&���v2��䱐�8Q�E<sd;[߲��� w���P���j��F��ah����j=n4K��Q�7t�O��%ڱ��Qt��Cܱ�%r%�La���DQ&ɔ��]��$f�K����$Mn�PX��C�`�PX#�	˅Єq �D�d�Jt�ܴ�U9��2�u�#9��$��}g�~�ﭻQˀ�tg
�$������*�F��A�C8�!��/�����G�ðQ�]��(�߻��Կ�%������j�=p>�c���\{k�Af?	Y��#��]Y�/}�Pzc�<ե��"`ʰ��W�����Z$}���MџӮ����[��� UM�^��4�<}�aZ��,%�5c�* ��������Ra%b'H�KQ��-U[��F�e�hG�$�,�N�}��lJf�R�(f�CB�I�����q�\����yR_��z~9n��o������_�,�"�]��q�@�E~� ��cwYۉ-�݆=��pd�y
����х�(��=R�95��zWnD6��
����Q���xy~���:����������/O��Ud��)�1�C�g#*_�ª�+K,f;%�㴈�®UZӃ���cE܈��I]�l����	��SZhI�}3�G��2�ǋ�f���_}���L��}��\�HT	v698������SG�D�n>Q��7���@y�|C�&e�'v�d��ܣ;�Q�Ўv���eɁ�b�[ģk�0�YR�u�V��iʺ�t��RȋYsN�2#5e`w,��Hf�0�J�®T[�)��w#[�[�'3�i�Ȣ�dڅ�Qxa�t'^�w VgQV1DQ����]+�v�.+��N�Y����ʤ,Α$����pQ_�'��Wc��	���P�U�Jk?��<`"��O�ۋ��
��ZJ4�������[�lh$T{~�e`3��6i�4n����AK4Y\P��6�������e��:_L,`�7q%�����>�^�ޔ�0Y�mΏ�@�HUNe���h2��	H��8s�Ʉ?Lƽ�w�,P<Fa���q�YP��xta8*��r�j�EJe��#�Q���ή�+l�a�<{���gA����R��v"�9<�偘��K0����?>��]<]�=w��G/C�L��=�d�8l �7{�g�`�e�$��(yM
y	V�f��$tf��Q�L�#����J8�2d�}�)��Z��*�y�em�.��V��me%���g�V�����5�7EY�V�)h&{�6��b��(3��D�B�aId,#�Ur9c$e��\��Jh<����l/a�R�ȓ����؃`"��d s,R.���!�/u1��@P�.4|4=��إ�~�6�!�lt���S�P���6$��"C������֥	-�P8Qi�	n���ca ̷�T6� m�{a�G$n�4Z���x`^��K���'/O�˝�][�yؕ�1G	���� )��e��WU'+:=��'M1F-�e�;-�N  /+uC�T��J��ɊD�r��ר$�VΧ*z�&2>i9	�y�dѬmh���.�Bt��U��LF�J�NݿAŝ�����<^��|{4��b7��::���M�Q�4@��k	F���|7�Æ�MYڎ��Ѝ˒�/�4&������+@�|H�z!oP�t/kt@�����L����'�34h P=�C�0���{��q���b�%le4���r�v=̃dF�rK�{mKy���� ۋ���[-.�T�l�����݋pm�uh ��&}蹝ٺH���RK�хD ��7ƕ�����±!Wn����@�۶���w�ؾ؟J�/��k@��g9�<Dϵ��x#���e ��NW��$�n�|�L��(�G���$���dw��
�qZ����O���������n^���oD%<�HN��!�lDۂ�M�����i (��ᝋ�Zn�2��`!�����`S靣�*�� _��WD��+���^Ήq�8`M'�eP]H��=l	��CH���G�S�N�ݻ]���n���y=�x|M7/|ㅱ�L�"��)Q��$� S�n]%&j6���)��L�FL�c����p�bUk6�!�8��� &3!Q����6$�Ǆ*��U�rD����V����w�ǉ)�%b#??����~1_�A�^�NN��r�EuuQ�g��e5yW�Y��oӋ��;�I��'�����\�����W0c]O�����a�:�Iqx���;��ڲ�si��d�C�X�+���ݙn�sq�-+�Q�G��M�EZ��n�E�t�������%6��{��V�K��ے���Q��A(��U����E��o�B�l�v�E��"ΦǼ��+��Ҕ��B6
�Me�
��]m�AT����N����x4���|���;��k~y�vc2���n���o�`+z<�a����C�@��p�ȡ�Zb7��< ��m�pS��e�f�v<�(K��9���9���Lu��@�˂=0D���o�ek�P�;�=�@&�N��0u�]���Q�2���,�qzt˔s�;u��m"����J���+� ��v�t&Lv��,�}@��p}��n{)�<+U��;����"ȶt�>�|�Z������]�m���q} M<{���=��(�PGFA3瀰'�'����^Ȅoxe��G�&8Ht!I���й!؀^_r=4aD!D���)��vk�uDȊ�>	���q�\�F�3��g�{���:ڱN~P���v�o�F��R�Ͷ�L�XɐZ��puF�.ń��L�d�0�Z�ż��Q���}u4�f�pX�}�\=�^/@(��Y7��g��-��X[<K�\7�ѐ�"�� �OIl�hZ^��t�F� �c�/JEL�\�	��C�����7
] ��k�Q��^��K�����~}S�/��c���gm<{-�p�:$�9��B\�J��p��nqB��8���d[[=�V�~��d� r �0u�p���#f0"�Lh	� ֲ"K�%�g�J���^kKTs�*QK>"    �aʊ�8ڧ��e�`�6��e/ЬKdE+��o��gk17�)̓��O"3F�-� ���ʼ��K�Rz!���$��yM�7��I1�������6�m�v�}:7�������"��ws��E��0!Ϡ<�C ������r>q#c�5.��ג���4T�����B3�iG�l�a�ۀ��ܾ���e<qK�<�wē���WW\.������u�^,��~��_�P:Wu@��&!���X�0]P�ڵ����p���Bf�v����f(\<ܪ��J2=#f��͍ۍ��q�����Ym���|c/E;��g0et�+�K�~vp�s�l �^����g	C),V�s}#Bd^�'�=����ɾ/\o�������6��{i�8���4�P��v��6�v�/C��D�P�:&�ek������+d,�b��"���.
���g�oHw�;g@�UUP{���B۳n��>uD龰����|l��w˦^O���^@4�<O�"��¡r ����B�{ѕ�mbfLJ�@�Jp0��D
����ME��R��ϐI[��nZ��:$�^�{���~���b@+����'�&�P��A�'`)3����tT)�*�#4H� ��lHP�Ȃ�j��0NY����!�6[^dvR�H��6���3�B��,�7�'K����HS����n�Sl���%@R�\�j`m�ؤ��׸�DZ:���1���B(�{������ky6r4NK{�D� �k���y]��cV�t:��1�(�'�s�U�{�<W����z���������;�q��ﾩ�?�[4)� 0~� �������=	��H�L��g�[ �Ҝ9�f� f��Y��m�L��o��"��H��m�e.�=�Yb�fAK��2}qE��N,=h���Z��]m�c>�ѷ���]`vy��i) �~� � �kD�Ä�*@m ߂F�CefT����YK	
��Fv6�2���#pCI�qz�h*F�V��J~��K����*��/
�3Pi����x�*��_���,��΄��}(�'Ҽ�x_��&�P`�rkc� "L������A����~򼟚O����懓/�f��i	��(��o�VV�M���>����~~�r�F�}����,��d���!�Eц'���d���<��}�*8�W<ĳHB���,�?�8Jk _2�S[vrIl�fa  �W!wU9:�ӞIPH2m��̉G�vY�3�؉TI �w(:��9>� �~��C e�E��L*4HrK-4����PB5��F��Y��p��W,��Y�r/�������x|�~'�-h�!{����&��͸��a����k�n�!�m؅rڡ������F��S-}Sw�]/�f��/<�tu!}���_�￱�^;�НO�y���M�0�,`��y���AT�d(l X 7*m}�7��@
��B��n�E�^��lath$�|USY��8C+��:ܵ�^�ʾ��S�Y\+'���$V>|5'�J�9��,�Ϸ錻��7�#Mȴчi����pMBធ��Tk9�}_JoJ|Y�Ghoi�Y��Y_ �"�#����8ޠ�|�s^HEɜb��:pu��W�J�/ȼ^���7ʫ�x�SA��F`V���CɼB2qFQ��&�cٿE4�!ɤ|#�Y�@*O�-?bf �e�-��[�*�����ȑ賶x� �d�;��K$��Օ8�>V�T	��n�>;�%j��@�m����.�n#��,��2�8$��K�e��%�gϻ��3���N�_��{c��m, &�+p���ɻ��Uk������-�p)hX~i�2�~���L!xG�r�O�vӫ���?�5e ��PZ�a$ǈ���!�ࡿMF��2&��a����H$9�Y���s�t�lG9���"ZS����\�/�	ʉ�����ԣ������&�\�3�O���������������l��T�H=�y�H������c]�u��_��Ƭ�B}�����?��rR�w��}�x[�2�3A��
�i��x�"��� /�$IuD�}@}���&�(��`18P\��ʊ )�� ,���%�	���Fx#V>;b�#��:X7�"X���r<ΰ�ٛ�G�ԟ��_���,e&f�`���`�m�}>/���y��^����WK���?�+����.�ʱ�s�=~�'**�E:��0lMʍ��u��V�,I�b�ʨL/"��(���K���(w�F�J�{g�N
��l�m�m�%=@ޅ�An����u����Q������)�/Į�{%����8s�N�a�D�ƂhV���#�E���h���!����fD�ñ�	=ɑ�	�C��CBm��� �M�Xּ�ǡ��ň��s&rd�m�GR*���bk�%ɱ;$֢��������̒Ɂ1*�`�0bBRa������VB�/l����W�,f����	�����C~���0����ZppJ��:X��}�<;R-4���Т�~f��ݗ�#G�ֳ�Ձ�o���D'�5����B��j��3���b��@ 3iV������}fԳX�`�awOr�$�'��~t���g?�2gӋ�/-�����ݻd��H��;C(�XB�4��)��ӊ�/�}>��W��:aȥ��р�%��Gq��� �Q��A�_��I@D��m��A�d��].����~�`��;����
(�a�|���׃)	�AY�Y�H"9����ݲ3�lf�e��➉t2Vv��O�%���=�vǠ�G�M�QΓZ�O��F�5���	��?���/�;�����X�?w����<9�=���o�oið�k�r3�����������%�>�� � �j��D9c�*Ƶ8�����/��b�hqɟq��Ыͅ�-�17"�O`�&��50�{�Ek��b[It�F_���i>ɚ^]����|�3��6��F��Qa�7o.�TM�WWW��������}p�a�� ��?h0L���d��e7j�z�w���Օn+�������BE��Q&�{È0�LF�b�)Izpm�P�� ��A���g�ecY�n}<
shsu��j��;����[��՗.�
�
��s7e��v� ),1L�(��b�dC�������a��J%�R̸�k�mI-?�M�ǁx}�m6��Z�C#�����&j�Uwa/��M�������ņ3�	��Y����m��	�4f��7R��'�`�qKA�@Į�KPy�A���O�ዀ�%�y��|l�H&"��<i����˱~��z�K;�m�w5�'�ߊ�<��2G���cK� �;��aD]�:�����{����'ɸ���H�� +W��� ����{��Fn#���"%o�},�6�>jG�ڌ������g�B����s=m@93[[��\�/o3�坧[�|�-J�'Ƃ�u�F"�6�2�Q,���!��T�G�	E	�BK�J�	�(M�Pı�+6éFl��ٝ��#�8bBfSf UGxzע��#֍ZY�2Q���y���c:x=��z�X�'՟ΧM����o���[�L� c/�q�?!$a� �pi��bV�uI�GF��g<��҉'�6W�!�kE�bYk'fB�=��4�pX���U,����\�Ɇ�>�Ju	}�&�/���;gY1~��^5�?5=ny�7߈�I7�Q2���a�\��-a_#�Յ�S+F	[�D��N^,� C˷���kOP�hl G)�E�)/�8����a��s�����@T% �
Ǿ]�/7�}���4Z�X�'�N(I�]��=_{͢��v�d6�<���$Q�ɇ�_�(�'�e�����e\�T�o]���AG�]�5��nQ��ax�܋ݰ\��8^����ϧ�������g�U��s�Y?L�h��Q�lKcY8L&� �8��
�6H_��F��R-b�/��B�͈���JX?B���&�*o��^���7<�z��=����/���������c᧝����aM�y�q����s��˚=`ڡLM�v)���G �����Y0Ҏ    
�TK)���D1?Ju69<�hw�.Dw�3
�y�/�����E��Q6�V���\�m��[`e@1����V\T6:���Ė�7]��?26 bTf�*�%&&Q����cP���
_؆��#ƽ��J1��y2�v�	��e��'�� � uSR�8�@��@��u�r U�`�e,����DZ1αi
F�m&k�ˉ�o�=s�&$"��i�S�
|9��vy��>+���<�}w�[*�
M�У����;����F�,R$�9Y��3��a�E4I`�h�z$r�@ڙ�� �f_�]���֩wVX�w�}��d>jj�,��	^�R�tDj I��a�=y�ѽ�{I��;�3^&z�-Âov%�#xyhx�K����P���kc%��a?q_ؤ�s�^�������N�Hzu4���V�y��s̼Zն %"*	� �
dnT���J�m��n=���9�k�Eq�J��M�v^�f%�W��v[�$?�W��z^���Z�[w'�h��_�;�V����hd�!<+�@���&�FA đ���4 �ѳ/p����nԱ��(^��C�\A0�N�un���f;������^4��GL]�j��6ěh�fu��pǑ�]�����
,�dI�M��!�z/.�x��%(z�.�a�-�8!4�!+�ũ@2�y�kh�?]Lhfb�abH�9E��22hU�9�$c�#�KF���!R9��jxMr&�x���kHL�k�]�zA���7U����QD�8Ա�;%P��ր�,7I\�I�@˸4�)��`����Έ��D��nR=���ӎj|`�@y�Տ����_���8"�c����B?�`p��'"WEb��3N�z�TjrT�����i�T�R:�Rt�&������5�G�������ΞO�6;n���媑?����L>ZMϗ,���ófV__��ov�o�oI�2����6p���@Ȅ���O#E�.E1�I�"L] ʠw.LO��I1P˚@��ՑZ\S�wg����O��D� Vr�l��P�ӆ��	X�;�S�`+�����ǘ!�-z�Ӝ��'j�����*�,�u�e���jq�U.(r�
|��3�[j���O�2��fT�'�J�ȊFp�"[�:�����ǈ����C�B[!h���- e�*Sԉ�D��i��\�dI7�b��J��N����������.'�?����Mj�UU��\�q���Lg�k@��g����?�����??o���/?����C���?����77xذ�1FD��M􃀯їy@�!�H�m[Ǝ�A�-`t	�%�J�N񘴣�g�y�Y0c����&�\�>��]tl�F�nQ��w�f�<��!���Ld�M��7?������ڃ\��k=ݢ��,a�}�gѲI&]�{��-5T]M�i���3а�*�V̉�,��8X²A����N�ה�(�q�i����4ۡ��-����g�p�EC��ŖuVw~��r�[&|��Z~]6�ŧ��Y��X�`祯�T���F�o��	CD��x�I&c�#9�L	����F"V�q3��b�Û$�.��Y&���c;�U�kf�K�!�Q�<�V�:��q vuZ%&Ud�M�,p[A�>g��Ӿ{���h���bN�Ll�D��H�"Ob�N�'�΂Fv*���xU�R>����b���	��Ċ�3Q^����F'Z�|�������l��]?5��D�l�sz����5eO���������<�x){�����BU�Al��DUc�|b�L�7�<��:�S�|��O��ήίd��m&��dY�ޑʿYVx����<�'z�f5���t�����O�40�l� }-� ��B�H�Y͜&w��W՟	��J-b�"�2LϦ^��Ѯ�9���D�7b�nPf!E�KK���*�PV�Ѕ���mp��'���\?�@w���ٙ�bZ�A�W�sٱj��������ּ�i1y�L�->����L͌��*/;�if�x�]5v��}�5y�η�p珣����F{�@~�淅�ǃ��\v:��I���]oC�bn)�@e? ^�.�.��P�Nr+�O02�@0��b�*�E;�ً�:\�E�4�5!S�.���v�y�V �+��Q��f�5�we��|��b�����������
�����Ջ�����l>T���0�ʅj�?�ܬ��I�bzB�q���،ſ�PWYeW�lǕ�tU5����7�?�� �*����u=����I������/ z1h�tدR){j���W:Z'��O�1H����=e�@��Q�76O�q�ᲄ�y	F����e��X�����a�h`A�,�ޫ���O�}$:J6�
QPr�Q��2w 'Jf� ��x��{ Y�:橩&�$�zS7U-�ENѤ��: _�伧ŕ��Aw�!�3��ñ��4@nc������C�:��������动�� \H�u��\R�y���'�1�o�Ó:�
���{�Z�����I�o���r�����Y��A�@����O������Tm��P����QN�dR�q3��LL��R]���t�r#f�y��=�xz�zs��[���\HnB�� Sq�r�lp��A���\ �$Jr��c���@
��-�(V��C��r��Vs{\�F�Ƭ�����p��/�������I�GtrvD�ZD���N���Qvpt�yw�D�{q-g PT�D�*7I���r��4�P]H�=���ڣ3��� G�[���芤I��А<÷Q������Ā���C9�bu�Kn�D�fJ6�b�3���[Gޑ��8�U���3��6כ=F.�ӥ�Qk�y#���"w��G�_ƂJmΓ�Mh��T�S�h�R��8Pn����$���ʹqKn2�fz:3򿮕}�.
큊h9́B$��)#����ڊ/@"��E�<�a_�g�(�	�rr>|&:��#� 'T+�0��|LŒ�]ϝ
�F����	�8��{�	��;=�I��S�O����_Χ��7�#���G����Sp���>6�?��4��e���G��8��?rE���f�\��ߧ�����f?���9���)��ھ���(D��E!a��QQѻ��JbOe�*!�A�Pa��oK��m�P��Y����`��AS8:v��t`�C'k9���������#�2ח��r���7g�je Ɛ]A�Z8B
��G;6?5�3'<<�E��,��
-K���Gr���o�7��m�>��'�X�n	�����};�Vv�3���5֞�Z7��p8�ނ�↏5��m����4��� ���H����Sd��A���$6��e>���k[�	|�<�Z~X5ǲ��^��^~8}~��U��J4t* �Ah�`�?3Jos��R�@ e�ef�6��(�PB>92�ȣ�MK��G�+ Oalݎ����Ʒ��� E��4�邐�g��>;#�Y��|5Y,�ggb�T"���b��%�[��u�ROE���S�ᵇ�hd׫$�_4AT�z�� �b����vS�5�: �4G)�,���	<��V��r`� T�U݉�S��{��¢� ���>0��h2�G	��z�Ei�CL��56�~��Jn�+�Fu�kD�#P�9���r�X�B�����́��ϖ^���� ��a�=z꙽nδk��.���1�N������O�?��^�O~ӏdrf�R���\M�����˦����x��b�=�����_ϧo�5�����e�W���o�g?^�����m�.�;�7���w�����)��DW�X�=v,��Y��GW��}�IUTf�vq/2x�82���%�y N����&����tnӅ�� #��@�}�װ�[��}ia� ]y,��R���Ӭ�5` ρ2��~,hVF�iW�Ȱb�({�|ph~�I]�ߖ��[�2�������_y��M�0~��//����6֠7����T`7����j��@5v��_'Ջ���|�z�\�"|��Gp�]�[�6^[�ɬ�ZJ�J�?3=��<�Vn    lm5��X�<��bq*"�C}�]��Gl���ƀ,('�u5�I���w�O����x�}�t�id��i�6U�P���W7���i�I�j1?]����z�V�����zR�PW�L��&���ƺjc�c���'�O�����և��fZ���+��i�e�MVzb�����*ۛEE�_����_^x�X\�^�/H�u��]�2��o�p��w�}v_�v���<�x48,��ㆉ����}�L�����
�^b��2,X�ԯl�Й&�Bs�@��N��҆f�H�'����������r��a�?5Go^����T���K��ڽ)�}�B� y�� `��(�PZ�}iێ8 �UF� �x��� Ygk��>��NFA�r���6I|�dHZ�%8��o{Om�*�.fKD,��r�!�C�P�׮�}�`�E�4��Xm�ά��ຯB��3��Hr�a75#��/:r�ø�kU�����*��
�?���0td6�Dx��әO'����yԾ�d�? 28d"�2�AAh�I�XlFT0��������3�\0�8~�Pl�P��3쉒�w� ��m��:1�7A-�)a����)�-�9>*�9�Ȋȱ�>|y?�dۊ--��?d�"���"ų��E���m���X|�z\M�̈r��X�q�="]���^"t7���˦�.�>{����Ao"7t���%i��bZh$��Z��t6�����q7:�S��
=�e�`�&D���3nP���.؋�FB���� kw���'|i�G�Up�D��Yjt�|��W�;_�A�]\��{o�4�S,�jFi麟�3%6}D�W�P��6>w����l�#~�aHx-x�uU�M{�n0� ��Ι9�R��Eoep��~�]���:i]6~�jX�Ƚҫs�5L"j�2��A�z�������p�<[�����]7H��� 8ŚDΕ=^
#Cp�~u�22���V�lq
9�"o$P�L�iG����N��e�E�k^FPJ��ʕ��&���;�O/�ӓ���������u�EY�Ҫ�쨚���a5�\-��2?|w���u}>����5b���fk�P�ōM&ڪqښ&��4��ެ'9O�4WZ���P}c5�DҚq�4q���<�-���K�̓�ΰ1�@�ь ���$UiS�iP�!����o(��"kȧ(�})W��EP��� ��D�/o�#�Ĩ��i�-�2�Q=��j�7�(����=�#�D�_wW�ܶ�E��`�)y ���<I���d�8V��r� AI�(�-�����v�m�d�T�2�������{Nq�ܝY_�	���`����������pO���m�av��bt<(��׿��������?�^!^w���=�U>2���+�{����r�j��pXan x���I���6z�yp�����2"6p�'�ת��{�S%�����\�̇OR�8lW��_��0�EpoE���V �~�g=�<�`���7�����ͬ��G��� r�Q圎^n\�^H��f�?����J'����X�ӂ�^�0_s�&?1E4���Рf���/��Eq�I#�#�C��9sQ�r(�Gp^�<L�%H:,�8P�t�L��l�m��5z�_dn#W[�a�o��Y����n����T����W�����~��������ֱ'Qu<��iQh���y%9��
󂳚=8���r�q�aD�o�>|LZ0��*��L��q��=%;���R��.�_��!�˩k�f�L8L�ĳg��ʬ����[S����n&_�N�����)(��{�O��E���
)���Ua��o"@���_Ħ�(��
�t�]lQ�� òE�(�;9/Sd�R��T�����ä����,U]���(n=��/�o{��l���	C��e*Ŝ�t�ɥ��t�����[��y��
h�I,����i*�fZK�Ѡ����ݘ-@��M��FH��uwp(�C��3�^9�{��ĝ�٠G�(Yaƾ��[.�ʠ��|�2Q6,iV��&Q��� �cm<���f�A�-�]���:� g�H��uY�۸]��0zmYb+����w��Q\�_�7�i�"2�����>5��ؗ���>}�3?����u��mf�X}��-���:B��t�4*��1\55"�ҚT%���4����46m��C3�lr"*�3n�p�q�ǂ��
��9q�	5�J�	�!��}���e�Mrr�O -@��$?��:��'��>i�]���y��%�9��u$L ��39�31�?m�("7`o�vA��4\���KKd���o��ESl���m-7h�[�A�k7�N���i��Z[ֱ)ƕ�
3v�(m�j�TU}����P��)��ԣ~�?m�K(�C�
u�{� A-9��*�
D��D)#�®�By8���1�Oi�� �WfK��X��=�x���*�ݖ����fэa���ٹ/]�M^�(�îC^FY_ĸ
�+D0;{;�{��}b���>[rĘI33�N5���9b�<ud༥!a�ً`�x�2����.]+f4�:����h���rBG�9O��O��������� ��/7��,�M��|�ma�.6 ۔��@_��8���5Qd�*m�-��&G%׀$v��#9��y��[=������ã�1��BY0���р������N�(���(�Gʭ�Ʉ��٥��|z�#�=���ٌ��b�)���?f�֣�>u��Y�r�//:t�Y�r��D?���:���aQ� �G;�2�#,�` ���4<��!�sz2� ��*��5�H��u1,>�@s���ɽ~-��/��إ�_7g��ë5>���؟����򢷲�����R�C������w��+��|~g�'q�ӿz�G���IA7�~Lu�H��Y�RmRFޓ������XHW[p�<6
 4���`Y:�MrN�z��,w~�c� X-���}�T�^8�_-c{�v�9�B[����q�1@ p,��"?�jw�N�'���Z­m4������^��:G��o�'���+x��ѭZw�CnͶ��Uo���!�Ҍ���Ue�i�)iUF$7=ډ.���� �C�*�$�bP�jI��[j�@�Ut�I3g���sT�V [Vf4��"2x>�Q��B��:�ʫƗ������/�G���v���ʛ::;�D+������� ��)�Q��FW�#w��d+ y���#W)h�*Z�иq�hیLY6�h��
P�ں�(�F�X���tW4R���m݈�J+�����cØ�@6ɠѨ���D7\ �b��D�\
z.�H�E|<e&et�p�F�w��a����|:��B��z� �׶�n	���?�J�ٛ2�'�c�F��,}H('�7^�bO��y%�X��=:CwK�L��F�р���в\%��)5�"j��ZSh�@�י��9]��k�Z/A�"�I��n��V�$�/��]z�!	�����P4�,ٻ"��)����+ߘ2~����@�+�K�)h�p�[=I�wN䀓��b�m�	$��pJ��`�I��B���8ᔸ^�x�d�=mƉ�;�p
B���p��ɡ8�sT���$R�u�R�����lvRs$3���G�A�8��0��ZHvi^�b=ca9S�W��F�l���R[w8��E�&��C�+f�s�;�îh����LW�B$�\�.pU�)t���&GU�P�bj{Z�OO������i�che��b�b�f0�����^|?���ޫ��,�6�6Ϥm��%���� 'kz1�ʕ����YsVި�}wP~9������������u���*"�]&�mk��� ��b9㖕Z�#�R��fJ�$��+�҄:� H�|DG>x@bL6j.dQ��K$T�˲���^؈�.��˃���7V�1�m�A$IX��7I�I�x(�J&�eb��4�UHp. x��]����bjX�>��a{�S���]��W�����,�q;<��(5Dx�2��z�pg�yt!�6}�� M  B���x	6*�(�3���! ��1b�AS�!x(�-�ex�՝�0�S�y�=�����l��*����(��<����w�I���D��|:%�|L�<����y��젮G�z�.�ٽ�Wyr�<�D�,�ȷB#r ��ԡ�i��2pG�X��-���R0�i�4H<�dUDe#��/�(]8��r�<�&4y"Q-�w4]�ĵ�̼e�hJ��\g���'"8�o��u�^6�Y��_Ɋ��@8*zr#��4	���ʸixAzPO)ϊ"`�g��Bf��0i��ϻ�~X����}�ZJ���d�6��� ��QB{+������'����@���3��8T'�1)�VD����]����B,T�EL��93gy�sm�p��P�d��v
?��tV�hu�z(���h/Z�dy���=�����X� ����Zb�΁�6�����m�sfr/X��)��3IE�{�	W�D.B�;�A�@գ��.m%b8}l뉞	�E�Q<�������.����/��������ن��M���'f^��O"��]`g-������v���3�c��,GAW���,UE���r�K�� �rT���XK�۪���!�/]#d�G+1�}�g��
�@�B�/��KA�#�p�#/@�La���������'�4<M�@v��k�3�[iE��A;�+�U�b��G���O����{�>�iJ��}��^o����|�]Җ���n����.�s�![Q�ڌ�qt�c�(����޾}.�ެ�ɖ���h���b+V��>��G�မw;Yg�'���I��M(-0�581���/�@!��Q�U"�F`G�	2�U�@;:�V�a]�䩊S�
J���bT����**�E��1�nP�8-a�|88:E41xޜ6�G�K
K�^��K~�ez:�C��(V�ϴp×�Qs~:|1�Зr/ӝ8(LS�>�;�����h�oľ�' >a@r8��.�\/�e�
x�Zb# �GG�byrFRA��t(h2i���� QY��1wГ7gCB�*��mT��[<��-	�#�9�v{�����L��ӷ����[������Z�O��89��*�u���狠G�b4�'r�m�U�E5o��X�}�U?5	!a�T�!}�.�`��a�I�@ �z^�¦F7-�g�a**�%~|toq�d\ 3�=xc\B��^ij���-�=ޞ�������>�/>�������i��_/��ϟ��^�ʽ���Gږo�.ڝ�����I
��HȻ��}����{;��yh?H�y<x������7�trVΎ�������{7��W��_�j~� ox=���o/���t>2]�0;���?�����ez/���4���Ӳ�LO�������f�m�G�Uk3j���+H��E"gc��?p;/nN6�L��H��CB3�xB9ǎ&���}slA��"��1Ȅx{���;�?lNN����4oNk�S-c�\rcvqvL��UWUݨ�͕Pa�����xU�ٺ����c��	�5	�~0)*���茦u��ɲ �딀8J	֫��7�y��3�cc\4>�M��1xp�2sf��O��j	H7P�\t����2ƿT2xv�X�<-����V
y���6q(�[\Б�X�^gҬfpL��8���A��ܹ���ζ�q����I���ny�]�|�knz�C?�s���A`(z�Ђ�&��(Ǆ֌��1��E�3E�f����y|~�IX؀�&-4�B"UIkNu��t�yz4��x�.��_�����s./�+��ϭ2J�FG���m����,)<�tr�K_L���ff?����9���P�S�y�5"kݠ�χ�<c ��h�G����t� 6���o���c�B2���?N���������������&?��=������b6x2��O��wt�J�������Y5c~�[���ԈfL�&%����p�}�����Cƒ��a!�eۿ����:3޹C���|^�j�Z�O\�4�u�IB�XVA����:H�9B7��V�e�O�#%�6m-;��̏����]�t��lϤ�v3,�9��m�f��ѣ�aG�      �   �  x��[[o��~���HG�]	���`�m&ɉ�ٳG�F46c�f���Oc71N�0�d&#?XTWUW��UwCdMy���џ��{<�?�\]ݞ��(����iY�q3��s~i��Y�%��+���Z���
&�_jA;Y��ϲ�hC=�������Q�����y�忎������~�V9���]�_p�{����q�}�-0��)�S�1�k*���p�l]b��ZV/��2OP���L#{��lI�!�H�	
��,	q�C�c�$�ޏ1*��	޷�{[�ԗ�ûG�����IqBP���܏������q���({�⺊hݦ�^�8A~�Ĥ��z�$bB/��=Z��oE���mw��	%יG���)��؄��$�|�K��d�b��*��Ƅ���	��{��eK�8�#&��K��uJK���R6�Nu$��������Ia=�2����a<H��n�tq��	�����u�W�.�f�/;�<�-�oc��ȯ!�C�������f�	�{I!뵗d���3��Ї����g�N㶻ɤ��$��ɤF8.H5�aLޣ4LpQN&nQ�$���N��#?���|��_����!Y�b9� ICI0ݡ%��+��+[CU��y�?��=?c�b\v{cz�,z��Ȫ�EKp]��=ɲ�>l�1���_R$c-PE��4�N9��e�2�2B��c�ԃƈ�T#��VMEi4=]�D�L�s]�]ױw��w���btFK�f�&v��5�*s�z�c��(��*���.��H��EEw$��.����U;�{�t���@����}�H\��w(Xm�(�Q�5.�h3�@;�*�(cfd��S\֫���-3�UC|���
�fX�hʾ"��Y-��om3�B��,#Y9��2��P�k i�ɞ/�9ᮙJ�5��]禮��d���&���[*~�k\~�]�L�r�֍���4������X��F)~�2�H(�Xә�$�Љr�F���տ�!.u��kČ6L��*�CXь(��F��	�f�/J� +�����bK���_��k��ڂ�馠�lu�	�9rM����R�@��>^������go�i��GR��l��(�/��?>\K��.�c��d�=��j���xjδrswg��JSLU[/R��uxw�=�p3�3��(��LULW��k�)�yzW�5m5Cи�8UW�9]÷2���*Ӓ�)�?/4��e�m0��/z�RU�B��O�6~������8N��k��t���5 �l	҂uy�K�+����H߲E��uW�,Xk�e��K]���ړMQg
����\V����}5�N�`�):
!�4 :�;48c���p�2}ͮ�s���/V���b�x��_┗��M�c$_?T�"��:��HZOK�{#j=��!j'��n�� �Єh=�~�C�5jW���fBm$��fB}$��f����31@|���!K�>�v���,��`���a{0���R�AQ��Cq�M^|�LqY�nL����f�{5�1�Xg2�δ�v�-���XՅ�3�����>.V���Le2U�:�R�N��]L�z�ٔ�\��(�rLa���(�P��cj�\;��� @�-��1���R@#�҈��H�eA5]�5�T��3�#]�tu��=�΂c�<�O�Wv[u��[ /z���p�G|Z�u�+S	���-�K���A��'�����O}����<e���c�����5}|�*>�L?:U�"�i����(2��v�����������7���W��W��◸�<!��jG�.��щg��T)4E��,��W�u��c�*�4��u��i��'ڜuZ�q������oewI|� ������^���P�lC��86�U�$E���,�}���v̦�G)u��O= y��h��C96>G ���Y��M	+�fH�����]{������S,麢�#���(Ǌy'ѫ��įa(h}B� ��>O�3f����R7K��ɲy���Gp�NB��J&PL-q��Rd �����=��H�4}�z�PrAUM��G�e�3%KrU�b�B������]x��ΥX]v�
ֳ�,]ƚCW,��Lٰ<�2� �A�LIdY`aѵ9�m��v�z�'q�H��o�qf�R8��\��[��˒d�]���q�℩�0�t��݋=�ֲ^��׈�"C�*2��"&U�	��iW*l:b�	f]C�%f��a��F���e�w�\�dtA�c;
�&{'6�����EoK7�"�3�S-�����c�V �!���Ѯ��\��UO��6 �a?d��W��,
-� �î�o��N�Y�* ���㙚<� PQ q�(t�}��,F��PhU�q�:��2�u�1.�=�(�Е�N+���~��Qm��� �ͺ^Hl�\�1"{�� K�Gʥռ�$eP�9�0*�Rq�J����6;��g/�s�c ��>��F�)*@6qԵs�G������'�ܑ'Ac≏. ���o�2��)�*]�}փ����Tk �m]�f�X2a��P���0�Z�Y�z:��"Vb����V ݭQ(m��K���
��p�Z��_>�E��u��cR�����R��]�خR� 0�~��i�+����~�C�Ƥ�?&�l�x]-�r����i `��E�y�}��՝7V����-���~��%JƤ&��Z�t3]�G$�0|E	}x4���'������ ��YB/H������4J��s& g'3�0/΃,������HmZ��Y]���OS��n��j�U�~�[�7gg�+ck ]c}�̗9
��@t2�h5� /��L&A�X��?�����7�����
�ߋ��c�-D3vN
����Ê���U)��,ʻ���(�~N7��=�w�(�  �`'��x͆u\}�������7Q>��~�mj	�(�� ����=^��d������S
�      �   �   x�=�K�0��)|�
	87@�ؘ�T������iף7�S���â6\���B�3YeWz��N�`"_XH���8 x��6i:��MxG�#���5O&�
O�=�*���p�q}u���LE>��N�F�7`���>($��UL�]J���V)      �   �  x�m�ݑ#1���Ql���4�\�q�����~�W�i�F����y+3_lO�5�d&ɜ$b4�K^��ب�:Q�z�_�h�IF#�/��P4�B!CNt�����$烴K�2%a=����7��%U?Q����r V:;/�<��]w(+v�%-V�A�6�Wa����-���K�d#����X)w�#�<Y�/�`��:�+u�O�ʶ���ch�ŕ��5�P}�?e'���5��_����
��Fg�v��7h>�2y�o#t��m�����)��N�LҸ�R��4%���{�MV;[C�ČX�l���(��;����ı�����Ճ�B1b��eJbE�����=̓u%���>يR��4Ѕ�[�K�&v�-_�1�ܗ'rK�Xǵ�soE�q�l}�T栺�`�*�zp�����P���y�����Qۇ"����}�f�jl9]K��	�l�P�1�!�d+���Y�IfXcU�#9=��j�*�#P�ϱ��l�ή��Y��������'+;IPݏ��m_��P6���'���@��+�C�	t�s�7����:8�N�/;vݨ�)-t����s_��fu�Q�{n����knL� �2;��f�v(��� E6���Z�P뗽c�v�t�	������GF���70�?�z��צ%h      �   \   x�3�tI-NML��t�I�M�+�WH-.H-�(��)�$*$���� �E�\�~�
����(�OR����4U� (��I��ϴ=... �L>�      �   �   x���Kn�0Eѱ��l�I���	�k��頫o�����כC�ZK�K�m�ޏS�g��Qv9`��R\f�T�"��b���p������RK�����#�`~�X�f�@�]t��k���ߵ���y���iK�1�ʉ�CN�F�T\����>h�l�.%Q��irN4���0�{�x�7�]������-kz��#��H��E𯶓���J�x�4���NV(����0��~�      �      x������ � �      �      x������ � �      �   �  x�u�ݎ� ���S�T����kT����u��Q�l�o_�p��^�����0���p{N���|~o��Wa�����.����c��G�\S+O�e|2�"X�9���"�g��q��e�oE)�b�i���������E"�#p�����_����l���~���EOQ;��ъąvW��kE-�Gck�_{uz48�:��8�v�Ԯ�3�Ϸ��W{{~�Ǣڴ�ۣ�VC��W«?��C���b�X\/����bX�LI��0������A�GH\$V�s��E'v�GSRyk�q մj�P��-���X���������[����ʘ@�,�3��
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