{ ... }:
{
  # 기본 nvim 만. LazyVim/커스텀 config 는 나중에 ~/.config/nvim 등으로
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
  };

  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.VISUAL = "nvim";
}
