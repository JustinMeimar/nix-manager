
quadmux() {
  if [ -z "$TMUX" ]; then
    echo "Use from within a tmux session."
    return 1
  fi
  tmux split-window -h
  tmux split-window -v
  tmux select-pane -t 1
  tmux split-window -v
}

