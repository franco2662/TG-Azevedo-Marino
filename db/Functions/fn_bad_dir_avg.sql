--drop function if exists public.fn_bad_dir_avg(varchar)

create or replace function public.fn_bad_dir_avg(name_directorio varchar)
returns table (directorio varchar,cantidad bigint, promedio double precision) 
language plpgsql
as $$
begin
return query
select name_directorio as directorio,coalesce(count(distinct se."Fk_Usuario"),0) cantidad,coalesce(avg(dir."Porcentaje_No"),0) promedio
from "Directorio" dir join "Analisis" ON "Analisis"."Id" = dir."Fk_Analisis"
join "Sesion" se ON se."Id" = "Analisis"."Fk_Sesion"
join "Tipo" ON "Tipo"."Id" = dir."Fk_Tipo"
where dir."Nombre" = name_directorio and "Tipo"."Id" in (2,3)
;
end;$$ 