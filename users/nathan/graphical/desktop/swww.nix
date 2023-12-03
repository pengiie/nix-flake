{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    swww
    (import ./scripts/random-wallpaper.nix { inherit pkgs; })
  ];
}
