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
    ./programs/sops/sops.nix
    ./packages/llvm.nix 
  ];

  # Pacakges
  home.packages = [
    pkgs.age
    pkgs.bat
    pkgs.boost
    pkgs.dust
    pkgs.github-cli
    pkgs.htop
    pkgs.just
    pkgs.jq
    pkgs.lazygit
    pkgs.nodejs_23
    pkgs.oh-my-zsh
    pkgs.ripgrep
    pkgs.sops
    pkgs.sshfs
    pkgs.tree
    pkgs.wget
    pkgs.zellij
    pkgs.fzf
    pkgs.zoxide
  ];
 
  # Configure LLVM user library version 
  llvm = {
    enable = true;
    version = "18";
  };
   
  # Other dotfiles
  home.file = {
    ".config/alacritty/alacritty.toml".source = ./dotfiles/alacritty.toml;
  };

  # Environment
  home.sessionVariables = {
    EDITOR = "vim";
  };
  
  # Let home manager self-manage
  programs.home-manager.enable = true;
}

