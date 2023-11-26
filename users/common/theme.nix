{ config, lib, ... }:
let
  inherit (lib) mkOption types;
in {
  options.theme = {
    colors = {
      primary = mkOption {
        type = types.str;
        default = config.theme.colors.purple.base;
      };

      purple = {
        base = mkOption {
          type = types.str;
          default = "#C2BBF0";
        };
      };
    };
  };
}
