{ pkgs, ... }: {
  imports = [
    ./hyprland.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
    # Wayland clipboard
    wl-clipboard

    # Media control cli
    playerctl
  ];
}
