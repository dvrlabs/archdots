#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Scripts for refreshing ags waybar, rofi, swaync, wallust

SCRIPTSDIR=$HOME/.config/hypr/scripts

# Define file_exists function
file_exists() {
    if [ -e "$1" ]; then
        return 0  # File exists
    else
        return 1  # File does not exist
    fi
}

# Kill already running processes
_ps=(waybar rofi swaync ags)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

# quit ags
ags -q

sleep 0.3
#Restart waybar

waybar_conf=$HOME/.config/hypr/waybar/config
waybar_styl=$HOME/.config/hypr/waybar/style.css
waybar -c $waybar_conf -s $waybar_styl &

# relaunch swaync
sleep 0.5
swaync_conf=$HOME/.config/hypr/swaync/config.json
swaync_styl=$HOME/.config/hypr/swaync/style.css
swaync -c $swaync_conf -s $swaync_styl > /dev/null 2>&1 &

# relaunch ags
ags --config $HOME/.config/hypr/ags/config.js &

# Relaunching rainbow borders if the script exists
sleep 1
if file_exists "${SCRIPTSDIR}/RainbowBorders.sh"; then
    ${SCRIPTSDIR}/RainbowBorders.sh &
fi


exit 0
