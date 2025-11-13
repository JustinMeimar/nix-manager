{ config, lib, ... }:
  let homeOpts = config.specifics.home; 
in { 
  home = lib.mkIf homeOpts.enable {
    username = homeOpts.username;
    homeDirectory = homeOpts.homeDirectory;
    stateVersion = homeOpts.stateVersion;
    
    # probably defaults
    packages = homeOpts.packages;
    sessionVariables = homeOpts.sessionVariables; 
    file = homeOpts.file;
  };

  # Let home manager self-manage
  programs.home-manager.enable = true;
}

