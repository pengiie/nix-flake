{ ... }: {
  imports = [
    ../common

    ./hardware.nix
  ];

  # Setting the host name option defined in ../common/host.nix
  host.name = "laptop";

  # "light" cli tool to control laptop screen brightness
  programs.light.enable = true;

  # Service to control fans through software
  services.thermald.enable = true;
}
