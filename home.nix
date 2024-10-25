{ config, pkgs, ... }:
{
  # Home info
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "24.05";
  
  # imports
  imports = [
    ./programs/zsh.nix
    ./programs/vim.nix
    ./programs/nvim/nvim.nix
  ];

  # Pacakges
  home.packages = [
    pkgs.dust
    pkgs.htop
    pkgs.just
    pkgs.oh-my-zsh
    pkgs.ripgrep
    pkgs.tree
    pkgs.wget
    pkgs.zellij
  ];
  
  # Other dotfiles
  home.file = {
    ".config/zellij/config.kdl".source = ./dotfiles/config.kdl;
    ".tmux.conf".source = ./dotfiles/tmux.conf;
    ".config/alacritty/alacritty.toml".source = ./dotfiles/alacritty.toml;
  };

  # Environment
  home.sessionVariables = {
    EDITOR = "vim";
  };
  
  # Let home manager self-manage
  programs.home-manager.enable = true;
}
