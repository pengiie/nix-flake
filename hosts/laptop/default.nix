{ ... }: {
  imports = [
    ../common

    ./hardware.nix
    ./config.nix
  ];

  # "light" cli tool to control laptop screen brightness
  programs.light.enable = true;

  # Service to control fans through software
  services.thermald.enable = true;
}
