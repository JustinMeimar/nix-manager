{ config, pkgs, ... }:

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
  
  programs.home-manager.enable = true;
}
