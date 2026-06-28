alter table public.confirmacoes_presenca enable row level security;

grant usage on schema public to anon, authenticated;
grant select on public.reunioes to anon, authenticated;
grant insert on public.confirmacoes_presenca to anon, authenticated;

do $$
begin
  if not exists (
    select 1
    from pg_policies
    where schemaname = 'public'
      and tablename = 'confirmacoes_presenca'
      and policyname = 'Confirmacao publica'
  ) then
    create policy "Confirmacao publica"
    on public.confirmacoes_presenca
    for insert
    to anon, authenticated
    with check (true);
  end if;
end
$$;
