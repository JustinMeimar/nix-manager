{ config, pkgs, ... }:
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
    };
    
    # oh my zsh plugin
    oh-my-zsh = {
	enable = true;
	plugins = [ ];
	theme = "robbyrussell";
    };
    
    # load scripts
    initExtra = concatFilesInDir ./scripts;

    # env vars!
    envExtra = builtins.readFile ./zsh_env.sh; 
  };
}

