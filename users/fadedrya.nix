{ inputs, pkgs, system, config, lib, ... }: {
  imports = [
  # Must be imported for every user.
  ./user.nix

  ./modules/zsh.nix
  ./modules/git.nix
  ./modules/dev.nix
  ./modules/direnv.nix
  ./modules/kitty.nix
  ./modules/theming.nix
  ./modules/nvim
  ./modules/citra

  # Encapsulates the entire DE
  ./modules/desktop.nix
  ];

  user = {
    name = "nathan";
    email = "nathan@pengie.dev";

    git = {
      username = "pengiie";
      email = "nathan@pengie.dev";
    };

    obs.droidcam = false;

    desktop = {
      enableWallpaper = false;
    };
  };
}
