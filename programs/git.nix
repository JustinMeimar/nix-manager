{ config, lib, pkgs, ... }: {

  config = lib.mkIf config.specifics.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = config.specifics.git.userName;
          email = config.specifics.git.userEmail;
        };
        pull.rebase = true;
        init.defaultBranch = "main";
      };  
    };
  };
}
