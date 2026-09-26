{ config, lib, pkgs, ... }:
let
  myLib = import ../../../lib {};
  homePath = path: if lib.hasPrefix "/" path then path else "$HOME/${path}";
in {
  home.sessionPath = map homePath [
    ".rbenv/shims"
    ".rbenv/bin"
    ".npm-global/bin"
    ".bun/bin"
    ".pixi/bin"
    "install/cmake/bin"
    "CDOL/Tester/bin"
    "install/zig"
    "/usr/local/go/bin"
    "go/bin"
    ".deno/bin"
    "/home/linuxbrew/.linuxbrew/bin"
    ".local/bin"
    ".cargo/bin"
    "bin"
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      lsdir = "ls -d */";
      ll = "ls -la";
      gita = "git add";
      gitc = "git commit";
      gits = "git status";
      gitd = "git diff";
      gitds = "git diff --staged";
      gitl = "git log | bat";
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

    initContent = builtins.readFile ./zsh_env.sh + "\n"
      + myLib.concatDirFiles ./scripts;
  };
}
