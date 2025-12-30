start_tmux() {
    local session="${1:-main}"
    exec tmux new-session -A -s "${session}"
   
}

# auto-start if TMUX is not active in shell and not already created in
# another shell.
if command -v tmux &> /dev/null && [ -n "$PS1" ] \
                                && [[ ! "$TERM" =~ screen ]] \
                                && [[ ! "$TERM" =~ tmux ]] \
                                && [ -z "$TMUX" ] \
                                && [ ! -f /tmp/tmux_started ]; then
  touch /tmp/tmux_started
  start_tmux "main"
fi

