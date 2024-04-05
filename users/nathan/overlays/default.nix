{ inputs, system, nixpkgs, ... }@args: {
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  nixpkgs.overlays = [
    (import ./chrome.nix args)
    (import ./renderdoc.nix args)
    inputs.neovim-nightly-overlay.overlay
  ];
}
