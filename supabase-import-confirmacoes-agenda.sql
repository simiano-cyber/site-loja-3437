-- Importacao gerada a partir de Confirmacao Presenca Loja 3437.xlsx

-- Execute no Supabase SQL Editor depois de criar o schema principal.

begin;

insert into public.reunioes (data, titulo, descricao, status, fotos)
select '2026-05-30', 'Sess∴ no Gr∴ de Apr∴', 'Sessão ordinária de Aprendiz, com confirmação aberta para os irmãos.', coalesce('realizada', 'programada'), '{"https://drive.google.com/file/d/1kD2un9bkZzHke024NZSleEyAaS_kILIs/view?usp=sharing"}'::text[]
where not exists (
  select 1 from public.reunioes
  where data = '2026-05-30'::date and titulo = 'Sess∴ no Gr∴ de Apr∴'
);

insert into public.reunioes (data, titulo, descricao, status, fotos)
select '2026-06-06', 'Sess∴ Mag∴ de Inst∴ e Poss∴', 'Irmão José Solon', coalesce('realizada', 'programada'), '{"https://drive.google.com/file/d/1ynSFvDoX76wpycKWxagZVWYeufpyPP4-/view?usp=sharing"}'::text[]
where not exists (
  select 1 from public.reunioes
  where data = '2026-06-06'::date and titulo = 'Sess∴ Mag∴ de Inst∴ e Poss∴'
);

insert into public.reunioes (data, titulo, descricao, status, fotos)
select '2026-06-27', 'Sess∴ no Gr∴ de Apr∴', 'Sessão ordinária de Aprendiz, com confirmação aberta para os Ir∴', coalesce('programada', 'programada'), '{}'::text[]
where not exists (
  select 1 from public.reunioes
  where data = '2026-06-27'::date and titulo = 'Sess∴ no Gr∴ de Apr∴'
);

insert into public.reunioes (data, titulo, descricao, status, fotos)
select '2026-07-11', 'Sess∴ no Gr∴ de Apr∴', 'Apresentação de trabalhos', coalesce('programada', 'programada'), '{}'::text[]
where not exists (
  select 1 from public.reunioes
  where data = '2026-07-11'::date and titulo = 'Sess∴ no Gr∴ de Apr∴'
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sess∴ no Gr∴ de Apr∴',
  null,
  'GLESP',
  'A∴M∴',
  'Danilo Alves',
  'A∴M∴ Danilo Alves',
  '32',
  'A∴ R∴ G∴ BEN∴ G∴ BENF∴ L∴ S∴ Marechal Neiva n 32',
  '(11) 9.6664-4310',
  '2026-05-17T11:01:51.051000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Danilo Alves', '')
    and coalesce(telefone, '') = coalesce('(11) 9.6664-4310', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sess∴ no Gr∴ de Apr∴',
  null,
  'GOB',
  'V∴M∴',
  'Amorim',
  'V∴M∴ Alexxandre Amorim',
  '3437',
  'Tradição e Progresso 3437',
  '(11) 9.9416-7331',
  '2026-05-26T10:37:54.459000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('V∴M∴ Alexxandre Amorim', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9416-7331', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sess∴ no Gr∴ de Apr∴',
  null,
  'GOB',
  'A∴M∴',
  'Ronaldo de Sousa Marques',
  'A∴M∴ Ronaldo de Sousa Marques',
  '3437',
  'Tradição e Progresso 3437',
  '(11) 9.9914-0758',
  '2026-05-26T10:55:38.574000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Ronaldo de Sousa Marques', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9914-0758', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sess∴ no Gr∴ de Apr∴',
  null,
  'GLESP',
  'M∴M∴',
  'Fernando José da Silva Filho',
  'M∴M∴ Fernando José da Silva Filho',
  '160',
  'Acácia de Guarulhos 160',
  '(11) 9.7422-1482',
  '2026-05-26T11:13:53.792000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ Fernando José da Silva Filho', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7422-1482', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sess∴ no Gr∴ de Apr∴',
  null,
  'GOB',
  'A∴M∴',
  'Sandro Elias de Carvalho Fernandes',
  'A∴M∴ Sandro Elias de Carvalho Fernandes',
  '3437',
  'Tradição e Progresso 3437',
  '(11) 9.4732-6145',
  '2026-05-26T11:18:10.211000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Sandro Elias de Carvalho Fernandes', '')
    and coalesce(telefone, '') = coalesce('(11) 9.4732-6145', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sess∴ no Gr∴ de Apr∴',
  null,
  'GOB',
  'A∴M∴',
  'Favarão',
  'A∴M∴ Sergio Favarão',
  '3437',
  'Tradição e Progresso 3437',
  '(11) 9.5231-6440',
  '2026-05-26T11:27:40.328000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Sergio Favarão', '')
    and coalesce(telefone, '') = coalesce('(11) 9.5231-6440', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sess∴ no Gr∴ de Apr∴',
  null,
  'GOB',
  'A∴M∴',
  'André luis de Sousa Marques',
  'A∴M∴ André luis de Sousa Marques',
  '3437',
  'Tradição e Progresso 3437',
  '(11) 9.4721-2723',
  '2026-05-26T12:50:50.590000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ André luis de Sousa Marques', '')
    and coalesce(telefone, '') = coalesce('(11) 9.4721-2723', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sess∴ no Gr∴ de Apr∴',
  null,
  'GOB',
  'M∴M∴',
  'Carlos Alberto Cavalcante Silva',
  'M∴M∴ Carlos Alberto Cavalcante Silva',
  '2642',
  'Lautaro',
  '(11) 9.8199-2340',
  '2026-05-26T15:25:59.161000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ Carlos Alberto Cavalcante Silva', '')
    and coalesce(telefone, '') = coalesce('(11) 9.8199-2340', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sess∴ no Gr∴ de Apr∴',
  null,
  'GLESP',
  'M∴M∴',
  'MILTON L  M PENALBER',
  'M∴M∴ MILTON L  M PENALBER',
  '850',
  'FRATERNIDADE ESTRELA FLAMIGERA',
  '(11) 119.7419-2640',
  '2026-05-26T15:50:07.224000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ MILTON L  M PENALBER', '')
    and coalesce(telefone, '') = coalesce('(11) 119.7419-2640', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sess∴ no Gr∴ de Apr∴',
  null,
  'GLESP',
  'A∴M∴',
  'Carlos Eduardo Trindade Nunes Villela',
  'A∴M∴ Carlos Eduardo Trindade Nunes Villela',
  '498',
  'Tijucussú',
  '(11) 9.9933-8856',
  '2026-05-26T16:01:16.604000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Carlos Eduardo Trindade Nunes Villela', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9933-8856', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GOB',
  'A∴M∴',
  'Thiago José Simiano Ribeiro',
  'A∴M∴ Thiago José Simiano Ribeiro',
  '3437',
  'Tradição e Progresso 3437',
  '(11) 9.9693-0689',
  '2026-05-15T10:22:13.060000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Thiago José Simiano Ribeiro', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9693-0689', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GOB',
  'M∴I∴',
  'SILVA',
  'M∴I∴ CELSO SILVA',
  null,
  null,
  '(11) 9.9106-5464',
  '2026-05-15T13:00:19.713000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ CELSO SILVA', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9106-5464', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'M∴I∴',
  'Eduardo Mizael Prado',
  'M∴I∴ Eduardo Mizael Prado',
  null,
  'ARLS Tales de Mileto 570',
  '(11) 9.4748-7964',
  '2026-05-15T13:03:33.007000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Eduardo Mizael Prado', '')
    and coalesce(telefone, '') = coalesce('(11) 9.4748-7964', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GOB',
  'M∴I∴',
  'Helson Willian Shikasho',
  'M∴I∴ Helson Willian Shikasho',
  null,
  'Cavaleiros da luz de Guarulhos 2686',
  '(11) 9.7437-7727',
  '2026-05-15T13:05:14.559000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Helson Willian Shikasho', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7437-7727', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'M∴I∴',
  'Alex Sandro Lima de Souza',
  'M∴I∴ Alex Sandro Lima de Souza',
  null,
  'Propaganda Terceira 779',
  '(11) 9.9831-5970',
  '2026-05-15T13:35:01.828000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Alex Sandro Lima de Souza', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9831-5970', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GOB',
  'Comp∴',
  'RODRIGO FREIRE DOS SANTOS',
  'Comp∴ RODRIGO FREIRE DOS SANTOS',
  '2804',
  'Loja nº 2804 - Luz do Universo',
  '(11) 9.4715-1737',
  '2026-05-15T13:37:33.816000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('Comp∴ RODRIGO FREIRE DOS SANTOS', '')
    and coalesce(telefone, '') = coalesce('(11) 9.4715-1737', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'M∴I∴',
  'Pedro Alexandre de Francischi',
  'M∴I∴ Pedro Alexandre de Francischi',
  '701',
  'Luiz Gonzaga do Nascimento, 701',
  '(11) 9.9537-4575',
  '2026-05-15T14:30:27.268000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Pedro Alexandre de Francischi', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9537-4575', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GOB',
  'Comp∴',
  'Cícero Tenório de Araújo',
  'Comp∴ Cícero Tenório de Araújo',
  null,
  'ARLS O ZOHAR 4560',
  '(11) 9.6313-2798',
  '2026-05-15T14:31:45.430000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('Comp∴ Cícero Tenório de Araújo', '')
    and coalesce(telefone, '') = coalesce('(11) 9.6313-2798', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'V∴M∴',
  'Carlos Alberto Alves da Silva',
  'V∴M∴ Carlos Alberto Alves da Silva',
  '569',
  '569 ARLS MERKABAH',
  '(11) 9.8118-3393',
  '2026-05-15T15:27:42.374000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('V∴M∴ Carlos Alberto Alves da Silva', '')
    and coalesce(telefone, '') = coalesce('(11) 9.8118-3393', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GOB',
  'V∴M∴',
  'João carlos pais',
  'V∴M∴ João carlos pais',
  '3253',
  'Fraternidade acadêmica Guarulhos 3253',
  '(11) 9.9689-6909',
  '2026-05-15T16:06:59.770000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('V∴M∴ João carlos pais', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9689-6909', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'Comp∴',
  'Carlos Otávio Schocair Mendes',
  'Comp∴ Carlos Otávio Schocair Mendes',
  '701',
  'Luiz Gonzaga do Nascimento 701',
  '(11) 9.7758-3003',
  '2026-05-15T16:07:34.957000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('Comp∴ Carlos Otávio Schocair Mendes', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7758-3003', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'Comp∴',
  'Carlos Otávio Schocair Mendes',
  'Comp∴ Carlos Otávio Schocair Mendes',
  '701',
  'Luiz Gonzaga do Nascimento 701',
  '(11) 9.7758-3003',
  '2026-05-15T16:07:58.611000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('Comp∴ Carlos Otávio Schocair Mendes', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7758-3003', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GOB',
  'M∴I∴',
  'José Augusto B. B. Braga',
  'M∴I∴ José Augusto B. B. Braga',
  '4795',
  '4795 ARLS CAVALEIROS DA ESPERANÇA',
  '(11) 9.8122-2435',
  '2026-05-15T18:11:29.177000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ José Augusto B. B. Braga', '')
    and coalesce(telefone, '') = coalesce('(11) 9.8122-2435', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'M∴I∴',
  'Felipe Jucá Sarpieri',
  'M∴I∴ Felipe Jucá Sarpieri',
  '779',
  'Propaga de terceira 779',
  '(11) 9.9157-2580',
  '2026-05-15T19:26:02.624000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Felipe Jucá Sarpieri', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9157-2580', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GOB',
  'Comp∴',
  'FERNANDES',
  'Comp∴ GUILHERME FERNANDES',
  null,
  'GUILHERME',
  '(11) 9.9399-1189',
  '2026-05-15T21:27:56.342000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('Comp∴ GUILHERME FERNANDES', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9399-1189', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GOB',
  'M∴M∴',
  'Yousif Ahmed El Hindi',
  'M∴M∴ Yousif Ahmed El Hindi',
  '2804',
  '2804 Luz do Universo',
  '(11) 9.4736-4948',
  '2026-05-16T12:35:09.862000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ Yousif Ahmed El Hindi', '')
    and coalesce(telefone, '') = coalesce('(11) 9.4736-4948', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'M∴M∴',
  'RUBENS SANTOS DE OLIVEIRA',
  'M∴M∴ RUBENS SANTOS DE OLIVEIRA',
  null,
  null,
  '(11) 9.7375-7488',
  '2026-05-16T18:24:03.329000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ RUBENS SANTOS DE OLIVEIRA', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7375-7488', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'V∴M∴',
  'Antônio Carlos de Lima',
  'V∴M∴ Antônio Carlos de Lima',
  '169',
  'ACÁCIA DE GUARULHOS 169',
  '(11) 9.6464-3630',
  '2026-05-17T15:17:21.095000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('V∴M∴ Antônio Carlos de Lima', '')
    and coalesce(telefone, '') = coalesce('(11) 9.6464-3630', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'M∴M∴',
  'Sérgio Luís de Carvalho Filho',
  'M∴M∴ Sérgio Luís de Carvalho Filho',
  '373',
  'Estrela de Cumbica - 373',
  '(11) 9.7093-8827',
  '2026-05-18T10:18:56.966000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ Sérgio Luís de Carvalho Filho', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7093-8827', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'M∴I∴',
  'Antônio Carlos de Lima',
  'M∴I∴ Antônio Carlos de Lima',
  '160',
  'Acácia de Guarulhos 160',
  '(11) 9.6464-3630',
  '2026-05-19T09:55:05.753000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Antônio Carlos de Lima', '')
    and coalesce(telefone, '') = coalesce('(11) 9.6464-3630', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GOB',
  'A∴M∴',
  'Brasil',
  'A∴M∴ Brasil',
  null,
  'Rodrigo',
  '(11) 9.9161-0381',
  '2026-05-19T12:01:31.965000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Brasil', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9161-0381', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'Comp∴',
  'Marcos Bento',
  'Comp∴ Marcos Bento',
  '373',
  'Estrela de Cumbica 373',
  '(11) 9.9420-5482',
  '2026-05-19T15:23:25.935000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('Comp∴ Marcos Bento', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9420-5482', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴',
  null,
  'GLESP',
  'M∴M∴',
  'Felipe Sarpieri',
  'M∴M∴ Felipe Sarpieri',
  '779',
  '779 Propaganda Terceira',
  '(11) 9.9157-2580',
  '2026-05-22T13:58:42.995000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ Felipe Sarpieri', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9157-2580', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-27'::date order by created_at asc limit 1),
  '2026-06-27',
  'Sess∴ no Gr∴ de Apr∴',
  '27/06/2026 - Sess∴ no Gr∴ de Apr∴',
  'GOB',
  'A∴M∴',
  'Thiago Jose Simiano Ribeiro',
  'A∴M∴ Thiago Jose Simiano Ribeiro',
  '3437',
  'Tradição e Progresso',
  '(11) 9.9693-0689',
  '2026-06-10T14:19:37.112000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-27'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Thiago Jose Simiano Ribeiro', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9693-0689', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-27'::date order by created_at asc limit 1),
  '2026-06-27',
  'Sess∴ no Gr∴ de Apr∴',
  '27/06/2026 - Sess∴ no Gr∴ de Apr∴',
  'GOB',
  'A∴M∴',
  'Sérgio Ricardo Favarão',
  'A∴M∴ Sérgio Ricardo Favarão',
  '3437',
  'Tradição e Progresso',
  '(11) 9.5231-6440',
  '2026-06-10T14:52:10.888000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-27'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Sérgio Ricardo Favarão', '')
    and coalesce(telefone, '') = coalesce('(11) 9.5231-6440', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-27'::date order by created_at asc limit 1),
  '2026-06-27',
  'Sess∴ no Gr∴ de Apr∴',
  '27/06/2026 - Sess∴ no Gr∴ de Apr∴',
  'GOB',
  'A∴M∴',
  'Sandro Elias de Carvalho Fernandes',
  'A∴M∴ Sandro Elias de Carvalho Fernandes',
  '3437',
  'Tradição e Progresso',
  '(11) 9.4732-6145',
  '2026-06-23T11:07:15.638000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-27'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Sandro Elias de Carvalho Fernandes', '')
    and coalesce(telefone, '') = coalesce('(11) 9.4732-6145', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-27'::date order by created_at asc limit 1),
  '2026-06-27',
  'Sess∴ no Gr∴ de Apr∴',
  '27/06/2026 - Sess∴ no Gr∴ de Apr∴',
  'GLESP',
  'M∴M∴',
  'Fernando José da Silva Filho',
  'M∴M∴ Fernando José da Silva Filho',
  '160',
  'Acácia de Guarulhos',
  '(11) 9.7422-1482',
  '2026-06-23T14:32:39.532000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-27'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ Fernando José da Silva Filho', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7422-1482', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-27'::date order by created_at asc limit 1),
  '2026-06-27',
  'Sess∴ no Gr∴ de Apr∴',
  '27/06/2026 - Sess∴ no Gr∴ de Apr∴',
  'GOB',
  'M∴I∴',
  'Everton',
  'M∴I∴ Everton',
  '3437',
  'Tradição e Progresso',
  '(11) 9.7991-8744',
  '2026-06-26T09:47:17.650000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-27'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Everton', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7991-8744', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GOB',
  'A∴M∴',
  'Thiago José Simiano Ribeiro',
  'A∴M∴ Thiago José Simiano Ribeiro',
  '3437',
  'Tradição e Progresso 3437',
  '(11) 9.9693-0689',
  '2026-05-15T10:22:13.060000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Thiago José Simiano Ribeiro', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9693-0689', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GOB',
  'M∴I∴',
  'SILVA',
  'M∴I∴ CELSO SILVA',
  null,
  null,
  '(11) 9.9106-5464',
  '2026-05-15T13:00:19.713000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ CELSO SILVA', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9106-5464', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'M∴I∴',
  'Eduardo Mizael Prado',
  'M∴I∴ Eduardo Mizael Prado',
  null,
  'ARLS Tales de Mileto 570',
  '(11) 9.4748-7964',
  '2026-05-15T13:03:33.007000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Eduardo Mizael Prado', '')
    and coalesce(telefone, '') = coalesce('(11) 9.4748-7964', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GOB',
  'M∴I∴',
  'Helson Willian Shikasho',
  'M∴I∴ Helson Willian Shikasho',
  null,
  'Cavaleiros da luz de Guarulhos 2686',
  '(11) 9.7437-7727',
  '2026-05-15T13:05:14.559000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Helson Willian Shikasho', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7437-7727', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'M∴I∴',
  'Alex Sandro Lima de Souza',
  'M∴I∴ Alex Sandro Lima de Souza',
  null,
  'Propaganda Terceira 779',
  '(11) 9.9831-5970',
  '2026-05-15T13:35:01.828000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Alex Sandro Lima de Souza', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9831-5970', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GOB',
  'Comp∴',
  'RODRIGO FREIRE DOS SANTOS',
  'Comp∴ RODRIGO FREIRE DOS SANTOS',
  '2804',
  'Loja nº 2804 - Luz do Universo',
  '(11) 9.4715-1737',
  '2026-05-15T13:37:33.816000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('Comp∴ RODRIGO FREIRE DOS SANTOS', '')
    and coalesce(telefone, '') = coalesce('(11) 9.4715-1737', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'M∴I∴',
  'Pedro Alexandre de Francischi',
  'M∴I∴ Pedro Alexandre de Francischi',
  '701',
  'Luiz Gonzaga do Nascimento, 701',
  '(11) 9.9537-4575',
  '2026-05-15T14:30:27.268000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Pedro Alexandre de Francischi', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9537-4575', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GOB',
  'Comp∴',
  'Cícero Tenório de Araújo',
  'Comp∴ Cícero Tenório de Araújo',
  null,
  'ARLS O ZOHAR 4560',
  '(11) 9.6313-2798',
  '2026-05-15T14:31:45.430000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('Comp∴ Cícero Tenório de Araújo', '')
    and coalesce(telefone, '') = coalesce('(11) 9.6313-2798', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'V∴M∴',
  'Carlos Alberto Alves da Silva',
  'V∴M∴ Carlos Alberto Alves da Silva',
  '569',
  '569 ARLS MERKABAH',
  '(11) 9.8118-3393',
  '2026-05-15T15:27:42.374000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('V∴M∴ Carlos Alberto Alves da Silva', '')
    and coalesce(telefone, '') = coalesce('(11) 9.8118-3393', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GOB',
  'V∴M∴',
  'João carlos pais',
  'V∴M∴ João carlos pais',
  '3253',
  'Fraternidade acadêmica Guarulhos 3253',
  '(11) 9.9689-6909',
  '2026-05-15T16:06:59.770000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('V∴M∴ João carlos pais', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9689-6909', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'Comp∴',
  'Carlos Otávio Schocair Mendes',
  'Comp∴ Carlos Otávio Schocair Mendes',
  '701',
  'Luiz Gonzaga do Nascimento 701',
  '(11) 9.7758-3003',
  '2026-05-15T16:07:34.957000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('Comp∴ Carlos Otávio Schocair Mendes', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7758-3003', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'Comp∴',
  'Carlos Otávio Schocair Mendes',
  'Comp∴ Carlos Otávio Schocair Mendes',
  '701',
  'Luiz Gonzaga do Nascimento 701',
  '(11) 9.7758-3003',
  '2026-05-15T16:07:58.611000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('Comp∴ Carlos Otávio Schocair Mendes', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7758-3003', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GOB',
  'M∴I∴',
  'José Augusto B. B. Braga',
  'M∴I∴ José Augusto B. B. Braga',
  '4795',
  '4795 ARLS CAVALEIROS DA ESPERANÇA',
  '(11) 9.8122-2435',
  '2026-05-15T18:11:29.177000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ José Augusto B. B. Braga', '')
    and coalesce(telefone, '') = coalesce('(11) 9.8122-2435', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'M∴I∴',
  'Felipe Jucá Sarpieri',
  'M∴I∴ Felipe Jucá Sarpieri',
  '779',
  'Propaga de terceira 779',
  '(11) 9.9157-2580',
  '2026-05-15T19:26:02.624000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Felipe Jucá Sarpieri', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9157-2580', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GOB',
  'Comp∴',
  'FERNANDES',
  'Comp∴ GUILHERME FERNANDES',
  null,
  'GUILHERME',
  '(11) 9.9399-1189',
  '2026-05-15T21:27:56.342000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('Comp∴ GUILHERME FERNANDES', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9399-1189', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GOB',
  'M∴M∴',
  'Yousif Ahmed El Hindi',
  'M∴M∴ Yousif Ahmed El Hindi',
  '2804',
  '2804 Luz do Universo',
  '(11) 9.4736-4948',
  '2026-05-16T12:35:09.862000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ Yousif Ahmed El Hindi', '')
    and coalesce(telefone, '') = coalesce('(11) 9.4736-4948', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'M∴M∴',
  'RUBENS SANTOS DE OLIVEIRA',
  'M∴M∴ RUBENS SANTOS DE OLIVEIRA',
  null,
  null,
  '(11) 9.7375-7488',
  '2026-05-16T18:24:03.329000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ RUBENS SANTOS DE OLIVEIRA', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7375-7488', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sessão Grau de Aprendiz',
  '30/05/2026 - Sessão Grau de Aprendiz',
  'GLESP',
  'A∴M∴',
  'Danilo Alves',
  'A∴M∴ Danilo Alves',
  '32',
  'A∴ R∴ G∴ BEN∴ G∴ BENF∴ L∴ S∴ Marechal Neiva n 32',
  '(11) 9.6664-4310',
  '2026-05-17T11:01:51.051000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Danilo Alves', '')
    and coalesce(telefone, '') = coalesce('(11) 9.6664-4310', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'V∴M∴',
  'Antônio Carlos de Lima',
  'V∴M∴ Antônio Carlos de Lima',
  '169',
  'ACÁCIA DE GUARULHOS 169',
  '(11) 9.6464-3630',
  '2026-05-17T15:17:21.095000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('V∴M∴ Antônio Carlos de Lima', '')
    and coalesce(telefone, '') = coalesce('(11) 9.6464-3630', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'M∴M∴',
  'Sérgio Luís de Carvalho Filho',
  'M∴M∴ Sérgio Luís de Carvalho Filho',
  '373',
  'Estrela de Cumbica - 373',
  '(11) 9.7093-8827',
  '2026-05-18T10:18:56.966000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ Sérgio Luís de Carvalho Filho', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7093-8827', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'M∴I∴',
  'Antônio Carlos de Lima',
  'M∴I∴ Antônio Carlos de Lima',
  '160',
  'Acácia de Guarulhos 160',
  '(11) 9.6464-3630',
  '2026-05-19T09:55:05.753000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴I∴ Antônio Carlos de Lima', '')
    and coalesce(telefone, '') = coalesce('(11) 9.6464-3630', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GOB',
  'A∴M∴',
  'Brasil',
  'A∴M∴ Brasil',
  null,
  'Rodrigo',
  '(11) 9.9161-0381',
  '2026-05-19T12:01:31.965000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Brasil', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9161-0381', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'Comp∴',
  'Marcos Bento',
  'Comp∴ Marcos Bento',
  '373',
  'Estrela de Cumbica 373',
  '(11) 9.9420-5482',
  '2026-05-19T15:23:25.935000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('Comp∴ Marcos Bento', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9420-5482', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-06-06'::date order by created_at asc limit 1),
  '2026-06-06',
  'Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  '06/06/2026 - Sess∴ Mag∴ de Inst∴ e Poss∴ do V∴M∴ Solon',
  'GLESP',
  'M∴M∴',
  'Felipe Sarpieri',
  'M∴M∴ Felipe Sarpieri',
  '779',
  '779 Propaganda Terceira',
  '(11) 9.9157-2580',
  '2026-05-22T13:58:42.995000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-06-06'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ Felipe Sarpieri', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9157-2580', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sessão Grau de Aprendiz',
  '30/05/2026 - Sessão Grau de Aprendiz',
  'GOB',
  'V∴M∴',
  'Amorim',
  'V∴M∴ Alexxandre Amorim',
  '3437',
  'Tradição e Progresso 3437',
  '(11) 9.9416-7331',
  '2026-05-26T10:37:54.459000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('V∴M∴ Alexxandre Amorim', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9416-7331', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sessão Grau de Aprendiz',
  '30/05/2026 - Sessão Grau de Aprendiz',
  'GOB',
  'A∴M∴',
  'Ronaldo de Sousa Marques',
  'A∴M∴ Ronaldo de Sousa Marques',
  '3437',
  'Tradição e Progresso 3437',
  '(11) 9.9914-0758',
  '2026-05-26T10:55:38.574000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Ronaldo de Sousa Marques', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9914-0758', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sessão Grau de Aprendiz',
  '30/05/2026 - Sessão Grau de Aprendiz',
  'GLESP',
  'M∴M∴',
  'Fernando José da Silva Filho',
  'M∴M∴ Fernando José da Silva Filho',
  '160',
  'Acácia de Guarulhos 160',
  '(11) 9.7422-1482',
  '2026-05-26T11:13:53.792000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ Fernando José da Silva Filho', '')
    and coalesce(telefone, '') = coalesce('(11) 9.7422-1482', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sessão Grau de Aprendiz',
  '30/05/2026 - Sessão Grau de Aprendiz',
  'GOB',
  'A∴M∴',
  'Sandro Elias de Carvalho Fernandes',
  'A∴M∴ Sandro Elias de Carvalho Fernandes',
  '3437',
  'Tradição e Progresso 3437',
  '(11) 9.4732-6145',
  '2026-05-26T11:18:10.211000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Sandro Elias de Carvalho Fernandes', '')
    and coalesce(telefone, '') = coalesce('(11) 9.4732-6145', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sessão Grau de Aprendiz',
  '30/05/2026 - Sessão Grau de Aprendiz',
  'GOB',
  'A∴M∴',
  'Favarão',
  'A∴M∴ Sergio Favarão',
  '3437',
  'Tradição e Progresso 3437',
  '(11) 9.5231-6440',
  '2026-05-26T11:27:40.328000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Sergio Favarão', '')
    and coalesce(telefone, '') = coalesce('(11) 9.5231-6440', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sessão Grau de Aprendiz',
  '30/05/2026 - Sessão Grau de Aprendiz',
  'GOB',
  'A∴M∴',
  'André luis de Sousa Marques',
  'A∴M∴ André luis de Sousa Marques',
  '3437',
  'Tradição e Progresso 3437',
  '(11) 9.4721-2723',
  '2026-05-26T12:50:50.590000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ André luis de Sousa Marques', '')
    and coalesce(telefone, '') = coalesce('(11) 9.4721-2723', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sessão Grau de Aprendiz',
  '30/05/2026 - Sessão Grau de Aprendiz',
  'GOB',
  'M∴M∴',
  'Carlos Alberto Cavalcante Silva',
  'M∴M∴ Carlos Alberto Cavalcante Silva',
  '2642',
  'Lautaro',
  '(11) 9.8199-2340',
  '2026-05-26T15:25:59.161000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ Carlos Alberto Cavalcante Silva', '')
    and coalesce(telefone, '') = coalesce('(11) 9.8199-2340', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sessão Grau de Aprendiz',
  '30/05/2026 - Sessão Grau de Aprendiz',
  'GLESP',
  'M∴M∴',
  'MILTON L  M PENALBER',
  'M∴M∴ MILTON L  M PENALBER',
  '850',
  'FRATERNIDADE ESTRELA FLAMIGERA',
  '(11) 119.7419-2640',
  '2026-05-26T15:50:07.224000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('M∴M∴ MILTON L  M PENALBER', '')
    and coalesce(telefone, '') = coalesce('(11) 119.7419-2640', '')
);

insert into public.confirmacoes_presenca (
  reuniao_id,
  evento_data,
  evento_titulo,
  evento_label,
  potencia,
  titulo,
  nome,
  nome_completo,
  numero_loja,
  nome_loja,
  telefone,
  created_at
)
select
  (select id from public.reunioes where data = '2026-05-30'::date order by created_at asc limit 1),
  '2026-05-30',
  'Sessão Grau de Aprendiz',
  '30/05/2026 - Sessão Grau de Aprendiz',
  'GLESP',
  'A∴M∴',
  'Carlos Eduardo Trindade Nunes Villela',
  'A∴M∴ Carlos Eduardo Trindade Nunes Villela',
  '498',
  'Tijucussú',
  '(11) 9.9933-8856',
  '2026-05-26T16:01:16.604000'
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = '2026-05-30'::date
    and coalesce(nome_completo, '') = coalesce('A∴M∴ Carlos Eduardo Trindade Nunes Villela', '')
    and coalesce(telefone, '') = coalesce('(11) 9.9933-8856', '')
);

commit;
