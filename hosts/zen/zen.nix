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
    pkgs.cargo
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
    pkgs.python3
    pkgs.psmisc
    pkgs.radare2
    pkgs.ripgrep
    pkgs.rr
    pkgs.ruff
    pkgs.sops
    pkgs.sox
    pkgs.ffmpeg
    pkgs.gnupg
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
    pkgs.openssl
    pkgs.eza
    pkgs.fd
    pkgs.yq
    pkgs.hexyl
    pkgs.hyperfine
    pkgs.delta
    pkgs.difftastic
    pkgs.gdb
    pkgs.valgrind
    pkgs.strace
    pkgs.btop
    pkgs.bandwhich
    pkgs.duf
    pkgs.tldr
    pkgs.nix-tree
    pkgs.direnv
    pkgs.poppler-utils
    pkgs.zip
    pkgs.unzip
  ];
  
  home = {
    username = "justin";
    homeDirectory = "/home/justin";
    stateVersion = "24.05";
  };
  
  programs.git = {
    enable = true;
    delta.enable = false;
    settings = {
      user = {
        name = "justinmeimar";
        email = "meimar@ualberta.ca";
      };
      core.editor = "vim";
      delta = {
        navigate = true;
        side-by-side = true;
      };
      merge.conflictstyle = "zdiff3";
    };
  }; 
  
  # allow home-manager to manage itself
  programs.home-manager.enable = true;
}

