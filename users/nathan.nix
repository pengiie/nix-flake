{ inputs, pkgs, system, config, lib, ... }: let
  citra-pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/336eda0d07dc5e2be1f923990ad9fdb6bc8e28e3.tar.gz";
  }) {};
in {
  imports = [
  # Must be imported for every user.
  ./user.nix

  ./modules/zsh.nix
  ./modules/git.nix
  ./modules/dev.nix
  ./modules/direnv.nix
  #./modules/renderdoc.nix
  ./modules/kitty.nix
  ./modules/obs.nix
  ./modules/google-chrome.nix
  ./modules/theming.nix
  ./modules/discord.nix
  ./modules/nvim
  ./modules/citra

  # Encapsulates the entire DE
  ./modules/desktop.nix
  ];

  user = {
    name = "nathan";
    email = "nathan@pengie.dev";

    shellAliases = {
      notes = "cd /home/nathan/vaults/notes/";
      paratym = "cd /home/nathan/dev/paratym/";
      wuser = "cd /mnt/windows/Users/nathan/";
      fadedrya = "kitty +kitten ssh nathan@192.168.0.250";
    };

    git = {
      username = "pengiie";
      email = "nathan@pengie.dev";
    };

    obs.droidcam = !config.host.laptop;

    desktop = {
      enableWallpaper = true;
    };
  };

  home.packages = with pkgs; lib.lists.optionals (!config.host.laptop) [
    inputs.nixpkgs-unstable.legacyPackages.${system}.jetbrains.rust-rover
    vscode

    gh-markdown-preview

    gimp
    blender
    musescore
    audacity
    krita
    prismlauncher
    scarab
    clonehero
  ];
}
