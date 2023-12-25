{ ... }:
(final: prev: {
  google-chrome = prev.google-chrome.override {
    commandLineArgs = "--use-ozone-platform=wayland --enable-unsafe-webgpu --enable-features=UseOzonePlatform,Vulkan --test-type";
  };
})
