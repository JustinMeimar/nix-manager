{ config, pkgs, ... }:

{
  imports = [
    ./plugins/treesitter.nix
    ./plugins/lsp.nix
  ];

  programs.nixvim = { 
    enable = true;

    colorschemes.catppuccin.enable = true; 
    plugins.lualine.enable = true;  
  
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    opts = {
	number = true;
	shiftwidth = 2;
	clipboard = "unnamedplus";
    };
  };
}

