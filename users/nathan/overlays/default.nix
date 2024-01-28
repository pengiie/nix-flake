{ inputs, system, nixpkgs, ... }@args: {
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  nixpkgs.overlays = [
    (import ./chrome.nix args)
    (import ./chrome-dev.nix { 
      inherit system;
      browser-previews = inputs.browser-previews;
    })
    (import ./renderdoc.nix args)
  ];
}
