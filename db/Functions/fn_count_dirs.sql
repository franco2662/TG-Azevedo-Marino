--drop function if exists public.fn_count_dirs(bigint)

create or replace function public.fn_count_dirs(id_analisis bigint)
returns table ( no_deseados bigint,prob_no_deseados bigint) 
language plpgsql
as $$
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
end;$$ 




