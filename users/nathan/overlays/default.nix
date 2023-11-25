{ nixpkgs, lib, ... }@inputs:
let
  inherit (nixpkgs) pkgs;

  importLocalOverlay = file:
    lib.fixed-points.composeExtentensions
      (_: _: { __inputs = inputs; })
      (import file);

in {
  nixpkgs.overlays = [
    (importLocalOverlay ./chrome.nix)
  ];
}
