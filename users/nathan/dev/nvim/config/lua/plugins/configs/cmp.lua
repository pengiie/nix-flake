local options = {
  completion = {
    completeopt = "menu,menuone",
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "nvim_lua" },
  },
}

return options
