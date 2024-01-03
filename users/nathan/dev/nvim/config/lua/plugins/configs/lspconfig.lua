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

local lspconfig = require("lspconfig")
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      all_features = true,
    },
  },
}

lspconfig.nixd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "nix" },
}

lspconfig.wgsl_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "wgsl" },
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "htmldjango", "css", "scss" },
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "lua" },
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            -- library = {
            --   vim.env.VIMRUNTIME
            --   -- "${3rd}/luv/library"
            --   -- "${3rd}/busted/library",
            -- }
            library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
}

lspconfig.htmx.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "htmldjango" },
}

lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "htmldjango" },
}
