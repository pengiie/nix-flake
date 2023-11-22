{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  services.thermald.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nathan-laptop";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Arizona";
  i18n.defaultLocale = "en_US.UTF-8";

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.nathan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    packages = with pkgs; [
      firefox
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    (import ../scripts/build-home.nix { inherit pkgs; })
    (import ../scripts/build-nixos.nix { inherit pkgs; })
  ];

  hardware = {
    opengl.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings.General.ControllerMode = "bredr";
    };
  };

  networking.firewall.enable = false;

  programs.light.enable = true;

  system.stateVersion = "23.05";
}

