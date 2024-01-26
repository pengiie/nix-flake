{ pkgs, ... }: {
  home.packages = with pkgs; [
    neovim 

    # LSP/Helpers
    nixd
    stylua
    rustywind
    tailwindcss-language-server
    lua-language-server
    vscode-langservers-extracted
    # "its so over" - ThePrimeagen
    (import ./htmx-lsp { inherit pkgs; })
    clang-tools
    cmake-language-server

    vimPlugins.markdown-preview-nvim
  ];

  home.file.".config/nvim/" = {
    source = ./config;
    recursive = true;
  };
}
