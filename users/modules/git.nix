{ config, ... }: {
  programs.git = {
    enable = true;
    userName = config.user.git.username;
    userEmail = config.user.git.email;


    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  # Github cli and git credentials helper
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;

    settings = {
      # Workaround for https://github.com/nix-community/home-manager/issues/4744
      version = 1;
    };
  };
}
