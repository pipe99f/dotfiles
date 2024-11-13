#!/bin/bash

chosen=$(
  wofi --show dmenu --insensitive -p "Keyboard Layouts" <<EOF
English
Russian
Greek
Arabic
Korean
Japanese
Chinese
EOF
)

case "$chosen" in
"English")
  swaymsg input type:keyboard xkb_layout us
  ;;
"Russian")
  swaymsg input type:keyboard xkb_layout ru
  ;;
"Greek")
  swaymsg input type:keyboard xkb_layout gr
  ;;
"Arabic")
  swaymsg input type:keyboard xkb_layout ara
  ;;
"Korean")
  swaymsg input type:keyboard xkb_layout kr
  ;;
"Japanese")
  swaymsg input type:keyboard xkb_layout jp
  ;;
"Chinese")
  swaymsg input type:keyboard xkb_layout cn
  ;;
esac
