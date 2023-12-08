{ config, lib, pkgs, ... }: 
  pkgs.writeShellScriptBin "minimal-mode" ''
    if [ "$1" == "toggle" ]; then
      MINIMAL_MODE=$(hyprctl getoption general:gaps_in | awk 'NR==2{print $2}')
      if [ "$MINIMAL_MODE" = "0" ]; then
        minimal-mode false
      else
        minimal-mode true
      fi
    elif [ "$1" == "true" ]; then
      echo "Enabling minimal desktop."
      eww kill
      hyprctl --batch "keyword general:gaps_in 0; keyword general:gaps_out 0; keyword decoration:rounding 0;"
    else
      echo "Disabling minimal desktop."
      eww daemon &&
      ${lib.concatMapStringsSep " & " (m: "eww open ${m.name}-status-bar") config.host.monitors} &
      hyprctl --batch "keyword general:gaps_in ${toString config.theme.spacing.margins.desktop}; keyword general:gaps_out ${toString config.theme.spacing.margins.desktop}; keyword decoration:rounding 8;"
    fi
  ''
