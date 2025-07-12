
{ config, pkgs, ... }:

{
  imports = [
    ../home.nix
  ]; 
  programs.git.userEmail = "justin.meimar@h-partners.com";
  programs.git.userName = "j84409084";
}

