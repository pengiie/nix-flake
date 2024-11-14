{ config, cutil, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";

    shellIntegration.enableZshIntegration = true;

    font = {
      package = pkgs.comic-mono;
      name = "Comic Mono";
      size = 13.0;
    };

    keybindings = {
      # tab management
      "alt+n" = "new_tab_with_cwd !neighbor";
      "alt+m" = "new_tab !neighbor";
      "alt+q" = "close_tab";

      # movements
      "alt+l" = "next_tab";
      "alt+h" = "previous_tab";
      "alt+shift+l" = "move_tab_forward";
      "alt+shift+h" = "move_tab_backward";
      "alt+tab" = "next_tab";
      "alt+shift+tab" = "previous_tab";
      "alt+u" = "scroll_page_up";
      "alt+d" = "scroll_page_down";

      # map alt+jk to arrow keys
      "alt+j" = "send_text all \\x1b[B";
      "alt+k" = "send_text all \\x1b[A";

      # clipboard
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };

    settings = {
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_align = "left";

      background_opacity = "0.9";
      active_tab_background = cutil.color.shadeHex config.theme.colors.active 0.75;

      scrollback_lines = 10000;
    };
  };
}
