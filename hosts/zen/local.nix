{ ... }:
let
  buildHost = domain: ''
    0.0.0.0 ${domain}
    0.0.0.0 www.${domain}
  '';
in {
  networking.extraHosts = builtins.concatStringsSep "" (map buildHost [
  ]);
}
