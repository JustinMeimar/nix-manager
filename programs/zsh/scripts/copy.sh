copy() {
  if [ -z "$1" ]; then
    echo "Usage: copy <filename>"
    return 1
  fi
  if [ -f "$1" ]; then
    cat "$1" | xclip -selection clipboard
    echo "Copied $1 to clipboard"
  else
    echo "Error: File $1 does not exist"
    return 1
  fi
}

