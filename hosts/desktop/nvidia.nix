{ config, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];

  # hardware.opengl = {
  #   enable = true;
  #   #driSupport = true;
  #   #driSupport32Bit = true;
  # };

  hardware.nvidia = {
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Using workaround declared here.
  hardware.nvidia.modesetting.enable = true;
  # boot.kernelParams = [ "nvidia-drm.modeset=1" ];
}
