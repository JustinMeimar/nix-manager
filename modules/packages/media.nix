{ pkgs, ... }:
{
  home.packages = import ./media-packages.nix { inherit pkgs; };

  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
    };
  };
}
