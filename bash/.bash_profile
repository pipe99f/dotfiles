#start sway
[ "$(tty)" = "/dev/tty1" ] && exec sway

# GTK
export GTK_THEME=Adwaita-One-Dark
export MOZ_ENABLE_WAYLAND=1 # only start firefox in wayland mode and no other GTK apps
export MOZ_DBUS_REMOTE=1    # fixes firefox is already running, but is not responding

# Qt theme
export QT_QPA_PLATFORM="wayland"
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_STYLE_OVERRIDE=adwaita
export CLUTTER_BACKEND="wayland"
export SDL_VIDEODRIVER="wayland"
export XDG_SESSION_TYPE="wayland"
export XDG_CURRENT_DESKTOP="sway"
# removes window outlines and stuff
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
# java fix
export _JAVA_AWT_WM_NONREPARENTING=1
export ECORE_EVAS_ENGINE="wayland_egl"
export ELM_ENGINE="wayland_egl"
