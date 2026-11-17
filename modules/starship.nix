{ ... }:
{
  # 프롬프트: 디렉터리, git 브랜치/상태, 언어 버전(OCaml 은 opam switch 까지), 명령 실행 시간 등을 표시
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      command_timeout = 1000;
      # SSH 로 접속했을 때만 user@host 표시
      username.show_always = false;
      hostname.ssh_only = true;
      # 2초 넘게 걸린 명령만 실행 시간 표시
      cmd_duration.min_time = 2000;
    };
  };
}
