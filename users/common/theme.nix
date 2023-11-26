{ config, lib, ... }@args:
let
  inherit (lib) mkOption types;
  inherit (config.theme) colors;

  catppuccin = (import ./schemes/catppuccin.nix args).catppuccin;
in {
  options.theme = {
    colors = {
      primary = mkOption {
        type = types.str;
        default = catppuccin.mocha.mauve;
      };
      accent = mkOption {
        type = types.str;
        default = catppuccin.mocha.red;
      };
      text = mkOption {
        type = types.str;
        default = catppuccin.mocha.text;
      };
      active = mkOption {
        type = types.str;
        default = colors.primary;
      };

      bg = {
        base0 = mkOption {
          type = types.str;
          default = catppuccin.mocha.crust;
        };
        base1 = mkOption {
          type = types.str;
          default = catppuccin.mocha.mantle;
        };
        base2 = mkOption {
          type = types.str;
          default = catppuccin.mocha.base;
        };
        base3 = mkOption {
          type = types.str;
          default = catppuccin.mocha.surface0;
        };
        base4 = mkOption {
          type = types.str;
          default = catppuccin.mocha.surface1;
        };
      };

      purple = {
        base = mkOption {
          type = types.str;
          default = "#B980F0";
        };
      };

      orange = {
        base = mkOption {
          type = types.str;
          default = "#FE9898";
        };
      };
    };
    spacing = {
      margins = {
        desktop = mkOption {
            type = types.int;
            default = 8;
            description = "Margin between desktop elements";
        };
      };
    };
  };
}
