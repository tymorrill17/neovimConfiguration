return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>pf', builtin.find_files) -- Fuzzy find working files
        vim.keymap.set('n', '<leader>pg', builtin.live_grep) -- Open a menu to grep all files for what you type
    end
}
