{ pkgs, ... }:
{
  imports = [
    ../../modules/programs/terminal.nix
  ];
  home = {
    username = "justin";
    homeDirectory = "/home/justin";
    stateVersion = "24.05";
    packages = with pkgs; [ ripgrep fd bat jq htop rsync just ];
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "JustinMeimar";
      email = "meimar@ualberta.ca";
    };
  };

  programs.home-manager.enable = true;
  programs.tmux.extraConfig = ''
    set -g @host-color brightred
    set -g @host-label pi
  '';
  programs.neovim.enable = true;
}
