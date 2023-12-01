{ config, pkgs, ... }: {
  home.packages = if config.host.wallpaper then (with pkgs; [
    swww
    (import ./scripts/random-wallpaper.nix { inherit pkgs; })
  ]) else [];
}
