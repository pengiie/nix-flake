{ pkgs, inputs, ... }: let 
  vscode-lldb = pkgs.vscode-extensions.vadimcn.vscode-lldb;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  nixpkgs.overlays = [ inputs.fenix.overlays.default ];

  programs.nixvim = {
    enable = true;

    opts = {
      # using lualine instead
      laststatus = 3; # remove default status lines
      showmode = false; # don't show the mode
      ruler = false; # don't show cursor position in status line

      clipboard = "unnamedplus"; # use system clipboard
      cursorline = true; # highlight line the cursor is on

      # indenting, 2 space tabs
      expandtab = true; # we use tabs instead of spaces here
      shiftwidth = 2; # set the auto indent width
      smartindent = true; # it's smart
      tabstop = 2; # what a tab in a file means to nvim
      softtabstop = 2; # when i click tab, this is how many spaces

      # line number
      number = true; # show line numbers
      relativenumber = true; # show relative line numbers
      numberwidth = 2; # line number is 2 width

      ignorecase = true; # ignore case for searches
      smartcase = true; # be smart about ignoring case

      termguicolors = true; # enable the good colors
      fillchars = { eob = " "; vert = " "; };
    };

    globals = { 
      mapleader = " "; 
      rustfmt_autosave = 1;
    };

    keymaps = [
      # Line numbers
      {
        mode = "n";
        key = "<leader>ln";
        action = ":set number!<CR>";
      }
      {
        mode = "n";
        key = "<leader>lr";
        action = ":set relativenumber!<CR>";
      }

      # Save
      {
        mode = "n";
        key = "<C-s>";
        action = ":w<CR>";
      }

      # Insert mode movement
      {
        mode = "i";
        key = "<C-h>";
        action = "<Left>";
      }
      {
        mode = "i";
        key = "<C-j>";
        action = "<Down>";
      }
      {
        mode = "i";
        key = "<C-k>";
        action = "<Up>";
      }
      {
        mode = "i";
        key = "<C-l>";
        action = "<Right>";
      }

      # Window Movement
      ## Page up and down
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
      }
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
      }

      ## Move between buffers
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
      }

      {
        mode = "n";
        key = "<leader>q";
        action = ":q<CR>";
      }
      {
        mode = "n";
        key = "<leader>Q";
        action = ":qall<CR";
      }

      # File tree
      {
        mode = "n";
        key = "<leader>e";
        action = ":NvimTreeToggle<CR>";
      }
      {
        mode = "n";
        key = "<leader>fe";
        action = ":NvimTreeFindFile<CR>";
      }
    ];

    clipboard.providers.wl-copy.enable = true;

    colorschemes.catppuccin.enable = true;

    plugins = {
      # Appearance
      transparent = {
        enable = true;
        settings.extra_groups = [
          "NvimTreeNormal"
          "NvimTreeWinSeparator"
          "lualine_c_normal"
          "lualine_c_inactive"
          "lualine_x_filetype_DevIconRs_normal"
        ];
      };

      lualine = {
        enable = true;
        settings.options = {
          theme = "catppuccin";
          component_separators.right = "|";
          component_separators.left = "|";
          section_separators.right = "";
          section_separators.left = "";
        };
      };

      # File explorer
      nvim-tree = {
        enable = true;
        view = {
          side = "left";
          width = {};
        };
        git = {
          enable = false;
        };
      };

      # Find everything
      telescope = {
        enable = true;
        settings.defaults.file_ignore_patterns = [
          "node_modules/"
          ".git/"
          ".direnv/"
        ];
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fk" = "keymaps";
          "<leader>fr" = "resume";
        };
      };

      # Syntax highlighting
      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
        };
      };
      nvim-colorizer.enable = true;

      # LSP stuff
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          bashls.enable = true;
          html.enable = true;
          nixd.enable = true;
          lua-ls.enable = true;
          clangd.enable = true;
          cmake.enable = true;
          zls.enable = true;
        };
        keymaps = {
          lspBuf = {
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
            "K" = "hover";
          };
          diagnostic = {
            "<leader>dn" = "goto_next";
            "<leader>dN" = "goto_prev";
          };
          extra = [
            {
              mode = "n";
              key = "gd";
              action.__raw = ''
                function()
                  require('telescope.builtin').lsp_definitions()
                end
              '';
            }
            {
              mode = "n";
              key = "gr";
              action.__raw = ''
                function()
                  require('telescope.builtin').lsp_references()
                end
              '';
            }
            {
              mode = "n";
              key = "<leader>dd";
              action.__raw = ''
                function()
                  require('trouble').toggle({ mode = 'diagnostics', filter = { buf = 0 }, focus = true })
                end
              '';
            }
            {
              mode = "n";
              key = "<leader>dw";
              action.__raw = ''
                function()
                  require("trouble").toggle({ mode = "diagnostics", focus = true })
                end
              '';
            }
          ];
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
            { name = "crates"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = false }";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
        };
      };
      nvim-autopairs.enable = true;

      trouble = {
        enable = true;
      };

      crates-nvim.enable = true;
      rustaceanvim = {
        enable = true;
        rustAnalyzerPackage = pkgs.rust-analyzer;
      };

      hex.enable = true;
      wakatime.enable = true;
    };
  };
}
  # Old pre-nixvim
  # home.packages = with pkgs; [
  #   neovim

  #   # LSP/Helpers
  #   nixd
  #   stylua
  #   rustywind
  #   tailwindcss-language-server
  #   lua-language-server
  #   vscode-langservers-extracted
  #   nodePackages.typescript-language-server
  #   # "its so over" - ThePrimeagen
  #   (import ./htmx-lsp { inherit pkgs; })
  #   clang-tools
  #   cmake-language-server
  #   glslls
  #   zls

  #   vimPlugins.markdown-preview-nvim

  #   vscode-lldb.adapter
  #   lldb
  # ];

  # home.file.".config/nvim/" = {
  #   source = ./config;
  #   recursive = true;
  # };

  # home.file.".config/nvim-constants/constants.lua".text = ''
  #   return {
  #     codelldb_path = "${vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb",
  #     liblldb_path = "${vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.so",
  #   }
  # '';
