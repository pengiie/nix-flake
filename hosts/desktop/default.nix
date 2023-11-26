{ ... }: {
  imports = [
    ../common

    ./hardware.nix
    ./host.nix
    ./nvidia.nix
  ];

  # Setting the host name option defined in ../common/host.nix
  host = {
    name = "desktop"; 
    monitors = [
      {
        name = "DP-1";
        resolution.width = 2560;
        resolution.height = 1440;
        refreshRate = 144.0;
        position.x = 1920;
        position.y = 0;
      }
      {
        name = "DP-2";
        resolution.width = 1920;
        resolution.height = 1080;
        refreshRate = 60.0;
        position.x = 0;
        position.y = 0;
      }
    ];
  };
}
