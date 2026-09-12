return {
  cmd = { "slangd" },
  filetypes = { "hlsl", "shaderslang", "slang" },
  root_markers = { ".git" },
  settings = {
    slang = {
      predefinedMacros = { "MY_VALUE_MACRO=1" },
      inlayHints = {
        deducedTypes = true,
        parameterNames = true,
      },
    },
  },
}
