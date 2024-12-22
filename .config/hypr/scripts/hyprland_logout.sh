#!/bin/bash

# Define the directory to track uses
TRACK_DIR="/tmp/hyprland_logout"
MAX_USES=3
TIME_LIMIT=10

# Ensure the tracking directory exists
mkdir -p "$TRACK_DIR"

# Record the current timestamp
current_time=$(date +%s)
echo "$current_time" >> "$TRACK_DIR/uses"

# Clean up old timestamps
find "$TRACK_DIR" -type f -name "uses" -exec awk -v cutoff=$((current_time - TIME_LIMIT)) '$1 > cutoff' {} \; > "$TRACK_DIR/temp_uses"
mv "$TRACK_DIR/temp_uses" "$TRACK_DIR/uses"

# Count the remaining entries (recent runs)
usage_count=$(wc -l < "$TRACK_DIR/uses")

# Notify user of the current status
if [[ "$usage_count" -lt "$MAX_USES" ]]; then
    hyprctl notify -0 10000 "rgb(ff1ea3)" "Logout: $usage_count/$MAX_USES attempts in $TIME_LIMIT seconds"
else
    # If the script has been run enough times, perform the logout
    rm -rf "$TRACK_DIR" # Clear tracking files
    hyprctl notify -1 10000 "rgb(ff1ea3)" "Logging out..."
    hyprctl dispatch exit # Replace this with your actual logout command if needed
fi
