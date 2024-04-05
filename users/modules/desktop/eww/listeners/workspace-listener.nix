{ pkgs, ... }: pkgs.rustPlatform.buildRustPackage {
  pname = "hyprland-workspaces";
  version = "1.0.0";
  src = ./workspaces;
  cargoLock.lockFile = ./workspaces/Cargo.lock;
}
