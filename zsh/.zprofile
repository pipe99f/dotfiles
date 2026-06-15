# removes window outlines and stuff
# java fix
export _JAVA_AWT_WM_NONREPARENTING=1
export ECORE_EVAS_ENGINE="wayland_egl"
export ELM_ENGINE="wayland_egl"

# Legacy... ?
# export MOZ_ENABLE_WAYLAND=1             # only start firefox in wayland mode and no other GTK apps
# export MOZ_DBUS_REMOTE=1                # fixes firefox is already running, but is not responding

#start sway
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec start-hyprland
fi


