{ inputs, config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    libva
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    grim
    slurp
    wl-clipboard
    playerctl
    hyprpicker
    inputs.nixpkgs-24.legacyPackages.${system}.waypipe
  ] ++ lib.lists.optional config.user.desktop.enableWallpaper pkgs.swww;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor = map (monitor: let
        resolution = "${toString monitor.resolution.width}x${toString monitor.resolution.height}@${toString monitor.refreshRate}";
        position = "${toString monitor.position.x}x${toString monitor.position.y}";
      in "${monitor.name}, ${resolution}, ${position}, ${toString monitor.scale}"
      ) config.host.monitors ++ ["Unknown-1,disable"];

      input = {
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.5;
        };
        accel_profile = "flat";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      general = {
        "col.inactive_border" = "rgba(00000000)";
        "col.active_border" = "rgba(${lib.strings.removePrefix "#" config.theme.colors.primary}77)";
        border_size = 2;

        gaps_in = config.theme.spacing.margins.desktop;
        gaps_out = config.theme.spacing.margins.desktop;

        resize_on_border = true;
        no_border_on_floating = true;
      };
      
      cursor = {
        inactive_timeout = 2.5;
        no_hardware_cursors = true;
      };

      decoration = {
        rounding = 8;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      # render.explicit_sync = 1;
      # render.explicit_sync_kms = 0;

      exec = ([
        # Reload font cache and launch eww status bars
        "fc-cache -f; eww kill; eww daemon; ${lib.concatMapStringsSep " & " (m: "eww open ${m.name}-status-bar") config.host.monitors}"
      ] ++ 
        (if config.user.desktop.enableWallpaper then [
          ## On non-laptop devices, run swww for wallpapers
          "swww kill; swww init;"
        ] else [
          ## On laptop devices, ensure swww is not running
          "swww kill"
        ])
      );

      exec-once = [
        "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent &"
      ];

      env = (if config.host.nvidia then [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ] else []);

      bind = ([
        ## Hyprland
        "SUPER, R, exec, hyprctl reload" # reload hyprland
        "SUPER, Q, killactive" # kill active window
        "ALT, F5, killactive"
        "SUPER, Escape, exit" # exit hyprland

        ## Window Management
        "SUPER, H, movefocus, l"
        "SUPER, J, movefocus, d"
        "SUPER, K, movefocus, u"
        "SUPER, L, movefocus, r"
        "SUPER_SHIFT, H, movewindow, l"
        "SUPER_SHIFT, J, movewindow, d"
        "SUPER_SHIFT, K, movewindow, u"
        "SUPER_SHIFT, L, movewindow, r"
        "SUPER, F, fullscreen"
        "SUPER, Minus, togglefloating"

        ## Window workspace
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER_SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER_SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER_SHIFT, 7, movetoworkspacesilent, 7"
        "SUPER_SHIFT, 8, movetoworkspacesilent, 8"
        "SUPER_SHIFT, 9, movetoworkspacesilent, 9"

        "SUPER, W, swapactiveworkspaces, ${config.host.desktop.quickSwap.left} ${config.host.desktop.quickSwap.right}"
        "SUPER, Left, focusmonitor, ${config.host.desktop.quickSwap.left}"
        "SUPER, Right, focusmonitor, ${config.host.desktop.quickSwap.right}"

        ## System
        ",XF86AudioRaiseVolume, exec, pamixer -i 2"
        ",XF86AudioLowerVolume, exec, pamixer -d 2"
        ",XF86AudioMute, exec, amixer ssset 'Master' toggle"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"

        ## Modes
        "SUPER, M, exec, minimal-mode toggle"

        ## Quick Apps
        "SUPER, T, exec, kitty"
        "SUPER, V, exec, pavucontrol"
        "SUPER, B, exec, blueberry" # Bluetooth gui
        "ALT, Space, exec, rofi -show drun"
        ", Print, exec, grim -g \"\$(slurp)\" - | wl-copy"
      ]) ++ (if config.host.laptop then [
        ## Laptop Specific

        ## Brightness
        ",XF86MonBrightnessUp, exec, light -A 5%"
        ",XF86MonBrightnessDown, exec, light -U 5%"
      ] else []);
      bindm = [
        "SUPER_SHIFT,mouse:272,movewindow"
      ];
    
      windowrulev2 = [
        "noinitialfocus,class:^(showmethekey-gtk)$"
        "nofocus,class:^(showmethekey-gtk)$"
        "float,class:^(showmethekey-gtk)$"
        "pin,class:^(showmethekey-gtk)$"
        "opacity 0.0 override 0.0 override,class:^(showmethekey-gtk)$"
        "decorate 0,class:^(showmethekey-gtk)$"

        "float,class:^(org\.pulseaudio\.pavucontrol)$"
        "float,class:^(blueberry\.py)$"
      ];

      layerrule = [ 
        "noanim,rofi"
      ];
    };
  };
}
