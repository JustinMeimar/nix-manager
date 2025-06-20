{
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
   };
  };
}

