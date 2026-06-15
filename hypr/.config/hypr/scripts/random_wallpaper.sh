#!/bin/bash

WALLPAPER_DIRECTORY="$HOME/.config/hypr/wallpapers"

WALLPAPER=$(find "$WALLPAPER_DIRECTORY" -type f | shuf -n 1)

hyprctl hyprpaper wallpaper ,"$WALLPAPER"
