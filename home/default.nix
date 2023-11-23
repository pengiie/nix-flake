{ 
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = (import ../nix/overlay.nix inputs);
  nix.package = pkgs.nixFlakes;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home = {
    username = "nathan";
    homeDirectory = "/home/nathan";
    sessionVariables = {
      TERM = "kitty";
      BROWSER = "google-chrome";
    };
    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
    };
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "robbyrussell";
  };

  programs.gh.enable = true;

  gtk.enable = true;
  gtk.gtk3.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
  };

  systemd.user.startServices = true;

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    google-chrome
    bibata-cursors
    blueberry
    neovim
    pavucontrol
    ripgrep
    discord
    wl-clipboard
    nodejs_20
  ];

  home.file.".config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    shellIntegration.enableZshIntegration = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = [ "eDP-1,2496x1664@59.984,0x0,1.25" ];
      input = {
        touchpad = {
          natural_scroll = true;
	        scroll_factor = 0.5;
	      };
	      accel_profile = "flat";
      };
      general = {
        resize_on_border = true;
      };
      bind = [
        ## Hyprland
        "SUPER, R, exec, hyprctl reload" # reload hyprland
        "SUPER, Q, killactive" # kill active window
        "SUPER, Escape, exit" # exit hyprland

        ## Window Management
        "SUPER, H, movefocus, left"
        "SUPER, J, movefocus, down"
        "SUPER, K, movefocus, up"
        "SUPER, L, movefocus, right"
        "SUPER_SHIFT, H, movewindow, left"
        "SUPER_SHIFT, J, movewindow, down"
        "SUPER_SHIFT, K, movewindow, up"
        "SUPER_SHIFT, L, movewindow, right"

        ## System

        ## Quick Apps
        "SUPER, Return, exec, kitty"
        "ALT, Space, exec, wofi"
      ];
    };
  };

  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      # normal_window = true;
    };
  };
}
