{ pkgs, ... }: with pkgs; 
(rustPlatform.buildRustPackage rec {
  pname = "htmx-lsp";
  version = "0.1.0";
  src = fetchFromGitHub {
    owner = "ThePrimeagen";
    repo = "htmx-lsp";
    rev = "8f05662346b1d14cb1a39e011c7dc454a104df21";
    hash = "sha256-S6yyKKD7sHbZw0yN7iVH+FGXQpMrr8kDj2GhqJZ3Px8=";
  };
  cargoHash = "sha256-DOu41v41UUAlVlgV+dLVtqKkzF25CAPYNVyD2b6TeMw=";
})
