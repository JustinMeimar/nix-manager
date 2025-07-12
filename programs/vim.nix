{ config, lib, pkgs, ... } : {
  programs.vim = {
    enable = true;
    settings = {
      expandtab = true;
      tabstop = 4;
      shiftwidth = 4;
      number = true;
    };
    extraConfig = ''
      set clipboard+=unnamedplus
      set autoindent
      set smartindent
    '';
  };
}	
