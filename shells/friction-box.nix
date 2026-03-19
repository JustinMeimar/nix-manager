{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "friction-box-dev";

  buildInputs = with pkgs; [
    bun
    nodejs
    just
  ];

  shellHook = ''
    echo "friction-box development environment loaded"
    echo "  bun:  $(bun --version)"
    echo "  node: $(node --version)"
    echo "  just: $(just --version)"
  '';
}
