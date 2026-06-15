#!/bin/bash

choice=$(
  fuzzel -d -i -p "Outputs: " -l 10 <<MENU
1. Main monitor
2. Vertical samsung and main
3. Acer
MENU
)

case $choice in
"1. Main monitor")
  hyprctl eval 'hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "0x0", scale = 1, disabled = false })'
  hyprctl eval 'hl.monitor({ output = "HDMI-A-1", disabled = true })'
  ;;
"2. Vertical samsung and main")
  hyprctl eval 'hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "0x180", scale = 1 })'
  hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "1920x0", scale = 1, transform = 3, disabled = false })'
  ;;
"3. Acer")
  hyprctl eval 'hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "0x0", scale = 1, disabled = false })'
  hyprctl eval 'hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "0x1080", scale = 1, transform = 0, disabled = false })'
  ;;
esac
