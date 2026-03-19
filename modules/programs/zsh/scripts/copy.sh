copy() {
  if [ -t 0 ] && [ -z "$1" ]; then
    echo "Usage: copy <filename> or <cmd> | copy"
    return 1
  fi

  if [ ! -t 0 ]; then
    wl-copy
  elif [ -f "$1" ]; then
    wl-copy < "$1"
    echo "Copied $1 to clipboard"
  else
    echo "Error: File $1 does not exist"
    return 1
  fi
}
