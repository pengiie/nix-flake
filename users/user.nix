{ lib, config, pkgs, ... }: 
let
  inherit (lib) mkOption types;
in {
  imports = [
    ./modules/theme.nix
  ];

  options.user = {
    name = mkOption {
      type = types.str;
      description = "The user's name.";
    };
    email = mkOption {
      type = types.str;
      description = "The user's email.";
    };
    shellAliases = mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = "A list of shell aliases to add.";
    };
    git = {
      username = mkOption {
        type = types.str;
        description = "The user's git username.";
      };
      email = mkOption {
        type = types.str;
        description = "The user's git email.";
      };
    };
    obs.droidcam = mkOption {
      type = types.bool;
      default = false;
      description = "Enable DroidCam OBS plugin.";
    };

    desktop = {
      enableWallpaper = mkOption {
        type = types.bool;
      };
    };
  };

  config = {
    nix.package = pkgs.nixFlakes;

    home = {
      username = config.user.name;
      homeDirectory = "/home/${config.user.name}";
      stateVersion = "23.05";

      sessionVariables = {
        TERM = "kitty";
        EDITOR = "nvim";
        DEFAULT_BROWSER = "firefox";
      };

      packages = with pkgs; [
        zip
        unzip
        ripgrep

        # Bluetooth gui
        blueberry

        # Audio patch and mixer
        helvum
        pavucontrol

        vlc
        nemo
        firefox

        libsForQt5.polkit-kde-agent
      ];
    };

    nixpkgs.config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };

    systemd.user.startServices = true;
    programs.home-manager.enable = true;
  };
}
