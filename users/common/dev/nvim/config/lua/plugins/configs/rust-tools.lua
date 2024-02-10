local constants = dofile("/home/nathan/.config/nvim-constants/constants.lua")

local options = {
  server = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          autoReload = true,
        },
      },
    },
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(constants.codelldb_path, constants.liblldb_path),
    }
  },
}

return options
