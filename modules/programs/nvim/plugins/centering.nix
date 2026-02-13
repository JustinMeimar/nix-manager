{ config, lib, pkgs, ... }: {
  programs.nixvim = {
    plugins.no-neck-pain = {
      enable = true;
      settings = {
        # max width before centering.
        width = 140;
        autocmds = {
          enableOnVimEnter = false;
        };
        buffers = {
          right = {
            enabled = false; # Only show left side buffer for symmetry
          };
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
