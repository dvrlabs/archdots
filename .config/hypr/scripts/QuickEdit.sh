#!/bin/bash

configs="$HOME/.config/hypr"
terminal="kitty -e"

# Dynamically generate menu based on *.conf files in configs
generate_menu() {
    local i=1
    for file in $(ls "$configs"/*.conf | sort); do
        base=$(basename "$file" .conf)
        printf "%d. %s\n" "$i" "$base"
        ((i++))
    done
}

main() {
    # Generate menu dynamically
    choice=$(generate_menu | sort -h | walker -k -d -p Choose | cut -d. -f1)

    # Map choice to corresponding file
    local i=1
    for file in $(ls "$configs"/*.conf | sort); do
        if [[ "$choice" -eq "$i" ]]; then
            $terminal $EDITOR "$file"
            return
        fi
        ((i++))
    done

    echo "Invalid choice or none selected."
}

main
