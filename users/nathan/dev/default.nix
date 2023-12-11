{ pkgs, ... }: {
  imports = [
    ./direnv.nix
    ./git.nix
    ./nvim
  ];

  home.packages = with pkgs; [
    ripgrep
    gnumake
    cmake
    nodejs_20
    clang
    clangStdenv
    python3
    vscode
  ];
}
