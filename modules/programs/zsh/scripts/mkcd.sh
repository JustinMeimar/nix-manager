mkcd() { 
    if [ -z "$1" ]; then
        echo "Usage: mkcd <dir>"
        return 1;
    else 
        mkdir "$1" && cd "$1"
        return 0;
    fi; 
}

