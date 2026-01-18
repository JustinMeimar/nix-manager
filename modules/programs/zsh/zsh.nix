{ config, lib, pkgs, ... }:
let
  myLib = import ../../../lib { };
  inherit (myLib) concatFilesInDir;
in {
  programs.zsh = {

    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # peak lazy
    shellAliases = {
      ll = "ls -la";
      
      gita = "git add .";
      gitc = "git commit";
      gits = "git status";
      gitd = "git diff";
      gitds = "git diff --staged";

      nv = "nvim .";
      t = "tmux";
    };

    # oh my zsh plugin
    oh-my-zsh = {
      enable = true;
      plugins = [ ];
      theme = "robbyrussell";
    };

    # load scripts
    initContent = "${concatFilesInDir ./scripts}";

    # env vars!
    envExtra = builtins.readFile ./zsh_env.sh;
  };
}

