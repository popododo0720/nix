{ ... }:
{
  # 프롬프트: starship 공식 Jetpack 프리셋 (Nerd Font 불필요)
  # modules/starship.toml 은 `starship preset jetpack` 원본 + OCaml 표시 추가분
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
