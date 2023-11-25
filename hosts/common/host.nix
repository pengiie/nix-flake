{ lib, config, ... }:
let
  inherit (lib) mkOption types;
in {
  imports = [
    ./monitors.nix
  ];

  options = {
    host = {
      name = mkOption {
        type = types.str;
        description = "The hostname of the current machine.";
      };
    };
  };
}
