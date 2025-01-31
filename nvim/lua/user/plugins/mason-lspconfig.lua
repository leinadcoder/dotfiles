return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
    require("mason-lspconfig").setup {
      ensure_installed = {
        'docker_compose_language_service',
        'lua_ls',
        'pyright',
        'tailwindcss',
        'volar'
      }
    }
  end
}
