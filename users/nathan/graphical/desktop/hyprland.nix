{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    libva
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    xwaylandvideobridge
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = config.host.nvidia;

    settings = {
      monitor = map (monitor: let
        resolution = "${toString monitor.resolution.width}x${toString monitor.resolution.height}";
        position = "${toString monitor.position.x}x${toString monitor.position.y}";
      in "${monitor.name}, ${resolution}, ${position}, ${toString monitor.scale}"
      ) config.host.monitors;

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
        "col.active_border" = "rgba(${lib.strings.removePrefix "#" config.theme.colors.primary}44)";

        gaps_in = config.theme.spacing.margins.desktop;
        gaps_out = config.theme.spacing.margins.desktop;

        resize_on_border = true;
      };

      decoration = {
        rounding = 8;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      exec = ([
        # Reload font cache and launch eww status bars
        "fc-cache -f; eww kill; eww daemon; ${lib.concatMapStringsSep " & " (m: "eww open ${m.name}-status-bar") config.host.monitors}"
      ] ++ 
        (if config.host.wallpaper then [
          ## On non-laptop devices, run swww for wallpapers
          "swww kill; swww init; random-wallpaper"
        ] else [
          ## On laptop devices, ensure swww is not running
          "swww kill"
        ])
      );

      exec-once = [
      "/nix/store/$(ls -la /nix/store | grep polkit-kde-agent | grep '^d' | awk '{print $9}')/libexec/polkit-kde-authentication-agent-1 &"
      "xwaylandvideobridge &"
      ];

      env = (if config.host.nvidia then [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
      ] else []);

      bind = ([
        ## Hyprland
        "SUPER, R, exec, hyprctl reload" # reload hyprland
        "SUPER, Q, killactive" # kill active window
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

        ## Window workspace
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER_SHIFT, 5, movetoworkspacesilent, 5"
        "SUPER_SHIFT, 6, movetoworkspacesilent, 6"
        "SUPER, W, swapactiveworkspaces, ${config.host.desktop.quickSwap.left} ${config.host.desktop.quickSwap.right}"

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
        "SUPER, Return, exec, kitty"
        "ALT, Space, exec, rofi -show drun"
      ]) ++ (if config.host.laptop then [
        ## Laptop Specific

        ## Brightness
        ",XF86MonBrightnessUp, exec, light -A 5%"
        ",XF86MonBrightnessDown, exec, light -U 5%"
      ] else []);
    
      windowrulev2 = [
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
      ];

      layerrule = [ 
        "noanim,rofi"
      ];
    };
  };
}
