{ pkgs, ... }: {
  home.packages = with pkgs; [
    # adb for droidcam plugin
    android-tools
  ];
  programs.obs-studio = {
    enable = true;
    plugins = [
      pkgs.obs-studio-plugins.wlrobs
      pkgs.obs-studio-plugins.obs-multi-rtmp
      pkgs.obs-studio-plugins.droidcam-obs
      pkgs.obs-studio-plugins.obs-pipewire-audio-capture
      pkgs.obs-studio-plugins.obs-backgroundremoval
      pkgs.obs-studio-plugins.obs-livesplit-one
    ];
  };
}
