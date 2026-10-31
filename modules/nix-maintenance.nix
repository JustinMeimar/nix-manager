{ ... }:
{
  nix.gc = {
    automatic = true;
    dates = "daily";
    persistent = true;
    # Keep the current generation and one previous generation per profile.
    options = "--delete-older-than +2";
  };
  # Deduplicate identical store files weekly.
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}
