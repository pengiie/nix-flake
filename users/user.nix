{ lib, inputs, config, pkgs, ... }: 
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
    nix.package = pkgs.nixVersions.stable;

    home = {
      username = config.user.name;
      homeDirectory = "/home/${config.user.name}";
      stateVersion = "24.05";

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
      permittedInsecurePackages = [
        "dotnet-runtime-7.0.20"
        "dotnet-sdk-wrapped-7.0.410"
        "dotnet-sdk-7.0.410"
        "dotnet-runtime-6.0.36"
        "dotnet-sdk-wrapped-6.0.428"
        "dotnet-sdk-6.0.428"
      ];
    };

    systemd.user.startServices = true;
    programs.home-manager.enable = true;
  };
}
