# Configuration specifying a home manager user environment.
{ pkgs, ... }: {
  imports = [
  ../common

  ./dev
  ./graphical
  ./overlays

  ./spotify.nix
  ./zsh.nix
  ];

  user = {
    name = "nathan";
    email = "nathan@pengie.dev";
  };

  home.sessionVariables = {
    TERM = "kitty";
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    hueadm
  ];
}
