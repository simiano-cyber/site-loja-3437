const AGENDA_STORAGE_KEY = 'tradicao3437_agenda';
const AUTH_STORAGE_KEY = 'tradicao3437_admin_auth';
const DEFAULT_ADMIN_USER = 'admin';
const DEFAULT_ADMIN_PASSWORD = '3437';
const DEFAULT_APPS_SCRIPT_URL =
  'https://script.google.com/macros/s/AKfycbzJqBotGpzkooB01roAMtHHg_a-NWtzi_Dnz2qcNW26y8FPxWva7Bs4dXTU2t7UOt9V/exec';

const seedAgenda = [
  {
    id: '2026-05-30-sessao-aprendiz',
    data: '2026-05-30',
    titulo: 'Sessão de Aprendiz',
    descricao: 'Sessão ordinária de Aprendiz, com confirmação aberta para os irmãos.',
    status: 'programada',
    confirmados: 0,
    fotos: [],
  },
  {
    id: '2026-06-06-sessao-magna',
    data: '2026-06-06',
    titulo: 'Sessão Magna de Instalação e Posse do V∴M∴ Solon',
    descricao: 'Reunião especial com a cerimônia de instalação e posse.',
    status: 'programada',
    confirmados: 0,
    fotos: [],
  },
];

const loginCard = document.getElementById('adminLoginCard');
const loginForm = document.getElementById('adminLoginForm');
const adminDashboard = document.getElementById('adminDashboard');
const agendaList = document.getElementById('agendaList');
const agendaForm = document.getElementById('agendaForm');
const agendaIndex = document.getElementById('agendaIndex');
const agendaData = document.getElementById('agendaData');
const agendaTituloPadrao = document.getElementById('agendaTituloPadrao');
const agendaTituloCustom = document.getElementById('agendaTituloCustom');
const agendaDescricao = document.getElementById('agendaDescricao');
const agendaStatus = document.getElementById('agendaStatus');
const agendaFotos = document.getElementById('agendaFotos');
const agendaJsonPreview = document.getElementById('agendaJsonPreview');
const appsScriptUrl = document.getElementById('appsScriptUrl');
const importFile = document.getElementById('importFile');
const agendaFiltro = document.getElementById('agendaFiltro');
const btnNovo = document.getElementById('btnNovo');
const editorModal = document.getElementById('editorModal');
const editorCard = document.getElementById('editorCard');
const btnFecharEditor = document.getElementById('btnFecharEditor');
const btnSalvarAgenda = document.getElementById('btnSalvarAgenda');
const btnSalvarLocal = document.getElementById('btnSalvarLocal');
const btnExportar = document.getElementById('btnExportar');
const btnSincronizar = document.getElementById('btnSincronizar');
const btnCancelarEdicao = document.getElementById('btnCancelarEdicao');
const metricTotal = document.getElementById('metricTotal');
const metricProgramadas = document.getElementById('metricProgramadas');
const metricRealizadas = document.getElementById('metricRealizadas');
const metricFotos = document.getElementById('metricFotos');

let reunioes = [];
let termoFiltro = '';

function obterAppsScriptBaseUrl() {
  return appsScriptUrl?.value?.trim() || DEFAULT_APPS_SCRIPT_URL;
}

async function carregarAgendaDaPlanilha() {
  try {
    const resposta = await fetch(`${obterAppsScriptBaseUrl()}?action=agenda`, {
      cache: 'no-store',
    });

    if (!resposta.ok) {
      throw new Error('Falha ao ler a agenda na planilha.');
    }

    const agenda = await resposta.json();
    return Array.isArray(agenda) ? agenda : null;
  } catch (erro) {
    console.warn('Não foi possível ler a agenda na planilha.', erro);
    return null;
  }
}

async function inicializarAgenda() {
  const agendaRemota = await carregarAgendaDaPlanilha();
  if (agendaRemota && agendaRemota.length) {
    reunioes = agendaRemota;
  } else {
    const agendaLocal = carregarAgendaLocal();
    reunioes = agendaLocal && agendaLocal.length ? agendaLocal : seedAgenda.slice();
  }

  salvarAgendaLocal();
  renderizarLista();
  atualizarPreview();
  atualizarMetricas();
}

async function recarregarAgendaDaPlanilha() {
  const agendaRemota = await carregarAgendaDaPlanilha();
  if (agendaRemota && agendaRemota.length) {
    reunioes = agendaRemota;
    salvarAgendaLocal();
    renderizarLista();
    atualizarPreview();
    atualizarMetricas();
  }
}

function mostrarDashboard() {
  loginCard.hidden = true;
  adminDashboard.hidden = false;
}

function mostrarLogin() {
  loginCard.hidden = false;
  adminDashboard.hidden = true;
}

function isAutenticado() {
  return sessionStorage.getItem(AUTH_STORAGE_KEY) === 'ok';
}

function autenticar(usuario, senha) {
  return usuario === DEFAULT_ADMIN_USER && senha === DEFAULT_ADMIN_PASSWORD;
}

function carregarAgendaLocal() {
  try {
    const valor = localStorage.getItem(AGENDA_STORAGE_KEY);
    if (!valor) {
      return null;
    }

    const agenda = JSON.parse(valor);
    return Array.isArray(agenda) ? agenda : null;
  } catch (erro) {
    console.warn('Não foi possível ler a agenda local.', erro);
    return null;
  }
}

function salvarAgendaLocal() {
  localStorage.setItem(AGENDA_STORAGE_KEY, JSON.stringify(reunioes));
  atualizarPreview();
}

function normalizarFotos(valor) {
  return String(valor || '')
    .split(/[\n|,]/)
    .map((item) => item.trim())
    .filter(Boolean)
    .slice(0, 2);
}

function gerarIdReuniao(data, titulo) {
  const dataParte = String(data || '')
    .replace(/-/g, '')
    .trim();

  const tituloParte = normalizarTexto(titulo)
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');

  return [dataParte, tituloParte].filter(Boolean).join('-');
}

function obterTituloFormulario() {
  if (!agendaTituloPadrao) {
    return '';
  }

  if (agendaTituloPadrao.value === '__custom__') {
    return String(agendaTituloCustom?.value || '').trim();
  }

  return String(agendaTituloPadrao.value || '').trim();
}

function ajustarTituloCustomizacao() {
  if (!agendaTituloPadrao || !agendaTituloCustom) {
    return;
  }

  const mostrarCustom = agendaTituloPadrao.value === '__custom__';
  agendaTituloCustom.hidden = !mostrarCustom;
  agendaTituloCustom.required = mostrarCustom;
  if (!mostrarCustom) {
    agendaTituloCustom.value = '';
  }
}

function formatarDataBR(valor) {
  if (!valor) {
    return '';
  }

  const data = new Date(`${valor}T12:00:00`);
  const dia = String(data.getDate()).padStart(2, '0');
  const mes = String(data.getMonth() + 1).padStart(2, '0');
  const ano = data.getFullYear();

  return `${dia}/${mes}/${ano}`;
}

function normalizarTexto(valor) {
  return String(valor || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '');
}

function obterReunioesFiltradas() {
  const termo = normalizarTexto(termoFiltro);

  if (!termo) {
    return reunioes.map((reuniao, indice) => ({ reuniao, indice }));
  }

  return reunioes
    .map((reuniao, indice) => ({ reuniao, indice }))
    .filter(({ reuniao }) => {
      const campos = [
        formatarDataBR(reuniao.data),
        reuniao.titulo,
        reuniao.descricao,
        reuniao.status,
        reuniao.id,
      ].map(normalizarTexto);

      return campos.some((campo) => campo.includes(termo));
    });
}

function limparFormulario() {
  agendaForm.reset();
  agendaIndex.value = '';
  agendaStatus.value = 'programada';
  ajustarTituloCustomizacao();
}

function abrirEditor() {
  if (!editorModal) {
    return;
  }

  editorModal.hidden = false;
  document.body.classList.add('admin-modal-open');
}

function fecharEditor() {
  if (!editorModal) {
    return;
  }

  editorModal.hidden = true;
  document.body.classList.remove('admin-modal-open');
}

function definirModoFormulario(modo) {
  if (btnSalvarAgenda) {
    btnSalvarAgenda.textContent = modo === 'editar' ? 'Salvar sessão' : 'Cadastrar sessão';
  }
}

function carregarReuniaoNoFormulario(indice) {
  const reuniao = reunioes[indice];
  if (!reuniao) {
    return;
  }

  agendaIndex.value = String(indice);
  agendaData.value = reuniao.data || '';
  agendaDescricao.value = reuniao.descricao || '';
  agendaStatus.value = reuniao.status || 'programada';
  agendaFotos.value = Array.isArray(reuniao.fotos) ? reuniao.fotos.join('\n') : '';
  const tituloExiste = Array.from(agendaTituloPadrao?.options || []).some((option) => option.value === reuniao.titulo);
  if (tituloExiste) {
    agendaTituloPadrao.value = reuniao.titulo || '';
    ajustarTituloCustomizacao();
  } else {
    agendaTituloPadrao.value = '__custom__';
    ajustarTituloCustomizacao();
    if (agendaTituloCustom) {
      agendaTituloCustom.value = reuniao.titulo || '';
    }
  }
  definirModoFormulario('editar');
  abrirEditor();
}

async function removerReuniao(indice) {
  reunioes.splice(indice, 1);
  salvarAgendaLocal();
  renderizarLista();
  limparFormulario();
  try {
    await sincronizarAppsScript();
    await recarregarAgendaDaPlanilha();
  } catch (erro) {
    console.warn('Não foi possível sincronizar após excluir a reunião.', erro);
  }
}

async function adicionarFoto(indice) {
  const reuniao = reunioes[indice];
  if (!reuniao) {
    return;
  }

  const valorAtual = Array.isArray(reuniao.fotos) ? reuniao.fotos.join('\n') : '';
  const resposta = prompt(
    'Cole a URL da foto. Você pode separar várias por linha ou por "|".',
    valorAtual,
  );

  if (resposta === null) {
    return;
  }

  reuniao.fotos = normalizarFotos(resposta);
  salvarAgendaLocal();
  renderizarLista();

  try {
    await sincronizarAppsScript();
    await recarregarAgendaDaPlanilha();
  } catch (erro) {
    console.warn('Não foi possível sincronizar após atualizar as fotos.', erro);
  }
}

function atualizarMetricas() {
  const total = reunioes.length;
  const programadas = reunioes.filter((reuniao) => (reuniao.status || 'programada') === 'programada').length;
  const realizadas = reunioes.filter((reuniao) => reuniao.status === 'realizada').length;
  const fotos = reunioes.filter((reuniao) => Array.isArray(reuniao.fotos) && reuniao.fotos.length > 0).length;

  if (metricTotal) metricTotal.textContent = String(total);
  if (metricProgramadas) metricProgramadas.textContent = String(programadas);
  if (metricRealizadas) metricRealizadas.textContent = String(realizadas);
  if (metricFotos) metricFotos.textContent = String(fotos);
}

function renderizarLista() {
  if (!agendaList) {
    return;
  }

  const lista = obterReunioesFiltradas();

  if (!lista.length) {
    const mensagem = reunioes.length
      ? '<p class="admin-empty">Nenhuma reunião encontrada com esse filtro.</p>'
      : '<p class="admin-empty">Nenhuma reunião cadastrada ainda.</p>';
    agendaList.innerHTML = `<tr><td colspan="7">${mensagem}</td></tr>`;
    atualizarMetricas();
    return;
  }

  agendaList.innerHTML = lista
    .map(
      ({ reuniao, indice }) => `
        <tr class="agenda-row">
          <td data-label="Data">${formatarDataBR(reuniao.data)}</td>
          <td data-label="Título">
            <strong>${reuniao.titulo || ''}</strong>
          </td>
          <td data-label="Descrição">${reuniao.descricao || ''}</td>
          <td data-label="Status">
            <span class="admin-event-pill">${reuniao.status || 'programada'}</span>
          </td>
          <td data-label="Confirmados">${Number(reuniao.confirmados || 0)}</td>
          <td data-label="Fotos">${Array.isArray(reuniao.fotos) ? reuniao.fotos.length : 0}</td>
          <td data-label="Ações">
            <div class="dashboard-action-buttons">
              <button type="button" class="dashboard-action-btn dashboard-action-btn--edit" data-edit="${indice}" aria-label="Editar reunião" title="Editar reunião">&#9998;</button>
              <button type="button" class="dashboard-action-btn dashboard-action-btn--photo" data-photo="${indice}" aria-label="Adicionar foto" title="Adicionar foto">&#128247;</button>
              <button type="button" class="dashboard-action-btn dashboard-action-btn--delete" data-delete="${indice}" aria-label="Excluir reunião" title="Excluir reunião">&times;</button>
            </div>
          </td>
        </tr>
      `,
    )
    .join('');

  agendaList.querySelectorAll('[data-edit]').forEach((button) => {
    button.addEventListener('click', () => carregarReuniaoNoFormulario(Number(button.dataset.edit)));
  });

  agendaList.querySelectorAll('[data-delete]').forEach((button) => {
    button.addEventListener('click', () => removerReuniao(Number(button.dataset.delete)));
  });

  agendaList.querySelectorAll('[data-photo]').forEach((button) => {
    button.addEventListener('click', () => adicionarFoto(Number(button.dataset.photo)));
  });

  atualizarMetricas();
}

function atualizarPreview() {
  agendaJsonPreview.value = JSON.stringify(reunioes, null, 2);
}

function exportarJson() {
  const blob = new Blob([JSON.stringify(reunioes, null, 2)], { type: 'application/json' });
  const url = URL.createObjectURL(blob);
  const link = document.createElement('a');
  link.href = url;
  link.download = 'reunioes.json';
  link.click();
  URL.revokeObjectURL(url);
}

async function sincronizarAppsScript() {
  const destino = obterAppsScriptBaseUrl();

  for (const reuniao of reunioes) {
    const payload = {
      action: 'agenda-save',
      id: reuniao.id,
      data: reuniao.data,
      titulo: reuniao.titulo,
      descricao: reuniao.descricao,
      status: reuniao.status,
      fotos: reuniao.fotos || [],
    };

    await fetch(destino, {
      method: 'POST',
      body: JSON.stringify(payload),
    });
  }
}

loginForm?.addEventListener('submit', (evento) => {
  evento.preventDefault();
  const usuario = document.getElementById('adminUser').value.trim();
  const senha = document.getElementById('adminPassword').value;

  if (!autenticar(usuario, senha)) {
    alert('Acesso inválido.');
    return;
  }

  sessionStorage.setItem(AUTH_STORAGE_KEY, 'ok');
  mostrarDashboard();
});

agendaForm?.addEventListener('submit', async (evento) => {
  evento.preventDefault();

  const indice = agendaIndex.value === '' ? -1 : Number(agendaIndex.value);
  const tituloFormulario = obterTituloFormulario();
  const idAutomatico = gerarIdReuniao(agendaData.value, tituloFormulario);
  const reuniao = {
    id: idAutomatico,
    data: agendaData.value,
    titulo: tituloFormulario,
    descricao: agendaDescricao.value.trim(),
    status: agendaStatus.value,
    fotos: normalizarFotos(agendaFotos.value),
    confirmados: reunioes[indice]?.confirmados ?? 0,
  };

  if (!reuniao.id || !reuniao.data || !reuniao.titulo) {
    alert('Preencha data e título.');
    return;
  }

  if (indice >= 0) {
    reunioes[indice] = reuniao;
  } else {
    reunioes.unshift(reuniao);
  }

  salvarAgendaLocal();
  renderizarLista();
  limparFormulario();
  definirModoFormulario('novo');
  fecharEditor();

  const destino = appsScriptUrl?.value?.trim() || DEFAULT_APPS_SCRIPT_URL;
  if (destino) {
    try {
      await sincronizarAppsScript();
      await recarregarAgendaDaPlanilha();
    } catch (erro) {
      console.warn('Não foi possível sincronizar a agenda automaticamente.', erro);
    }
  }
});

btnNovo?.addEventListener('click', () => {
  limparFormulario();
  definirModoFormulario('novo');
  abrirEditor();
});
btnSalvarLocal?.addEventListener('click', () => {
  salvarAgendaLocal();
  alert('Agenda salva no navegador local.');
});
btnExportar?.addEventListener('click', exportarJson);
btnSincronizar?.addEventListener('click', async () => {
  try {
    await sincronizarAppsScript();
    await recarregarAgendaDaPlanilha();
    alert('Agenda sincronizada com sucesso.');
  } catch (erro) {
    console.warn(erro);
    alert('Não foi possível sincronizar agora. Verifique a URL do Apps Script.');
  }
});
btnCancelarEdicao?.addEventListener('click', () => {
  limparFormulario();
  definirModoFormulario('novo');
  fecharEditor();
});
btnFecharEditor?.addEventListener('click', () => {
  limparFormulario();
  definirModoFormulario('novo');
  fecharEditor();
});

agendaTituloPadrao?.addEventListener('change', ajustarTituloCustomizacao);
agendaTituloCustom?.addEventListener('input', () => {
  if (agendaTituloPadrao?.value === '__custom__') {
    return;
  }
});

editorModal?.addEventListener('click', (evento) => {
  if (evento.target === editorModal) {
    limparFormulario();
    definirModoFormulario('novo');
    fecharEditor();
  }
});

importFile?.addEventListener('change', async () => {
  const arquivo = importFile.files?.[0];
  if (!arquivo) {
    return;
  }

  try {
    const texto = await arquivo.text();
    const dados = JSON.parse(texto);
    if (!Array.isArray(dados)) {
      throw new Error('Formato inválido.');
    }

    reunioes = dados;
    salvarAgendaLocal();
    renderizarLista();
    limparFormulario();
  } catch (erro) {
    alert('Não foi possível importar o JSON.');
  }
});

appsScriptUrl.value = localStorage.getItem('tradicao3437_apps_script_url') || DEFAULT_APPS_SCRIPT_URL;
appsScriptUrl.addEventListener('input', () => {
  localStorage.setItem('tradicao3437_apps_script_url', appsScriptUrl.value.trim());
});

if (isAutenticado()) {
  mostrarDashboard();
}

agendaFiltro?.addEventListener('input', (evento) => {
  termoFiltro = evento.target.value;
  renderizarLista();
});

definirModoFormulario('novo');
fecharEditor();
ajustarTituloCustomizacao();

renderizarLista();
atualizarPreview();
atualizarMetricas();

inicializarAgenda();
