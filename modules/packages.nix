{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    fd
    bat
    eza
    jq
    yq-go
    btop
    lazygit
    nil
    nixfmt-rfc-style
    lua-language-server
    pyright
    yaml-language-server
    bash-language-server
    marksman
    wget
  ];
}
