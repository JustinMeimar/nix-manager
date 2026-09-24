{ config, lib, pkgs, ... }:
let
  farm = config.services.beefarm;
  otherSites = lib.filterAttrs (name: site: name != "bee" && site.enable) farm.sites;
  renderLink = site:
    let hostname = lib.escapeXML "${site.subdomain}.${farm.domain}";
    in ''
      <li>
        <a href="https://${hostname}/">${hostname}<span aria-hidden="true">↗</span></a>
      </li>
    '';
  index = pkgs.replaceVars ./index.html {
    SERVICE_LINKS = lib.concatMapStrings renderLink (builtins.attrValues otherSites);
  };
in
pkgs.linkFarm "bee-site" [
  { name = "index.html"; path = index; }
  { name = "my-goph-bee.png"; path = ./my-goph-bee.png; }
]
