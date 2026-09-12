return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = function()
    return require("myconfig.configs.indent-blankline")
  end,
}
