{ browser-previews, system, ... }:
(final: prev: {
  google-chrome-dev = browser-previews.packages.${system}.google-chrome-dev.override {
    commandLineArgs = "--enable-unsafe-webgpu --enable-features=Vulkan --test-type";
  };
})
