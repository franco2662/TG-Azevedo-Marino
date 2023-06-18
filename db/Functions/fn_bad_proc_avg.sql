--drop function if exists public.fn_bad_proc_avg(varchar(100))

create or replace function public.fn_bad_proc_avg(name_proceso varchar(100))
returns table (proceso varchar(100),cantidad bigint, promedio double precision) 
language plpgsql
as $$
begin
return query
select name_proceso as proceso,coalesce(count(distinct se."Fk_Usuario"),0) cantidad,coalesce(avg(proc."Porcentaje_No"),0) promedio
from "Proceso" proc join "Analisis" ON "Analisis"."Id" = proc."Fk_Analisis"
join "Sesion" se ON se."Id" = "Analisis"."Fk_Sesion"
join "Tipo" ON "Tipo"."Id" = proc."Fk_Tipo"
where proc."Description" like '%'||name_proceso||'%' and "Tipo"."Id" in (2,3)
;
end;$$ 