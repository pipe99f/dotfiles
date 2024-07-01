#copy preset into pwd
cpreset() {
    cp $HOME/dotfiles/tmuxp/.config/tmuxp/$1.yaml ./.tmuxp.yaml
    session=$(basename $(pwd) | tr . - | tr ' ' - | tr ':' - | tr '[:upper:]' '[:lower:]')
    echo $session
    sed -i "s/sname/$session/" ./.tmuxp.yaml
}

#overwrite sessions using tmuxp
overtmux() {
    tmux kill-session -t $1 && tmuxp load ./
}

#runs cwd session preset. Useful for rerunning "shell_command_before"

runpreset() {
    # Store current tmux session name
    local session_name=$(tmux display-message -p '#S')

    # Run tmuxp load
    tmuxp load --yes ./

    # Eliminate the session where the function was run
    tmux kill-session -t $session_name

    # Rename the new session with the stored name
    tmux rename-session -t "tempp" $session_name
}


function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

