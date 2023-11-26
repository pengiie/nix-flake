{ ... }: {
  programs.git = {
    enable = true;
    userName = "pengiie";
    userEmail = "nathan@pengie.dev";


    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  # Github cli and git credentials helper
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}
