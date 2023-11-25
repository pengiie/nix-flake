{ pkgs, ... }: {
  imports = [
    ./discord
    ./kitty
    ./theming
  ];

  home.packages = with pkgs; [
    discord
    google-chrome
    blueberry
    pavucontrol
  ];
}
