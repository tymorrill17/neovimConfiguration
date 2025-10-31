return {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
	    local builtin = require('telescope.builtin')

	    vim.keymap.set('n', '<leader>pf', builtin.find_files) -- Fuzzy find working files
	    vim.keymap.set('n', '<leader>pg', builtin.live_grep) -- Open a menu to grep all files for what you type
    end
}
