{ ... }: {
  imports = [ ../common/host.nix ];

   # Setting the host name option defined in ../common/host.nix
  host = {
    name = "desktop"; 
    monitors = [
      {
        name = "DP-2";
        resolution.width = 1920;
        resolution.height = 1080;
        refreshRate = 60;
        position.x = 0;
        position.y = 0;
        scale = 1.0;
      }
      {
        name = "DP-3";
        resolution.width = 2560;
        resolution.height = 1440;
        refreshRate = 144;
        position.x = 1920;
        position.y = 0;
        scale = 1.0;
      }
    ];
  };
}
