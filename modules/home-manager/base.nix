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

  # Anything in a module which changes depending on the host.
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
  };
}

