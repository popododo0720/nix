{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.bash.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
}
