{ config, cutil, ... }: {
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

    settings = {
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_align = "left";

      active_tab_background = cutil.color.shadeHex config.theme.colors.active 0.75;
    };
  };
}
