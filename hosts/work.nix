
{ config, pkgs, ... }:

{
  imports = [
    ../home.nix
    ../modules/laptop.nix
  ]; 
  programs.git.userEmail = "justin.meimar@h-partners.com";
  programs.git.userName = "j84409084";
}

