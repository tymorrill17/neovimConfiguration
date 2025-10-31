

-- Enable relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync the OS and neovim clipboard
vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

-- Don't show the mode
-- vim.o.showmode = false

-- Breakindent means that line breaks will start at the indentation the line is at
vim.o.breakindent = true
vim.o.breakindentopt = 'shift:2,sbr' -- shift the linebreak 2 characters show the showbreak
vim.o.showbreak = '>>' -- prepended to the beginning of a linebreak
vim.o.wrap = false -- Try turning wrapping off

-- Save undo history between instances of nvim
vim.o.undofile = true

-- Case-insensitive searching unless \C or one or more capital letters are in the search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Signcolumn (where breakpoints, etc go) on by default
vim.o.signcolumn = 'auto'

-- disable swapfiles and use undo files instead
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath('data') .. '\\undodir'
vim.o.undofile = true

-- highlight and incremental search
vim.o.hlsearch = true
vim.o.incsearch = true

-- Decrease the timeout length for a mapped sequence
vim.o.timeoutlen = 500

-- How should new splits be opened?
vim.o.splitright = true
vim.o.splitbelow = true

-- Neovim can choose to show certain characters for certain whitespace characters
-- vim.o.list = true
-- vim.opt.listchars = { tab = '| ', trail = '·', nbsp = '␣' }

-- For the substitution command, preview the substitutions while typing
vim.o.inccommand = 'split'

-- Number of lines to keep above and below the cursor
vim.o.scrolloff = 10

-- Request a confirm dialogue to save the file when quitting
vim.o.confirm = true

-- Show which line cursor is at
-- vim.o.cursorline = true

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- optionally enable 24-bit colour
vim.opt.termguicolors = true
-- vim.o.background = 'light'

vim.o.signcolumn = 'yes'

-- All about tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.smartindent = true

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = {'*'},
    callback = function()
      local save_cursor = vim.fn.getpos('.')
      pcall(function() vim.cmd [[%s/\s\+$//e]] end)
      vim.fn.setpos('.', save_cursor)
    end,
})

vim.cmd([[colorscheme vague]])

vim.opt.completeopt = { "menuone", "noselect", "popup" }

