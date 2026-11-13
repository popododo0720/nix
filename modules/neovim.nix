{ pkgs, ... }:
let
  lib = pkgs.lib;

  # nixpkgs 최신에서는 nvim-treesitter.withPlugins 가 파서를 포함하지 않는다.
  # grammarPlugins 의 parser/*.so 를 모아 runtimepath 에 직접 올린다.
  grammarPlugins = pkgs.vimPlugins.nvim-treesitter.passthru.grammarPlugins;
  grammars = [
    "bash"
    "python"
    "nix"
    "yaml"
    "lua"
    "json"
    "markdown"
    "markdown_inline"
    "vim"
    "vimdoc"
    "regex"
    "toml"
    "html"
    "css"
    "hcl"
    "terraform"
    "rust"
    "go"
    "gomod"
    "gosum"
    "gowork"
  ];

  tsParsers = pkgs.runCommand "nvim-treesitter-parsers" { } ''
    mkdir -p $out/parser
    ${lib.concatMapStringsSep "\n" (
      n: "cp -f ${grammarPlugins.${n}}/parser/*.so $out/parser/"
    ) grammars}
  '';
in
{
  home.packages = with pkgs; [
    neovim
    xsel
    rustc
    cargo
    clippy
    rustfmt
    rust-analyzer
    gopls
    gotools
    gofumpt
    golangci-lint
    delve
  ];

  xdg.configFile."nvim/init.lua".source = ../config/nvim/init.lua;

  xdg.dataFile."nvim/site/pack/nix/start/nvim-treesitter".source =
    pkgs.vimPlugins.nvim-treesitter;
  xdg.dataFile."nvim/site/pack/nix/start/ts-parsers".source = tsParsers;
  xdg.dataFile."nvim/site/pack/nix/start/blink-cmp".source = pkgs.vimPlugins.blink-cmp;
  xdg.dataFile."nvim/site/pack/nix/start/nvim-lspconfig".source = pkgs.vimPlugins.nvim-lspconfig;
  xdg.dataFile."nvim/site/pack/nix/start/nvim-lint".source = pkgs.vimPlugins.nvim-lint;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
  };

  programs.bash.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
}
