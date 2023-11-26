{ ... }: {
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";

    shellIntegration.enableZshIntegration = true;

    keybindings = {
      "alt+t" = "new_tab";
      "alt+n" = "new_tab_with_cwd";
      "alt+q" = "close_tab";
      "alt+l" = "next_tab";
      "alt+h" = "previous_tab";
      "alt+tab" = "next_tab";
      "alt+shift+tab" = "previous_tab";
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
  };
}
