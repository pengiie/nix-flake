local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, 'Rename')
  nmap("<leader>ca", vim.lsp.buf.code_action, 'Code action')

  nmap("gd", vim.lsp.buf.definition, 'Go to definition')
  nmap("gr", vim.lsp.buf.references, 'Go to references')

  nmap("K", vim.lsp.buf.hover, 'Hover')
  nmap("<C-k>", vim.lsp.buf.signature_help, 'Signature help')

  nmap("<leader>fm", function()
    vim.lsp.buf.format()
  end, 'Format')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require("lspconfig").rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      all_features = true,
    },
  },
}
