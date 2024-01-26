{ pkgs, ... }: {
  home.packages = with pkgs; [
    citra-nightly

    # todo - it doesnt go here but ok
    superTuxKart
    openttd
  ];
}
