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

      # opam (OCaml) 환경: oxcaml switch 의 ocaml, dune, ocamllsp, ocamlformat 을 PATH 에 올린다
      if command -v opam >/dev/null 2>&1; then
        eval "$(opam env 2>/dev/null)"
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
    ./modules/starship.nix
  ];
}
