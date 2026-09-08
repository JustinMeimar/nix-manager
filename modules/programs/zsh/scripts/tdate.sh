# Create a date-stamped file with a hyphen-separated title.
#
# Usage: tdate <title> [extension]
# Example: tdate my-short-entry .typ
#          -> 09-08-2026-my-short-entry.typ
tdate() {
  if [ "$#" -lt 1 ] || [ "$#" -gt 2 ] || [ -z "$1" ]; then
    echo "Usage: tdate <title> [extension]" >&2
    return 1
  fi

  local title="$1"
  local extension="${2:-md}"

  extension="${extension#.}"
  if [ -z "$extension" ]; then
    echo "tdate: extension cannot be empty" >&2
    return 1
  fi

  local filename="$(date +%m-%d-%Y)-${title}.${extension}"
  touch -- "$filename" || return 1
  echo "$filename"
}
