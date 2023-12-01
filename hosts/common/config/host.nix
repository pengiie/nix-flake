{ lib, config, ... }:
let
  inherit (lib) mkOption types;
in {
  imports = [
    ./monitors.nix
    ./desktop.nix
  ];

  options = {
    host = {
      name = mkOption {
        type = types.str;
        description = "The hostname of the current machine.";
      };
      nvidia = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the current machine has an Nvidia GPU.";
      };
      laptop = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the current machine is a laptop.";
      };
      wallpaper = mkOption {
        type = types.bool;
        default = false;
        description = "Whether the current machine should use wallpapers.";
      };
      extraAllowedTCPPorts = mkOption {
        type = types.listOf types.int;
        default = [];
        description = "Extra TCP ports to allow in the firewall.";
      };
    };
  };
}
