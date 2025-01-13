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
    ./plugins/vimtext.nix
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
      signcolumn = "yes:1"; # prevent diagnostic flicker
      relativenumber = true;
    };
   
    keymaps = [
      {
        mode = "n";
        key = "<leader>tt";
        action = ":lua vim.diagnostic.disable(0)<CR>";
      }
      {
        mode = "n";
        key = "<leader>TT";
        action = ":lua vim.diagnostic.enable(0)<CR>";
      }
    ]; 
  };
}

