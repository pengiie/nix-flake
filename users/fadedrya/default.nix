# Configuration specifying a home manager user environment.
{ pkgs, ... }: {
  imports = [
  ../common
  ../common/dev/nvim

  ./zsh.nix
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
  ];
}
