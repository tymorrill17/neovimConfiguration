return {
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
    { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
    { "vague2k/vague.nvim", lazy = false, priority = 1000 },
    { 'maxmx03/solarized.nvim', lazy = false, priority = 1000,
        ---@type solarized.config
        config = function()
            vim.o.termguicolors = true
            vim.o.background = 'light'
            -- default config
            require('solarized').setup({
                transparent = {
                    enabled = false,
                --     pmenu = true,
                --     normal = true,
                --     normalfloat = true,
                --     neotree = true,
                --     nvimtree = true,
                --     whichkey = true,
                --     telescope = true,
                --     lazy = true,
                },
                on_highlights = nil,
                on_colors = nil,
                palette = 'solarized', -- solarized (default) | selenized
                variant = 'winter', -- "spring" | "summer" | "autumn" | "winter" (default)
                -- error_lens = {
                --     text = false,
                --     symbol = false,
                -- },
                -- styles = {
                --     enabled = true,
                --     types = {},
                --     functions = {},
                --     parameters = {},
                --     comments = {},
                --     strings = {},
                --     keywords = {},
                --     variables = {},
                --     constants = {},
                -- },
                plugins = {
                    treesitter = true,
                    cmp = true,
                    telescope = true,
                    lazy = true,
                },
            })
        end,
    },
    { "bettervim/yugen.nvim", lazy = false, priority = 1000 },
    { "shaunsingh/nord.nvim", lazy = false, priority = 1000 },
    { "rebelot/kanagawa.nvim", lazy = false, priority = 1000,
        config = function ()
            -- Default options:
            require('kanagawa').setup({
                compile = false,             -- enable compiling the colorscheme
                undercurl = true,            -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true},
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false,         -- do not set background color
                dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
                terminalColors = true,       -- define vim.g.terminal_color_{0,17}
                colors = {                   -- add/modify theme and palette colors
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function(colors) -- add/modify highlights
                    return {}
                end,
                theme = "wave",              -- Load "wave" theme
                background = {               -- map the value of 'background' option to a theme
                    dark = "wave",           -- try "dragon" !
                    light = "lotus"
                },
            })
        end
    },
    { "ellisonleao/gruvbox.nvim", priority = 1000,
        config = function ()
            -- Default options:
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    emphasis = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
        end
    },
    { "savq/melange-nvim", lazy = false, priority = 1000 }
}
