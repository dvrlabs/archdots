#!/bin/bash

# Check if sleep.target is masked
STATUS=$(systemctl is-enabled sleep.target 2>/dev/null)

if [[ "$STATUS" == "masked" ]]; then
    echo '{"text": "", "tooltip": "Sleep is disabled", "class": "disabled"}'
else
    echo '{"text": "", "tooltip": "Sleep is enabled", "class": "enabled"}'
fi
