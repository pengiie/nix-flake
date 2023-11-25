{ pkgs, ... }: {
  home.packages = with pkgs; [
    neovim 
    vimPlugins.nvim-treesitter-parsers.nix
    vimPlugins.nvim-treesitter-parsers.lua
    vimPlugins.nvim-treesitter-parsers.rust
    vimPlugins.nvim-treesitter-parsers.toml
    vimPlugins.nvim-treesitter-parsers.json
    vimPlugins.nvim-treesitter-parsers.html
    vimPlugins.nvim-treesitter-parsers.css
    vimPlugins.nvim-treesitter-parsers.yaml
    vimPlugins.nvim-treesitter-parsers.c
    vimPlugins.nvim-treesitter-parsers.cpp
  ];

  home.file.".config/nvim/" = {
    source = ./config;
    recursive = true;
  };
}
