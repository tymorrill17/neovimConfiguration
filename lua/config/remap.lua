
-- Mapleaders
vim.g.mapleader = " "
vim.g.maplocalleader = " " -- not sure what localleaders are used for but this might be a good alt: "\\"

-- Easier save and quit
vim.keymap.set('n','<leader>w',':write<CR>')
vim.keymap.set('n','<leader>q',':quit<CR>')

-- Set space and C-space to search forwards and backwards
vim.keymap.set('n','<leader><leader>','/')

-- Easier way of moving between windows
vim.keymap.set('n','<C-j>','<C-w>j')
vim.keymap.set('n','<C-k>','<C-w>k')
vim.keymap.set('n','<C-h>','<C-w>h')
vim.keymap.set('n','<C-l>','<C-w>l')

-- remove highlights
vim.keymap.set('n','<leader><CR>',':noh<CR>')

-- Open the file explorer
vim.keymap.set('n','<leader>pl',vim.cmd.Ex)

-- Move selected up or down lines
vim.keymap.set('v','J',":m '>+1<CR>gv=gv")
vim.keymap.set('v','K',":m '<-2<CR>gv=gv")

-- Keep cursor in the middle when:
vim.keymap.set('n','<C-d>','<C-d>zz') -- page down
vim.keymap.set('n','<C-u>','<C-u>zz') -- page up
vim.keymap.set('n','n','nzzzv') -- next word in search
vim.keymap.set('n','N','Nzzzv') -- prev word in search

vim.keymap.set('n','J',"mzJ`z") -- Keeps cursor where it's at when using J

-- Paste and replace without overwriting buffer
vim.keymap.set('x','<leader>p',"\"_dP")

-- unmap Q
vim.keymap.set('n','Q','<nop>')

-- One way to make replacing better:
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- replace the word at the cursor

-- temporary binds --
vim.keymap.set('n','<leader>o',':update<CR> :source<CR>')
-- Temporary disabling of arrow keys to move
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
-- temporary binds --







