{ ... }:
{
  targets.genericLinux.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  imports = [
    ./modules/aliases.nix
    ./modules/packages.nix
    ./modules/fzf.nix
    ./modules/zoxide.nix
    ./modules/neovim.nix
  ];
}
