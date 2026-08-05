{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "popododo0720";
        email = "popododo0720@naver.com";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
      core.editor = "nvim";
      color.ui = "auto";
      push.autoSetupRemote = true;
      alias = {
        st = "status -sb";
        co = "checkout";
        br = "branch";
        ci = "commit";
        lg = "log --oneline --graph --decorate -20";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
      side-by-side = true;
    };
  };
}
