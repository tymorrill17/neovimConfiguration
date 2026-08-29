-- Roslyn-specific handlers and settings, split out of lsp.lua because they are
-- code rather than plain config. Consumed by the "roslyn_ls" entry in lsp.lua.
--
-- Roslyn LS method names come from:
-- https://github.com/dotnet/roslyn/tree/main/src/LanguageServer/Protocol

local M = {}

-- Each handler corresponds to a request Roslyn may send us. Without them the
-- client answers MethodNotFound, which can stall project loading.
M.handlers = {
    -- Loading a Unity solution takes a while, and buffers opened before that
    -- finishes never get diagnostics. Pull them once the projects are ready.
    ["workspace/projectInitializationComplete"] = function(_, _, ctx)
        vim.notify("[C#] Roslyn project initialization complete", vim.log.levels.INFO)

        local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
        local method = vim.lsp.protocol.Methods.textDocument_diagnostic

        for _, buf in ipairs(vim.lsp.get_buffers_by_client_id(ctx.client_id)) do
            local ok = client:request(method, {
                textDocument = vim.lsp.util.make_text_document_params(buf),
            }, nil, buf)
            if not ok then
                vim.notify(
                    string.format("[C#] diagnostic request failed for %s",
                        vim.api.nvim_buf_get_name(buf)),
                    vim.log.levels.ERROR
                )
            end
        end
    end,

    -- Older Roslyn versions ask the client to restore; ask the server to run
    -- `dotnet restore` itself rather than shelling out here.
    ["workspace/_roslyn_projectNeedsRestore"] = function(_, result, ctx)
        local client = assert(vim.lsp.get_client_by_id(ctx.client_id))

        client:request("workspace/_roslyn_restore", result, function(err, response)
            if err then
                vim.notify(err.message, vim.log.levels.ERROR)
                vim.lsp.log.error(err.message)
                return
            end
            local failed = false
            for _, v in ipairs(response or {}) do
                -- errors are reported inside the message string
                if v.message:find("error%s*MSB%d%d%d%d") then
                    vim.lsp.log.warn(v.message)
                    vim.notify(v.message, vim.log.levels.WARN)
                    failed = true
                end
            end
            if not failed then
                vim.notify("[C#] dotnet restore completed", vim.log.levels.INFO)
            end
        end)

        return vim.NIL
    end,

    ["workspace/_roslyn_projectHasUnresolvedDependencies"] = function()
        vim.notify(
            "[C#] missing dependencies - run `dotnet restore`, or regenerate "
                .. "project files from Unity",
            vim.log.levels.ERROR
        )
        return vim.NIL
    end,
}

M.settings = {
    ["csharp|background_analysis"] = {
        -- "fullSolution" tanks performance on a Unity-sized solution:
        -- https://github.com/dotnet/vscode-csharp/issues/8145
        ---@type "openFiles" | "fullSolution" | "none"
        dotnet_analyzer_diagnostics_scope = "openFiles",
        ---@type "openFiles" | "fullSolution" | "none"
        dotnet_compiler_diagnostics_scope = "openFiles",
    },
    ["csharp|navigation"] = {
        -- Unity ships DLLs without source, so go-to-definition on UnityEngine
        -- types is useless unless Roslyn decompiles them.
        dotnet_navigate_to_decompiled_sources = true,
        dotnet_navigate_to_source_link_and_embedded_sources = true,
    },
    ["csharp|symbol_search"] = {
        dotnet_search_reference_assemblies = true,
    },
    ["csharp|completion"] = {
        dotnet_show_name_completion_suggestions = true,
        dotnet_trigger_completion_in_argument_lists = true,
        -- off on purpose: too slow across the whole Unity assembly set
        dotnet_show_completion_items_from_unimported_namespaces = false,
    },
    ["csharp|code_lens"] = {
        dotnet_enable_references_code_lens = true,
        dotnet_enable_tests_code_lens = true,
    },
    ["csharp|projects"] = {
        dotnet_enable_automatic_restore = true,
    },
}

return M
