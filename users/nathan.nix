{ inputs, pkgs, system, config, lib, ... }: let
  kicad-fixed = pkgs.writeShellScriptBin "kicad-fixed" ''
      GTK_THEME=Adwaita gdb -ex=r -ex=q --args bash -e /home/nathan/.nix-profile/bin/kicad
  '';
in {
  imports = [
  # Must be imported for every user.
  ./user.nix

  ./modules/zsh.nix
  ./modules/git.nix
  ./modules/dev.nix
  ./modules/direnv.nix
  ./modules/renderdoc.nix
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
      notes = "cd /home/nathan/notes";
      para = "cd /home/nathan/dev/paratym";
      rogue = "cd /home/nathan/dev/paratym/rogue";
      flake = "cd /home/nathan/flake";
      wuser = "cd /mnt/windows/Users/nathan";
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

  nixpkgs.overlays = [
    inputs.firefox-nightly.overlays.firefox
  ];

  home.packages = with pkgs; lib.lists.optionals (!config.host.laptop) [
    inputs.nixpkgs-unstable.legacyPackages.${system}.jetbrains.rust-rover
    vscode
    osu-lazer-bin

    gh-markdown-preview

    gimp
    blender
    musescore
    audacity
    krita
    prismlauncher
    lumafly
    clonehero

    image-roll
    wineWowPackages.waylandFull
    winetricks
    opentabletdriver

    kicad-fixed
    kicad
    librecad
    freecad

    qdirstat
    kdenlive
    showmethekey
  ];


  xdg.desktopEntries.kicad-fixed = {
    name = "Kicad Fixed";
    exec = "kicad-fixed";
  };

}
