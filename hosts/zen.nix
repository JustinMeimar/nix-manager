
{ config, pkgs, ... }:

{
  imports = [
    ../home.nix
    ../modules/laptop.nix
    ../programs/sops/sops.nix
    ../packages/llvm.nix 
  ];
  
  programs.git.userEmail = "meimar@ualberta.ca";
  programs.git.userName = "JustinMeimar";

  # Configure LLVM user library version 
  llvm = {
    enable = true;
    version = "17";
  };
}

