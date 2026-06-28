# A.R.L.S. Tradicao e Progresso 3437

Plataforma web da Loja Tradicao e Progresso 3437, com area institucional publica e ambiente de gestao conectado ao Supabase.

## Estrutura

```text
site-loja-3437-main/
├── index.html
├── script.js
├── style.css
├── supabase-config.js
├── supabase-schema.sql
├── confirmacao/
│   ├── index.html
│   └── script.js
├── admin/
│   ├── index.html
│   └── script.js
├── comparecimento/
│   └── index.html
└── assets/
```

## Base oficial

O sistema agora foi preparado para usar Supabase como fonte principal dos dados.

- A home le a agenda na tabela `reunioes`.
- A confirmacao de presenca grava na tabela `confirmacoes_presenca`.
- O Admin usa login do Supabase Auth.
- O Admin gerencia Agenda, Obreiros, Secretaria, Atas, Tesouraria, Galerias e Presencas.

## Como configurar

1. Crie um projeto no Supabase.
2. Abra o SQL Editor e execute o conteudo de `supabase-schema.sql`.
3. Em Authentication, crie o usuario administrativo.
4. Em Project Settings > API, copie:
   - Project URL
   - anon public key
5. Preencha `supabase-config.js`:

```js
window.LOJA_SUPABASE = {
  url: 'https://seu-projeto.supabase.co',
  anonKey: 'sua-chave-anon-public',
};
```

## Modulos iniciais

- `obreiros`: cadastro central da Loja.
- `reunioes`: agenda exibida no site e no formulario de presenca.
- `confirmacoes_presenca`: registros enviados pelos visitantes.
- `datas_importantes`: aniversariantes e datas comemorativas.
- `atas`: atas de reuniao com modelo estruturado.
- `pagamentos`: gestao dos pagantes.
- `galeria`: fundadores, veneraveis e obreiros.

## Proximos passos recomendados

- Criar os primeiros usuarios administrativos no Supabase Auth.
- Importar os dados antigos da planilha para as tabelas novas.
- Configurar Storage para fotos de galeria e documentos.
- Evoluir permissoes por perfil: admin, secretaria e tesouraria.
