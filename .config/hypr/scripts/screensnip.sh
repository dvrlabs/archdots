#!/usr/bin/bash

# Freeze the screen and get the PID of the screenfreeze with hyprpicker.
hyprpicker -r -z & HYPRPICKER_PID=$!

# Establish a place to save the screenshot
IMG=~/Pictures/$(date +%Y-%m-%d_%H-%m-%s).png

# Copy the location into clipboard
# Can be found with clipboard manager later.
echo "$(realpath "$IMG")" | wl-copy

# Get the screenshot
grim -g "$(slurp)" $IMG

# Throw it in the clipboard
wl-copy < $IMG

# Stop the screen freeze.
kill $HYPRPICKER_PID
