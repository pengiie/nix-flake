{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./nvim
  ];

  home.packages = with pkgs; [
    ripgrep
    gnumake
    cmake
    nodejs_20
    rustc
    rust-analyzer
    cargo
    clang
    clangStdenv
    shaderc
    python3
    vscode
    vulkan-tools
  ];
}
