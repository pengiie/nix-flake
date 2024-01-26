{ pkgs, ... }: {
  imports = [
    ./direnv.nix
    ./git.nix
    ./nvim
  ];

  home.packages = with pkgs; [
    ripgrep
    gnumake

    nodejs_20
    nodejs

    cmake
    clang
    clangStdenv

    python3
    vscode
    yarn
    renderdoc
  ];
}
