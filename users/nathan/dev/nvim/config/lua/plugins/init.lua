local plugins = {
  -- deps
  {
    "nvim-tree/nvim-web-devicons",
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
    }
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzy-native.nvim", build = "make" },
    },
    config = function()
      require("plugins.configs.telescope")
    end
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
};

require("lazy").setup(plugins);
