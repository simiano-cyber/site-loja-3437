/* =========================================================
   SCRIPT PRINCIPAL - SITE INSTITUCIONAL 3437
   ---------------------------------------------------------
   Responsável pelo comportamento do menu mobile.
   Mantém o JavaScript separado do HTML, seguindo a boa
   organização presente na V1.
   ========================================================= */

// Seleciona o botão do menu mobile e o bloco de links do menu.
const menuToggle = document.querySelector('.menu-toggle');
const menu = document.querySelector('.menu');

// Só executa se os elementos existirem na página.
if (menuToggle && menu) {
  menuToggle.addEventListener('click', () => {
    const isOpen = menu.classList.toggle('is-open');
    menuToggle.setAttribute('aria-expanded', String(isOpen));
  });

  // Fecha o menu automaticamente ao clicar em qualquer link.
  menu.querySelectorAll('a').forEach((link) => {
    link.addEventListener('click', () => {
      menu.classList.remove('is-open');
      menuToggle.setAttribute('aria-expanded', 'false');
    });
  });
}

console.log('Site institucional da Loja 3437 - V3 carregado com sucesso.');
