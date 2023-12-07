{ config, pkgs, ... }: {
  imports = [
    ./firewall.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  system.stateVersion = "23.05";

  # Zsh shell
  programs.zsh.enable = true;

  # Boot options
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # OBS Virtual Camera
  security.polkit.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=i
  '';

  # Networking
  networking.hostName = "nathan-${config.host.name}";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "America/Arizona";
  i18n.defaultLocale = "en_US.UTF-8";

  # DConf settings
  programs.dconf.enable = true;

  # Users
  users.users.nathan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];

    # Set the user shell to zsh
    shell = pkgs.zsh;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    networkmanagerapplet
    pamixer
    xdg-utils
  ];

  # Htop, the task manager of linux kinda
  programs.htop = {
    enable = true;
    settings.show_program_path = false;
  };

  # Enable OpenGL support
  hardware.opengl.enable = true;

  # XDG portal support
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  # Pipewire support
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.ControllerMode = "bredr";
    settings.Policy.ReconnectAttempts=0;
  };

}
