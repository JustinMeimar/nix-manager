{ config, pkgs, ... }: {
  # Home info
  home.username = "justin";
  home.homeDirectory = "/home/justin";
  home.stateVersion = "24.05";

  # Pacakges
  home.packages = [

    # Low config command line tools
    pkgs.age
    pkgs.bat
    pkgs.dust
    pkgs.docker-compose
    pkgs.github-cli
    pkgs.htop
    pkgs.just
    pkgs.jq
    pkgs.lazygit
    pkgs.mutagen
    pkgs.opam
    pkgs.ripgrep
    pkgs.rr
    pkgs.sshfs
    pkgs.tree
    pkgs.typst
    pkgs.tinymist
    pkgs.wget
    pkgs.zathura

    # Todo: find place
    pkgs.ninja
    pkgs.sops

    # Todo: categorically different...
    # pkgs.nodejs_23
    # pkgs.boost
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

