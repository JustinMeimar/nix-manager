{ config, pkgs, ...}:

{
  programs.tmux = {

    enable = true;
    mouse = true;
    escapeTime =  0;
    baseIndex= 1;
    historyLimit = 10000;
    keyMode = "vi";
    
    extraConfig = builtins.readFile ./tmux.conf;

    # TODO: Setup TMUX plugins 
    # extraConfig = builtins.readFile ./tmux.conf +
    # ''
    #   set -g @plugin 'jimeh/tmux-themepack'
    #   set -g @plugin 'tmux-plugins/tpm'
    #
    #   run-shell ~/.tmux/plugins/tpm/tpm
    # ''; 
  };
  
  # TODO: ^
  # home.file = {
  #   ".tmux/plugins/tpm".source = pkgs.fetchFromGitHub {
  #     owner = "tmux-plugins";
  #     repo = "tpm";
  #     rev = "v3.1.0";
  #     sha256 = "sha256-CeI9Wq6tHqV68woE11lIY4cLoNY8XWyXyMHTDmFKJKI=";
  #   };
  # };
}

