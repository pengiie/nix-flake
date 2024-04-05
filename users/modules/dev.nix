{ pkgs, ... }: {
    home.packages = with pkgs; [
      # JS
      nodejs
      yarn

      # C
      cmake
      clangStdenv
      gnumake

      # unfortunately...
      python3
    ];
  }
