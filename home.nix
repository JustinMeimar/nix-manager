{ config, pkgs, ... }:
{
  # Home info
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "24.05";
  
  # imports
  imports = [
    ./programs/vim.nix
    ./programs/zsh/zsh.nix
    ./programs/nvim/nvim.nix
  ];

  # Pacakges
  home.packages = [
    pkgs.dust
    pkgs.htop
    pkgs.just
    pkgs.lazygit
    pkgs.oh-my-zsh
    pkgs.ripgrep
    pkgs.tree
    pkgs.wget
    pkgs.zellij
    pkgs.zoxide
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
