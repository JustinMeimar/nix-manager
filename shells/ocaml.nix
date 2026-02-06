{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "ocaml-dev";

  buildInputs = with pkgs; [
    ocaml
    dune_3
    opam
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat
    ocamlPackages.utop
    pkg-config
    ocamlPackages.findlib
    ocamlPackages.odoc
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
