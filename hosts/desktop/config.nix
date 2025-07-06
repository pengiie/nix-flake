{ ... }: {
  imports = [ ../common/config/host.nix ];

   # Setting the host name option defined in ../common/host.nix
  host = {
    name = "desktop"; 
    nvidia = true;
    extraAllowedTCPPorts = [ 22 ];
    wallpaper = true;
    monitors = [
      # {
      #   name = "HDMI-A-1";
      #   resolution.width = 1920;
      #   resolution.height = 1080;
      #   refreshRate = 60;
      #   position.x = 0;
      #   position.y = 0;
      #   scale = 1.0;
      # }
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
    desktop.quickSwap = {
      #left = "HDMI-A-1";
      left = "DP-3";
      right = "DP-3";
    };
  };
}
