{ config, lib, pkgs, ... } : {
  programs.ssh = {
   enable = true;
   
   matchBlocks = {
     "innis" = {
       user = "meimar";
       hostname = "innisfree.cs.ualberta.ca";
     };
     
     "cdol04" = {
       user = "meimar";
       proxyJump = "innis";
       extraOptions = {
         PreferredAuthentications = "password";
         PubkeyAuthentication = "no";
       };
     };
     
     "cdol03" = {
       user = "meimar";
       proxyJump = "innis";
       extraOptions = {
         PreferredAuthentications = "password";
         PubkeyAuthentication = "no";
       };
     };
     
     "cdol02" = {
       user = "meimar";
       proxyJump = "innis";
       extraOptions = {
         PreferredAuthentications = "password";
         PubkeyAuthentication = "no";
       };
     };
      
     "ug" = {
       user = "cmput415";
       hostname = "uf17.cs.ualberta.ca";
       identityFile = "~/.ssh/cmput415";
     };

     "ci415" = {
       user = "meimar";
       hostname = "ci.cmput415.cs.ualberta.ca";
       proxyJump = "innis";
       identityFile = "~/.ssh/ci-server";
     };
     
     "bee" = {
       user = "justin";
       hostname = "192.168.1.88";
       identityFile = "~/.ssh/justin-bee";
     };
     
     "github.com" = {
       hostname = "github.com";
       identityFile = "~/.ssh/github-zen";
     };

     "gazbolt" = {
       user = "justin";
       hostname = "159.223.200.125";
       identityFile = "~/.ssh/github-zen";
     };
   };
  };
}

