{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "ocaml-dev";

  buildInputs = with pkgs; [
    # OCaml toolchain
    ocaml
    dune_3
    opam

    # Language server and tools
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat
    ocamlPackages.utop  # Interactive REPL

    # Build utilities
    pkg-config

    # Optional but useful OCaml packages
    ocamlPackages.findlib
    ocamlPackages.odoc  # Documentation generator
  ];

  shellHook = ''
    echo "🐫 OCaml development environment loaded"
    echo "  - ocaml:           $(ocaml --version | head -n1)"
    echo "  - dune:            $(dune --version)"
    echo "  - opam:            $(opam --version)"
    echo "  - ocaml-lsp:       $(ocamllsp --version 2>/dev/null || echo 'installed')"
    echo "  - ocamlformat:     $(ocamlformat --version)"
    echo ""
    
    # Return into zsh if not already 
    if [ -z "$IN_NIX_SHELL_ZSH" ] && command -v zsh &> /dev/null; then
      export IN_NIX_SHELL_ZSH=1
      exec zsh
    fi
  '';
}
