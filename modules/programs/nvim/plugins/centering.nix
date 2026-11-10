{ config, lib, pkgs, ... }: {
  # :CenterBuffer is defined in ../lua/centering.lua
  programs.nixvim.plugins.no-neck-pain = {
    enable = true;
    settings.autocmds.enableOnVimEnter = false;
  };
}
