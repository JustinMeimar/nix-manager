{ config, pkgs, ... }:

{
  imports = [
    ../../modules/programs/default.nix
    ../../modules/packages/default.nix
  ];
  
  home = {
    username = "justin";
    homeDirectory = "/home/justin";
    stateVersion = "24.05";
  };
  
  programs.git = {
    enable = true;
    signing.format = null;
    settings = {
      user = {
        name = "justinmeimar";
        email = "meimar@ualberta.ca";
      };
      core.editor = "vim";
      merge.conflictstyle = "zdiff3";
    };
  };

  programs.delta.enable = false;

  programs.plasma = {
    enable = true;
    overrideConfig = false;
    panels = [
      {
        location = "bottom";
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.pager"
          {
            iconTasks = {
              launchers = [
                "applications:bitwarden.desktop"
                "applications:obsidian.desktop"
                "applications:firefox.desktop"
                "applications:zotero.desktop"
                "applications:systemsettings.desktop"
                "applications:discord.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];
  };

  programs.home-manager.enable = true;
}

