const CONFIG = {
  confirmationsSheetName: 'registro',
  agendaSheetName: 'reuniao',
  scriptSpreadsheetIdProperty: 'SPREADSHEET_ID',
};

const AGENDA_HEADERS = ['data', 'titulo', 'descricao', 'status', 'fotos'];
const REGISTRO_HEADERS = [
  'eventoData',
  'eventoTitulo',
  'eventoLabel',
  'potencia',
  'titulo',
  'nome',
  'nomeCompleto',
  'numeroLoja',
  'nomeLoja',
  'telefone',
  'criadoEm',
];

function doGet(e) {
  const action = String((e && e.parameter && e.parameter.action) || 'agenda').toLowerCase();

  if (action === 'agenda') {
    return jsonResponse(buildAgenda_());
  }

  if (action === 'health') {
    return jsonResponse({ ok: true });
  }

  return jsonResponse({ error: 'Ação inválida.' }, 400);
}

function doPost(e) {
  const payload = JSON.parse((e && e.postData && e.postData.contents) || '{}');

  if (String(payload.action || '').toLowerCase() === 'agenda-save') {
    return jsonResponse(saveAgenda_(payload));
  }

  return jsonResponse(saveConfirmation_(payload));
}

function buildAgenda_() {
  const agendaSheet = getSheetByName_(CONFIG.agendaSheetName);
  if (!agendaSheet) {
    return [];
  }

  ensureHeaders_(agendaSheet, AGENDA_HEADERS);

  const agendaRows = readSheetRows_(agendaSheet);
  const confirmations = readConfirmations_();
  const confirmationTotals = groupConfirmationsByEventDate_(confirmations);

  return agendaRows
    .filter((row) => row.data || row.titulo)
    .map((row) => {
      const data = extractEventDateKey_(row);
      const fotos = normalizePhotos_(row.fotos);
      const confirmados = confirmationTotals[data] || 0;

      return {
        id: data,
        data: data,
        titulo: row.titulo || '',
        descricao: row.descricao || '',
        status: row.status || 'programada',
        confirmados: confirmados,
        fotos: fotos,
      };
    });
}

function saveConfirmation_(payload) {
  const sheet = getOrCreateConfirmationsSheet_();
  ensureHeaders_(sheet, REGISTRO_HEADERS);

  const eventoData =
    extractEventDateKey_(payload) ||
    normalizeDateKey_(payload.eventoData || payload.eventoId || '');
  const eventoTitulo = String(payload.eventoTitulo || payload.tituloEvento || '').trim();
  const eventoLabel = String(payload.eventoLabel || payload.evento || '').trim();

  sheet.appendRow([
    eventoData,
    eventoTitulo,
    eventoLabel,
    payload.potencia || '',
    payload.titulo || '',
    payload.nome || '',
    payload.nomeCompleto || '',
    payload.numeroLoja || '',
    payload.nomeLoja || '',
    payload.telefone || '',
    new Date(),
  ]);

  return {
    ok: true,
    message: 'Sucesso',
  };
}

function saveAgenda_(payload) {
  const sheet = getOrCreateAgendaSheet_();
  ensureHeaders_(sheet, AGENDA_HEADERS);

  const agendaData = normalizeDateKey_(payload.data || payload.id || '');
  if (!agendaData) {
    throw new Error('Informe a data da reunião.');
  }

  const rows = readSheetRows_(sheet);
  const targetIndex = rows.findIndex((row) => normalizeDateKey_(row.data) === agendaData);
  const rowValues = [
    agendaData,
    payload.titulo || '',
    payload.descricao || '',
    payload.status || 'programada',
    normalizePhotos_(payload.fotos).join(' | '),
  ];

  if (targetIndex >= 0) {
    sheet.getRange(targetIndex + 2, 1, 1, rowValues.length).setValues([rowValues]);
  } else {
    sheet.appendRow(rowValues);
  }

  return {
    ok: true,
    message: 'Agenda salva com sucesso.',
  };
}

function readConfirmations_() {
  const sheet = getSheetByName_(CONFIG.confirmationsSheetName);
  if (!sheet || sheet.getLastRow() < 2) {
    return [];
  }

  ensureHeaders_(sheet, REGISTRO_HEADERS);
  return readSheetRows_(sheet);
}

function groupConfirmationsByEventDate_(rows) {
  return rows.reduce((accumulator, row) => {
    const normalizedKey = extractEventDateKey_(row);
    if (normalizedKey) {
      accumulator[normalizedKey] = (accumulator[normalizedKey] || 0) + 1;
    }

    return accumulator;
  }, {});
}

function readSheetRows_(sheet) {
  const values = sheet.getDataRange().getValues();
  if (!values || values.length < 2) {
    return [];
  }

  const headers = values[0].map((header) => String(header || '').trim());

  return values.slice(1).map((row) => {
    return headers.reduce((record, header, index) => {
      const key = normalizeHeader_(header);
      record[key] = row[index];
      return record;
    }, {});
  });
}

function getSheetByName_(name) {
  const spreadsheet = getSpreadsheet_();
  return spreadsheet.getSheetByName(name);
}

function getOrCreateConfirmationsSheet_() {
  const spreadsheet = getSpreadsheet_();
  let sheet = spreadsheet.getSheetByName(CONFIG.confirmationsSheetName);

  if (!sheet) {
    sheet = spreadsheet.insertSheet(CONFIG.confirmationsSheetName);
  }

  return sheet;
}

function getOrCreateAgendaSheet_() {
  const spreadsheet = getSpreadsheet_();
  let sheet = spreadsheet.getSheetByName(CONFIG.agendaSheetName);

  if (!sheet) {
    sheet = spreadsheet.insertSheet(CONFIG.agendaSheetName);
  }

  return sheet;
}

function getSpreadsheet_() {
  const propertyValue = PropertiesService.getScriptProperties().getProperty(
    CONFIG.scriptSpreadsheetIdProperty,
  );

  if (propertyValue) {
    return SpreadsheetApp.openById(propertyValue);
  }

  const activeSpreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  if (activeSpreadsheet) {
    return activeSpreadsheet;
  }

  throw new Error(
    'Defina a propriedade SPREADSHEET_ID ou execute o script vinculado a uma planilha.',
  );
}

function normalizeHeader_(header) {
  const map = {
    'evento data': 'eventoData',
    'evento id': 'eventoData',
    'eventodata': 'eventoData',
    'evento titulo': 'eventoTitulo',
    'evento título': 'eventoTitulo',
    'eventotitulo': 'eventoTitulo',
    'evento label': 'eventoLabel',
    'eventolabel': 'eventoLabel',
    'evento': 'eventoLabel',
    'potencia': 'potencia',
    'titulo': 'titulo',
    'nome': 'nome',
    'nome completo': 'nomeCompleto',
    'nomecompleto': 'nomeCompleto',
    'numero loja': 'numeroLoja',
    'nº loja': 'numeroLoja',
    'n loja': 'numeroLoja',
    'numeroloja': 'numeroLoja',
    'nome loja': 'nomeLoja',
    'nomeloja': 'nomeLoja',
    'telefone': 'telefone',
    'criado em': 'criadoEm',
    'criadoem': 'criadoEm',
    'data': 'data',
    'descricao': 'descricao',
    'descrição': 'descricao',
    'status': 'status',
    'fotos': 'fotos',
    'id': 'id',
  };

  const normalized = String(header || '')
    .trim()
    .toLowerCase()
    .replace(/\s+/g, ' ');

  return map[normalized] || normalized.replace(/\s+/g, '');
}

function normalizeDateKey_(value) {
  if (!value) {
    return '';
  }

  if (Object.prototype.toString.call(value) === '[object Date]' && !isNaN(value)) {
    return Utilities.formatDate(value, Session.getScriptTimeZone(), 'yyyy-MM-dd');
  }

  const texto = String(value).trim();
  if (!texto) {
    return '';
  }

  if (/^\d{4}-\d{2}-\d{2}/.test(texto)) {
    return texto.slice(0, 10);
  }

  const partes = texto.split(/[\/\-]/).map((item) => item.trim());
  if (
    partes.length === 3 &&
    /^\d{2}$/.test(partes[0]) &&
    /^\d{2}$/.test(partes[1]) &&
    /^\d{4}$/.test(partes[2])
  ) {
    return `${partes[2]}-${partes[1]}-${partes[0]}`;
  }

  const data = new Date(texto);
  if (!isNaN(data)) {
    return Utilities.formatDate(data, Session.getScriptTimeZone(), 'yyyy-MM-dd');
  }

  return texto;
}

function normalizePhotos_(value) {
  if (!value) {
    return [];
  }

  if (Array.isArray(value)) {
    return value.filter(Boolean).slice(0, 2);
  }

  return String(value)
    .split(/[|,]/)
    .map((item) => item.trim())
    .filter(Boolean)
    .slice(0, 2);
}

function extractEventDateKey_(rowOrPayload) {
  if (!rowOrPayload) {
    return '';
  }

  const candidateValues = [
    rowOrPayload.data,
    rowOrPayload.id,
    rowOrPayload.eventoData,
    rowOrPayload.eventoId,
    rowOrPayload.eventoLabel,
    rowOrPayload.eventoTitulo,
    rowOrPayload.evento,
  ];

  for (let index = 0; index < candidateValues.length; index += 1) {
    const normalized = normalizeDateKey_(candidateValues[index]);
    if (normalized && /^\d{4}-\d{2}-\d{2}$/.test(normalized)) {
      return normalized;
    }
  }

  const textualCandidates = candidateValues
    .map((value) => String(value || '').trim())
    .filter(Boolean);

  for (let index = 0; index < textualCandidates.length; index += 1) {
    const texto = textualCandidates[index];
    const match = texto.match(/\b(\d{2}\/\d{2}\/\d{4}|\d{4}-\d{2}-\d{2})\b/);
    if (match) {
      const normalized = normalizeDateKey_(match[1]);
      if (normalized) {
        return normalized;
      }
    }
  }

  return '';
}

function ensureHeaders_(sheet, expectedHeaders) {
  const currentHeaders =
    sheet.getLastColumn() > 0
      ? sheet.getRange(1, 1, 1, sheet.getLastColumn()).getValues()[0]
      : [];

  const normalizedCurrentHeaders = currentHeaders
    .map((header) => String(header || '').trim())
    .filter(Boolean);

  const matches =
    normalizedCurrentHeaders.length === expectedHeaders.length &&
    normalizedCurrentHeaders.every(
      (header, index) => normalizeHeader_(header) === normalizeHeader_(expectedHeaders[index]),
    );

  if (!matches) {
    sheet.getRange(1, 1, 1, expectedHeaders.length).setValues([expectedHeaders]);
  }
}

function jsonResponse(payload, statusCode) {
  const output = ContentService.createTextOutput(JSON.stringify(payload));
  output.setMimeType(ContentService.MimeType.JSON);
  return output;
}
