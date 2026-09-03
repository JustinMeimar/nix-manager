{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "latex";

  buildInputs = with pkgs; [
    (texlive.combine {
      inherit (texlive)
        scheme-medium
        acmart
        biblatex
        biber
        latexmk
        collection-fontsrecommended
        collection-latexextra
        collection-bibtexextra
        collection-fontsextra
        collection-mathscience;
    })
    biber
    poppler-utils
  ];
}
