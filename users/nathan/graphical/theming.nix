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

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
