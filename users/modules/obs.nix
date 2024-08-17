{ pkgs, lib, config, ... }: let
  enableDroidCam = config.user.obs.droidcam;
  catppuccin-obs-theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "obs";
    rev = "refs/pull/8/head";
    hash = "sha256-j905gMz6ieVFaaSv00S5ANKwlQGqa0v9qwxwgzt2V0o=";
  };
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

  home.file.".config/obs-studio/themes" = {
    source = "${catppuccin-obs-theme}/themes";
    recursive = true;
  };
  
}
