create or replace function public.get_reuniao_resumos()
returns table (
  evento_data date,
  total bigint,
  aprendizes bigint,
  companheiros bigint,
  mestres bigint
)
language sql
security definer
set search_path = public
as $$
  select
    confirmacoes_presenca.evento_data,
    count(*)::bigint as total,
    count(*) filter (
      where replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%A∴M∴%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%AM%'
    )::bigint as aprendizes,
    count(*) filter (
      where replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%Comp∴%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%COMP%'
    )::bigint as companheiros,
    count(*) filter (
      where replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%M∴M∴%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%M∴I∴%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%V∴M∴%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%MM%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%MI%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%VM%'
    )::bigint as mestres
  from public.confirmacoes_presenca
  where confirmacoes_presenca.evento_data is not null
  group by confirmacoes_presenca.evento_data;
$$;

grant execute on function public.get_reuniao_resumos() to anon;
grant execute on function public.get_reuniao_resumos() to authenticated;
