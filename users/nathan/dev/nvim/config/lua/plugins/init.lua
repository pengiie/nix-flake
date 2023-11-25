local general = {
  -- deps
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },

  -- startup color scheme
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin]])
    end
  },

  -- file tree
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    ops = function()
      return require("plugins.configs.nvim-tree")
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end
  },

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = function()
      return require("plugins.configs.lualine")
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
    end
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzy-native.nvim", build = "make" },
    },
  },

  -- github copilot
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    cmd = "Copilot",
    event = "InsertEnter",
    opts = function()
      return require("plugins.configs.copilot")
    end,
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "BufRead",
    opts = function()
      return require("plugins.configs.treesitter")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
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
          require("null-ls").setup(opts)
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

      -- cmp sources
      {
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
}

local plugins = {};
for _, plugin in ipairs(general) do
  table.insert(plugins, plugin)
end
for _, plugin in ipairs(require("plugins.lsp")) do
  table.insert(plugins, plugin)
end

require("lazy").setup(plugins)
