{ ... }: {
  imports = [
    ../common

    ./hardware.nix
    ./host.nix
    ./nvidia.nix
  ];
}
