-- Language Server Protocol
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    -- Go to definition
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { buffer = event.buf })

    -- Return to previous location after going to definition
    vim.api.nvim_set_keymap('n', 'gb', '<C-t>', {})

    -- Go to definition in new tab
    vim.api.nvim_set_keymap('n', 'gdt', '<C-w><C-]><C-w>T', {})

    -- Code completion
    vim.api.nvim_set_keymap('i', '<C-Space>', '<C-x><C-o>', {})

    -- Don't open an empty buffer when triggering autocomplete
    vim.o.completeopt = 'menu'

    -- Show documentation for symbol
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { buffer = event.buf })

    -- Format code
    vim.keymap.set('n', 'F', '<cmd>lua vim.lsp.buf.format()<cr>', { buffer = event.buf })

    -- Rename symbol
    vim.keymap.set('n', '3r', '<cmd>lua vim.lsp.buf.rename()<cr>', { buffer = event.buf })
  end
})

return {
  'neovim/nvim-lspconfig',
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Docker Compose
    vim.lsp.config('docker_compose_language_service', {
      capabilities = capabilities,
    })

    -- HTML
    vim.lsp.config('html', {
      capabilities = capabilities,
    })

    -- Lua
    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = {
              'vim'
            }
          }
        }
      }
    })

    -- Python
    local venv_path = vim.fn.getcwd() .. '/.venv'

    if vim.fn.isdirectory(venv_path) == 1 then
      local python_path = venv_path .. '/bin/python'

      vim.lsp.config('pyright', {
        capabilities = capabilities,
        settings = {
          python = {
            pythonPath = python_path,
            analysis = {
              extraPaths = { './src' },
              autoSearchPaths = true
            }
          }
        }
      })
    else
      vim.lsp.config('pyright', {
        capabilities = capabilities,
      })
    end

    -- Tailwind CSS
    vim.lsp.config('tailwindcss', {
      capabilities = capabilities,
    })

    -- Vue / TypeScript
    vim.lsp.config('volar', {
      capabilities = capabilities,
      filetypes = {
        'typescript',
        'javascript',
        'vue',
      },
      init_options = {
        vue = {
          -- Disable hybrid mode
          hybridMode = false,
        },
      },
    })

    -- Enable language servers
    vim.lsp.enable({
      'docker_compose_language_service',
      'html',
      'lua_ls',
      'pyright',
      'tailwindcss',
      'volar',
    })
  end,
}
