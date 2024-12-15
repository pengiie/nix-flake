{ pkgs, ... }: let in {
  
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
    (python3.withPackages (python-pkgs: [
      python-pkgs.pip
      python-pkgs.setuptools
      python-pkgs.srt
      # TODO: Package https://github.com/alphacep/vosk-api/tree/master/python so we can have kdenlive tts
    ]))

  ];

  programs.btop = {
    enable = true;
  };
}
