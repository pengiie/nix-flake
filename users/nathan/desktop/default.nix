{ pkgs, ... }: {
  home.packages = with pkgs; [
    krita
    goxel
    prismlauncher
    wireshark
    lmms
    libreoffice
    scarab
  ];
}
