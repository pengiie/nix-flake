{ pkgs, ... }: {
  programs.obs-studio = {
    enable = true;
    plugins = [
      pkgs.obs-studio-plugins.wlrobs
      pkgs.obs-studio-plugins.obs-multi-rtmp
      pkgs.obs-studio-plugins.droidcam-obs
    ];
  };
}
