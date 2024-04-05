{ config, lib, pkgs, ... }: let
  script = path: (import path { inherit config lib pkgs; });
in {
  home.packages = [
    (script ./random-wallpaper.nix)
    (script ./toggle-minimal.nix)
  ]; 
}
