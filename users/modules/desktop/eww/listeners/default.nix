{ pkgs, ... }: {
  home.packages = with pkgs; [
    (callPackage ./workspace-listener.nix { inherit pkgs; })
  ];
}
