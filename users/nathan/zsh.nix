{ pkgs, config, ... }: {
  # Enable shell history
  programs.hstr.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    shellAliases = {
      up = "sudo nixos-rebuild switch --flake /home/nathan/flake#${config.host.name}";
      upuser = "home-manager switch --flake /home/nathan/flake#${config.user.name}-${config.host.name}";
      apc = "bluetoothctl connect EC:73:79:35:26:BD";
      apd = "bluetoothctl disconnect EC:73:79:35:26:BD";
    };
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ 
      "cp"
    ];
    extraConfig = ''
      PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;30m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %b%{\e[0;34m%}%B[%b%{\e[1;37m%}%~%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─%B[%{\e[1;35m%}$%{\e[0;34m%}%B] <$(git_prompt_info)>%{\e[0m%}%b '
      PS2=$' \e[0;34m%}%B>%{\e[0m%}%b ' 
    '';
  };
}
