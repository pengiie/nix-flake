{ config, ... }: {
  programs.git = {
    enable = true;
    userName = config.user.git.name;
    userEmail = config.user.git.email;

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}
