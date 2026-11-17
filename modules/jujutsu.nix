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
      aliases = {
        # 가장 가까운 bookmark(main 등)를 방금 완성한 커밋(@-)으로 옮기기
        tug = [
          "bookmark"
          "move"
          "--from"
          "heads(::@- & bookmarks())"
          "--to"
          "@-"
        ];
      };
    };
  };
}
