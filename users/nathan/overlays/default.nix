{ nixpkgs, ... }: {
  nixpkgs.overlays = [
    (import ./chrome.nix)
  ];
}
