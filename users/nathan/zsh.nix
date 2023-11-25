{ pkgs, ... }: {
  # Enable shell history
  programs.hstr.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/nathan/flake#desktop";
      update-nathan = "home-manager switch --flake /home/nathan/flake#nathan-desktop";
    };
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    theme = "robbyrussell";
    plugins = [ 
      "cp"
    ];
  };
}
