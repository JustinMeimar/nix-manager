{ config, pkgs, ... }:
{
  imports = [
    ../../modules/programs/default.nix
  ];
  specifics = {
    git = {
      enable = true;
      userName = "j84409084";
      userEmail = "justin.meimar@hpartners.com";
    };
  };
}

