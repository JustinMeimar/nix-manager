{ config, lib, pkgs, ... }: {

  imports = [
    ../../home.nix
    ../../programs/git.nix
    ../../programs/vim.nix
    ../../programs/fzf.nix
    ../../programs/zoxide.nix
    ../../programs/ssh.nix
    ../../programs/tmux/tmux.nix
    ../../programs/zsh/zsh.nix
    ../../programs/nvim/nvim.nix
  ];
    
  # interface which hosts implement to provide system
  # specific information.
  options.specifics = {
    git = {
      enable = lib.mkEnableOption "git";
      userName = lib.mkOption {
        type = lib.types.str;
        description = "Git user name";
      };
      userEmail = lib.mkOption {
        type = lib.types.str;
        description = "Git email";
      };
    };
    home = {
      enable = lib.mkEnableOption "home";
      username = lib.mkOption {
        type = lib.types.str;
        description = "Username on system";
      };
      homeDirectory = lib.mkOption {
        type = lib.types.str;
        description = "Home directory on system";
      };
      stateVersion = lib.mkOption {
        type = lib.types.str;
        description = "Home manager version.";
      };
      packages = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        description = "Basic packages to install";
        default = [
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
      };
      # defaults
      sessionVariables = lib.mkOption {
        type = lib.types.attrs;
        default = { EDITOR = "vim"; };
        description = "Session environment variables";
      };
      file = lib.mkOption {
        type = lib.types.attrs;
        default = {};
        description = "Files to link into home directory";
      };
    };
  };
}

