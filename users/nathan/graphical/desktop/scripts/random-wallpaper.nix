{ pkgs, ... }: 
  pkgs.writeShellScriptBin "random-wallpaper" ''
    WALLPAPERS_PATH=$HOME/wallpapers/;
    WALLPAPER=$(find $WALLPAPERS_PATH -type f | shuf -n 1)
    swww img "$WALLPAPER"
  ''
