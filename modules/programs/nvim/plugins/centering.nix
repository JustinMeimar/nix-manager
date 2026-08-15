{ config, lib, pkgs, ... }: {
  programs.nixvim = {
    plugins.no-neck-pain = {
      enable = true;
      settings = {
        # max width before centering.
        width = 90;
        autocmds = {
          enableOnVimEnter = false;
        };
      };
    };

    userCommands = {
      CenterBuffer = {
        command = "NoNeckPain";
        desc = "Toggle buffer centering";
      };
    };
  };
}
