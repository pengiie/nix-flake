{ pkgs, ... }: {
  imports = [
    ./desktop

    ./discord.nix
    ./kitty.nix
    ./theming.nix
  ];

  home.packages = with pkgs; [
    discord
    google-chrome
    blueberry
    pavucontrol
    obsidian
  ];
}
