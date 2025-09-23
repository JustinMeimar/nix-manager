{ config, pkgs, ... }:

{
  imports = [ ../modules/home-manager/base.nix ];

  specifics = {
    git = {
      enable = true;
      userName = "j84409084";
      userEmail = "justin.meimar@hpartners.com";
    };
  };
}

