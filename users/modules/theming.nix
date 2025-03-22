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
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      (nerdfonts.override { fonts = [ 
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
      name = "catppuccin-mocha-mauve-compact+rimless";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
    };
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme=1
    '';
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = gtk3.extraConfig; 
  };

  qt = {
    enable = true;
    style.package = pkgs.catppuccin-qt5ct;
    style.name = "catppuccin-mocha-mauve";
  };
  
  nixpkgs.overlays = [
    (final: prev: {
      catppuccin-papirus-folders = prev.catppuccin-papirus-folders.override {
        accent = "mauve";
      };
    })
  ];
}
