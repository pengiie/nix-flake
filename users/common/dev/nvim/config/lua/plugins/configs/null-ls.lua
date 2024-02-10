local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

return {
  sources = {
    formatting.stylua,
    formatting.rustywind,
  }
}
