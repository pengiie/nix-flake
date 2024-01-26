{ pkgs, ... }: {
  home.packages = with pkgs; [
    openttd
    mindustry-wayland
    superTuxKart
  ];
}
