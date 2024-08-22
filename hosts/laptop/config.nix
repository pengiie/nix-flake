{ ... }: {
  imports = [ ../common/config/host.nix ];

   # Setting the host name option defined in ../common/host.nix
  host = {
    name = "laptop"; 
    laptop = true;
    monitors = [
      {
        name = "eDP-1";
        resolution.width = 2496;
        resolution.height = 1664;
        refreshRate = 60;
        position.x = 0;
        position.y = 0;
        scale = 1.0;
      }
    ];
    desktop.quickSwap.left = "eDP-1";
    desktop.quickSwap.right = "eDP-1";
  };
}
