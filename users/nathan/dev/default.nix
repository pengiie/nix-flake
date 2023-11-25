{ pkgs, ... }: {
  imports = [
    ./git
    ./nvim
  ];

  home.packages = with pkgs; [
    ripgrep
    nodejs_20
  ];
}
