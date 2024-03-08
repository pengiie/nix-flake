# Configuration specifying a home manager user environment.
{ pkgs, ... }: {
  imports = [
  ../common

  ./dev
  ./graphical
  ./overlays

  ./spotify.nix
  ./zsh.nix
  ./open-games.nix
  ];

  user = {
    name = "nathan";
    email = "nathan@pengie.dev";
  };

  home.sessionVariables = {
    TERM = "kitty";
    EDITOR = "nvim";
    DEFAULT_BROWSER = "firefox";
  };

  home.packages = with pkgs; [
    hueadm
    zip
    unzip
  ];
}
