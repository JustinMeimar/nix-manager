{ config, pkgs, ... }:
{
  # Home info
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "24.05";
  
  # imports
  imports = [
    ./dotfiles/zsh/zsh.nix
    ./dotfiles/tmux/tmux.nix
  ];

  # Pacakges
  home.packages = [
    pkgs.dust
    pkgs.htop
    pkgs.oh-my-zsh
    pkgs.tree
    pkgs.wget
    pkgs.zellij
    pkgs.zsh
  ];
  
  # Other dotfiles
  home.file = {
    ".config/zellij/config.kdl".source = ./dotfiles/zellij/config.kdl;
  };  

  # Environment
  home.sessionVariables = {
    EDITOR = "vim";
  };
  
  # Let home manager self-manage
  programs.home-manager.enable = true;
}
