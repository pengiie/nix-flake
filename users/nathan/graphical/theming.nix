{ pkgs, ... }: {
  home = {
    pointerCursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;

      # Enable the cursor theme for gtk
      gtk.enable = true;
    };

    packages = with pkgs; [ 
      # Cursors
      bibata-cursors
      
      # Fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      (pkgs.nerdfonts.override { fonts = [ 
        "FiraCode"
        "DaddyTimeMono"
        "CascadiaCode"
      ]; })
    ];
  };

  fonts.fontconfig.enable = true;

  gtk = rec {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme=1
    '';
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = gtk3.extraConfig; 
  };
}
