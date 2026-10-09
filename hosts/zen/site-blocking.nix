{ lib, ... }:
let
  parseBlockList = f:
    builtins.filter (domain: domain != "")
      (lib.splitString "\n" (builtins.readFile f));
  buildHost = domain: ''
    0.0.0.0 ${domain}
    0.0.0.0 www.${domain}
  '';
  blocked =
    if builtins.pathExists ./site_block_list.txt
    then parseBlockList ./site_block_list.txt
    else [];
in {
  networking.extraHosts = builtins.concatStringsSep
    "" (map buildHost blocked);
}
