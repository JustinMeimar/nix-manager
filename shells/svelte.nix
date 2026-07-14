{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  name = "svelte";
  buildInputs = with pkgs; [
    bun
    nodejs
  ];
  shellHook = ''
    echo "Svelte + bun is ready :D"
  '';
}
