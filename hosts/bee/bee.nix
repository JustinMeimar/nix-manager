{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/programs/default.nix
    ../../modules/packages/default.nix
  ];
     
  home = {
    username = "justin";
    homeDirectory = "/home/justin";
    stateVersion = "24.05"; 
  };
  
  home.packages = [
    pkgs.claude-code 
    pkgs.signal-cli
    pkgs.qrencode
    pkgs.ripgrep
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "justinmeimar";
        email = "meimar@ualberta.ca";
      };
    }; 
  }; 

  programs.zsh.initExtra = lib.mkAfter ''
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
  '';
  rust.enable = true;
  
  # allow home-manager to manage itself
  programs.home-manager.enable = true;
}

