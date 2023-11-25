{ config, ... }: {
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
}
