#!/bin/bash

monitor_dimensions=$( swaymsg -t get_outputs |
    jq -r '.. | select(.focused?) | .current_mode | "\(.width)x\(.height)"' )

window_width=380
window_height=300
monitor_width=${monitor_dimensions%x*}
monitor_height=${monitor_dimensions#*x}
rborderalign=$((${monitor_width}-${window_width}))

swaymsg "[app_id = "python3"] resize set height ${window_height}"
swaymsg "[app_id = "python3"] resize set width ${window_width}"

swaymsg "[app_id = "python3"] move position ${rborderalign} -45"
swaymsg "[class = "R_x11" instance = "r_x11"] move position ${rborderalign} 0"


