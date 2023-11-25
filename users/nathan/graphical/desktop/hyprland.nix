{ ... }: {
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
}
