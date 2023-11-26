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
        (status-bar :workspaces ${m.name}-workspaces)) 
    '') config.host.monitors) }
  '';

  xdg.configFile."eww/eww.scss".text = ''
    * { all: unset; }

    window { background: transparent; }

    .status-bar {
      border-radius: 4px;
      background-color: ${config.theme.colors.bg.base2};
      color: ${config.theme.colors.text};
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
        background-color: ${cutil.color.shadeLHex config.theme.colors.primary 0.25 };
      }

      &:hover {
        background-color: ${config.theme.colors.primary};
      }
    }
  '';
}
