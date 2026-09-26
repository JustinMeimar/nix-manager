# Interactive setup only; loaded from .zshrc through programs.zsh.initContent.
# Ordinary PATH entries are managed by home.sessionPath.

### Python
alias python='python3'
alias python3.8='/usr/bin/python3.8'

### Zig
export ZIG_PATH=/home/justin/install/zig

### BUN
export BUN_INSTALL="$HOME/.bun"

### NPM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

### ANTLR
export ANTLR_INS=/home/justin/install/antlr/antlr4-install
export ANTLR_JAR=/home/justin/install/antlr/antlr4-install/bin/antlr-4.13.0-complete.jar
export CLASSPATH="$ANTLR_JAR:$CLASSPATH"

alias antlr4="java -Xmx500M org.antlr.v4.Tool"
alias grun='java org.antlr.v5.gui.TestRig'

### RUBY
export RBENV_SHELL=zsh
rbenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi
  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}

### OTHER
export MODULAR_HOME=/home/justin/.modualr
export EMSDK=/home/justin/installs/emsdk
export EMSDK_NODE=/home/justin/installs/emsdk/node/18.20.3_64bit/bin/node

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
