window.LOJA_SUPABASE = {
  url: 'https://thfkdhcwfyallwrdjqwb.supabase.co',
  anonKey: 'sb_publishable_fXQK1kLKEX91SV59jr6YIQ_Xhg-wFn_',
};

window.getLojaSupabaseClient = function getLojaSupabaseClient() {
  const config = window.LOJA_SUPABASE || {};

  if (!config.url || !config.anonKey || !window.supabase) {
    return null;
  }

  if (!window.__lojaSupabaseClient) {
    window.__lojaSupabaseClient = window.supabase.createClient(config.url, config.anonKey);
  }

  return window.__lojaSupabaseClient;
};
