--drop function if exists public.fn_list_bad_regs(bigint)

create or replace function public.fn_list_bad_regs(id_analisis bigint)
returns table ( registro varchar(100),tipo int,porcentaje double precision) 
language plpgsql
as $$
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
end;$$ 




