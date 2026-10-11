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
    packages = with pkgs; [
      alacritty
      bitwarden-desktop
      dolphin-emu
    ];
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "justinmeimar";
      email = "meimar@ualberta.ca";
    };
  };
  programs.home-manager.enable = true;
  programs.plasma = {
    enable = true;
    overrideConfig = false;
    workspace.colorScheme = "BreezeDark";
    shortcuts."Alacritty.desktop"."_launch" = "Ctrl+Alt+T";
    configFile."kdeglobals"."General" = {
      TerminalApplication = "alacritty";
      TerminalService = "Alacritty.desktop";
    };
  };
  programs.tmux.extraConfig = ''
    set -g @host-color '#ff8800'
    set -g @host-label ubik
  '';
}
