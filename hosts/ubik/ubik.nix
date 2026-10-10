{ pkgs, ... }:
{
  imports = [
    ../../modules/programs/default.nix
    ../../modules/packages/cli.nix
  ];

  home = {
    username = "justin";
    homeDirectory = "/home/justin";
    stateVersion = "26.05";
    packages = [ pkgs.alacritty pkgs.dolphin-emu ];
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "justinmeimar";
      email = "meimar@ualberta.ca";
    };
  };
  programs.home-manager.enable = true;
  programs.tmux.extraConfig = ''
    set -g @host-color brightmagenta
    set -g @host-label ubik
  '';
}
