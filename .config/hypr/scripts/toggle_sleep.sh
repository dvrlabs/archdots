#!/bin/bash

# Check the current status of sleep mode
if systemctl is-enabled sleep.target &>/dev/null && systemctl is-enabled suspend.target &>/dev/null; then
    # Sleep is currently enabled; disable it
    systemctl mask sleep.target suspend.target
    notify-send "Sleep Mode Disabled" "The system will no longer suspend or sleep."
else
    # Sleep is currently disabled; enable it
    systemctl unmask sleep.target suspend.target
    notify-send "Sleep Mode Enabled" "The system can now suspend or sleep."
fi

