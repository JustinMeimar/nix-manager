{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.programs.git.enable {
    programs.git.settings = {
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };
}
