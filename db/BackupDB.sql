PGDMP                     
    z            TGAM    14.2    14.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16394    TGAM    DATABASE     f   CREATE DATABASE "TGAM" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Venezuela.1252';
    DROP DATABASE "TGAM";
                postgres    false            �            1259    41356    Empresa    TABLE     ]   CREATE TABLE public."Empresa" (
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
            public          postgres    false    245            �            1259    16517    Flag    TABLE     �   CREATE TABLE public."Flag" (
    "Id" integer NOT NULL,
    "Tipo" character varying NOT NULL,
    "Comentario" character varying,
    "Fk_Tipo" integer NOT NULL
);
    DROP TABLE public."Flag";
       public         heap    postgres    false            �            1259    16516    Flag_Fk_Tipo_seq    SEQUENCE     �   CREATE SEQUENCE public."Flag_Fk_Tipo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public."Flag_Fk_Tipo_seq";
       public          postgres    false    223            �           0    0    Flag_Fk_Tipo_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Flag_Fk_Tipo_seq" OWNED BY public."Flag"."Fk_Tipo";
          public          postgres    false    222            �            1259    16515    Flag_Id_seq    SEQUENCE     �   CREATE SEQUENCE public."Flag_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public."Flag_Id_seq";
       public          postgres    false    223            �           0    0    Flag_Id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Flag_Id_seq" OWNED BY public."Flag"."Id";
          public          postgres    false    221            �            1259    16417    Persona    TABLE     �   CREATE TABLE public."Persona" (
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
          public          postgres    false    213            �            1259    16401    Rol    TABLE     �   CREATE TABLE public."Rol" (
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
       public          postgres    false    220            �           0    0    Tipo_Id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public."Tipo_Id_seq" OWNED BY public."Tipo"."Id";
          public          postgres    false    219            �            1259    16426    Usuario    TABLE     4  CREATE TABLE public."Usuario" (
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
          public          postgres    false    215            �            1259    16498    Virus    TABLE     �   CREATE TABLE public."Virus" (
    "Id" bigint NOT NULL,
    "Nombre" character varying NOT NULL,
    "FechaCreacion" timestamp without time zone NOT NULL,
    "Descripcion" character varying
);
    DROP TABLE public."Virus";
       public         heap    postgres    false            �            1259    16497    Virus_Id_seq    SEQUENCE     w   CREATE SEQUENCE public."Virus_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public."Virus_Id_seq";
       public          postgres    false    218            �           0    0    Virus_Id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public."Virus_Id_seq" OWNED BY public."Virus"."Id";
          public          postgres    false    217            �            1259    16636 
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
       public          postgres    false    231            �           0    0    auth_group_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;
          public          postgres    false    230            �            1259    16645    auth_group_permissions    TABLE     �   CREATE TABLE public.auth_group_permissions (
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
       public          postgres    false    233            �           0    0    auth_group_permissions_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;
          public          postgres    false    232            �            1259    16629    auth_permission    TABLE     �   CREATE TABLE public.auth_permission (
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
       public          postgres    false    229            �           0    0    auth_permission_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;
          public          postgres    false    228            �            1259    16652 	   auth_user    TABLE     �  CREATE TABLE public.auth_user (
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
       public          postgres    false    237            �           0    0    auth_user_groups_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;
          public          postgres    false    236            �            1259    16651    auth_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.auth_user_id_seq;
       public          postgres    false    235            �           0    0    auth_user_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;
          public          postgres    false    234            �            1259    16668    auth_user_user_permissions    TABLE     �   CREATE TABLE public.auth_user_user_permissions (
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
       public          postgres    false    239            �           0    0 !   auth_user_user_permissions_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;
          public          postgres    false    238            �            1259    16727    django_admin_log    TABLE     �  CREATE TABLE public.django_admin_log (
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
       public          postgres    false    241            �           0    0    django_admin_log_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;
          public          postgres    false    240            �            1259    16620    django_content_type    TABLE     �   CREATE TABLE public.django_content_type (
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
       public          postgres    false    227            �           0    0    django_content_type_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;
          public          postgres    false    226            �            1259    16611    django_migrations    TABLE     �   CREATE TABLE public.django_migrations (
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
       public          postgres    false    225            �           0    0    django_migrations_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;
          public          postgres    false    224            �            1259    16763    django_session    TABLE     �   CREATE TABLE public.django_session (
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
       public          postgres    false    244            �           0    0    myapp_tipo_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.myapp_tipo_id_seq OWNED BY public.myapp_tipo.id;
          public          postgres    false    243            �            1259    41377    vw_user_list    VIEW       CREATE VIEW public.vw_user_list AS
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
       public          postgres    false    216    210    245    245    216    216    216    210    214    214    214    214    216    216            �           2604    16520    Flag Id    DEFAULT     h   ALTER TABLE ONLY public."Flag" ALTER COLUMN "Id" SET DEFAULT nextval('public."Flag_Id_seq"'::regclass);
 :   ALTER TABLE public."Flag" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    221    223    223            �           2604    16521    Flag Fk_Tipo    DEFAULT     r   ALTER TABLE ONLY public."Flag" ALTER COLUMN "Fk_Tipo" SET DEFAULT nextval('public."Flag_Fk_Tipo_seq"'::regclass);
 ?   ALTER TABLE public."Flag" ALTER COLUMN "Fk_Tipo" DROP DEFAULT;
       public          postgres    false    223    222    223            �           2604    16448 
   Persona Id    DEFAULT     o   ALTER TABLE ONLY public."Persona" ALTER COLUMN "Id" SET DEFAULT nextval('public."Persona_Id_seq1"'::regclass);
 =   ALTER TABLE public."Persona" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    213    214    214            �           2604    16449    Rol Id    DEFAULT     f   ALTER TABLE ONLY public."Rol" ALTER COLUMN "Id" SET DEFAULT nextval('public."Rol_Id_seq"'::regclass);
 9   ALTER TABLE public."Rol" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    210    209    210            �           2604    16450 	   Sesion Id    DEFAULT     m   ALTER TABLE ONLY public."Sesion" ALTER COLUMN "Id" SET DEFAULT nextval('public."Persona_Id_seq"'::regclass);
 <   ALTER TABLE public."Sesion" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    211    212    212            �           2604    16510    Tipo Id    DEFAULT     h   ALTER TABLE ONLY public."Tipo" ALTER COLUMN "Id" SET DEFAULT nextval('public."Tipo_Id_seq"'::regclass);
 :   ALTER TABLE public."Tipo" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    219    220    220            �           2604    16451 
   Usuario Id    DEFAULT     n   ALTER TABLE ONLY public."Usuario" ALTER COLUMN "Id" SET DEFAULT nextval('public."Usuario_Id_seq"'::regclass);
 =   ALTER TABLE public."Usuario" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    216    215    216            �           2604    16501    Virus Id    DEFAULT     j   ALTER TABLE ONLY public."Virus" ALTER COLUMN "Id" SET DEFAULT nextval('public."Virus_Id_seq"'::regclass);
 ;   ALTER TABLE public."Virus" ALTER COLUMN "Id" DROP DEFAULT;
       public          postgres    false    218    217    218            �           2604    16639    auth_group id    DEFAULT     n   ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);
 <   ALTER TABLE public.auth_group ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    231    230    231            �           2604    16648    auth_group_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);
 H   ALTER TABLE public.auth_group_permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    233    233            �           2604    16632    auth_permission id    DEFAULT     x   ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);
 A   ALTER TABLE public.auth_permission ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    228    229            �           2604    16655    auth_user id    DEFAULT     l   ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);
 ;   ALTER TABLE public.auth_user ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    235    234    235            �           2604    16664    auth_user_groups id    DEFAULT     z   ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);
 B   ALTER TABLE public.auth_user_groups ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    236    237    237            �           2604    16671    auth_user_user_permissions id    DEFAULT     �   ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);
 L   ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    239    238    239            �           2604    16730    django_admin_log id    DEFAULT     z   ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);
 B   ALTER TABLE public.django_admin_log ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    240    241    241            �           2604    16623    django_content_type id    DEFAULT     �   ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);
 E   ALTER TABLE public.django_content_type ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227            �           2604    16614    django_migrations id    DEFAULT     |   ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);
 C   ALTER TABLE public.django_migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            �           2604    16777    myapp_tipo id    DEFAULT     n   ALTER TABLE ONLY public.myapp_tipo ALTER COLUMN id SET DEFAULT nextval('public.myapp_tipo_id_seq'::regclass);
 <   ALTER TABLE public.myapp_tipo ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    243    244    244            �          0    41356    Empresa 
   TABLE DATA           3   COPY public."Empresa" ("Id", "Nombre") FROM stdin;
    public          postgres    false    245   ��       �          0    16517    Flag 
   TABLE DATA           G   COPY public."Flag" ("Id", "Tipo", "Comentario", "Fk_Tipo") FROM stdin;
    public          postgres    false    223   �       �          0    16417    Persona 
   TABLE DATA           c   COPY public."Persona" ("Id", "Nombre", "Apellido", "FechaNac", "DocIdentidad", "Sexo") FROM stdin;
    public          postgres    false    214   0�       �          0    16401    Rol 
   TABLE DATA           >   COPY public."Rol" ("Id", "Nombre", "Descripcion") FROM stdin;
    public          postgres    false    210   ��       �          0    16410    Sesion 
   TABLE DATA           R   COPY public."Sesion" ("Id", "HoraInicio", "IpConexion", "Fk_Usuario") FROM stdin;
    public          postgres    false    212   t�       �          0    16507    Tipo 
   TABLE DATA           ?   COPY public."Tipo" ("Id", "Nombre", "Descripcion") FROM stdin;
    public          postgres    false    220   R�       �          0    16426    Usuario 
   TABLE DATA           |   COPY public."Usuario" ("Id", "Email", "Clave", "FechaCreacion", "Fk_Rol", "Fk_Persona", "Estado", "Fk_Empresa") FROM stdin;
    public          postgres    false    216   }�       �          0    16498    Virus 
   TABLE DATA           Q   COPY public."Virus" ("Id", "Nombre", "FechaCreacion", "Descripcion") FROM stdin;
    public          postgres    false    218   w�       �          0    16636 
   auth_group 
   TABLE DATA           .   COPY public.auth_group (id, name) FROM stdin;
    public          postgres    false    231   ��       �          0    16645    auth_group_permissions 
   TABLE DATA           M   COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
    public          postgres    false    233   ��       �          0    16629    auth_permission 
   TABLE DATA           N   COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
    public          postgres    false    229   ��       �          0    16652 	   auth_user 
   TABLE DATA           �   COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
    public          postgres    false    235   ~�       �          0    16661    auth_user_groups 
   TABLE DATA           A   COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
    public          postgres    false    237   9�       �          0    16668    auth_user_user_permissions 
   TABLE DATA           P   COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
    public          postgres    false    239   V�       �          0    16727    django_admin_log 
   TABLE DATA           �   COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
    public          postgres    false    241   s�       �          0    16620    django_content_type 
   TABLE DATA           C   COPY public.django_content_type (id, app_label, model) FROM stdin;
    public          postgres    false    227   ��       �          0    16611    django_migrations 
   TABLE DATA           C   COPY public.django_migrations (id, app, name, applied) FROM stdin;
    public          postgres    false    225   q�       �          0    16763    django_session 
   TABLE DATA           P   COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
    public          postgres    false    242   ��       �          0    16774 
   myapp_tipo 
   TABLE DATA           A   COPY public.myapp_tipo (id, "Nombre", "Descripcion") FROM stdin;
    public          postgres    false    244   ��       �           0    0    Empresa_Id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Empresa_Id_seq"', 3, true);
          public          postgres    false    246            �           0    0    Flag_Fk_Tipo_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public."Flag_Fk_Tipo_seq"', 1, false);
          public          postgres    false    222            �           0    0    Flag_Id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public."Flag_Id_seq"', 1, false);
          public          postgres    false    221            �           0    0    Persona_Id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Persona_Id_seq"', 20, true);
          public          postgres    false    211            �           0    0    Persona_Id_seq1    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Persona_Id_seq1"', 7, true);
          public          postgres    false    213            �           0    0 
   Rol_Id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public."Rol_Id_seq"', 3, true);
          public          postgres    false    209            �           0    0    Tipo_Id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public."Tipo_Id_seq"', 1, true);
          public          postgres    false    219            �           0    0    Usuario_Id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Usuario_Id_seq"', 6, true);
          public          postgres    false    215            �           0    0    Virus_Id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public."Virus_Id_seq"', 1, false);
          public          postgres    false    217            �           0    0    auth_group_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);
          public          postgres    false    230            �           0    0    auth_group_permissions_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);
          public          postgres    false    232            �           0    0    auth_permission_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.auth_permission_id_seq', 96, true);
          public          postgres    false    228            �           0    0    auth_user_groups_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);
          public          postgres    false    236            �           0    0    auth_user_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);
          public          postgres    false    234            �           0    0 !   auth_user_user_permissions_id_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);
          public          postgres    false    238            �           0    0    django_admin_log_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);
          public          postgres    false    240            �           0    0    django_content_type_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.django_content_type_id_seq', 24, true);
          public          postgres    false    226            �           0    0    django_migrations_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.django_migrations_id_seq', 23, true);
          public          postgres    false    224            �           0    0    myapp_tipo_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.myapp_tipo_id_seq', 1, false);
          public          postgres    false    243                       2606    41364    Empresa Empresa_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Empresa"
    ADD CONSTRAINT "Empresa_pkey" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Empresa" DROP CONSTRAINT "Empresa_pkey";
       public            postgres    false    245            �           2606    16525    Flag Flag_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public."Flag"
    ADD CONSTRAINT "Flag_pkey" PRIMARY KEY ("Id");
 <   ALTER TABLE ONLY public."Flag" DROP CONSTRAINT "Flag_pkey";
       public            postgres    false    223            �           2606    16424    Persona Persona_pkey1 
   CONSTRAINT     Y   ALTER TABLE ONLY public."Persona"
    ADD CONSTRAINT "Persona_pkey1" PRIMARY KEY ("Id");
 C   ALTER TABLE ONLY public."Persona" DROP CONSTRAINT "Persona_pkey1";
       public            postgres    false    214            �           2606    16406    Rol Rol_pkey 
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
       public            postgres    false    220            �           2606    16433    Usuario Usuario_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Usuario_pkey" PRIMARY KEY ("Id");
 B   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Usuario_pkey";
       public            postgres    false    216            �           2606    16505    Virus Virus_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public."Virus"
    ADD CONSTRAINT "Virus_pkey" PRIMARY KEY ("Id");
 >   ALTER TABLE ONLY public."Virus" DROP CONSTRAINT "Virus_pkey";
       public            postgres    false    218            �           2606    16754    auth_group auth_group_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);
 H   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
       public            postgres    false    231            �           2606    16684 R   auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);
 |   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
       public            postgres    false    233    233            �           2606    16650 2   auth_group_permissions auth_group_permissions_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
       public            postgres    false    233            �           2606    16641    auth_group auth_group_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
       public            postgres    false    231            �           2606    16675 F   auth_permission auth_permission_content_type_id_codename_01ab375a_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);
 p   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq;
       public            postgres    false    229    229            �           2606    16634 $   auth_permission auth_permission_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
       public            postgres    false    229            �           2606    16666 &   auth_user_groups auth_user_groups_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_pkey;
       public            postgres    false    237            �           2606    16699 @   auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);
 j   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq;
       public            postgres    false    237    237            �           2606    16657    auth_user auth_user_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_pkey;
       public            postgres    false    235            �           2606    16673 :   auth_user_user_permissions auth_user_user_permissions_pkey 
   CONSTRAINT     x   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);
 d   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_pkey;
       public            postgres    false    239                       2606    16713 Y   auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
       public            postgres    false    239    239            �           2606    16749     auth_user auth_user_username_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);
 J   ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_username_key;
       public            postgres    false    235                       2606    16735 &   django_admin_log django_admin_log_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
       public            postgres    false    241            �           2606    16627 E   django_content_type django_content_type_app_label_model_76bd3d3b_uniq 
   CONSTRAINT     �   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);
 o   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
       public            postgres    false    227    227            �           2606    16625 ,   django_content_type django_content_type_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
       public            postgres    false    227            �           2606    16618 (   django_migrations django_migrations_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
       public            postgres    false    225            	           2606    16769 "   django_session django_session_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);
 L   ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
       public            postgres    false    242                       2606    16779    myapp_tipo myapp_tipo_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.myapp_tipo
    ADD CONSTRAINT myapp_tipo_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.myapp_tipo DROP CONSTRAINT myapp_tipo_pkey;
       public            postgres    false    244            �           1259    16755    auth_group_name_a6ea08ec_like    INDEX     h   CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);
 1   DROP INDEX public.auth_group_name_a6ea08ec_like;
       public            postgres    false    231            �           1259    16695 (   auth_group_permissions_group_id_b120cbf9    INDEX     o   CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);
 <   DROP INDEX public.auth_group_permissions_group_id_b120cbf9;
       public            postgres    false    233            �           1259    16696 -   auth_group_permissions_permission_id_84c5c92e    INDEX     y   CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);
 A   DROP INDEX public.auth_group_permissions_permission_id_84c5c92e;
       public            postgres    false    233            �           1259    16681 (   auth_permission_content_type_id_2f476e4b    INDEX     o   CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);
 <   DROP INDEX public.auth_permission_content_type_id_2f476e4b;
       public            postgres    false    229            �           1259    16711 "   auth_user_groups_group_id_97559544    INDEX     c   CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);
 6   DROP INDEX public.auth_user_groups_group_id_97559544;
       public            postgres    false    237            �           1259    16710 !   auth_user_groups_user_id_6a12ed8b    INDEX     a   CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);
 5   DROP INDEX public.auth_user_groups_user_id_6a12ed8b;
       public            postgres    false    237            �           1259    16725 1   auth_user_user_permissions_permission_id_1fbb5f2c    INDEX     �   CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);
 E   DROP INDEX public.auth_user_user_permissions_permission_id_1fbb5f2c;
       public            postgres    false    239                        1259    16724 +   auth_user_user_permissions_user_id_a95ead1b    INDEX     u   CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);
 ?   DROP INDEX public.auth_user_user_permissions_user_id_a95ead1b;
       public            postgres    false    239            �           1259    16750     auth_user_username_6821ab7c_like    INDEX     n   CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);
 4   DROP INDEX public.auth_user_username_6821ab7c_like;
       public            postgres    false    235                       1259    16746 )   django_admin_log_content_type_id_c4bce8eb    INDEX     q   CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);
 =   DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
       public            postgres    false    241                       1259    16747 !   django_admin_log_user_id_c564eba6    INDEX     a   CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);
 5   DROP INDEX public.django_admin_log_user_id_c564eba6;
       public            postgres    false    241                       1259    16771 #   django_session_expire_date_a5c62663    INDEX     e   CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);
 7   DROP INDEX public.django_session_expire_date_a5c62663;
       public            postgres    false    242            
           1259    16770 (   django_session_session_key_c0390e0f_like    INDEX     ~   CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);
 <   DROP INDEX public.django_session_session_key_c0390e0f_like;
       public            postgres    false    242                       2606    41371    Usuario Empresa    FK CONSTRAINT     �   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Empresa" FOREIGN KEY ("Fk_Empresa") REFERENCES public."Empresa"("Id") NOT VALID;
 =   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Empresa";
       public          postgres    false    216    3342    245                       2606    16781    Sesion Fk_Usuario    FK CONSTRAINT     �   ALTER TABLE ONLY public."Sesion"
    ADD CONSTRAINT "Fk_Usuario" FOREIGN KEY ("Fk_Usuario") REFERENCES public."Usuario"("Id") NOT VALID;
 ?   ALTER TABLE ONLY public."Sesion" DROP CONSTRAINT "Fk_Usuario";
       public          postgres    false    216    212    3285                       2606    16439    Usuario Persona    FK CONSTRAINT     �   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Persona" FOREIGN KEY ("Fk_Persona") REFERENCES public."Persona"("Id") NOT VALID;
 =   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Persona";
       public          postgres    false    3283    216    214                       2606    16434    Usuario Rol    FK CONSTRAINT     {   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Rol" FOREIGN KEY ("Fk_Rol") REFERENCES public."Rol"("Id") NOT VALID;
 9   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Rol";
       public          postgres    false    210    216    3279                       2606    16526 	   Flag Tipo    FK CONSTRAINT     q   ALTER TABLE ONLY public."Flag"
    ADD CONSTRAINT "Tipo" FOREIGN KEY ("Fk_Tipo") REFERENCES public."Tipo"("Id");
 7   ALTER TABLE ONLY public."Flag" DROP CONSTRAINT "Tipo";
       public          postgres    false    220    223    3289                       2606    16690 O   auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 y   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
       public          postgres    false    3302    233    229                       2606    16685 P   auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 z   ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
       public          postgres    false    231    3307    233                       2606    16676 E   auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 o   ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
       public          postgres    false    3297    229    227                       2606    16705 D   auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;
 n   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id;
       public          postgres    false    237    3307    231                       2606    16700 B   auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
       public          postgres    false    235    3315    237                       2606    16719 S   auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;
 }   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
       public          postgres    false    229    239    3302                       2606    16714 V   auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 �   ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
       public          postgres    false    235    3315    239                       2606    16736 G   django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;
 q   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
       public          postgres    false    241    3297    227                       2606    16741 B   django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;
 l   ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id;
       public          postgres    false    241    235    3315            �   +   x�3�qw��2�uvt�2���KI-H�K�L�+I����� �I�      �      x������ � �      �   �   x�M�1
�0�Y>E/�")�L�@�Аt1��Ydp�CO_�]�� ���
kn�V�i�ų �q��j?Ο�.�O�'6ܫ����������4ͺ�=��*!��\�{})�j9����=�ι/0�&w      �   �   x�=�K�0��)|�
	87@�ؘ�T������iף7�S���â6\���B�3YeWz��N�`"_XH���8 x��6i:��MxG�#���5O&�
O�=�*���p�q}u���LE>��N�F�7`���>($��UL�]J���V)      �   �   x�m�ˑ�@г�0E��8�8�����^!�i��E��[�����|�k�"@iم[O�_j�+��P�4�J?�qX���qP��LT:+���U���K�����˨r�[��ӎ�Icv�]�N�Wc����n��V��6��R�%�����~Z�����1��A����a��r2i��U��e�y_�ӎ`��f�p���mN��}�d��      �      x�3�,(*MMJ�R)���\1z\\\ lz�      �   �   x����m1�3�
70II���o#�K�>����?~�Ŏv�/����2ΠER�r���B�-���kkj�$�R��z�9�)u�l�{�D
��3�Lq��y.0܀'�~��������7��3��d�n�#��h�?z-�`����q}�	�3�Wm���s��m��v��$�wMI�Eq�.)���c�Ԭ;�J�����!�ڵ��O3�H�A�i�����8~�      �      x������ � �      �      x������ � �      �      x������ � �      �   �  x�u�ݎ� ���S�T����kT����u��Q�l�o_�p��^�����0���p{N���|~o��Wa�����.����c��G�\S+O�e|2�"X�9���"�g��q��e�oE)�b�i���������E"�#p�����_����l���~���EOQ;��ъąvW��kE-�Gck�_{uz48�:��8�v�Ԯ�3�Ϸ��W{{~�Ǣڴ�ۣ�VC��W«?��C���b�X\/����bX�LI��0������A�GH\$V�s��E'v�GSRyk�q մj�P��-���X���������[����ʘ@�,�3��
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