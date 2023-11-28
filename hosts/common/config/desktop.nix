{ lib, config, ... }:
let
  inherit (lib) mkOption types;
in {
  options = {
    host.desktop = {
      quickSwap.left = mkOption {
        type = types.str;
        default = (builtins.elemAt config.host.monitors 0).name;
        description = "One of the monitors to swap from";
      };
      quickSwap.right = mkOption {
        type = types.str;
        default = (builtins.elemAt config.host.monitors 1).name;
        description = "One of the monitors to swap to";
      };
    };
  };
}
