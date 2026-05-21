{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "luamura";

  buildInputs = with pkgs; [
    cmake
    gnumake
    gcc

    llvmPackages.llvm
    llvmPackages.libllvm
    llvmPackages.libllvm.dev
  ];
}
