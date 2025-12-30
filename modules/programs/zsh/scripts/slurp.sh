
slurp() {
    if [ -z "$1" ]; then
        echo "Usage: slurp <regex_pattern>"
        echo "Example: slurp '\.cpp$|\.h$' for C++ files"
        echo "Example: slurp '\.py$' for Python files"
        return 1
    fi
    
    find . -type f -regextype posix-extended -regex ".*($1)" \
        | xargs cat \
        | xclip -selection clipboard
    echo "Content from files matching pattern '$1' copied to clipboard."
}

