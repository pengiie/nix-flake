{ pkgs, lib, config, ... }: let
  enableDroidCam = config.user.obs.droidcam;
in {
  home.packages = lib.mkIf enableDroidCam [
    # adb for droidcam plugin
    pkgs.android-tools
  ];
  programs.obs-studio = with pkgs; {
    enable = true;
    plugins = [
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-pipewire-audio-capture
      obs-studio-plugins.obs-backgroundremoval
    ] ++ lib.lists.optional enableDroidCam obs-studio-plugins.droidcam-obs;
  };
}
