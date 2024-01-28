{ pkgs, ... }: {
  imports = [
    ./browsers.nix
  ];

  home.packages = with pkgs; [
    citra-nightly

    krita
    goxel
    prismlauncher
    wireshark
    lmms
    libreoffice
    scarab
  ];
}
