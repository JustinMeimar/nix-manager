{ config, lib, pkgs, ... } : 

let
  
  mkKeyConfig = { user, hostname, key }: {
    user = user;
    hostname = hostname;
    identityFile = key;
    identitiesOnly = true;
  };
  
  mkPwdConfig = { user, hostname ? null, proxyJump ? null }: {
    user = user;
    extraOptions = {
      PreferredAuthentications = "password";
      PubkeyAuthentication = "no";
    };
  } // lib.optionalAttrs (hostname != null) {
    hostname = hostname;
  } // lib.optionalAttrs (proxyJump != null) {
    proxyJump = proxyJump;
  };
in
{
  programs.ssh = {
    enable = true;
   
    matchBlocks = {
      
      "innis" = mkKeyConfig {
        user = "meimar";
        hostname = "innisfree.cs.ualberta.ca";
        key = "~/.ssh/cdol.pub";
      };

      "coronation" = mkKeyConfig {
        user = "cmput415";
        hostname = "coronation.cs.ualberta.ca";
        key = "~/.ssh/cmput415";
      };

      "bee" = mkKeyConfig {
        user = "justin";
        hostname = "192.168.1.88";
        key = "~/.ssh/justin-bee";
      };

      "gazbolt" = mkKeyConfig {
        user = "justin";
        hostname = "159.223.200.125";
        key = "~/.ssh/github-zen";
      };

      "cdol04" = mkPwdConfig {
        user = "meimar";
        proxyJump = "innis";
      };
      
      "cdol03" = mkPwdConfig {
        user = "meimar";
        proxyJump = "innis";
      };
      
      "uofa" = mkPwdConfig {
        user = "meimar";
        hostname = "coronation.cs.ualberta.ca";
      };
 
      "ci415" = {
        user = "meimar";
        hostname = "ci.cmput415.cs.ualberta.ca";
        proxyJump = "innis";
        identityFile = "~/.ssh/ci-server";
        identitiesOnly = true;
      };
      
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/github-zen";
        identitiesOnly = true;
      };  
   };
  };
}

