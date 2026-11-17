{ config, lib, pkgs, ... }:
let
  settings = import ./settings.nix;
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = settings.aliases;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "history" ];
      theme = "robbyrussell";
    };

    initContent = builtins.readFile ./zsh_env.sh;
  };
}
