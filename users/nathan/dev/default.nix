{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./nvim
  ];

  home.packages = with pkgs; [
    ripgrep
    nodejs_20
  ];
}
