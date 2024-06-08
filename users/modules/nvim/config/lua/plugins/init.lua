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

  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = function ()
      return {
        extra_groups = {
          "NvimTreeNormal",
          "NvimTreeWinSeparator",
          "lualine_c_normal",
          "lualine_c_inactive",
          "lualine_x_filetype_DevIconRs_normal"
        }
      }
    end,
    config = function (_, opts)
      require("transparent").setup(opts)
    end
  },

  -- {
  --   "morhetz/gruvbox",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd([[colorscheme gruvbox]])
  --   end
  -- },

  -- file tree
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = function()
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

  -- tab line
  {
    "akinsho/nvim-bufferline.lua",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = function()
      return require("plugins.configs.bufferline")
    end,
    config = function(_, opts)
      -- require("bufferline").setup(opts)
    end
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzy-native.nvim", build = "make" },
    },
    opts = function()
      return require("plugins.configs.telescope")
    end,
    config = function(_, opts)
      require("telescope").setup(opts)
    end,
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

  -- color code highlighting
  {
    "norcalli/nvim-colorizer.lua",
    lazy = true,
    event = "BufRead",
    config = function()
      require("colorizer").setup()
    end,
  },

  -- diagnostics
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  -- debug
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap"},
    config = function(_, _)
      require("dapui").setup()
    end
  },

  -- vim game
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
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
