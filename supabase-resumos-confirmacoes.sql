drop function if exists public.get_reuniao_resumos();

create function public.get_reuniao_resumos()
returns table (
  reuniao_id uuid,
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
    reunioes.id as reuniao_id,
    reunioes.data as evento_data,
    count(confirmacoes_presenca.id)::bigint as total,
    count(confirmacoes_presenca.id) filter (
      where replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%A∴M∴%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%AM%'
    )::bigint as aprendizes,
    count(confirmacoes_presenca.id) filter (
      where replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%Comp∴%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%COMP%'
    )::bigint as companheiros,
    count(confirmacoes_presenca.id) filter (
      where replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%M∴M∴%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%M∴I∴%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%V∴M∴%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%MM%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%MI%'
         or replace(coalesce(confirmacoes_presenca.titulo, ''), ' ', '') ilike '%VM%'
    )::bigint as mestres
  from public.reunioes
  left join public.confirmacoes_presenca
    on confirmacoes_presenca.reuniao_id = reunioes.id
    or (
      confirmacoes_presenca.reuniao_id is null
      and confirmacoes_presenca.evento_data = reunioes.data
    )
  group by reunioes.id, reunioes.data;
$$;

grant execute on function public.get_reuniao_resumos() to anon;
grant execute on function public.get_reuniao_resumos() to authenticated;
