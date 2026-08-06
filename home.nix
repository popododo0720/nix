{ ... }:
{
  targets.genericLinux = {
    enable = true;
    gpu.enable = false;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      if [ -n "''${SSH_CONNECTION:-}" ]; then
        case "''${TERM:-}" in
          xterm|xterm-color|vt100|ansi)
            export TERM=xterm-256color
            ;;
        esac
      fi
    '';
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
    ./modules/tmux.nix
  ];
}
