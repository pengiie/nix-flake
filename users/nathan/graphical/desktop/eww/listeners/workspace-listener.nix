{ pkgs, ... }: pkgs.rustPlatform.buildRustPackage {
  pname = "hyprland-workspaces";
  version = "1.2.5";
  src = pkgs.fetchFromGitHub {
    owner = "FieldofClay";
    repo = "hyprland-workspaces";
    rev = "v1.2.5";
    sha256 = "5/add1VSJe5ChKi4UU5iUKRAj4kMjOnbB76QX/FkA6k=";
  };

  cargoHash = "sha256-kUDo+6fsrzzojHYNMNBYpztGJPPtPp/OXUypUJnzebY=";
}
