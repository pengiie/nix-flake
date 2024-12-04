{ pkgs, lib, ... }: {
  imports = [
    ../common

    ./hardware.nix
    ./config.nix
    ./nvidia.nix
    ./nginx.nix
  ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false; 
  };

  programs.ssh.startAgent = true;

  hardware.opentabletdriver.enable = true;

  users.users."nathan".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGKjnG27iMrDlET2Wxs58otPJBqwW0y5WR1GNRgjPF+6 desktop"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.gamescope.enable = true;

  services.pipewire.jack.enable = true;
  services.pipewire.extraConfig.pipewire = {
    "default.clock.rate" = 48000;
  };
  # Persist the auto-mute = false for speaker in alsa mixer
  hardware.alsa.enablePersistence = true;
  programs.noisetorch.enable = true;

  networking.firewall.checkReversePath = "loose";
  networking.nameservers = lib.mkForce [ "10.2.0.1" ];

  # MTP support
  services.gvfs.enable = true;
}
