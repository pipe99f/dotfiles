#start sway
if [[ -z $DISPLAY && $TTY = /dev/tty1 ]]; then
  exec sway
fi


#mandatory for rust
# . "$HOME/.cargo/env"

#makes tmux consider what is in this bashrc
source ~/.zshrc

#fuck alias
eval $(thefuck --alias)

# GTK
export MOZ_ENABLE_WAYLAND=1             # only start firefox in wayland mode and no other GTK apps
export MOZ_DBUS_REMOTE=1                # fixes firefox is already running, but is not responding

