const loginCard = document.getElementById('adminLoginCard');
const loginForm = document.getElementById('adminLoginForm');
const adminDashboard = document.getElementById('adminDashboard');
const setupStatus = document.getElementById('setupStatus');
const btnLogout = document.getElementById('btnLogout');
const btnNovoRegistro = document.getElementById('btnNovoRegistro');
const btnRecarregar = document.getElementById('btnRecarregar');
const btnFecharEditor = document.getElementById('btnFecharEditor');
const editorModal = document.getElementById('editorModal');
const moduleTitle = document.getElementById('moduleTitle');
const moduleDescription = document.getElementById('moduleDescription');
const moduleSearch = document.getElementById('moduleSearch');
const moduleTableHead = document.getElementById('moduleTableHead');
const moduleTableBody = document.getElementById('moduleTableBody');
const moduleForm = document.getElementById('moduleForm');
const syncStatus = document.getElementById('syncStatus');

const metricObreiros = document.getElementById('metricObreiros');
const metricReunioes = document.getElementById('metricReunioes');
const metricPendentes = document.getElementById('metricPendentes');
const metricConfirmacoes = document.getElementById('metricConfirmacoes');

const supabase = window.getLojaSupabaseClient?.();

document.body.dataset.adminScriptLoaded = 'true';

const MODULES = {
  reunioes: {
    title: 'Agenda',
    description: 'Cadastro das reunioes exibidas no site e no formulario de confirmacao.',
    table: 'reunioes',
    order: 'data',
    columns: [
      { key: 'data', label: 'Data', type: 'date', required: true },
      { key: 'titulo', label: 'Titulo', required: true },
      { key: 'descricao', label: 'Descricao', type: 'textarea' },
      { key: 'status', label: 'Status', type: 'select', options: ['programada', 'realizada', 'cancelada'] },
      { key: 'fotos', label: 'Fotos', type: 'textarea', helper: 'Uma URL por linha.' },
    ],
    list: ['data', 'titulo', 'status'],
  },
  obreiros: {
    title: 'Obreiros',
    description: 'Cadastro central usado por Secretaria, Tesouraria e Galerias.',
    table: 'obreiros',
    order: 'nome',
    columns: [
      { key: 'nome', label: 'Nome', required: true },
      { key: 'telefone', label: 'Telefone' },
      { key: 'email', label: 'E-mail', type: 'email' },
      { key: 'data_nascimento', label: 'Nascimento', type: 'date' },
      { key: 'data_iniciacao', label: 'Iniciacao', type: 'date' },
      { key: 'grau', label: 'Grau', type: 'select', options: ['Aprendiz', 'Companheiro', 'Mestre', 'Mestre Instalado'] },
      { key: 'cargo', label: 'Cargo' },
      { key: 'status', label: 'Status', type: 'select', options: ['ativo', 'afastado', 'licenciado', 'visitante'] },
      { key: 'foto_url', label: 'Foto URL', type: 'url' },
      { key: 'observacoes', label: 'Observacoes', type: 'textarea' },
    ],
    list: ['nome', 'grau', 'cargo', 'status'],
  },
  datas_importantes: {
    title: 'Secretaria - Datas',
    description: 'Aniversariantes, datas comemorativas e lembretes recorrentes.',
    table: 'datas_importantes',
    order: 'data',
    columns: [
      { key: 'titulo', label: 'Titulo', required: true },
      { key: 'tipo', label: 'Tipo', type: 'select', options: ['aniversario', 'comemorativa', 'iniciacao', 'elevacao', 'exaltacao', 'outro'] },
      { key: 'data', label: 'Data', type: 'date', required: true },
      { key: 'recorrente', label: 'Recorrente', type: 'checkbox' },
      { key: 'observacoes', label: 'Observacoes', type: 'textarea' },
    ],
    list: ['data', 'titulo', 'tipo'],
  },
  atas: {
    title: 'Atas',
    description: 'Registro das atas com campos estruturados para facilitar o preenchimento.',
    table: 'atas',
    order: 'data',
    columns: [
      { key: 'data', label: 'Data', type: 'date', required: true },
      { key: 'tipo_reuniao', label: 'Tipo de reuniao' },
      { key: 'titulo', label: 'Titulo', required: true },
      { key: 'presentes', label: 'Presentes', type: 'textarea' },
      { key: 'pauta', label: 'Pauta', type: 'textarea' },
      { key: 'texto_ata', label: 'Texto da ata', type: 'textarea' },
      { key: 'status', label: 'Status', type: 'select', options: ['rascunho', 'revisao', 'aprovada'] },
    ],
    list: ['data', 'titulo', 'status'],
  },
  pagamentos: {
    title: 'Tesouraria',
    description: 'Gestao dos pagantes, status mensal e historico financeiro.',
    table: 'pagamentos',
    order: 'referencia_ano',
    columns: [
      { key: 'nome', label: 'Nome', required: true },
      { key: 'referencia_mes', label: 'Mes', type: 'number', required: true },
      { key: 'referencia_ano', label: 'Ano', type: 'number', required: true },
      { key: 'valor', label: 'Valor', type: 'number', step: '0.01' },
      { key: 'status', label: 'Status', type: 'select', options: ['pendente', 'pago', 'isento', 'atrasado'] },
      { key: 'data_pagamento', label: 'Data pagamento', type: 'date' },
      { key: 'forma_pagamento', label: 'Forma pagamento' },
      { key: 'observacoes', label: 'Observacoes', type: 'textarea' },
    ],
    list: ['nome', 'referencia_mes', 'referencia_ano', 'status', 'valor'],
  },
  galeria: {
    title: 'Galerias',
    description: 'Fundadores, Veneraveis e Obreiros para exibicao institucional.',
    table: 'galeria',
    order: 'ordem',
    columns: [
      { key: 'tipo', label: 'Tipo', type: 'select', options: ['fundador', 'veneravel', 'obreiro'] },
      { key: 'nome', label: 'Nome', required: true },
      { key: 'cargo', label: 'Cargo' },
      { key: 'periodo', label: 'Periodo' },
      { key: 'foto_url', label: 'Foto URL', type: 'url' },
      { key: 'biografia', label: 'Biografia', type: 'textarea' },
      { key: 'ordem', label: 'Ordem', type: 'number' },
      { key: 'ativo', label: 'Ativo', type: 'checkbox' },
    ],
    list: ['tipo', 'nome', 'cargo', 'periodo'],
  },
  confirmacoes_presenca: {
    title: 'Presencas',
    description: 'Confirmacoes recebidas pelo formulario publico.',
    table: 'confirmacoes_presenca',
    order: 'created_at',
    readonly: true,
    columns: [
      { key: 'created_at', label: 'Criado em' },
      { key: 'evento_data', label: 'Data' },
      { key: 'evento_titulo', label: 'Reuniao' },
      { key: 'nome_completo', label: 'Nome' },
      { key: 'telefone', label: 'Telefone' },
      { key: 'nome_loja', label: 'Loja' },
    ],
    list: ['evento_data', 'evento_titulo', 'nome_completo', 'telefone'],
  },
};

let activeModuleKey = 'reunioes';
let activeRows = [];
let editingId = null;

const setStatus = (message, type = '') => {
  if (!syncStatus) return;
  syncStatus.textContent = message;
  syncStatus.dataset.type = type;
};

const setSetupStatus = (message, type = '') => {
  if (!setupStatus) return;
  setupStatus.textContent = message;
  setupStatus.dataset.type = type;
};

window.addEventListener('error', (event) => {
  setSetupStatus(`Erro no Admin: ${event.message}`, 'error');
});

window.addEventListener('unhandledrejection', (event) => {
  const message = event.reason?.message || String(event.reason || 'erro desconhecido');
  setSetupStatus(`Erro no Admin: ${message}`, 'error');
});

const escapeHTML = (value) => {
  const element = document.createElement('div');
  element.textContent = value ?? '';
  return element.innerHTML;
};

const formatValue = (value) => {
  if (Array.isArray(value)) return value.join(', ');
  if (typeof value === 'boolean') return value ? 'Sim' : 'Nao';
  if (value === null || value === undefined) return '';
  return String(value);
};

const normalizeSearch = (value) =>
  String(value || '').toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '');

const getCurrentModule = () => MODULES[activeModuleKey];

const showDashboard = () => {
  loginCard.hidden = true;
  adminDashboard.hidden = false;
  btnLogout.hidden = false;
};

const showLogin = () => {
  loginCard.hidden = false;
  adminDashboard.hidden = true;
  btnLogout.hidden = true;
};

const openEditor = (row = null) => {
  const module = getCurrentModule();
  editingId = row?.id || null;

  moduleForm.innerHTML = module.columns
    .filter((field) => field.key !== 'created_at')
    .map((field) => createFieldHTML(field, row))
    .join('');

  moduleForm.insertAdjacentHTML(
    'beforeend',
    `
      <div class="admin-form-actions">
        <button type="submit" class="confirmacao-button">${editingId ? 'Salvar alteracoes' : 'Cadastrar'}</button>
        <button type="button" class="confirmacao-button admin-secondary" id="btnCancelarEditor">Cancelar</button>
      </div>
    `,
  );

  document.getElementById('btnCancelarEditor')?.addEventListener('click', closeEditor);
  editorModal.hidden = false;
  document.body.classList.add('admin-modal-open');
};

const closeEditor = () => {
  editorModal.hidden = true;
  document.body.classList.remove('admin-modal-open');
  editingId = null;
  moduleForm.reset();
};

const createFieldHTML = (field, row) => {
  const value = row?.[field.key];
  const required = field.required ? 'required' : '';
  const label = `<label class="admin-field"><span>${escapeHTML(field.label)}</span>`;

  if (field.type === 'textarea') {
    const text = Array.isArray(value) ? value.join('\n') : formatValue(value);
    return `${label}<textarea name="${field.key}" rows="4" ${required}>${escapeHTML(text)}</textarea>${field.helper ? `<small>${escapeHTML(field.helper)}</small>` : ''}</label>`;
  }

  if (field.type === 'select') {
    const options = (field.options || [])
      .map((option) => `<option value="${escapeHTML(option)}" ${option === value ? 'selected' : ''}>${escapeHTML(option)}</option>`)
      .join('');
    return `${label}<select name="${field.key}" ${required}><option value="">Selecione</option>${options}</select></label>`;
  }

  if (field.type === 'checkbox') {
    return `${label}<input name="${field.key}" type="checkbox" ${value === true ? 'checked' : ''} /></label>`;
  }

  const type = field.type || 'text';
  const step = field.step ? `step="${field.step}"` : '';
  return `${label}<input name="${field.key}" type="${type}" value="${escapeHTML(formatValue(value))}" ${step} ${required} /></label>`;
};

const buildPayload = () => {
  const module = getCurrentModule();
  const formData = new FormData(moduleForm);

  return module.columns.reduce((payload, field) => {
    if (field.key === 'created_at') return payload;

    if (field.type === 'checkbox') {
      payload[field.key] = moduleForm.elements[field.key]?.checked || false;
      return payload;
    }

    const rawValue = formData.get(field.key);
    if (field.key === 'fotos') {
      payload[field.key] = String(rawValue || '')
        .split(/\n|\|/)
        .map((item) => item.trim())
        .filter(Boolean);
      return payload;
    }

    if (field.type === 'number') {
      payload[field.key] = rawValue === '' || rawValue === null ? null : Number(rawValue);
      return payload;
    }

    payload[field.key] = rawValue === '' ? null : rawValue;
    return payload;
  }, {});
};

const renderTable = () => {
  const module = getCurrentModule();
  const visibleColumns = module.columns.filter((field) => module.list.includes(field.key));
  const term = normalizeSearch(moduleSearch.value);
  const rows = term
    ? activeRows.filter((row) => normalizeSearch(Object.values(row).join(' ')).includes(term))
    : activeRows;

  moduleTableHead.innerHTML = `
    <tr>
      ${visibleColumns.map((field) => `<th>${escapeHTML(field.label)}</th>`).join('')}
      <th>Acoes</th>
    </tr>
  `;

  if (!rows.length) {
    moduleTableBody.innerHTML = `<tr><td colspan="${visibleColumns.length + 1}"><p class="admin-empty">Nenhum registro encontrado.</p></td></tr>`;
    return;
  }

  moduleTableBody.innerHTML = rows
    .map((row) => {
      const cells = visibleColumns
        .map((field) => `<td data-label="${escapeHTML(field.label)}">${escapeHTML(formatValue(row[field.key]))}</td>`)
        .join('');

      const actions = module.readonly
        ? '<span class="admin-event-pill">somente leitura</span>'
        : `
          <div class="dashboard-action-buttons">
            <button type="button" class="dashboard-action-btn dashboard-action-btn--edit" data-edit="${row.id}" title="Editar">E</button>
            <button type="button" class="dashboard-action-btn dashboard-action-btn--delete" data-delete="${row.id}" title="Excluir">x</button>
          </div>
        `;

      return `<tr class="agenda-row">${cells}<td data-label="Acoes">${actions}</td></tr>`;
    })
    .join('');

  moduleTableBody.querySelectorAll('[data-edit]').forEach((button) => {
    button.addEventListener('click', () => {
      const row = activeRows.find((item) => item.id === button.dataset.edit);
      openEditor(row);
    });
  });

  moduleTableBody.querySelectorAll('[data-delete]').forEach((button) => {
    button.addEventListener('click', () => deleteRow(button.dataset.delete));
  });
};

const loadModule = async () => {
  const module = getCurrentModule();
  moduleTitle.textContent = module.title;
  moduleDescription.textContent = module.description;
  btnNovoRegistro.hidden = Boolean(module.readonly);
  setStatus('Carregando...');

  try {
    const direction = module.order === 'created_at' ? false : true;
    const { data, error } = await supabase
      .from(module.table)
      .select('*')
      .order(module.order, { ascending: direction });

    if (error) throw error;

    activeRows = data || [];
    renderTable();
    setStatus('Supabase conectado', 'ok');
  } catch (error) {
    console.warn(error);
    activeRows = [];
    renderTable();
    setStatus('Erro ao carregar dados', 'error');
  }
};

const saveRow = async (event) => {
  event.preventDefault();

  const module = getCurrentModule();
  const payload = buildPayload();
  setStatus('Salvando...');

  try {
    const request = editingId
      ? supabase.from(module.table).update(payload).eq('id', editingId)
      : supabase.from(module.table).insert(payload);

    const { error } = await request;
    if (error) throw error;

    closeEditor();
    await loadModule();
    await loadMetrics();
    setStatus('Registro salvo', 'ok');
  } catch (error) {
    console.warn(error);
    setStatus('Erro ao salvar', 'error');
    alert('Nao foi possivel salvar. Verifique as politicas do Supabase e os campos obrigatorios.');
  }
};

const deleteRow = async (id) => {
  const module = getCurrentModule();
  const confirmed = confirm('Deseja excluir este registro?');
  if (!confirmed) return;

  setStatus('Excluindo...');

  try {
    const { error } = await supabase.from(module.table).delete().eq('id', id);
    if (error) throw error;

    await loadModule();
    await loadMetrics();
    setStatus('Registro excluido', 'ok');
  } catch (error) {
    console.warn(error);
    setStatus('Erro ao excluir', 'error');
  }
};

const countTable = async (table, filter) => {
  let query = supabase.from(table).select('id', { count: 'exact', head: true });
  if (filter) query = filter(query);
  const { count, error } = await query;
  if (error) throw error;
  return count || 0;
};

const loadMetrics = async () => {
  try {
    const [obreiros, reunioes, pendentes, confirmacoes] = await Promise.all([
      countTable('obreiros'),
      countTable('reunioes'),
      countTable('pagamentos', (query) => query.eq('status', 'pendente')),
      countTable('confirmacoes_presenca'),
    ]);

    metricObreiros.textContent = String(obreiros);
    metricReunioes.textContent = String(reunioes);
    metricPendentes.textContent = String(pendentes);
    metricConfirmacoes.textContent = String(confirmacoes);
  } catch (error) {
    console.warn('Nao foi possivel carregar metricas.', error);
  }
};

const initialize = async () => {
  if (!supabase) {
    setSetupStatus('Configure url e anonKey em supabase-config.js antes de entrar.', 'error');
    showLogin();
    return;
  }

  const { data } = await supabase.auth.getSession();
  if (data.session) {
    showDashboard();
    await loadMetrics();
    await loadModule();
  } else {
    setSetupStatus('Supabase configurado. Entre com seu usuario administrativo.', 'ok');
    showLogin();
  }
};

loginForm?.addEventListener('submit', async (event) => {
  event.preventDefault();

  setSetupStatus('Tentando entrar no Supabase...', 'ok');

  if (!supabase) {
    setSetupStatus('Supabase ainda nao configurado.', 'error');
    return;
  }

  const email = document.getElementById('adminEmail').value.trim();
  const password = document.getElementById('adminPassword').value;

  const { error } = await supabase.auth.signInWithPassword({ email, password });

  if (error) {
    const message = `Erro no login: ${error.message}`;
    setSetupStatus(message, 'error');
    alert(`${message}\n\nConfira se o usuario existe em Authentication > Users e se esta confirmado.`);
    return;
  }

  setSetupStatus('Login realizado com sucesso.', 'ok');
  showDashboard();
  await loadMetrics();
  await loadModule();
});

btnLogout?.addEventListener('click', async () => {
  await supabase?.auth.signOut();
  showLogin();
});

document.querySelectorAll('.admin-tab').forEach((button) => {
  button.addEventListener('click', async () => {
    document.querySelectorAll('.admin-tab').forEach((tab) => tab.classList.remove('is-active'));
    button.classList.add('is-active');
    activeModuleKey = button.dataset.module;
    moduleSearch.value = '';
    await loadModule();
  });
});

btnNovoRegistro?.addEventListener('click', () => openEditor());
btnRecarregar?.addEventListener('click', async () => {
  await loadMetrics();
  await loadModule();
});
btnFecharEditor?.addEventListener('click', closeEditor);
moduleSearch?.addEventListener('input', renderTable);
moduleForm?.addEventListener('submit', saveRow);

editorModal?.addEventListener('click', (event) => {
  if (event.target === editorModal) closeEditor();
});

initialize();
