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
  ./modules/discord.nix
  ./modules/nvim

  # Encapsulates the entire DE
  ./modules/desktop.nix
  ];

  user = {
    name = "nathan";
    email = "nathan@pengie.dev";

    shellAliases = {
      desktop = "kitty +kitten ssh desktop";
    };

    git = {
      username = "pengiie";
      email = "nathan@pengie.dev";
    };

    desktop = {
      enableWallpaper = false;
    };
  };

  home.packages = with pkgs; lib.lists.optionals (!config.host.laptop) [
    vscode

    gimp
    musescore
    audacity
  ];
}
