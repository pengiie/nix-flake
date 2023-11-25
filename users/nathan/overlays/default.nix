{ nixpkgs, lib, ... }@inputs: {
  nixpkgs.overlays = [
    (import ./chrome.nix inputs)
  ];
}
