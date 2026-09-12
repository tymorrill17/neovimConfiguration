return {
  "mfussenegger/nvim-dap",
  event = { "VeryLazy" },
  lazy = false,
  config = function()
    require("myconfig.configs.nvim-dap")
  end,
}
