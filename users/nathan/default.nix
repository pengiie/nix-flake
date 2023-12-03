# Configuration specifying a home manager user environment.
{ ... }: {
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
    BROWSER = "google-chrome-stable";
  };
}
