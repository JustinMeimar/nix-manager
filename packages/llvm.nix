{ config, pkgs, lib, ... }: {
  
  options.llvm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable LLVM toolchain";
    };
    version = lib.mkOption {
      type = lib.types.enum [ "19" ];
      default = "19";
      description = "LLVM version";
    };
  };

  config = lib.mkIf config.llvm.enable {
    home.packages = let
      stablePackages = {
        "19" = with pkgs.llvmPackages_19; [
          llvm
          libcxxClang
          clang-tools
          libcxx
          lld
          mlir
        ]; 
      };
    in stablePackages.${config.llvm.version} ++ [ pkgs.lit ];
  };
}

