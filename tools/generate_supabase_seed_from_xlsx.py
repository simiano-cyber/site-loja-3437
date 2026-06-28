import math
import re
import sys
from datetime import date, datetime
from pathlib import Path

import pandas as pd


sys.stdout.reconfigure(encoding="utf-8")

SOURCE = Path(r"C:\Users\Usuario\Downloads\Confirmacao Presenca Loja 3437.xlsx")
OUTPUT = Path("supabase-import-confirmacoes-agenda.sql")


def is_blank(value):
    if value is None:
        return True
    if isinstance(value, float) and math.isnan(value):
        return True
    return str(value).strip() == ""


def clean(value):
    if is_blank(value):
        return ""
    if isinstance(value, pd.Timestamp):
        return value.to_pydatetime()
    return value


def text(value):
    value = clean(value)
    if isinstance(value, datetime):
        return value.isoformat(sep=" ")
    if isinstance(value, date):
        return value.isoformat()
    return str(value).strip()


def sql_text(value):
    value = text(value)
    if not value:
        return "null"
    return "'" + value.replace("'", "''") + "'"


def sql_date(value):
    value = clean(value)
    if not value:
        return "null"
    if isinstance(value, datetime):
        return f"'{value.date().isoformat()}'"
    if isinstance(value, date):
        return f"'{value.isoformat()}'"
    parsed = pd.to_datetime(value, dayfirst=True, errors="coerce")
    if pd.isna(parsed):
        return "null"
    return f"'{parsed.date().isoformat()}'"


def sql_timestamp(value):
    value = clean(value)
    if not value:
        return "now()"
    parsed = pd.to_datetime(value, dayfirst=True, errors="coerce")
    if pd.isna(parsed):
        return "now()"
    return f"'{parsed.isoformat()}'"


def parse_event_label(label):
    label = text(label)
    match = re.match(r"^\s*(\d{2}/\d{2}/\d{4})\s*-\s*(.+?)\s*$", label)
    if not match:
        return "", label
    parsed = pd.to_datetime(match.group(1), dayfirst=True, errors="coerce")
    event_date = "" if pd.isna(parsed) else parsed.date().isoformat()
    return event_date, match.group(2).strip()


def normalize_photo_list(*values):
    photos = []
    for value in values:
        if is_blank(value):
            continue
        for item in re.split(r"\s*\|\s*|\s*,\s*", str(value).strip()):
            item = item.strip()
            if item and item not in photos:
                photos.append(item)
    return photos[:2]


def array_literal(values):
    if not values:
        return "'{}'::text[]"
    escaped = ",".join('"' + value.replace("\\", "\\\\").replace('"', '\\"') + '"' for value in values)
    return f"'{{{escaped}}}'::text[]"


def agenda_statements():
    df = pd.read_excel(SOURCE, sheet_name="reuniao", dtype=object)
    statements = []
    for _, row in df.iterrows():
        data = sql_date(row.get("data"))
        titulo = sql_text(row.get("titulo"))
        descricao = sql_text(row.get("descricao"))
        status = sql_text(row.get("status") or "programada")
        fotos = array_literal(normalize_photo_list(row.get("fotos"), row.get("fotos.1")))
        statements.append(
            f"""
insert into public.reunioes (data, titulo, descricao, status, fotos)
select {data}, {titulo}, {descricao}, coalesce({status}, 'programada'), {fotos}
where not exists (
  select 1 from public.reunioes
  where data = {data}::date and titulo = {titulo}
);
""".strip()
        )
    return statements


def confirmation_statement(values):
    event_date = values["evento_data"]
    event_title = values["evento_titulo"]
    return f"""
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
  (select id from public.reunioes where data = {event_date}::date order by created_at asc limit 1),
  {event_date},
  {event_title},
  {values["evento_label"]},
  {values["potencia"]},
  {values["titulo"]},
  {values["nome"]},
  {values["nome_completo"]},
  {values["numero_loja"]},
  {values["nome_loja"]},
  {values["telefone"]},
  {values["created_at"]}
where not exists (
  select 1 from public.confirmacoes_presenca
  where evento_data = {event_date}::date
    and coalesce(nome_completo, '') = coalesce({values["nome_completo"]}, '')
    and coalesce(telefone, '') = coalesce({values["telefone"]}, '')
);
""".strip()


def registro_statements():
    df = pd.read_excel(SOURCE, sheet_name="registro", dtype=object)
    statements = []
    for _, row in df.iterrows():
        if is_blank(row.get("eventoData")) and is_blank(row.get("nome")):
            continue
        values = {
            "evento_data": sql_date(row.get("eventoData")),
            "evento_titulo": sql_text(row.get("eventoTitulo")),
            "evento_label": sql_text(row.get("eventoLabel")),
            "potencia": sql_text(row.get("potencia")),
            "titulo": sql_text(row.get("titulo")),
            "nome": sql_text(row.get("nome")),
            "nome_completo": sql_text(row.get("nomeCompleto")),
            "numero_loja": sql_text(row.get("numeroLoja")),
            "nome_loja": sql_text(row.get("nomeLoja")),
            "telefone": sql_text(row.get("telefone")),
            "created_at": sql_timestamp(row.get("criadoEm") or row.get("criadoEm.1")),
        }
        statements.append(confirmation_statement(values))
    return statements


def pagina6_statements():
    df = pd.read_excel(SOURCE, sheet_name="Página6", dtype=object)
    statements = []
    for _, row in df.iterrows():
        event_date, event_title = parse_event_label(row.get("Evento"))
        if not event_date and is_blank(row.get("Nome")):
            continue
        values = {
            "evento_data": f"'{event_date}'" if event_date else "null",
            "evento_titulo": sql_text(event_title),
            "evento_label": sql_text(row.get("Evento")),
            "potencia": sql_text(row.get("Potência")),
            "titulo": sql_text(row.get("Título")),
            "nome": sql_text(row.get("Nome")),
            "nome_completo": sql_text(row.get("Nome Completo")),
            "numero_loja": sql_text(row.get("Nº Loja")),
            "nome_loja": sql_text(row.get("Nome Loja")),
            "telefone": sql_text(row.get("Telefone")),
            "created_at": sql_timestamp(row.get("Data")),
        }
        statements.append(confirmation_statement(values))
    return statements


def main():
    agenda = agenda_statements()
    registro = registro_statements()
    pagina6 = pagina6_statements()
    sql = [
        "-- Importacao gerada a partir de Confirmacao Presenca Loja 3437.xlsx",
        "-- Execute no Supabase SQL Editor depois de criar o schema principal.",
        "begin;",
        *agenda,
        *registro,
        *pagina6,
        "commit;",
    ]
    OUTPUT.write_text("\n\n".join(sql) + "\n", encoding="utf-8")
    print(f"Arquivo gerado: {OUTPUT.resolve()}")
    print(f"Reunioes: {len(agenda)}")
    print(f"Confirmacoes registro: {len(registro)}")
    print(f"Confirmacoes Página6: {len(pagina6)}")
    print(f"Total confirmacoes: {len(registro) + len(pagina6)}")


if __name__ == "__main__":
    main()
