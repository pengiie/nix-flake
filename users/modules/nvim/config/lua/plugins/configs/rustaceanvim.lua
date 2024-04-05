local constants = dofile("/home/nathan/.config/nvim-constants/constants.lua")

vim.g.rustaceanvim = {
  server = {
    on_attach = function (client, bufnr)
    end,
    default_settings = {
      ["rust-analyzer"] = {
      },
    },
  },
  dap = {
    adapter = require("rustaceanvim.config").get_codelldb_adapter(constants.codelldb_path, constants.liblldb_path),
  }
}
