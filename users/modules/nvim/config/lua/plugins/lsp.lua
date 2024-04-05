local lsps = {
  --- Lsp Setup

  -- lsp
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function()
          return require("plugins.configs.null-ls")
        end,
        config = function(_, opts)
          require("null-ls").setup({})
        end,
      },

      "folke/neodev.nvim",
    },
    config = function(_, opts)
      require("plugins.configs.lspconfig")
    end,
  },

  -- auto complete
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- autopairing
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)
        end
      },

      {
        "L3MON4D3/LuaSnip",
      },

      -- cmp sources
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require("plugins.configs.cmp")
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  --- Language Specific

  -- rust stuff
  {
    "rust-lang/rust.vim",
    lazy = true,
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require("plugins.configs.rust-tools")
    end,
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end,
  },

  {
    'saecki/crates.nvim',
    tag = 'v0.4.0',
    lazy = false,
    config = function()
      require('crates').setup({
        src = {
          cmp = {
            enabled = true,
          },
        },
      })
    end,
  },

  -- yuck, eww
  {
    "elkowar/yuck.vim",
    lazy = true,
    ft = "yuck",
  },

  -- wgsl
  {
    "wgsl-analyzer/wgsl-analyzer",
    lazy = false,
  },
}

return lsps
