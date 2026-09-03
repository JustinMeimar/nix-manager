{ pkgs }:
{
  c = import ./c.nix { inherit pkgs; };
  ocaml = import ./ocaml.nix { inherit pkgs; };
  spidermonkey = import ./spidermonkey.nix { inherit pkgs; };
  friction-box = import ./friction-box.nix { inherit pkgs; };
  rust = import ./rust.nix { inherit pkgs; };
  blog = import ./blog.nix { inherit pkgs; };
  python = import ./python.nix { inherit pkgs; };
  zig = import ./zig.nix { inherit pkgs; };
  luamura = import ./luamura.nix { inherit pkgs; };
  svelte = import ./svelte.nix { inherit pkgs; };
  latex = import ./latex.nix { inherit pkgs; };
}
