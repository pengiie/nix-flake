{ pkgs }:

pkgs.writeShellScriptBin "build-nixos" ''
  alacritty --hold -e nixos-rebuild switch --flake /home/nathan/flake &

  sleep 5

  if [ -z "$(pgrep -f 'alacritty')" ]; then
    pkill -f 'alacritty'
  fi
''
