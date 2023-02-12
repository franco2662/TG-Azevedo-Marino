--drop function if exists public.fn_list_bad_dirs(bigint)

create or replace function public.fn_list_bad_dirs(id_analisis bigint)
returns table ( directorio varchar(100),tipo int,porcentaje double precision) 
language plpgsql
as $$
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
end;$$ 




