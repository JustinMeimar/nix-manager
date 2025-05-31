{ config, pkgs, ... }:

{
  imports = [
    ./plugins/bar.nix
    ./plugins/cmp.nix
    ./plugins/comment.nix
    ./plugins/lsp.nix
    ./plugins/md.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
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
      expandtab = true;
      shiftwidth = 4;
      clipboard = "unnamedplus";
      signcolumn = "yes:1"; # prevent diagnostic flicker
      relativenumber = true;
    };
         
    extraConfigLua = builtins.readFile(./lua/lsp_tblgn_compilation_db.lua) + "\n" + 
                     builtins.readFile(./lua/keymaps.lua);
  };
}

