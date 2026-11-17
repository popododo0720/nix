{ ... }:
{
  # jj (Jujutsu): git 저장소 위에서 동작하는 버전 관리 도구
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "popododo0720";
        email = "popododo0720@naver.com";
      };
      ui = {
        editor = "nvim";
        default-command = "log";
        diff-formatter = ":git";
        pager = "delta";
      };
    };
  };
}
