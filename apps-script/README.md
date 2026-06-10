# Apps Script da confirmação

Este diretório guarda o código de referência do Google Apps Script que alimenta:

- o cadastro das reuniões
- o envio de confirmações de presença
- a contagem automática de confirmações por data

## Planilhas esperadas

### Aba `registro`

Usada para as confirmações. O script salva os campos:

```text
eventoData | eventoTitulo | eventoLabel | potencia | titulo | nome | nomeCompleto | numeroLoja | nomeLoja | telefone | criadoEm
```

### Aba `reuniao`

Usada para cadastrar as reuniões que aparecem no site e no formulário.

```text
data | titulo | descricao | status | fotos
```

O campo `fotos` aceita até 2 URLs, separadas por `|` ou por vírgula.

## Endpoints

- `GET ?action=agenda` retorna a agenda em JSON com `confirmados` calculado a partir da aba `registro`.
- `GET ?action=health` retorna um ping simples.
- `POST` salva uma confirmação.
- `POST` com `action=agenda-save` salva ou atualiza uma reunião na aba `reuniao`.

## Propriedades do script

Se o script não estiver vinculado diretamente à planilha, defina:

- `SPREADSHEET_ID`

em `Propriedades do projeto > Propriedades do script`.

## Como usar no site

- A home lê a agenda em `script.js`.
- A página `/confirmacao/` carrega o mesmo endpoint para preencher o seletor de reunião.
- Se o Apps Script falhar, o site usa o fallback local em `data/reunioes.json`.
