-- View: public.vw_user_list

-- DROP VIEW public.vw_user_list;

CREATE OR REPLACE VIEW public.vw_user_list
 AS
  SELECT us."Id" AS id,
    (per."Nombre"::text || ' '::text) || per."Apellido"::text AS nombre_completo,
    us."Email" AS email,
    per."DocIdentidad" AS doc_identidad,
    "Rol"."Nombre" AS rol,
    "Empresa"."Nombre" AS empresa,
    us."Estado" AS estado
   FROM "Usuario" us
     JOIN "Persona" per ON us."Fk_Persona" = per."Id"
     JOIN "Rol" ON "Rol"."Id" = us."Fk_Rol"
     JOIN "Empresa" ON "Empresa"."Id" = us."Fk_Empresa"
  ORDER BY us."Id";

ALTER TABLE public.vw_user_list
    OWNER TO postgres;

