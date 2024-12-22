#!/bin/bash

# get current sink
current_sink=$(pactl info | grep "Default Sink" | cut -d" " -f3)

# get all sink names
sink_names=($(pactl list short sinks | awk '{print $2}'))

# get index of current sink in array
for i in "${!sink_names[@]}"; do
    if [[ "${sink_names[$i]}" = "${current_sink}" ]]; then
        current_sink_index=$i
    fi
done

# get index of next sink
if [[ "$current_sink_index" -eq $((${#sink_names[@]}-1)) ]]; then
    next_sink_index=0
else
    next_sink_index=$(($current_sink_index+1))
fi

# set next sink as default
pactl set-default-sink ${sink_names[$next_sink_index]}

# move all inputs to the new sink
for input in $(pactl list short sink-inputs | cut -f1); do
    pactl move-sink-input "$input" ${sink_names[$next_sink_index]}
done

#notify-send -u critical "Swapped Audio Output." && sleep 1 && pkill mako
