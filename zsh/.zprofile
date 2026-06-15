export QT_QPA_PLATFORM="wayland"
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_STYLE_OVERRIDE=adwaita-dark
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

export CLUTTER_BACKEND="wayland"
export XDG_SESSION_TYPE="wayland"
export SDL_VIDEODRIVER="wayland"

# removes window outlines and stuff
# java fix
export _JAVA_AWT_WM_NONREPARENTING=1
export ECORE_EVAS_ENGINE="wayland_egl"
export ELM_ENGINE="wayland_egl"


export XDG_CURRENT_DESKTOP="Hyprland"
export XDG_SESSION_DESKTOP="Hyprland"

# Legacy... ?
# export MOZ_ENABLE_WAYLAND=1             # only start firefox in wayland mode and no other GTK apps
# export MOZ_DBUS_REMOTE=1                # fixes firefox is already running, but is not responding

#start sway
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
  # exec sway
  exec start-hyprland
fi


