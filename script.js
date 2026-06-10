/* =========================================================
   SCRIPT PRINCIPAL - SITE INSTITUCIONAL 3437
   ---------------------------------------------------------
   Controla o menu mobile e popula o calendário a partir de
   um arquivo de dados centralizado.
   ========================================================= */

const menuToggle = document.querySelector('.menu-toggle');
const menu = document.querySelector('.menu');
const reunioesGrid = document.querySelector('[data-reunioes-grid]');
const agendaEndpoint =
  'https://script.google.com/macros/s/AKfycbzJqBotGpzkooB01roAMtHHg_a-NWtzi_Dnz2qcNW26y8FPxWva7Bs4dXTU2t7UOt9V/exec?action=agenda';

const formatarData = (valor) => {
  if (!valor) {
    return '';
  }

  const data = new Date(`${valor}T12:00:00`);

  return new Intl.DateTimeFormat('pt-BR', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
  }).format(data);
};

const ordenarPorData = (reunioes) =>
  [...reunioes].sort((a, b) => {
    const dataA = a?.data ? new Date(`${a.data}T12:00:00`).getTime() : Number.POSITIVE_INFINITY;
    const dataB = b?.data ? new Date(`${b.data}T12:00:00`).getTime() : Number.POSITIVE_INFINITY;
    return dataA - dataB;
  });

const sanitizarTexto = (texto) => {
  const elemento = document.createElement('div');
  elemento.textContent = texto ?? '';
  return elemento.innerHTML;
};

const cameraIconeHTML = `
  <svg viewBox="0 0 24 24" aria-hidden="true" focusable="false">
    <path d="M9 4.5 7.6 6.6H4.5A2.5 2.5 0 0 0 2 9.1v7.4A2.5 2.5 0 0 0 4.5 19h15a2.5 2.5 0 0 0 2.5-2.5V9.1a2.5 2.5 0 0 0-2.5-2.5h-3.1L15 4.5H9Zm3 11.8A4.3 4.3 0 1 1 12 7a4.3 4.3 0 0 1 0 9.3Zm0-2.1A2.2 2.2 0 1 0 12 9.9a2.2 2.2 0 0 0 0 4.3Z"/>
  </svg>
`;

const criarCardReuniao = (reuniao) => {
  const status = reuniao.status || 'programada';
  const statusNormalizado = String(status).toLowerCase();
  const fotos = Array.isArray(reuniao.fotos) ? reuniao.fotos.slice(0, 2) : [];
  const confirmados = Number.isFinite(Number(reuniao.confirmados))
    ? Number(reuniao.confirmados)
    : null;

  const fotosHTML = fotos.length
    ? `
      <div class="reuniao-fotos">
        <a
          class="reuniao-foto-btn"
          href="${sanitizarTexto(fotos[0])}"
          target="_blank"
          rel="noopener noreferrer"
          aria-label="Abrir foto da sessão ${sanitizarTexto(reuniao.titulo)}"
          title="Abrir foto da sessão"
        >
          ${cameraIconeHTML}
        </a>
      </div>
    `
    : `
      <div class="reuniao-fotos">
        <span class="reuniao-foto-btn reuniao-foto-btn--vazio" aria-hidden="true">
          ${cameraIconeHTML}
        </span>
      </div>
    `;

  const presencaHTML = statusNormalizado === 'realizada'
    ? `
      <span
        class="reuniao-presenca-btn reuniao-presenca-btn--desativado"
        aria-disabled="true"
        title="Presença encerrada para sessões realizadas"
      >
        Presença
      </span>
    `
    : `
      <a
        class="reuniao-presenca-btn"
        href="confirmacao/index.html"
        aria-label="Confirmar presença na sessão ${sanitizarTexto(reuniao.titulo)}"
        title="Confirmar presença"
      >
        Presença
      </a>
    `;

  const confirmadosHTML = confirmados === null
    ? '<span class="reuniao-meta">Confirmações: em atualização</span>'
    : `<span class="reuniao-meta">Confirmações: ${confirmados}</span>`;

  return `
    <article class="reuniao-card reuniao-card--${sanitizarTexto(status)}">
      <div class="reuniao-col reuniao-col--data">
        <strong>${sanitizarTexto(formatarData(reuniao.data))}</strong>
      </div>
      <div class="reuniao-col reuniao-col--sessao">
        <span class="reuniao-titulo">${sanitizarTexto(reuniao.titulo)}</span>
      </div>
      <div class="reuniao-col reuniao-col--descricao">
        <p>${sanitizarTexto(reuniao.descricao || '')}</p>
      </div>
      <div class="reuniao-col reuniao-col--confirmados">
        ${confirmadosHTML}
      </div>
      <div class="reuniao-col reuniao-col--status">
        <span class="reuniao-status">${sanitizarTexto(status)}</span>
      </div>
      <div class="reuniao-col reuniao-col--fotos">
        ${fotosHTML}
      </div>
      <div class="reuniao-col reuniao-col--presenca">
        ${presencaHTML}
      </div>
    </article>
  `;
};

const carregarReunioes = async () => {
  if (!reunioesGrid) {
    return;
  }

  try {
    const resposta = await fetch(agendaEndpoint, { cache: 'no-store' });
    if (!resposta.ok) {
      throw new Error('Falha ao carregar as reuniões.');
    }

    const reunioes = await resposta.json();
    if (!Array.isArray(reunioes) || !reunioes.length) {
      reunioesGrid.innerHTML = '<p class="reunioes-vazio">Nenhuma reunião cadastrada na planilha.</p>';
      return;
    }

    reunioesGrid.innerHTML = ordenarPorData(reunioes).map(criarCardReuniao).join('');
    return;
  } catch (erro) {
    console.warn('Não foi possível ler a agenda na planilha.', erro);
    reunioesGrid.innerHTML = '<p class="reunioes-vazio">Agenda indisponível no momento.</p>';
  }
};

if (menuToggle && menu) {
  menuToggle.addEventListener('click', () => {
    const isOpen = menu.classList.toggle('is-open');
    menuToggle.setAttribute('aria-expanded', String(isOpen));
  });

  menu.querySelectorAll('a').forEach((link) => {
    link.addEventListener('click', () => {
      menu.classList.remove('is-open');
      menuToggle.setAttribute('aria-expanded', 'false');
    });
  });
}

carregarReunioes();

console.log('Site institucional da Loja 3437 - V3 carregado com sucesso.');
