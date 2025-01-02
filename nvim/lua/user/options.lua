vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmode = 'longest:full,full' -- Complete the longest common match, and allow tabbing the results to fully complete them

vim.opt.title = true

vim.opt.mouse = 'a' -- Enable mouse for all modes

vim.opt.termguicolors = true

vim.opt.spell = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.list = true -- Enable the below list of characters
vim.opt.listchars = { tab = '▸ ', trail = '·', nbsp = '␣' } 
vim.opt.fillchars:append({ eob = ' '}) -- Remove the ~ from end of buffer

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.confirm = true -- Ask for confirmation instead of show error message

vim.opt.undofile = true -- Persist undo
vim.opt.backup = true -- Automatically save a backup file
vim.opt.backupdir:remove('.') -- Keep backups out of the current directory

