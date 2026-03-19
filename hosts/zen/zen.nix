{ config, pkgs, ... }:

{
  imports = [
    ../../modules/programs/default.nix
  ];
  
  home.packages = [
    pkgs.age
    pkgs.bat
    pkgs.claude-code
    pkgs.cloc
    pkgs.curl
    pkgs.docker-compose
    pkgs.dune_3
    pkgs.dust
    pkgs.github-cli
    pkgs.htop
    pkgs.jq
    pkgs.just
    pkgs.lazygit
    pkgs.mutagen

    pkgs.fastfetch
    pkgs.ninja
    pkgs.ocaml
    pkgs.opam
    pkgs.psmisc
    pkgs.radare2
    pkgs.ripgrep
    pkgs.rr
    pkgs.ruff
    pkgs.sops
    pkgs.sox
    pkgs.sshfs
    pkgs.tinymist
    pkgs.tree
    pkgs.typst
    pkgs.usbutils
    pkgs.uv
    pkgs.wl-clipboard
    pkgs.wget
    pkgs.zathura
    pkgs.boost
  ];
  
  home = {
    username = "justin";
    homeDirectory = "/home/justin";
    stateVersion = "24.05";
  };
  
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "justinmeimar";
        email = "meimar@ualberta.ca";
      };
      core.editor = "vim";
    };
  }; 
  
  # allow home-manager to manage itself
  programs.home-manager.enable = true;
}

