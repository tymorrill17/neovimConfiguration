return {
  "igorlfs/nvim-dap-view",
  -- let the plugin lazy load itself
  lazy = false,
  version = "1.*",
  dependencies = { "mfussenegger/nvim-dap" },
  opts = function()
    return require("myconfig.configs.nvim-dap-view")
  end,
}
