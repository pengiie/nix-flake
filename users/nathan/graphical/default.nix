{ inputs, pkgs, ... }: {
  imports = [
    ./desktop

    ./discord.nix
    ./kitty.nix
    ./theming.nix
    ./obs.nix
    ./emulation.nix
  ];

  home.packages = with pkgs; [
    helvum
    discord
    google-chrome
    blueberry
    pavucontrol
    vlc
    cinnamon.nemo
    libsForQt5.polkit-kde-agent
    musescore
    audacity
    gimp
    firefox
    goxel
    blender
  ];
}
