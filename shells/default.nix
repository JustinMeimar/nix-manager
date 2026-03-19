{ pkgs }:
{
  ocaml = import ./ocaml.nix { inherit pkgs; };
  spidermonkey = import ./spidermonkey.nix { inherit pkgs; };
}
