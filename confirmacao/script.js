const APPS_SCRIPT_URL =
  'https://script.google.com/macros/s/AKfycbzJqBotGpzkooB01roAMtHHg_a-NWtzi_Dnz2qcNW26y8FPxWva7Bs4dXTU2t7UOt9V/exec';

const agendaEndpoint = `${APPS_SCRIPT_URL}?action=agenda`;

const eventoSelect = document.getElementById('evento');
const form = document.getElementById('formConfirmacao');
const telefone = document.getElementById('telefone');
const botaoEnviar = document.getElementById('botaoEnviar');
const modal = document.getElementById('modalConfirmacao');
const mensagemConfirmacao = document.getElementById('mensagemConfirmacao');
const fecharModal = document.getElementById('fecharModal');

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

const escaparHTML = (texto) => {
  const elemento = document.createElement('div');
  elemento.textContent = texto ?? '';
  return elemento.innerHTML;
};

const preencherEventos = (agenda) => {
  if (!eventoSelect) {
    return false;
  }

  eventoSelect.innerHTML = '';

  const placeholder = document.createElement('option');
  placeholder.value = '';
  placeholder.disabled = true;
  placeholder.selected = true;
  placeholder.textContent = 'Selecione o Dia de Sess.:';
  eventoSelect.appendChild(placeholder);

  if (!Array.isArray(agenda) || !agenda.length) {
    const vazio = document.createElement('option');
    vazio.value = '';
    vazio.disabled = true;
    vazio.textContent = 'Nenhuma sessão cadastrada na planilha';
    eventoSelect.appendChild(vazio);
    return false;
  }

  agenda.forEach((reuniao) => {
    const data = String(reuniao.data || reuniao.id || '').slice(0, 10);
    const option = document.createElement('option');
    option.value = data;
    option.textContent = `${formatarData(data)} - ${reuniao.titulo || ''}`;
    option.dataset.data = data;
    option.dataset.eventoTitulo = reuniao.titulo || '';
    option.dataset.label = reuniao.titulo || '';
    eventoSelect.appendChild(option);
  });

  return true;
};

const carregarEventos = async () => {
  if (!eventoSelect) {
    return;
  }

  try {
    const resposta = await fetch(agendaEndpoint, { cache: 'no-store' });
    if (!resposta.ok) {
      throw new Error('Falha ao carregar a agenda.');
    }

    const reunioes = await resposta.json();
    preencherEventos(reunioes);
  } catch (erro) {
    console.warn('Não foi possível ler a agenda na planilha.', erro);
    preencherEventos([]);
  }
};

telefone?.addEventListener('input', (evento) => {
  let valor = evento.target.value.replace(/\D/g, '');

  valor = valor.replace(/^(\d{2})(\d)/g, '($1) $2');
  valor = valor.replace(/(\d{1})(\d{4})(\d{4})$/, '$1.$2-$3');

  evento.target.value = valor;
});

form?.addEventListener('submit', async (evento) => {
  evento.preventDefault();

  const eventoOption = eventoSelect?.selectedOptions?.[0];
  const eventoData = eventoOption?.dataset?.data || eventoSelect?.value || '';
  const eventoTitulo = eventoOption?.dataset?.eventoTitulo || eventoOption?.dataset?.label || '';
  const eventoLabel = eventoOption?.textContent || '';
  const potencia = document.getElementById('potencia').value;
  const tituloIrmao = document.getElementById('titulo').value;
  const nomeIrmao = document.getElementById('nome').value.trim();
  const numeroLoja = document.getElementById('numeroLoja').value.trim();
  const nomeLoja = document.getElementById('nomeLoja').value.trim();
  const telefoneIrmao = document.getElementById('telefone').value;
  const nomeCompleto = `${tituloIrmao} ${nomeIrmao}`.trim();

  const dados = {
    evento: eventoLabel,
    eventoData,
    eventoTitulo,
    eventoLabel,
    potencia,
    titulo: tituloIrmao,
    nome: nomeIrmao,
    nomeCompleto,
    numeroLoja,
    nomeLoja,
    telefone: telefoneIrmao,
  };

  try {
    botaoEnviar.disabled = true;
    botaoEnviar.innerText = 'Enviando...';

    await fetch(APPS_SCRIPT_URL, {
      method: 'POST',
      body: JSON.stringify(dados),
    });

    const nomeCompletoSeguro = escaparHTML(nomeCompleto);
    const eventoLabelSeguro = escaparHTML(eventoLabel);

    mensagemConfirmacao.innerHTML =
      `Confirmação enviada com sucesso!<br><br>` +
      `Aguardamos o Ir∴ <strong>${nomeCompletoSeguro}</strong><br>` +
      `para a reunião:<br><br>` +
      `<strong>${eventoLabelSeguro}</strong><br><br>` +
      `Local da Sess∴:<br>` +
      `Rua Segundo Tenente Aluisio de Faria, Nº 193<br>` +
      `Jardim Santa Mena – Guarulhos – SP`;

    modal.style.display = 'flex';
    form.reset();
  } catch (erro) {
    alert('Não foi possível enviar a confirmação. Verifique sua conexão ou o Apps Script.');
  } finally {
    botaoEnviar.disabled = false;
    botaoEnviar.innerText = 'Enviar Confirmação';
  }
});

fecharModal?.addEventListener('click', () => {
  modal.style.display = 'none';
});

modal?.addEventListener('click', (evento) => {
  if (evento.target === modal) {
    modal.style.display = 'none';
  }
});

carregarEventos();
