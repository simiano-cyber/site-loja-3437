create extension if not exists "pgcrypto";

create table if not exists public.obreiros (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  telefone text,
  email text,
  data_nascimento date,
  data_iniciacao date,
  grau text,
  cargo text,
  status text not null default 'ativo',
  foto_url text,
  observacoes text,
  created_at timestamptz not null default now()
);

create table if not exists public.reunioes (
  id uuid primary key default gen_random_uuid(),
  data date not null,
  titulo text not null,
  descricao text,
  status text not null default 'programada',
  fotos text[] not null default '{}',
  created_at timestamptz not null default now()
);

create table if not exists public.confirmacoes_presenca (
  id uuid primary key default gen_random_uuid(),
  reuniao_id uuid references public.reunioes(id) on delete set null,
  evento_data date,
  evento_titulo text,
  evento_label text,
  potencia text,
  titulo text,
  nome text not null,
  nome_completo text,
  numero_loja text,
  nome_loja text,
  telefone text,
  created_at timestamptz not null default now()
);

create table if not exists public.datas_importantes (
  id uuid primary key default gen_random_uuid(),
  titulo text not null,
  tipo text not null default 'aniversario',
  data date not null,
  recorrente boolean not null default true,
  obreiro_id uuid references public.obreiros(id) on delete set null,
  observacoes text,
  created_at timestamptz not null default now()
);

create table if not exists public.atas (
  id uuid primary key default gen_random_uuid(),
  data date not null,
  tipo_reuniao text,
  titulo text not null,
  presentes text,
  pauta text,
  texto_ata text,
  status text not null default 'rascunho',
  created_at timestamptz not null default now()
);

create table if not exists public.pagamentos (
  id uuid primary key default gen_random_uuid(),
  obreiro_id uuid references public.obreiros(id) on delete set null,
  nome text not null,
  referencia_mes integer not null check (referencia_mes between 1 and 12),
  referencia_ano integer not null check (referencia_ano between 2000 and 2100),
  valor numeric(12,2) not null default 0,
  status text not null default 'pendente',
  data_pagamento date,
  forma_pagamento text,
  observacoes text,
  created_at timestamptz not null default now()
);

create table if not exists public.galeria (
  id uuid primary key default gen_random_uuid(),
  tipo text not null default 'obreiro',
  nome text not null,
  cargo text,
  periodo text,
  foto_url text,
  biografia text,
  ordem integer not null default 0,
  ativo boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.obreiros enable row level security;
alter table public.reunioes enable row level security;
alter table public.confirmacoes_presenca enable row level security;
alter table public.datas_importantes enable row level security;
alter table public.atas enable row level security;
alter table public.pagamentos enable row level security;
alter table public.galeria enable row level security;

create policy "Agenda publica para leitura"
on public.reunioes for select
using (true);

create policy "Galeria publica ativa"
on public.galeria for select
using (ativo = true);

create policy "Confirmacao publica"
on public.confirmacoes_presenca for insert
with check (true);

create policy "Usuarios autenticados gerenciam obreiros"
on public.obreiros for all
to authenticated
using (true)
with check (true);

create policy "Usuarios autenticados gerenciam reunioes"
on public.reunioes for all
to authenticated
using (true)
with check (true);

create policy "Usuarios autenticados leem confirmacoes"
on public.confirmacoes_presenca for select
to authenticated
using (true);

create policy "Usuarios autenticados gerenciam datas"
on public.datas_importantes for all
to authenticated
using (true)
with check (true);

create policy "Usuarios autenticados gerenciam atas"
on public.atas for all
to authenticated
using (true)
with check (true);

create policy "Usuarios autenticados gerenciam pagamentos"
on public.pagamentos for all
to authenticated
using (true)
with check (true);

create policy "Usuarios autenticados gerenciam galeria"
on public.galeria for all
to authenticated
using (true)
with check (true);
