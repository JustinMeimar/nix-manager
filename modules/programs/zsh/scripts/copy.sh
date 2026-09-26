# Clipboard helpers are available only in a local graphical session.
if { [[ -n "$WAYLAND_DISPLAY" ]] && (( $+commands[wl-copy] )); } ||
   { [[ -n "$DISPLAY" ]] && (( $+commands[xclip] )); }; then
  _clipboard_copy() {
    if [[ -n "$WAYLAND_DISPLAY" ]] && (( $+commands[wl-copy] )); then
      wl-copy
    else
      xclip -selection clipboard
    fi
  }

  copy() {
    if [[ ! -t 0 ]]; then
      _clipboard_copy
    elif [[ -f "$1" ]]; then
      _clipboard_copy < "$1"
    else
      echo "Usage: copy <filename> or <cmd> | copy" >&2
      return 1
    fi
  }

  slurp() {
    if [[ -z "$1" ]]; then
      echo "Usage: slurp <regex_pattern>" >&2
      return 1
    fi
    find . -type f -regextype posix-extended -regex ".*($1)" -print0 |
      xargs -0 -r cat | _clipboard_copy
  }

  alias cwd='pwd | copy'
fi
