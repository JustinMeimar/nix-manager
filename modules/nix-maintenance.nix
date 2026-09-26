{ ... }:
{
  nix.gc = {
    automatic = true;
    dates = "daily";
    persistent = true;
    options = "--delete-older-than 7d";
  };
  # dedup identical store files after every build.
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}
