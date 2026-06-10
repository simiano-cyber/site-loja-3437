# A.R.L.S. Tradição e Progresso 3437

Site institucional da Loja Tradição e Progresso 3437, com visual responsivo, calendário de reuniões e página local de confirmação de presença.

## Estrutura atual

```text
site-loja-3437-main/
├── index.html
├── script.js
├── style.css
├── README.md
├── data/
│   └── reunioes.json
├── confirmacao/
│   ├── index.html
│   └── script.js
├── admin/
│   ├── index.html
│   └── script.js
├── apps-script/
│   ├── Code.gs
│   └── README.md
├── comparecimento/
│   └── index.html
└── assets/
    └── img/
        ├── logo-gob.png
        ├── logo-gobsp.png
        ├── logo-loja.png
        ├── vm-alexandre-amorim.png
        └── vm-jose-solon.png
```

## O que já está integrado

- A home carrega as próximas reuniões a partir de `data/reunioes.json`.
- A home tenta primeiro a agenda remota do Apps Script e usa `data/reunioes.json` como fallback.
- O link de confirmação agora aponta para `/confirmacao/`.
- A página `/confirmacao/` envia os dados para o mesmo Apps Script já usado hoje.
- O formulário já grava em Google Sheets e continua compatível com o fluxo atual.
- A área `/admin/` permite editar a agenda localmente, importar/exportar JSON e sincronizar com o Apps Script quando houver uma URL configurada.
- No teste local, a agenda salva no admin fica em `localStorage`, e a home e a confirmação leem esse valor antes do fallback em arquivo.
- O arquivo `comparecimento/index.html` permanece como redirecionamento legado para `/confirmacao/`.
- O diretório `apps-script/` contém o código de referência para a integração com a planilha.

## Próximos passos

- Criar a área administrativa para cadastrar reuniões.
- Permitir atualizar a agenda sem editar HTML.
- Associar fotos de 1 ou 2 imagens por reunião.
- Conectar a contagem de confirmações por reunião ao Google Sheets.

## Observação

As fotos podem continuar no próprio repositório do GitHub, porque o upload ocorre depois da reunião e isso simplifica a operação neste momento.
