{ config, lib, pkgs, cutil, ... }: {
  imports = [
    ./assets.nix
    ./listeners
  ];

  home.packages = with pkgs; [
    eww-wayland
  ];

  xdg.configFile."eww/widgets.yuck".source = ./widgets.yuck;
  xdg.configFile."eww/eww.yuck".text = ''
    (include "./widgets.yuck")

    (defpoll time :interval "1s" 
      `TZ="America/Phoenix" date +'%H:%M %p'`)


    ${lib.concatStrings (lib.imap0 (i: m: ''
      (deflisten ${m.name}-workspaces "hyprland-workspaces ${m.name}")
      (defwindow ${m.name}-status-bar
        :monitor ${toString i}
        :stacking "fg"
        :exclusive true
        :focusable false
        :geometry (geometry 
          :x "0%" 
          :y "${toString config.theme.spacing.margins.desktop}px"
          :width "99%" 
          :height "24px"
          :anchor "top center"
        )
        (status-bar 
          :workspaces ${m.name}-workspaces
          :time time
          :battery ${if config.host.laptop then "true" else "false"})) 
    '') config.host.monitors) }
  '';

  xdg.configFile."eww/eww.scss".text = ''
    * { all: unset; }

    .status-bar {
      // Oh yeah daddy
      font-family: "DaddyTimeMono Nerd Font";
      border-radius: 4px;
      color: ${config.theme.colors.text.base};

      ${if !config.host.wallpaper then ''
        background-color: ${config.theme.colors.bg.base2};
        padding-right: 16px;
      '' else ""}
    }

    .workspace-group button:first-child {
      border-top-left-radius: 4px;
      border-bottom-left-radius: 4px;
    }

    .workspace-group button:last-child {
      border-top-right-radius: 4px;
      border-bottom-right-radius: 4px;
    }

    .workspace-button {
      padding: 0 8px;
      background-color: ${config.theme.colors.bg.base3};

      &.active {
        background-color: ${cutil.color.shadeLHex config.theme.colors.active 0.25 };
      }

      &:hover {
        background-color: ${config.theme.colors.active};
      }
    }

    .system-cluster {
      color: ${config.theme.colors.text.accent};
    }
  '';
}
