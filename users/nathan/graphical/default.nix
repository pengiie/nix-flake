{ pkgs, ... }: {
  imports = [
    ./desktop

    ./discord.nix
    ./kitty.nix
    ./theming.nix
    ./obs.nix
  ];

  home.packages = with pkgs; [
    floorp # this is the browser i actuallly use 
    discord
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
