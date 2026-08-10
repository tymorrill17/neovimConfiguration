-- CUDA toolkit location + target arch. Override per-project with a .clangd file.
local cuda_path = vim.env.CUDA_PATH or "/usr/local/cuda"
local cuda_arch = "sm_86" -- change to match your GPU (sm_75 Turing, sm_86 Ampere, sm_89 Ada, sm_90 Hopper)

local lsps = {
    {
        "clangd", {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=never",
                "--completion-style=detailed",
                "--offset-encoding=utf-16",
            },
            filetypes = { "c", "cpp", "cuda", "objc", "objcpp" },
            root_markers = {
                ".clangd",
                "compile_commands.json",
                "compile_flags.txt",
                "CMakeLists.txt",
                ".git",
            },
            init_options = {
                -- Only used when there is no compile_commands.json entry for the file.
                fallbackFlags = {
                    "-std=c++17",
                    "--cuda-path=" .. cuda_path,
                    "--cuda-gpu-arch=" .. cuda_arch,
                    "-I" .. cuda_path .. "/include",
                    "-D__CUDACC__",
                    -- silences the "CUDA version is newer than supported" error
                    "-Wno-unknown-cuda-version",
                },
                clangdFileStatus = true,
            },
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
        "slangd", {
            cmd = { 'slangd' },
            filetypes = { 'hlsl', 'shaderslang', 'slang' },
            root_markers = { '.git' },
            settings = {
                slang = {
                    predefinedMacros = { 'MY_VALUE_MACRO=1' },
                    inlayHints = {
                        deducedTypes = true,
                        parameterNames = true,
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
    if config then
        vim.lsp.config(name, config)
    end
    vim.lsp.enable(name)
end
