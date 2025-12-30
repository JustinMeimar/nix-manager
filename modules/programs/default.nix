{ config, lib, pkgs, ... }: {

  imports = [
    ./fzf.nix
    ./git.nix
    ./ssh.nix
    ./vim.nix
    ./zoxide.nix
    ./alacritty/alacritty.nix
    ./tmux/tmux.nix
    ./zsh/zsh.nix
    ./nvim/nvim.nix
  ];   
}

