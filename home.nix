{ config, pkgs, ... }:
{
  # Home info
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "24.05";
  
  # Pacakges
  home.packages = [
    pkgs.zsh
    pkgs.dust
    pkgs.tree
  ];
  
  # Dotfiles
  home.file = {
    "foo.txt".text = "bar";
    ".zshrc".source = dotfiles/.zshrc; 
    ".tmux.conf".source = dotfiles/.tmux.conf; 
  };
  
  # Environment
  home.sessionVariables = {
    EDITOR = "vim";
  };
  
  # Let home manager self-manage
  programs.home-manager.enable = true;
}
