{ config, lib, pkgs, ... }: {
  import = [
    ../nathan/graphical/kitty.nix
  ];

  home.packages = with pkgs; [
    firefox

    # Fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    input = {
      accel_profile = "flat";
    };

    decoration = {
      rounding = 8;
    };
    
    general = {
        "col.inactive_border" = "rgba(00000000)";
        "col.active_border" = "rgba(${lib.strings.removePrefix "#" config.theme.colors.primary}44)";

        gaps_in = config.theme.spacing.margins.desktop;
        gaps_out = config.theme.spacing.margins.desktop;

        resize_on_border = true;
        no_border_on_floating = true;
        cursor_inactive_timeout = 5;
    };

    env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
    ];

    bind = [
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
        "SUPER, Minus, togglefloating"

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

        ## Kitty
        "SUPER, Enter, exec, kitty"
    ];

    bindm = [
        "SUPER_SHIFT,mouse:272,movewindow"
    ];
  };
}
