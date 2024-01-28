{ ... }:
(final: prev: {
  renderdoc = prev.renderdoc.override {
    waylandSupport = true;
  };
})
