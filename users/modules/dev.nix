{ pkgs, ... }: {
    home.packages = with pkgs; [
      # JS
      nodejs
      yarn

      gdb
      valgrind

      # C
      cmake
      clangStdenv
      gnumake

      # unfortunately...
      python3
    ];
  }
