--drop function if exists public.fn_count_regs(bigint)

create or replace function public.fn_count_regs(id_analisis bigint)
returns table ( no_deseados bigint,prob_no_deseados bigint) 
language plpgsql
as $$
begin
return query
select 
(SELECT count(reg.*) as no_deseados
	FROM public."Analisis" analisis 
	JOIN "Registro" reg on analisis."Id" = reg."Fk_Analisis"
	JOIN "Tipo" tp on reg."Fk_Tipo" = tp."Id"
where tp."Nombre" = 'No Deseado' and analisis."Id" = id_analisis ) as no_deseados,
(SELECT count(reg.*) as prob_no_deseados
	FROM public."Analisis" analisis 
	JOIN "Registro" reg on analisis."Id" = reg."Fk_Analisis"
	JOIN "Tipo" tp on reg."Fk_Tipo" = tp."Id"
where tp."Nombre" = 'Prob No Deseado' and analisis."Id" = id_analisis) as prob_no_deseados
;
end;$$ 




