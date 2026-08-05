{ pkgs, ... }:
{
  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fzf
    zoxide
  ];

  programs.bash.enable = true;
}
