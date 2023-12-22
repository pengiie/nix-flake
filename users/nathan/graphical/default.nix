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
    firefox-beta
    google-chrome-dev
    google-chrome
    blueberry
    pavucontrol
    vlc
    cinnamon.nemo
    wireshark
    libsForQt5.polkit-kde-agent
    krita
    musescore
    audacity
    libreoffice
    prismlauncher
    lmms
    gimp
  ];
}
