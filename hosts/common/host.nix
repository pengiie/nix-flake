{ lib, ... }:
let
  inherit (lib) mkOption types;
in {
  options.host = {
    name = mkOption {
      type = types.str;
      description = "The hostname of the current machine.";
    };
    monitors = mkOption {
      type = types.listOf (types.submodule {
        name = mkOption {
          type = types.str;
          description = "The name of the monitor.";
        };
        resolution = {
          width = mkOption {
            type = types.int;
            default = 1920;
            description = "The width of the monitor.";
          };
          height = mkOption {
            type = types.int;
            default = 1080;
            description = "The height of the monitor.";
          };
        };
        refreshRate = mkOption {
          type = types.float;
          default = 60.0;
          description = "The refresh rate of the monitor.";
        };
        position = {
          x = mkOption {
            type = types.int;
            default = 0;
            description = "The x position of the monitor.";
          };
          y = mkOption {
            type = types.int;
            default = 0;
            description = "The y position of the monitor.";
          };
        };
        scale = mkOption {
          type = types.float;
          default = 1.0;
          description = "The scale of the monitor.";
        };
      });
      default = [];
      description = "A list of monitors to use for the host.";
    };
  };
}
