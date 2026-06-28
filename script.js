const menuToggle = document.querySelector('.menu-toggle');
const menu = document.querySelector('.menu');
const reunioesGrid = document.querySelector('[data-reunioes-grid]');

const seedReunioes = [
  {
    id: 'seed-2026-05-30',
    data: '2026-05-30',
    titulo: 'Sessao de Aprendiz',
    descricao: 'Sessao ordinaria de Aprendiz, com confirmacao aberta para os irmaos.',
    status: 'programada',
    confirmados: 0,
    fotos: [],
  },
  {
    id: 'seed-2026-06-06',
    data: '2026-06-06',
    titulo: 'Sessao Magna de Instalacao e Posse',
    descricao: 'Reuniao especial com a cerimonia de instalacao e posse.',
    status: 'programada',
    confirmados: 0,
    fotos: [],
  },
];

const formatarData = (valor) => {
  if (!valor) return '';

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

const normalizarReuniao = (reuniao) => ({
  ...reuniao,
  confirmados: Number(reuniao.confirmados || reuniao.confirmacoes_count || 0),
  aprendizes: Number(reuniao.aprendizes || 0),
  companheiros: Number(reuniao.companheiros || 0),
  mestres: Number(reuniao.mestres || 0),
  fotos: Array.isArray(reuniao.fotos) ? reuniao.fotos : [],
});

const criarCardReuniao = (reuniaoOriginal) => {
  const reuniao = normalizarReuniao(reuniaoOriginal);
  const status = reuniao.status || 'programada';
  const statusNormalizado = String(status).toLowerCase();
  const rotuloConfirmados = statusNormalizado === 'realizada' ? 'Presenças' : 'Confirmados';
  const fotos = reuniao.fotos.slice(0, 2);
  const resumoGrausHTML = Number(reuniao.confirmados || 0)
    ? `
      <span class="reuniao-resumo-graus">
        <span>A∴M∴: ${Number(reuniao.aprendizes || 0)}</span>
        <span>C∴M∴: ${Number(reuniao.companheiros || 0)}</span>
        <span>M∴M∴: ${Number(reuniao.mestres || 0)}</span>
      </span>
    `
    : '';

  const fotosHTML = fotos.length
    ? `
      <div class="reuniao-fotos">
        <a
          class="reuniao-foto-btn"
          href="${sanitizarTexto(fotos[0])}"
          target="_blank"
          rel="noopener noreferrer"
          aria-label="Abrir foto da sessao ${sanitizarTexto(reuniao.titulo)}"
          title="Abrir foto da sessao"
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
        title="Presenca encerrada para sessoes realizadas"
      >
        Presenca
      </span>
    `
    : `
      <a
        class="reuniao-presenca-btn"
        href="confirmacao/index.html"
        aria-label="Confirmar presenca na sessao ${sanitizarTexto(reuniao.titulo)}"
        title="Confirmar presenca"
      >
        Presenca
      </a>
    `;

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
        <span class="reuniao-meta">${rotuloConfirmados}: ${Number(reuniao.confirmados || 0)}</span>
        ${resumoGrausHTML}
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
  if (!reunioesGrid) return;

  const lojaSupabase = window.getLojaSupabaseClient?.();

  if (!lojaSupabase) {
    reunioesGrid.innerHTML = ordenarPorData(seedReunioes).map(criarCardReuniao).join('');
    return;
  }

  try {
    const [{ data, error }, { data: resumos, error: resumoError }] = await Promise.all([
      lojaSupabase
      .from('reunioes')
        .select('id,data,titulo,descricao,status,fotos')
        .order('data', { ascending: true }),
      lojaSupabase.rpc('get_reuniao_resumos'),
    ]);

    if (error) throw error;
    if (resumoError) {
      console.warn('Nao foi possivel ler o resumo de confirmacoes.', resumoError);
    }

    const resumosPorReuniao = (resumos || []).reduce((accumulator, resumo) => {
      if (resumo.reuniao_id) {
        accumulator.porId[resumo.reuniao_id] = resumo;
      }
      if (resumo.evento_data) {
        accumulator.porData[resumo.evento_data] = resumo;
      }
      return accumulator;
    }, { porId: {}, porData: {} });

    const reunioes = (data || []).map((reuniao) => {
      const resumo = resumosPorReuniao.porId[reuniao.id] || resumosPorReuniao.porData[reuniao.data] || {};

      return {
        ...reuniao,
        confirmados: resumo.total || 0,
        aprendizes: resumo.aprendizes || 0,
        companheiros: resumo.companheiros || 0,
        mestres: resumo.mestres || 0,
      };
    });

    reunioesGrid.innerHTML = reunioes.length
      ? reunioes.map(criarCardReuniao).join('')
      : '<p class="reunioes-vazio">Nenhuma reuniao cadastrada.</p>';
  } catch (erro) {
    console.warn('Nao foi possivel ler a agenda no Supabase.', erro);
    reunioesGrid.innerHTML = '<p class="reunioes-vazio">Agenda indisponivel no momento.</p>';
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

