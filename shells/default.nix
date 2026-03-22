{ pkgs }:
{
  ocaml = import ./ocaml.nix { inherit pkgs; };
  spidermonkey = import ./spidermonkey.nix { inherit pkgs; };
  friction-box = import ./friction-box.nix { inherit pkgs; };
  rust = import ./rust.nix { inherit pkgs; };
}
