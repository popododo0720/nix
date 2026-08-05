{ ... }:
{
  targets.genericLinux = {
    enable = true;
    gpu.enable = false;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  news.display = "silent";

  imports = [
    ./modules/aliases.nix
    ./modules/packages.nix
    ./modules/fzf.nix
    ./modules/zoxide.nix
    ./modules/neovim.nix
    ./modules/git.nix
    ./modules/gh.nix
  ];
}
