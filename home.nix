{ config, pkgs, ... }:
{
  # Home info
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "24.05";
  
  # imports
  imports = [ 
    ./programs/git.nix
    ./programs/vim.nix
    ./programs/tmux/tmux.nix
    ./programs/zsh/zsh.nix
    ./programs/nvim/nvim.nix
    ./packages/llvm.nix 
  ];

  # Pacakges
  home.packages = [
    pkgs.bat
    pkgs.dust
    pkgs.github-cli
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
    
  # Configure LLVM user library version 
  llvm = {
    enable = true;
    version = "19";
  };

  # Other dotfiles
  home.file = {
    ".config/zellij/config.kdl".source = ./dotfiles/config.kdl;
    ".config/alacritty/alacritty.toml".source = ./dotfiles/alacritty.toml;
  };

  # Environment
  home.sessionVariables = {
    EDITOR = "vim";
  };
  
  # Let home manager self-manage
  programs.home-manager.enable = true;
}
