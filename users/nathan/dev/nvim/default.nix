{ pkgs, ... }: {
  home.packages = with pkgs; [
    neovim 

    # LSPs
    nixd
  ];

  home.file.".config/nvim/" = {
    source = ./config;
    recursive = true;
  };
}
