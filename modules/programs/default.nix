{ config, lib, pkgs, ... }: {

  imports = [
    ./terminal.nix
    ./alacritty/alacritty.nix
    ./nvim/nvim.nix
  ];   
}
