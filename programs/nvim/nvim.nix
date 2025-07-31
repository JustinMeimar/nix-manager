{ config, lib, pkgs, ... }:
let
  concatFilesInDir = dirPath: 
    let
      files = builtins.attrNames (builtins.readDir dirPath);
      regularFiles = builtins.filter (name: 
        (builtins.readDir dirPath).${name} == "regular"
      ) files;
      contents = map (file: builtins.readFile "${dirPath}/${file}") regularFiles;
    in
      builtins.concatStringsSep "" contents;
in
{
  imports = [
    ./plugins/bar.nix
    ./plugins/cmp.nix
    ./plugins/comment.nix
    ./plugins/fmt.nix
    ./plugins/lsp.nix
    ./plugins/md.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/gitsigns.nix
  ];

  programs.nixvim = {

    enable = true; 
    colorschemes.catppuccin.enable = true; 
    
    plugins = {
      lualine = {
        enable = true;
      }; 
      typst-vim = {
        enable = true;
      };
    }; 

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
      scrolloff = 10;
    };
      
    autoCmd = [
      {
        event = ["FileType"];
        pattern = ["nix" "yaml" "json" "html" "css" "svelte"];
        command = "setlocal shiftwidth=2 tabstop=2";
      }
    ];

    extraConfigLua = concatFilesInDir ./lua;
  };
}

