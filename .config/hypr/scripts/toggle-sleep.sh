#!/bin/bash

# Check the current status of sleep
STATUS=$(systemctl is-enabled sleep.target 2>/dev/null)

if [[ "$STATUS" == "masked" ]]; then
    systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
    if [[ $? -eq 0 ]]; then
        notify-send "Toggle Sleep" "Sleep has been enabled."
    else
        notify-send "Toggle Sleep" "Failed to enable sleep. Please check your permissions."
    fi
else
    systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
    if [[ $? -eq 0 ]]; then
        notify-send "Toggle Sleep" "Sleep has been disabled."
    else
        notify-send "Toggle Sleep" "Failed to disable sleep. Please check your permissions."
    fi
fi
