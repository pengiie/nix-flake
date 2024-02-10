{ pkgs, ... }: {
  imports = [
    ./desktop

    ./discord.nix
    ./kitty.nix
    ./theming.nix
    ./obs.nix
  ];

  home.packages = with pkgs; [
    discord
    google-chrome-dev
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
