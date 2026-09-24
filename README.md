## Home Manager

This configuration is used to set up my home on any machine.

### Hosts

Applying a configuration referenced in `./hosts`

* Zen (Ubuntu Laptop): `home-manager switch --flake .#justin@zen`
* Bee (NixOS Home Server): `home-manager switch --flake .#justin@bee` 

### Secrets
Some hosts configure `sops` which is used to manage secrets, for which some additional work post switch needs to be done.

```bash
sops --encrypt -a $(cat {AGE_PUBLIC_KEY}) {SECRETS_YAML} > {SECRETS_YAML_ENC}
```

Where: 
* `AGE_PUBLIC_KEY`: path to AGE public key (hidden locally)
* `SECRETS_YAML`: path to `.yaml` containing secrets (hidden locally)
* `SECRETS_YAML_ENC`: encrypted version of secrets (can be stored publicly)

While `sops-nix` should automatically handle decryption based on the parameters in `sops.nix`,
secrets may be decrypted manually using:

```bash
sops --decrypt --input-type yaml --output-type yaml  <SECRETS_YAML_ENC>
```

On NixOS secrets go to `/run/secrets`. With home-manager they go to `~/.config/sops-nix/secrets`

## Bee web services

`hosts/bee/web-services/` holds one module per site. Each enabled
`services.beefarm.sites` entry creates a route on the existing `bee-hole`
Cloudflare tunnel: `<site>.justinmeimar.com` goes to its loopback service,
through Anubis when enabled.
`bee.justinmeimar.com` lists the other enabled sites.

Static sites use `hosts/bee/web-services/static-site.nix` to enable nginx and
derive the hostname and loopback listener from their Beefarm entry. The helper
also applies the shared cache policy. Each site supplies its document root and
any additional nginx locations. Bee's `page.nix` assembles its landing page and
generates links from the enabled sites.

Cloudflare DNS needs a proxied wildcard CNAME for `*.justinmeimar.com` pointing
to the existing tunnel's `<tunnel-id>.cfargotunnel.com` address. DNS is managed
outside this repository. Unconfigured hostnames receive a tunnel 404.

To add a service already managed by NixOS, declare its loopback port:

```nix
services.beefarm.sites.example = {
  port = 8010;
  anubis.enable = true;
};
```

Anubis listens on `127.0.0.1:<port + 10000>` (or an explicit
`anubis.port`) and forwards to the site's original loopback port. Beefarm
automatically points the tunnel route at Anubis and restricts challenge
redirects to that site's hostname. Set `anubis.enable = false` to expose a
service directly, for example if an API client cannot complete browser
challenges. A protected site requires JavaScript and cookies for challenged
visitors.

Beefarm manages publication. Configure the application using its NixOS service
module, or declare a dedicated `systemd.services` unit in the site's module.
Custom units should use a dedicated service account or `DynamicUser = true`,
`NoNewPrivileges = true`, `ProtectHome = true`, and `ProtectSystem = "strict"`,
with writable state explicitly provided through options such as `StateDirectory`.
Do not run public applications as a personal login user. Review permissions for
each application's needs; publication does not add process isolation.

The application must listen on `127.0.0.1` at the declared port. Set `subdomain`
if it should differ from the site attribute name. Ports (including Anubis ports)
and hostnames must be unique. Set `enable = false` to stop publishing a site;
the application's lifecycle is controlled by its own module.

`html.justinmeimar.com` serves
`/srv/beefarm/dashboard/`. NixOS creates this directory with `justin` as its
owner, so uploads do not require root access.
An uploaded `index.html` provides the HTML dashboard links; update it when adding
reports. Without that file, nginx lists files and directories.
Upload a dashboard with, for example,
`scp report.html justin@bee:/srv/beefarm/dashboard/`.
It is immediately available at `https://html.justinmeimar.com/report.html`,
without another NixOS rebuild. Nginx serves the directory directly with read-only
access under its systemd sandbox; it refuses requests for hidden paths and symlinks. The directory
listing shows filenames, and every uploaded file is public; keep secrets and
private files out of this directory.
