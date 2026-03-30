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

# ------------------------------------------------------------------------------
# Function: kubectl Overload
# Description:
#   A safety interceptor for kubectl. It prompts for confirmation if the current
#   context is a production environment and the command is destructive.
# ------------------------------------------------------------------------------
kubectl() {
    local cmd_args="$*"

    # 1. Check for destructive/modifying commands
    if [[ "$cmd_args" =~ "delete|scale|apply|edit" ]]; then

        # 2. Retrieve current context
        local current_ctx
        current_ctx=$(command kubectl config current-context 2>/dev/null)

        # 3. Guard PRODUCTION keywords
        if [[ "$current_ctx" =~ "prod|production|live|main" ]]; then
            print "\n${COLOR[BOLD]}${COLOR[RED]}[K8S GUARD]  WARNING: Targeting PRODUCTION ($current_ctx)${COLOR[RESET]}"
            print "Command: ${COLOR[YELLOW]}kubectl $cmd_args${COLOR[RESET]}"
            print -n "Are you sure? [y/N] "

            # read -q: read one character and compare it to 'y'
            if ! read -q; then
                print # Newline
                print "${COLOR[RED]}Aborted.${COLOR[RESET]}"
                return 1
            fi
            print # Newline
        fi
    fi

    # 4. Standard passthrough
    command kubectl "$@"
}
