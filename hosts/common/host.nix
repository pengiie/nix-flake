{ lib, ... }:
let
  inherit (lib) mkOption types;
in {
  options.host = {
    name = mkOption {
      type = types.str;
      description = "The hostname of the current machine.";
    };
  };
}
