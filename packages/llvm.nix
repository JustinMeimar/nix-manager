{ config, pkgs, lib, ... }:
{
  options.llvm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable llvm packages";
    };
    version = lib.mkOption {
      type = lib.types.enum [ "14" "16" "18" "19" ];
      default = "19";
      description = "Which major version of LLVM to install";
    };
  };

  config = lib.mkIf config.llvm.enable {
    home.packages = let
      llvmPkgs = {
        "19" = [
          pkgs.llvmPackages_19.libllvm
          pkgs.llvmPackages_19.mlir
        ];
        "18" = [
          pkgs.llvmPackages_18.libllvm
        ];
        "17" = [
          pkgs.llvmPackages_17.libllvm
          pkgs.llvmPackages_17.mlir
        ];
        "16" = [
          pkgs.llvmPackages_16.libllvm
          pkgs.llvmPackages_16.mlir
        ];
      };    
    in
      # will concatenate to existig definition of home.packages
      [ llvmPkgs.${config.llvm.version} ];
  };
}

