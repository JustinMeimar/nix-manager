{ pkgs, ... }: {
  home.packages = with pkgs; [
    age
    bandwhich
    claude-code
    delta
    difftastic
    direnv
    docker-compose
    gdb
    github-cli
    gnupg
    just
    lazygit
    mutagen
    nix-tree
    python3
    radare2
    rr
    sops
    sshfs
    strace
    valgrind
  ];
}
