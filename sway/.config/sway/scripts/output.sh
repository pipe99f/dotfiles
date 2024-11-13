#!/bin/bash

choice=$(
  wofi --show dmenu --insensitive -O alphabetical --lines=10 -p "Outputs" <<EOF
1. Main monitor
2. Vertical samsung and main
3. Acer
EOF
)

case $choice in
"1. Main monitor")
  sway output DP-1 res 1920x1080 pos 0 0
  sway output HDMI-A-1 disable
  ;;
"2. Vertical samsung and main")
  sway output DP-1 res 1920x1080 pos 0 118
  sway output HDMI-A-1 enable res 1920x1080 pos 1920 0 transform 90
  ;;
"3. Acer")
  sway output DP-1 res 1920x1080 pos 0 0
  sway output HDMI-A-1 enable res 1920x1080 pos 0 1080 transform 0
  ;;
esac
