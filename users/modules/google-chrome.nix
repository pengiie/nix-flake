{ pkgs, nixpkgs, ... }: {
  home.packages = with pkgs; [
    google-chrome
  ];

  nixpkgs.overlays = [
    (final: prev: {
      google-chrome = prev.google-chrome.override {
        commandLineArgs = "--use-ozone-platform=wayland --enable-unsafe-webgpu --enable-features=UseOzonePlatform,Vulkan,VaapiVideoDecoder --test-type";
      };
    })
  ];
}
