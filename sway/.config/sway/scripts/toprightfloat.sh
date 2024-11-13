#!/bin/bash
# shellcheck disable=2140

monitor_dimensions=$(swaymsg -t get_outputs |
  jq -r '.. | select(.focused?) | .current_mode | "\(.width)x\(.height)"')
transform=$(swaymsg -t get_outputs |
  jq -r '.. | select(.focused?) | .transform ')

window_width=380
window_height=300
monitor_width=${monitor_dimensions%x*}
monitor_height=${monitor_dimensions#*x}
# crear condición que intercambie height por width cuando "Transform" en el monitor sea 90

if [ "$transform" -eq 90 ]; then
  temp=$monitor_width
  monitor_width=$monitor_height
  monitor_height=$temp
fi

rborderalign=$((monitor_width - window_width))

# swaymsg "[class = "Matplotlib"] resize set height ${window_height}"
# swaymsg "[class = "Matplotlib"] resize set width ${window_width}"

swaymsg "[class = "Matplotlib" instance = "matplotlib"] move position ${rborderalign} -45"
swaymsg "[class = "R_x11" instance = "r_x11"] move position ${rborderalign} 0"
