local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require("lspconfig")
lspconfig.nixd.setup {
  capabilities = capabilities,
  filetypes = { "nix" },
}

lspconfig.wgsl_analyzer.setup {
  capabilities = capabilities,
  filetypes = { "wgsl" },
}

lspconfig.tailwindcss.setup {
  capabilities = capabilities,
  filetypes = { "html", "htmldjango", "css", "scss" },
}

lspconfig.lua_ls.setup {
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
  capabilities = capabilities,
  filetypes = { "html", "htmldjango" },
}

lspconfig.html.setup {
  capabilities = capabilities,
  filetypes = { "html", "htmldjango" },
}

lspconfig.clangd.setup {
  capabilities = capabilities,
  filetypes = { "c", "cpp", "hpp", "h" },
}

lspconfig.cmake.setup {
  capabilities = capabilities,
  filetypes = { "cmake" },
}

lspconfig.glslls.setup {
  capabilities = capabilities,
  filetypes = { "glsl" },
}
