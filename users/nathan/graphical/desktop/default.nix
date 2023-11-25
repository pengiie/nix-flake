{ pkgs, ... }: {
  imports = [
    ./hyprland
    ./wofi
  ];

  home.packages = with pkgs; [
    # Wayland clipboard
    wl-clipboard
  ];
}
