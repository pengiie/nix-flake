{ pkgs }:

pkgs.writeShellScriptBin "build-home" ''
  alacritty --hold -e home-manager switch --flake /home/nathan/flake &

  sleep 5

  if [ -z "$(pgrep -f 'alacritty')" ]; then
    pkill -f 'alacritty'
  fi
''
