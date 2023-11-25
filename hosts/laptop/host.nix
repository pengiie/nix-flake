{ ... }: {
  imports = [ ../common/host.nix ];

   # Setting the host name option defined in ../common/host.nix
  host = {
    name = "laptop"; 
    monitors = [
      {
        name = "eDP-1";
        resolution.width = 1920;
        resolution.height = 1080;
        refreshRate = 60;
        position.x = 0;
        position.y = 0;
        scale = 1.0;
      }
    ];
  };
}
