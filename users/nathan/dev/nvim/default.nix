{ pkgs, ... }: {
  home.packages = with pkgs; [
    neovim 

    # LSPs
    nixd

    vimPlugins.markdown-preview-nvim
  ];

  home.file.".config/nvim/" = {
    source = ./config;
    recursive = true;
  };
}
