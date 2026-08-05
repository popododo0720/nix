{ ... }:
{
  programs.bash.shellAliases = {
    ll = "eza -la --group-directories-first";
    la = "eza -a";
    l = "eza -F";
    ls = "eza";
    cat = "bat -pp";
  };
}
