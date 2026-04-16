{ config, lib, pkgs, ... }:
let
  myLib = import ../../../lib { };
  inherit (myLib) concatDirFiles;
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      lsdir = "ls -d */";
      ll = "ls -la";
      gita = "git add .";
      gitc = "git commit";
      gits = "git status";
      gitd = "git diff";
      gitds = "git diff --staged";
      nv = "nvim .";
      t = "tmux";
      b = "z ..";
      b2 = "z ../..";
      b3 = "z ../../../";
      dog = "bat --style=plain --paging=never";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "history" ];
      theme = "robbyrussell";
    };

    initContent = "${concatDirFiles ./scripts}";
    envExtra = builtins.readFile ./zsh_env.sh;
  };
}

