{ pkgs, ... }:
let
  ts = pkgs.vimPlugins.nvim-treesitter.withPlugins (
    p: with p; [
      bash
      python
      nix
      yaml
      lua
      json
      markdown
      markdown_inline
      vim
      vimdoc
      regex
      toml
      html
      css
    ]
  );
in
{
  home.packages = with pkgs; [
    neovim
  ];

  xdg.dataFile."nvim/site/pack/nix/start/nvim-treesitter".source = ts;
  xdg.dataFile."nvim/site/pack/nix/start/blink-cmp".source = pkgs.vimPlugins.blink-cmp;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.bash.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
}
