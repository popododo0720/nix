{ pkgs, ... }:
{
  home.packages = with pkgs; [ gh ];

  programs.git.settings.credential = {
    "https://github.com" = {
      helper = [
        ""
        "${pkgs.gh}/bin/gh auth git-credential"
      ];
    };
    "https://gist.github.com" = {
      helper = [
        ""
        "${pkgs.gh}/bin/gh auth git-credential"
      ];
    };
  };
}
