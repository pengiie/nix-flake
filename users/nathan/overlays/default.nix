{ inputs, system, nixpkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  nixpkgs.overlays = [
    (import ./chrome.nix { 
      inherit system;
      browser-previews = inputs.browser-previews;
    })
  ];
}
