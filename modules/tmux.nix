{ ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;

    extraConfig = ''
      set -s set-clipboard on
      set -as terminal-features ',xterm-256color:set-clipboard'
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
    '';
  };
}
