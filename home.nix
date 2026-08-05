{ ... }:
{
  # Ubuntu 등 비-NixOS (PATH/session 연동용). GPU/데스크톱 통합은 끔.
  targets.genericLinux = {
    enable = true;
    gpu.enable = false;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  # HM 뉴스 출력 줄이기
  news.display = "silent";

  imports = [
    ./modules/aliases.nix
    ./modules/packages.nix
    ./modules/fzf.nix
    ./modules/zoxide.nix
    ./modules/neovim.nix
  ];
}
