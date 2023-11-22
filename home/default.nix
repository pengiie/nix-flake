{ 
  inputs,
  pkgs,
  ...
}: {
  nix.package = pkgs.nixFlakes;
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  xdg.desktopEntries.discord = {
    name = "Discord";
    genericName = "Discord";
    comment = "All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.";
    icon = "discord";
    exec = "discord --enable-features=UseOzonePlatform --ozone-platform=wayland %U";
  };

  home = {
    username = "nathan";
    homeDirectory = "/home/nathan";
    sessionVariables = {
      TERM = "alacritty";
      BROWSER = "google-chrome";
    };
    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
      gtk.enable = true;
    };
  };

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

  programs.alacritty = {
    enable = true;
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

      resize_on_border = true;

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
        "SUPER_SHIFT, B, exec, alacritty --hold -e home-manager switch --flake /home/nathan/flake && bash" # reload home-manager flake in new alacritty window

        ## Quick Apps
        "SUPER, Return, exec, alacritty"
        "SUPER, Space, exec, wofi"
      ];
    };
  };

  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
    };
  };
}
