{ pkgs, nixpkgs, ... }: {
  home.packages = with pkgs; [
    renderdoc
  ];

  nixpkgs.overlays = [
    (final: prev: {
      renderdoc = prev.renderdoc.override {
        waylandSupport = true;
      };
    })
  ];
}
