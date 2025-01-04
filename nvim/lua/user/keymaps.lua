-- Space as a leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Paste replace visual selection without copying it
vim.keymap.set('v', 'p', '"_dp')

-- Quickly clear search highlighting
vim.keymap.set('n', '<leader>k', ':nohlsearch<CR>')

-- Easy insertion of a trailing ; or , from insert mode
vim.keymap.set('i', '<leader>;', '<Esc>A;')
vim.keymap.set('i', '<leader>,', '<Esc>A,')

-- Move lines up and down
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv=gv")
vim.keymap.set('n', '<A-j>', ':move .+1<CR>')
vim.keymap.set('n', '<A-k>', ':move .-2<CR>')

