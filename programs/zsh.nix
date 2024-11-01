{ config, pkgs, ... }:

{
  programs.zsh = {
    
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true; 
    
    shellAliases = {
 	ll = "ls -la"; 
    };
    
    oh-my-zsh = {
	enable = true;
	plugins = [ ];
	theme = "robbyrussell";
    };

    envExtra = ''
      ### Locals
      export PATH=$PATH:$HOME/.local/bin

      ### ANTLR
      export ANTLR_INS=/home/justin/install/antlr/antlr4-install
      export ANTLR_JAR=/home/justin/install/antlr/antlr4-install/bin/antlr-4.13.0-complete.jar
      export CLASSPATH="$ANTLR_JAR:$CLASSPATH"

      alias antlr4="java -Xmx500M org.antlr.v4.Tool"
      alias grun='java org.antlr.v5.gui.TestRig'

      ### LLVM
      export LLVM_DIR=/home/justin/install/llvm/llvm-18/lib/cmake/llvm
      export MLIR_INS=/home/justin/install/llvm/llvm-18
      export MLIR_DIR=$MLIR_INS/lib/cmake/mlir
      export PATH=$MLIR_INS/bin:$PATH

      ### 415
      export PATH=$PATH:$HOME/CDOL/Tester/bin

      ### OTHER
      export MODULAR_HOME=/home/justin/.modualr
      export EMSDK=/home/justin/installs/emsdk
      export EMSDK_NODE=/home/justin/installs/emsdk/node/18.20.3_64bit/bin/node

      ### Python
      alias python='python3'
      alias python3.8='/usr/bin/python3.8'

      ### Zig
      export ZIG_PATH=/home/justin/install/zig
      export PATH=$PATH:$ZIG_PATH
    '';
  };
}

