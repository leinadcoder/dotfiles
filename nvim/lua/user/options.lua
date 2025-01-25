vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.smartindent = true

vim.opt.swapfile = false

vim.opt.wrap = false
vim.opt.breakindent = true

-- Highlight column 81
vim.opt.colorcolumn = '81'

vim.opt.number = true
vim.opt.relativenumber = true

-- Complete the longest common match, and allow tabbing the results to fully complete them
vim.opt.wildmode = 'longest:full,full'

vim.opt.title = true

-- Enable mouse for all modes
vim.opt.mouse = 'a'

vim.opt.termguicolors = true

-- Spell checking
vim.opt.spell = false
vim.opt.spelllang = {'en_us'}
vim.api.nvim_create_autocmd(
  {
    'BufEnter',
    'BufWinEnter'
  },
  {
    pattern =  {
      '*.md',
    },
    command = [[:setlocal spell]]
  }
)

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enabled the below list of characters
vim.opt.listchars = { tab = '▸ ', trail = '·', nbsp = '␣' }
vim.opt.list = true

-- Remove the ~ from the end of the buffer
vim.opt.fillchars:append({ eob = ' '})

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Ask for confirmation instead of show error message
vim.opt.confirm = true

-- Persist undo
vim.opt.undofile = true

-- Automatically save a backup file
vim.opt.backup = true

-- Keep backups out of the current directory
vim.opt.backupdir:remove('.')

