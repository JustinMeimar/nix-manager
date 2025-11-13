{ config, pkgs, ... }: {
  
  # Home info
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "24.05";

  # Pacakges
  home.packages = [
    pkgs.age
    pkgs.bat
    pkgs.dust
    pkgs.github-cli
    pkgs.htop
    pkgs.just
    pkgs.jq
    pkgs.lazygit
    pkgs.mutagen
    pkgs.ripgrep
    pkgs.rr
    pkgs.sshfs
    pkgs.tree 
    pkgs.wget
  ];

  # Other dotfiles
  home.file = {
    ".config/alacritty/alacritty.toml".source = ./dotfiles/alacritty.toml;
  };

  # Environment
  home.sessionVariables = { EDITOR = "vim"; };

  # Let home manager self-manage
  programs.home-manager.enable = true;
}

