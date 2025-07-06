{ config, pkgs, ... }: let
  scarlett2 = pkgs.callPackage ./scarlett.nix {};
in {
  imports = [
    ./firewall.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.optimise = {
    automatic = true;
    dates = [ "Mon *-*-* 12:00:00" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "23.05";

  # Zsh shell
  programs.zsh.enable = true;

  # Boot options
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # OBS Virtual Camera
  security.polkit.enable = true;
  # boot.kernelModules = [
  #   "v4l2loopback"
  # ];
  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   v4l2loopback
  # ];

  # Scarlett Solo Gen 4 support.
  #    # options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
  boot.extraModprobeConfig = ''
    options snd_usb_audio vid=0x1235 pid=0x8218 device_setup=1,1,1,1
  '';

  # Networking
  networking.hostName = "nathan-${config.host.name}";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";

  # DConf settings
  programs.dconf.enable = true;

  # Users
  users.users.nathan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "libvirtd" ];

    # Set the user shell to zsh
    shell = pkgs.zsh;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    pamixer
    xdg-utils
    scarlett2
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Htop, the task manager of linux kinda
  programs.htop = {
    enable = true;
    settings.show_program_path = false;
  };

  # Enable OpenGL support
  # hardware.opengl.enable = true;
  # hardware.opengl.driSupport = true;
  # hardware.opengl.driSupport32Bit = true;
  # hardware.opengl.extraPackages = with pkgs; [
  #   vaapiVdpau
  #   libvdpau-va-gl
  # ];

  # Hyprland ( Enables other necessary components )
  programs.hyprland.enable = true;

  # Pipewire support
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/51-no-auto-headset-switch.conf" ''
          wireplumber.settings = {
            bluetooth.autoswitch-to-headset-profile = false
          }

          monitor.bluez.properties = {
            bluez5.roles = [ a2dp_sink a2dp_source ]
          }
        '')
      ];
    };
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.ControllerMode = "bredr";
    settings.Policy.ReconnectAttempts=0;
  };

}
