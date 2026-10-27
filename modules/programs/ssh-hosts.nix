{ lib }:

let

  mkKeyConfig = { user, hostname, key }: {
    User = user;
    HostName = hostname;
    IdentityFile = key;
    IdentitiesOnly = true;
  };

  mkPwdConfig = { user, hostname ? null, proxyJump ? null }:
    {
      User = user;
      PreferredAuthentications = "password";
      PubkeyAuthentication = false;
    } // lib.optionalAttrs (hostname != null) { HostName = hostname; }
    // lib.optionalAttrs (proxyJump != null) { ProxyJump = proxyJump; };
in {
      
      "am-build-rig" = mkKeyConfig {
        user = "justin";
        hostname = "100.73.6.114";
        key = "~/.ssh/am-build-rig";
      };
      
      "am-build-rig-pwd" = mkPwdConfig {
        user = "justin";
        hostname = "100.73.6.114";
      };

      "innis" = mkKeyConfig {
        user = "meimar";
        hostname = "innisfree.cs.ualberta.ca";
        key = "~/.ssh/cdol";
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

      "pi" = mkKeyConfig {
        user = "justin";
        hostname = "192.168.1.115";
        key = "~/.ssh/justin-pi";
      };

      "ci415" = {
        User = "meimar";
        HostName = "ci.cmput415.cs.ualberta.ca";
        ProxyJump = "innis";
        IdentityFile = "~/.ssh/ci-server";
        IdentitiesOnly = true;
      };

      "github.com" = {
        HostName = "github.com";
        IdentityFile = "~/.ssh/github-zen";
        IdentitiesOnly = true;
      };

      "github-vidual" = {
        HostName = "github.com";
        IdentityFile = "~/.ssh/github-vidual";
        IdentitiesOnly = true;
      };
    }
