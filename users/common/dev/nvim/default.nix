{ pkgs, ... }: let 
  vscode-lldb = pkgs.vscode-extensions.vadimcn.vscode-lldb;
in {
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

    vscode-lldb.adapter
    lldb
  ];

  home.file.".config/nvim/" = {
    source = ./config;
    recursive = true;
  };

  home.file.".config/nvim-constants/constants.lua".text = ''
    return {
      codelldb_path = "${vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb",
      liblldb_path = "${vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/lib/liblldb.so",
    }
  '';
}
