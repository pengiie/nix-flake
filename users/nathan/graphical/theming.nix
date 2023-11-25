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
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };
}
