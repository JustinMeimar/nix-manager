{ config, lib, pkgs, ... }: {

  config = lib.mkIf config.specifics.git.enable {
    programs.git = {
      enable = true;
      userName = config.specifics.git.userName;
      userEmail = config.specifics.git.userEmail;
      extraConfig = {
        pull.rebase = true;
        init.defaultBranch = "main";
      };
    };
  };
}
