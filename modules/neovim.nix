{ pkgs, rustfmtNightly, ... }:
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

  # nixpkgs 의 golangci-lint 는 go1.26 으로 빌드되어, go.mod 가 1.27 인 모듈을 거부한다.
  # go1.27 로 다시 빌드해서 사용한다.
  golangciLint = pkgs.golangci-lint.override {
    buildGo126Module = pkgs.buildGo127Module;
  };
in
{
  home.packages = with pkgs; [
    neovim
    xsel
    rustc
    cargo
    clippy
    rustfmtNightly
    rust-analyzer
    cargo-generate
    gopls
    gotools
    gofumpt
    golangciLint
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
