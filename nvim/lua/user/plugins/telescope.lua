return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope-fzf-native.nvim',
  },
  keys = {
    { 'ff', function() require('telescope.builtin').find_files() end },
    { 'bb', function() require('telescope.builtin').find_buffers() end },
  },
  opts = {
    defaults =  {
      mappings =  {
        i =  {
          ['<CR>'] =  function(bufnr)
            require('telescope.actions.set').edit(bufnr, 'tab drop')
          end,
        }
      },
      file_ignore_patterns =  {
        'node_modules',
        '__pycache__'
      }
    }
  }
}
