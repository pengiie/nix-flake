{ pkgs, ... }: {
  imports = [
    ./eww

    ./hyprland.nix
    ./rofi
    ./swww.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    playerctl
    hyprpicker
    waypipe
  ];
}
