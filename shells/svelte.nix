{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  name = "svelte";
  buildInputs = with pkgs; [
    bun
    nodejs
    wrangler
  ];
  shellHook = ''
    echo "Svelte + bun is ready :D"
  '';
}
