{ ... }: {
  imports = [ ../common/config/host.nix ];

  host = {
    name = "fadedrya"; 
    desktop.quickSwap.left = "eDP-1";
    desktop.quickSwap.right = "eDP-1";
  };
}
