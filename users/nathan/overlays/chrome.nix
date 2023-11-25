{...}:
(final: prev: {
  google-chrome = prev.google-chrome.override {
    commandLineArgs = [
      "--ozone-platform=wayland"
    ];
  };
})
