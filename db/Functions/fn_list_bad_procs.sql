--drop function if exists public.fn_list_bad_procs(bigint)

create or replace function public.fn_list_bad_procs(id_analisis bigint)
returns table ( proceso varchar(100),tipo int,porcentaje double precision) 
language plpgsql
as $$
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
end;$$ 




