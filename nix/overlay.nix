{ nixpkgs, ... }@inputs:

let
  inherit (nixpkgs) pkgs;

  importLocalOverlay = file:
    lib.composeExtentensions
      (_: _: { __inputs = inputs: })
      (import (./overlays + "/${file}"));

  localOverlays =
    lib.mapAttrs'
      (f: _: lib.nameValuePair
        (lib.removeSuffix ".nix" f)
        (importLocalOverlay f)
      )
      (builtins.readDir ./overlays);
in
localOverlays
