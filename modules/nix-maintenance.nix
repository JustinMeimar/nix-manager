{ ... }:
{
  nix.gc = {
    automatic = true;
    dates = "daily";
    persistent = true;
  };
  # Deduplicate identical store files weekly.
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}
