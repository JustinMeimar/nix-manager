{ pkgs, ... }:
{
  imports = [
    ../../modules/programs/terminal.nix
  ];
  home = {
    username = "justin";
    homeDirectory = "/home/justin";
    stateVersion = "24.05";
    packages = with pkgs; [ ripgrep fd bat jq htop rsync ];
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "JustinMeimar";
      email = "meimar@ualberta.ca";
    };
  };

  programs.home-manager.enable = true;
  programs.neovim.enable = true;
}
