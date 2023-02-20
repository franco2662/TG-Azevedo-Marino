--drop function if exists public.fn_count_procs(bigint)

create or replace function public.fn_count_procs(id_analisis bigint)
returns table ( no_deseados bigint,prob_no_deseados bigint) 
language plpgsql
as $$
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
end;$$ 




