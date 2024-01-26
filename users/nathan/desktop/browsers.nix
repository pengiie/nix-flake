{ pkgs, ... }: {
  home.packages = with pkgs; [
    google-chrome-dev
    floorp
  ];
}
