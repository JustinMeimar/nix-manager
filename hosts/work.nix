
{ config, pkgs, ... }:

{
  imports = [
    ../home.nix
    ../modules/laptop.nix
    ../programs/sops/sops.nix
    ../packages/llvm.nix 
  ];
  
  programs.git.userEmail = "justin.meimar@h-partners.com";
  programs.git.userName = "j84409084";

  # Configure LLVM user library version 
  llvm = {
    enable = false;
    version = "17";
  };
}

