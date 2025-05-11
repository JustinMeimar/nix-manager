export PATH=$PATH:$HOME/.local/bin

### ZSH
export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window down:3:wrap
  --bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort'
  --color header:italic
  --header 'Copy: <CTRL-Y> | Next: <CTRL-N> | Prev: <CTRL-P>"

export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border --tmux bottom,40%'

### Clang
export CC="/home/justin/install/llvm/llvm-18/bin/clang"
export CXX="/home/justin/install/llvm/llvm-18/bin/clang++"

### CMake
export PATH="$PATH:/home/justin/install/cmake/bin"

### 415
export PATH=$PATH:$HOME/CDOL/Tester/bin

### Python
alias python='python3'
alias python3.8='/usr/bin/python3.8'

### Zig
export ZIG_PATH=/home/justin/install/zig
export PATH=$PATH:$ZIG_PATH

### GO
export PATH=$PATH:/usr/local/go/bin  

### DENO
export PATH=$PATH:/home/justin/.deno/bin

### BUN
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

### NPM
export PATH="/home/justin/.npm-global/bin:$PATH"

### ANTLR
export ANTLR_INS=/home/justin/install/antlr/antlr4-install
export ANTLR_JAR=/home/justin/install/antlr/antlr4-install/bin/antlr-4.13.0-complete.jar
export CLASSPATH="$ANTLR_JAR:$CLASSPATH"

alias antlr4="java -Xmx500M org.antlr.v4.Tool"
alias grun='java org.antlr.v5.gui.TestRig'

### OTHER
export MODULAR_HOME=/home/justin/.modualr
export EMSDK=/home/justin/installs/emsdk
export EMSDK_NODE=/home/justin/installs/emsdk/node/18.20.3_64bit/bin/node
