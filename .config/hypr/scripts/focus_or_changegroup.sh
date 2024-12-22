#!/bin/bash

# Argument passed to the script, either "d" (down) or "u" (up)
direction=$1

# Choose the proper changegroupactive forward (f), or backward (b)
# based upon direction
if [[ "$direction" == "d" ]]; then
    tab_direction="b"
else
    tab_direction="f"
fi

# Get the ID of the active window (assuming it's "0" if not grouped)
active_window=$(hyprctl activewindow | grep "grouped" | awk '{print $2}')

# Create a boolean variable is_tabbed_group to check if active_window is not equal to "0"
if [[ "$active_window" != "0" ]]; then
    is_tabbed_group=true
else
    is_tabbed_group=false
fi

# Now use the is_tabbed_group variable in your logic
if $is_tabbed_group; then
    # If the window is in a tabbed group, cycle through the group
    hyprctl dispatch changegroupactive "$tab_direction"
else
    # If the window is not in a tabbed group, move focus in the specified direction
    hyprctl dispatch movefocus "$direction"
fi
