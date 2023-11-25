# Common configuration for all users.
{ config, ... }: {
  imports = [
    ./user
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  nix.packages = pkgs.nixFlakes;

  home = {
    name = config.user.name;
    homeDirectory = "/home/${config.user.name}";
    stateVersion = "23.05";
  };

  systemd.user.startServices = true;
  programs.home-manager.enable = true;
}
