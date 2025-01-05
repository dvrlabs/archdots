#!/bin/bash

# List of categories (category, folder, file_types or exact filenames)
categories_list=(
    "ZSH,$HOME,.zshrc"
    "Kitty,$HOME/.config/kitty/,conf;bak"
    "Hyprland,$HOME/.config/hypr,conf;json"
    "Scripts,$HOME/.config/hypr/scripts,sh"
    "Neovim,$HOME/.config/nvim/lua,lua"
    "Neovim Plugins,$HOME/.config/nvim/lua/plugins,lua"
)

terminal="kitty -e"

# Dynamically generate menu based on file type(s) or exact filenames
generate_menu() {
    local folder=$1
    local file_types=("${@:2}") # Array of file types or exact filenames
    local i=1

    for file_type in "${file_types[@]}"; do
        # If the "file_type" is an exact filename, check if it exists
        if [[ -f "$folder/$file_type" ]]; then
            printf "%d. %s\n" "$i" "$file_type"
            ((i++))
        else
            # Otherwise, treat "file_type" as an extension
            for file in $(ls -a "$folder"/*."$file_type" 2>/dev/null | sort); do
                [[ -f "$file" ]] || continue
                base=$(basename "$file")
                printf "%d. %s\n" "$i" "$base"
                ((i++))
            done
        fi
    done
}

open_file_from_menu() {
    local folder=$1
    local file_types=("${@:2}") # Array of file types or exact filenames

    if [[ ! -d $folder ]]; then
        echo "Error: The folder '$folder' does not exist."
        return 1
    fi

    # Generate menu dynamically
    choice=$(generate_menu "$folder" "${file_types[@]}" | walker -k -d -p "Choose a file")

    # Extract the number from the choice
    choice_number=$(echo "$choice" | awk '{print $1}' | tr -d '.')

    # Map choice to corresponding file
    local i=1
    for file_type in "${file_types[@]}"; do
        # Check for exact filename
        if [[ -f "$folder/$file_type" ]]; then
            if [[ "$choice_number" -eq "$i" ]]; then
                $terminal $EDITOR "$folder/$file_type"
                return
            fi
            ((i++))
        else
            # Otherwise, check for files with extensions
            for file in $(ls -a "$folder"/*."$file_type" 2>/dev/null | sort); do
                [[ -f "$file" ]] || continue
                if [[ "$choice_number" -eq "$i" ]]; then
                    $terminal $EDITOR "$file"
                    return
                fi
                ((i++))
            done
        fi
    done

    echo "Invalid choice or none selected."
}

# Function to handle category selection with a list
select_category() {
    local categories_list=("$@")
    declare -A categories
    declare -A file_types

    # Parse list into categories and file types
    for entry in "${categories_list[@]}"; do
        category=$(echo "$entry" | cut -d',' -f1)
        folder=$(echo "$entry" | cut -d',' -f2)
        types=$(echo "$entry" | cut -d',' -f3)
        categories["$category"]="$folder"
        file_types["$category"]="$types"
    done

    # Generate category menu with numbering
    local i=1
    for category in "${!categories[@]}"; do
        printf "%d. %s\n" "$i" "$category"
        ((i++))
    done

    # Use walker to choose a category
    local choice=$(printf "%s\n" "${!categories[@]}" | nl -w1 -s'. ' | walker -k -d -p "Choose a category")

    # Extract the number from the choice
    choice_number=$(echo "$choice" | awk '{print $1}' | tr -d '.')

    # Map choice to folder and file types
    local i=1
    for category in "${!categories[@]}"; do
        if [[ "$choice_number" -eq "$i" ]]; then
            local folder=${categories[$category]}
            local types_string=${file_types[$category]}
            # Split the file types into an array
            IFS=';' read -ra types_array <<< "$types_string"
            open_file_from_menu "$folder" "${types_array[@]}"
            return
        fi
        ((i++))
    done

    echo "Invalid choice or none selected."
}

# Call select_category with the list
select_category "${categories_list[@]}"
