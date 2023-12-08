{ config, lib, pkgs, ... }: 
  pkgs.writeShellScriptBin "minimal-mode" ''
    ACTIVE_WORKSPACE_ID=$(hyprctl activeworkspace | awk 'NR==1{print $3}')
    ACTIVE_WORKSPACE_MONITOR=$(hyprctl activeworkspace | awk 'NR==1{print $7}' | sed -e "s/://")
    if [ "$1" == "toggle" ]; then
      MINIMAL_MODE=$(hyprctl workspacerules | sed -n "/Workspace rule $ACTIVE_WORKSPACE_ID:/,/Workspace rule [0-9]\+:/ p" | awk 'NR==5{print $2}')
      if [ "$MINIMAL_MODE" == "0" ]; then
        minimal-mode false
      else
        minimal-mode true
      fi
    elif [ "$1" == "true" ]; then
      echo "Enabling minimal desktop."
      eww close $ACTIVE_WORKSPACE_MONITOR-status-bar
      hyprctl keyword workspace $ACTIVE_WORKSPACE_ID,rounding:false,gapsin:0,gapsout:0
    elif [ "$1" == "false" ]; then
      echo "Disabling minimal desktop."
      eww open $ACTIVE_WORKSPACE_MONITOR-status-bar
      hyprctl keyword workspace $ACTIVE_WORKSPACE_ID,
    fi
  ''
