const eventoSelect = document.getElementById('evento');
const form = document.getElementById('formConfirmacao');
const telefone = document.getElementById('telefone');
const botaoEnviar = document.getElementById('botaoEnviar');
const modal = document.getElementById('modalConfirmacao');
const mensagemConfirmacao = document.getElementById('mensagemConfirmacao');
const fecharModal = document.getElementById('fecharModal');

const formatarData = (valor) => {
  if (!valor) return '';

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
  if (!eventoSelect) return false;

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
    vazio.textContent = 'Nenhuma sessao cadastrada';
    eventoSelect.appendChild(vazio);
    return false;
  }

  agenda.forEach((reuniao) => {
    const option = document.createElement('option');
    option.value = reuniao.id;
    option.textContent = `${formatarData(reuniao.data)} - ${reuniao.titulo || ''}`;
    option.dataset.id = reuniao.id;
    option.dataset.data = reuniao.data || '';
    option.dataset.eventoTitulo = reuniao.titulo || '';
    option.dataset.label = option.textContent;
    eventoSelect.appendChild(option);
  });

  return true;
};

const carregarEventos = async () => {
  if (!eventoSelect) return;

  const supabase = window.getLojaSupabaseClient?.();

  if (!supabase) {
    preencherEventos([]);
    return;
  }

  try {
    const { data, error } = await supabase
      .from('reunioes')
      .select('id,data,titulo,status')
      .neq('status', 'realizada')
      .order('data', { ascending: true });

    if (error) throw error;
    preencherEventos(data || []);
  } catch (erro) {
    console.warn('Nao foi possivel ler a agenda no Supabase.', erro);
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

  const supabase = window.getLojaSupabaseClient?.();

  if (!supabase) {
    alert('Supabase ainda nao configurado. Preencha o arquivo supabase-config.js.');
    return;
  }

  const eventoOption = eventoSelect?.selectedOptions?.[0];
  const eventoData = eventoOption?.dataset?.data || '';
  const eventoTitulo = eventoOption?.dataset?.eventoTitulo || '';
  const eventoLabel = eventoOption?.dataset?.label || eventoOption?.textContent || '';
  const potencia = document.getElementById('potencia').value;
  const tituloIrmao = document.getElementById('titulo').value;
  const nomeIrmao = document.getElementById('nome').value.trim();
  const numeroLoja = document.getElementById('numeroLoja').value.trim();
  const nomeLoja = document.getElementById('nomeLoja').value.trim();
  const telefoneIrmao = document.getElementById('telefone').value;
  const nomeCompleto = `${tituloIrmao} ${nomeIrmao}`.trim();

  const dados = {
    reuniao_id: eventoOption?.dataset?.id || null,
    evento_data: eventoData || null,
    evento_titulo: eventoTitulo,
    evento_label: eventoLabel,
    potencia,
    titulo: tituloIrmao,
    nome: nomeIrmao,
    nome_completo: nomeCompleto,
    numero_loja: numeroLoja,
    nome_loja: nomeLoja,
    telefone: telefoneIrmao,
  };

  try {
    botaoEnviar.disabled = true;
    botaoEnviar.innerText = 'Enviando...';

    const { error } = await supabase.from('confirmacoes_presenca').insert(dados);
    if (error) throw error;

    mensagemConfirmacao.innerHTML =
      `Confirmacao enviada com sucesso!<br><br>` +
      `Aguardamos o Ir. <strong>${escaparHTML(nomeCompleto)}</strong><br>` +
      `para a reuniao:<br><br>` +
      `<strong>${escaparHTML(eventoLabel)}</strong><br><br>` +
      `Local da Sess.:<br>` +
      `Rua Segundo Tenente Aluisio de Faria, No 193<br>` +
      `Jardim Santa Mena - Guarulhos - SP`;

    modal.style.display = 'flex';
    form.reset();
  } catch (erro) {
    console.warn(erro);
    alert('Nao foi possivel enviar a confirmacao. Verifique sua conexao ou a configuracao do Supabase.');
  } finally {
    botaoEnviar.disabled = false;
    botaoEnviar.innerText = 'Enviar Confirmacao';
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
