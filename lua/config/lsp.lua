local lsps = {
    {
        "clangd", {
            init_options = {
                ---fallbackFlags = {'--std=c++23'}
            },
            cmd = { "clangd" },
            filetypes = { "cpp", "c"},
            root_markers = { ".clangd" },
        }
    },
    {
        "lua_ls", {
            cmd = { "lua-language-server" },
            filetypes = { "lua" },
            root_markers = { "init.lua" },
        }
    },
    {
        "ols", {
            cmd = { "ols" },
            filetypes = { "odin" },
            root_markers = { "ols.json" },
        }
    },
    {
        "pyright", {
            cmd = { "pyright-langserver", "--stdio" },
            filetypes = { "python" },
            root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "openFilesOnly",
                        typeCheckingMode = "basic",
                    },
                },
            },
        }
    },
    {
        "tsserver", {}
    },
    {
        "vscode-html-language-server", {}
    },
    {
        "vscode-css-language-server", {}
    },
    ---{
    ---    "jdtls"
    ---}
}

for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end
