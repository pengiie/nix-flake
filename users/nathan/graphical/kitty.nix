{ ... }: {
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    shellIntegration.enableZshIntegration = true;
  };
}
