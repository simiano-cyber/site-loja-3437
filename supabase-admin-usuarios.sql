create extension if not exists "pgcrypto";

create table if not exists public.admin_usuarios (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references auth.users(id) on delete cascade,
  email text not null unique,
  nome text,
  status text not null default 'pendente' check (status in ('pendente', 'aprovado', 'bloqueado')),
  perfil text not null default 'consulta' check (perfil in ('admin', 'secretaria', 'tesouraria', 'consulta')),
  approved_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.admin_usuarios enable row level security;

create or replace function public.is_admin_aprovado()
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1
    from public.admin_usuarios
    where user_id = auth.uid()
      and status = 'aprovado'
      and perfil = 'admin'
  );
$$;

create or replace function public.is_usuario_admin_aprovado()
returns boolean
language sql
security definer
set search_path = public
stable
as $$
  select exists (
    select 1
    from public.admin_usuarios
    where user_id = auth.uid()
      and status = 'aprovado'
  );
$$;

grant execute on function public.is_admin_aprovado() to authenticated;
grant execute on function public.is_usuario_admin_aprovado() to authenticated;

drop policy if exists "Usuarios veem acessos permitidos" on public.admin_usuarios;
drop policy if exists "Usuarios solicitam proprio acesso" on public.admin_usuarios;
drop policy if exists "Admins gerenciam acessos" on public.admin_usuarios;

create policy "Usuarios veem acessos permitidos"
on public.admin_usuarios
for select
to authenticated
using (auth.uid() = user_id or public.is_admin_aprovado());

create policy "Usuarios solicitam proprio acesso"
on public.admin_usuarios
for insert
to authenticated
with check (
  auth.uid() = user_id
  and status = 'pendente'
  and perfil = 'consulta'
);

create policy "Admins gerenciam acessos"
on public.admin_usuarios
for update
to authenticated
using (public.is_admin_aprovado())
with check (public.is_admin_aprovado());

drop policy if exists "Usuarios autenticados gerenciam obreiros" on public.obreiros;
drop policy if exists "Usuarios autenticados gerenciam reunioes" on public.reunioes;
drop policy if exists "Usuarios autenticados leem confirmacoes" on public.confirmacoes_presenca;
drop policy if exists "Usuarios autenticados gerenciam datas" on public.datas_importantes;
drop policy if exists "Usuarios autenticados gerenciam atas" on public.atas;
drop policy if exists "Usuarios autenticados gerenciam pagamentos" on public.pagamentos;
drop policy if exists "Usuarios autenticados gerenciam galeria" on public.galeria;

drop policy if exists "Administradores aprovados gerenciam obreiros" on public.obreiros;
drop policy if exists "Administradores aprovados gerenciam reunioes" on public.reunioes;
drop policy if exists "Administradores aprovados leem confirmacoes" on public.confirmacoes_presenca;
drop policy if exists "Administradores aprovados gerenciam datas" on public.datas_importantes;
drop policy if exists "Administradores aprovados gerenciam atas" on public.atas;
drop policy if exists "Administradores aprovados gerenciam pagamentos" on public.pagamentos;
drop policy if exists "Administradores aprovados gerenciam galeria" on public.galeria;

create policy "Administradores aprovados gerenciam obreiros"
on public.obreiros
for all
to authenticated
using (public.is_usuario_admin_aprovado())
with check (public.is_usuario_admin_aprovado());

create policy "Administradores aprovados gerenciam reunioes"
on public.reunioes
for all
to authenticated
using (public.is_usuario_admin_aprovado())
with check (public.is_usuario_admin_aprovado());

create policy "Administradores aprovados leem confirmacoes"
on public.confirmacoes_presenca
for select
to authenticated
using (public.is_usuario_admin_aprovado());

create policy "Administradores aprovados gerenciam datas"
on public.datas_importantes
for all
to authenticated
using (public.is_usuario_admin_aprovado())
with check (public.is_usuario_admin_aprovado());

create policy "Administradores aprovados gerenciam atas"
on public.atas
for all
to authenticated
using (public.is_usuario_admin_aprovado())
with check (public.is_usuario_admin_aprovado());

create policy "Administradores aprovados gerenciam pagamentos"
on public.pagamentos
for all
to authenticated
using (public.is_usuario_admin_aprovado())
with check (public.is_usuario_admin_aprovado());

create policy "Administradores aprovados gerenciam galeria"
on public.galeria
for all
to authenticated
using (public.is_usuario_admin_aprovado())
with check (public.is_usuario_admin_aprovado());

-- Primeiro administrador:
-- 1. Troque o e-mail abaixo pelo e-mail do usuario criado em Authentication > Users.
-- 2. Execute este bloco uma vez no SQL Editor.
insert into public.admin_usuarios (user_id, email, nome, status, perfil, approved_at)
select
  id,
  email,
  coalesce(raw_user_meta_data->>'name', split_part(email, '@', 1)),
  'aprovado',
  'admin',
  now()
from auth.users
where email = 'simiano9@gmail.com'
on conflict (user_id) do update
set
  status = 'aprovado',
  perfil = 'admin',
  approved_at = coalesce(public.admin_usuarios.approved_at, now()),
  updated_at = now();
