{ ... }:
(final: prev: {
  google-chrome = prev.google-chrome.override {
    commandLineArgs = "--use-ozone-platform=wayland --enable-features=UseOzonePlatform";
  };
})
