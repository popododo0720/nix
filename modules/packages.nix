{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    fd
    bat
    eza
    jq
    yq-go
    tmux
    btop
    lazygit
  ];
}

