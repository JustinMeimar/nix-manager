{ config, lib, pkgs, ... } :
let
  concatFilesInDir = dirPath: 
    let
      files = builtins.attrNames (builtins.readDir dirPath);
      regularFiles = builtins.filter (name: 
        (builtins.readDir dirPath).${name} == "regular"
      ) files;
      contents = map (file: builtins.readFile "${dirPath}/${file}") regularFiles;
    in
      builtins.concatStringsSep "" contents;
in
{
  programs.zsh = {
    
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true; 
    
    # peak lazy
    shellAliases = {
      ll = "ls -la";
      gita = "git add";
      gitc = "git commit";
      gits = "git status";
      nv = "nvim .";
    };
    
    # oh my zsh plugin
    oh-my-zsh = {
      enable = true;
      plugins = [ ];
      theme = "robbyrussell";
    };
    
    # load scripts
    initExtra = ''
      ${concatFilesInDir ./scripts}
      if command -v tmux &> /dev/null && [ -n "$PS1" ] \
                                      && [[ ! "$TERM" =~ screen ]] \
                                      && [[ ! "$TERM" =~ tmux ]] \
                                      && [ -z "$TMUX" ]; then
        exec tmux new-session -A -s main
      fi
    '';

    # env vars!
    envExtra = builtins.readFile ./zsh_env.sh; 
  };
}

