{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    envExtra = ''
      export ZSH_FROM_NIX="hi from nix"
    '';
  };

  # Sill manage zsh via .zshrc
  home.file = {
    ".zshrc".source = ./zshrc;
  };
}

