{ config, lib, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

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

      exec = [
        # Launch eww status bars
        "eww daemon & ${lib.concatMapStringsSep " & " (m: "eww open ${m.name}-status-bar") config.host.monitors}"
      ];

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
        ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +2%"
        ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -2%"
        ",XF86AudioMute, exec, amixer ssset 'Master' toggle"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"

        ## Quick Apps
        "SUPER, Return, exec, kitty"
        "ALT, Space, exec, wofi"
      # If on laptop, add brightness controls with light cli tool
      ]) ++ (if config.host.name == "laptop" then
        [",XF86MonBrightnessUp, exec, light -A 5%" ",XF86MonBrightnessDown, exec, light -U 5%"] 
      else 
        []
      );
    };
  };
}
