-- CUDA toolkit location + target arch. Override per-project with a .clangd file.
local cuda_path = vim.env.CUDA_PATH or "/usr/local/cuda"
local cuda_arch = "sm_86" -- change to match your GPU (sm_75 Turing, sm_86 Ampere, sm_89 Ada, sm_90 Hopper)

-----------------------------
-- LSPs INITIALIZATION
-----------------------------
-- default (i.e., inherited by all) LSP config
vim.lsp.config("*", {
  -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
  root_markers = { ".git" },
  on_error = function(code, err)
    local err_msg = vim.lsp.rpc.client_errors[code] .. err
    vim.lsp.log.error(err_msg)
    vim.notify(err_msg, vim.log.levels.ERROR)
  end,
})
-- enable virtual lines and disable virtual text diagnostics
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = true,
})
-- enable inlay hints
vim.lsp.inlay_hint.enable(true)
-- add LSPs to ignore here (same name as in ./lsps/ folder without the .lua extension)
local lsp_ignore = {}
-- load LSPs defined in ./lsps/ folder
local p = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "lsps")
for lsp_name, _ in vim.fs.dir(p) do
  local status_ok, error_object = pcall(function()
    local lsp_id = lsp_name:gsub("%.lua", "")
    if lsp_ignore[lsp_id] == nil then
      local lsp_config = require("lsps." .. lsp_id)
      vim.lsp.config(lsp_id, lsp_config)
      vim.lsp.enable(lsp_id)
    end
  end)
  if not status_ok then
    vim.notify(
      "failed to load LSP: " .. lsp_name .. "\n\n" .. "Reason: " .. error_object,
      vim.log.levels.ERROR
    )
  end
end
