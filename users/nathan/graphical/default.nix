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
    google-chrome
    blueberry
    pavucontrol
    obsidian
    vlc
    cinnamon.nemo
    wireshark
    libsForQt5.polkit-kde-agent
  ];
}
