{ config, lib, pkgs, ... } : {
  programs.tmux = {

    enable = true;
    mouse = true;
    escapeTime =  0;
    baseIndex= 1;
    historyLimit = 10000;
    keyMode = "vi";
    
    extraConfig = builtins.readFile ./tmux.conf;
  }; 
}

