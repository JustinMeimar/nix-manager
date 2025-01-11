{ config, pkgs, ... }:
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

    # custom scripts to expose to shell
    initExtra = builtins.readFile ./scripts/copy.sh;
    
    # env vars!
    envExtra = builtins.readFile ./zsh_env.sh; 
  };
}

