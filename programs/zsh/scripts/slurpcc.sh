
slurpcc() {
  if [ -z "$1" ]; then
    echo "Usage: slurpcc <path>"
    return 1
  fi
  if [ -d "$1" ]; then
    (
        find "$1" -type f \( \
            -name "*.h" -o \
            -name "*.c" -o \
            -name "*.cpp" -o \
            -name "*.hpp" -o \
            -name "*.cc" -o \
            -name "*.hh" -o \
            -name "*.inl" \
        \) \
        -not -path "*/build/*" \
        -not -path "*/test/*" \
        -not -path "*/.git/*" \
        -not -path "*/deps/*" \
        -exec sh -c '
            for file do
                printf "\n%s\n" "============================================"
                printf "%s\n" "=== $file ==="
                printf "%s\n" "============================================"
                cat "$file"
                printf "\n\n"
            done
        ' sh {} +
    ) | xclip -selection clipboard
    echo "Copied source files to clipboard"
  else
    echo "Error: Directory $1 does not exist"
    return 1
  fi
}

