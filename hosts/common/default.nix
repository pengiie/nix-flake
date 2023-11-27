{ config, pkgs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  system.stateVersion = "23.05";

  # Zsh shell
  programs.zsh.enable = true;

  # Boot options
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nathan-${config.host.name}";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  # Locale
  time.timeZone = "America/Arizona";
  i18n.defaultLocale = "en_US.UTF-8";

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # DConf settings
  programs.dconf.enable = true;

  # Users
  users.users.nathan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];

    # Set the user shell to zsh
    shell = pkgs.zsh;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
  ];

  # Htop, the task manager of linux kinda
  programs.htop = {
    enable = true;
    settings.show_program_path = false;
  };

  # Enable OpenGL support
  hardware.opengl.enable = true;

  # XDG portal support
  #xdg.portal = {
  #  enable = true;
  #  extraPortals = with pkgs; [
  #    xdg-desktop-portal
  #    xdg-desktop-portal-hyprland
  #  ];
  #};

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.ControllerMode = "bredr";
    settings.Policy.ReconnectAttemps=0;
  };

}
