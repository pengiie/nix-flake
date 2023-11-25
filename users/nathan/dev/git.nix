{ ... }: {
  programs.git = {
    enable = true;
    userName = "pengiie";
    userEmail = "nathan@pengie.dev";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # Github cli and git credentials helper
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}
