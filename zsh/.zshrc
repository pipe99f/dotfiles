# Profiler (measures time taken by commands)
# set next venv to 1 to enable profiling
export PROFILING_MODE=0
if [ $PROFILING_MODE -ne 0 ]; then
    zmodload zsh/zprof
    zmodload zsh/datetime
    zsh_start_time=$(( EPOCHREALTIME * 1000 ))
fi

# Environment Detection
# Capture the kernel name to handle OS-specific flags (Darwin vs Linux).
local detected_os
detected_os=$(uname -s)

#########
# PATH
#########

typeset -U path PATH
path=(
    $HOME/.pixi/bin
    $HOME/.yarn/bin
    $HOME/dotfiles/scripts/scripts
    $path
)

##############
# Zinit and plugins
##############

# Compile plugin loads 
ZINIT_COMPRESS_INDEX=1

# zinit directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Self update
# zinit self-update

# Plugin parallel update
# zinit update --parallel


export ZSH_COMPDUMP="/tmp/.zcompdump-${USER}-${ZSH_VERSION}" # using ram instead of disk

# Load completions
# It shoul be before the plugins loading
# 1. Faster compinit with daily cache check
autoload -Uz compinit
if [[ -n $ZSH_COMPDUMP(#qN.m-1) ]]; then
  compinit -C -d $ZSH_COMPDUMP # The -C flag skips the slow security audit
else
  compinit -d $ZSH_COMPDUMP
fi


# it is better to run vi-mode not in turbo mode, otherwise it would break zvm_after_init function
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode 

zinit ice depth=1
zinit light TunaCuma/zsh-vi-man # on vi mode press 'K' to open man page

# This function is automatically called by zsh-vi-mode after initialization
# Fixes conflict with Atuin CTRL-R
function zvm_after_init() {
  # Re-bind Atuin to CTRL-R for all modes
  zvm_bindkey vicmd '^R' _atuin_search_widget
  zvm_bindkey viins '^R' _atuin_search_widget

  # zvm_bindkey vicmd '^R' fzf-history-widget
  # zvm_bindkey viins '^R' fzf-history-widget
}

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    atload"fast-theme -q XDG:catppuccin-macchiato" \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 MichaelAquilina/zsh-you-should-use \
 Aloxaf/fzf-tab

# Zsh-fast-syntax-highlighting theme

# snippets plugins
zinit wait'0b' lucid for \
    OMZP::git
    # OMZP::command-not-found \ # Super slow

# Improves performance of compinit
# It should be after the plugins loading
zinit cdreplay -q


##############
# OPTIONS AND ENVVARS
##############

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':completion:*' use-cache yes
# zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
# Preview file content when completing 'cat' or 'bat'
zstyle ':fzf-tab:complete:*:*' fzf-preview \
  'if [ -d $realpath ]; then eza --icons --color=always $realpath; else bat --color=always --line-range :200 $realpath; fi'
# zstyle ':fzf-tab:complete:cd*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

 export VISUAL="nvim"
 export SYSTEMD_EDITOR="nvim"

# History
HISTSIZE=5000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Prevent accidental overwrite >
setopt NO_CLOBBER

# Add delay before rm *
setopt RM_STAR_WAIT

# Allow inline comments (useful for copy/paste)
setopt INTERACTIVE_COMMENTS

unsetopt FLOWCONTROL        # Disable Ctrl+S/Ctrl+Q output freezing
unsetopt NOMATCH            # Don't error if a glob has no matches (pass to command)
setopt NOTIFY                  # Report status of background jobs immediately
setopt NOHUP                   # Don't kill background jobs on exit
setopt NOBEEP                  # No beep on error

#GTK THEME
export GTK_THEME=Adwaita-One-Dark
export XDG_CURRENT_DESKTOP=sway

#QT
export QT_QPA_PLATFORMTHEME=qt6ct
#This makes matplotlib qt backend work
export QT_STYLE_OVERRIDE="Fusion"
export QT_QPA_PLATFORM=xcb


#Spellchecking
# setopt correct
# export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? [Yes, No, Abort, Edit] "

#Required by tmuxp
export DISABLE_AUTO_TITLE="true"


##############
# Third party utilities
##############

# Makes the caching work on MacOS
if [[ detected_os == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)" # Apple Silicon
    # eval "$(/usr/local/bin/brew shellenv)"  # Intel
fi

# Function to cache heavy init commands
cache_eval() {
    local name="$1"
    local cmd="$2"
    local binary="${3:-$name}"  # optional 3rd arg if binary name differs from cache name
    local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh_init"
    local cache_file="$cache_dir/$name.zsh"

    [[ ! -d "$cache_dir" ]] && mkdir -p "$cache_dir"

    local binary_path
    binary_path="$(command -v $binary 2>/dev/null)"

    if [[ -z "$binary_path" ]]; then
        echo "cache_eval: '$binary' not found in PATH, skipping." >&2
        return 1
    fi

    if [[ ! -f "$cache_file" ]] || [[ "$binary_path" -nt "$cache_file" ]]; then
        eval "$cmd" > "$cache_file" || {
            echo "cache_eval: failed to generate cache for '$name'" >&2
            rm -f "$cache_file"
            return 1
        }
    fi
    source "$cache_file"
}

# Atuin
# eval "$(atuin init zsh --disable-up-arrow)"
cache_eval "atuin"    "atuin init zsh --disable-up-arrow"


# Conda lazy loader
conda() {
    unfunction conda
    source "/home/pipe99f/miniconda3/etc/profile.d/conda.sh"
    conda "$@"
}

# Direnv
# eval "$(direnv hook zsh)"
cache_eval "direnv"   "direnv hook zsh"

# FZF
# source <(fzf --zsh)
cache_eval "fzf" "fzf --zsh"
source $HOME/.config/fzf/config.zsh

# Pixi
# eval "$(pixi completion --shell zsh)" # too slow

# Python
# export MPLBACKEND=tkagg # It is used to avoid compatibility problems with matplotlib plots in wayland. Same effect is achieved in a python script using "matplotlib.use('tkagg')". webagg is also good
# export PLOTLY_RENDERER="chromium"
export HIP_VISIBLE_DEVICES=0  # solve amdgpu error with pytorch
export ROCM_PATH=/opt/rocm
# export PYTORCH_ROCM_ARCH="gfx1034"
# export HSA_OVERRIDE_GFX_VERSION=10.3.1


# Source functions file
source $HOME/dotfiles/scripts/scripts/functions.zsh

#run starship theme
# eval "$(starship init zsh)"
cache_eval "starship" "starship init zsh"


# Zoxide (replaces cd)
# eval "$(zoxide init --cmd cd zsh)"
cache_eval "zoxide"   "zoxide init --cmd cd zsh"

# Zsh-syntax-highlighting theme
# source $HOME/dotfiles/scripts/scripts/catppuccin_macchiato-zsh-syntax-highlighting.zsh


[[ -f $HOME/.priv ]] && source $HOME/.priv


##############
# Aliases
##############

# System & Privileges
## Wrappers for administrative commands and safety features.
# Admin Helpers
alias -- _="sudo"        # Quick sudo shorthand

# Auto-Sudo (Linux Only)
# On Linux, system commands almost always require root. This wrapper adds
# 'sudo' automatically to specific commands to save typing.
if [[ "$detected_os" == "Linux" ]]; then
    for sys_cmd in mount umount sv updatedb su shutdown poweroff reboot; do
        alias "$sys_cmd"="_ $sys_cmd"
    done
    unset sys_cmd
fi

# Safety Nets
# Force interactive mode (-i) to prompt before destructive actions.
alias mv="command mv -i"
alias cp="command cp -i"
alias ln="command ln -i"
alias rm="command rm -i"      # "Are you sure?" prompt for deletions

# GNU/BSD Compatibility
# Linux specific flags that don't exist on macOS/BSD.
if [[ "$detected_os" == "Linux" ]]; then
    alias chown="chown --preserve-root"
    alias chmod="chmod --preserve-root"
    alias chgrp="chgrp --preserve-root"
fi

# Shell Management
# 'exec zsh' replaces the current process, reloading the config cleanly.
(( $+functions[_zsh_reload] )) && alias zsh="_zsh_reload" || alias zsh="exec zsh"  # Fallback if the function isn't defined yet
alias which='type -a' # 'type -a' is more robust in Zsh than 'which'


# Utilities & Tools
## Replacing legacy unix tools with modern Rust/Go alternatives.

# Modern Replacements

# 'cat' -> 'bat' (Syntax highlighting)
(( $+commands[bat] ))     && alias cat='bat'

# 'df' -> 'duf' (Disk Usage / Free utility)
(( $+commands[duf] ))     && alias df="duf" || alias df="df -h"

# 'rm' -> 'trash' (Moves to trash instead of permanent delete)
(( $+commands[trash] ))   && alias del="trash"

# 'grep' -> 'ripgrep' (Much faster search)
if (( $+commands[rg] )); then
    alias grep="rg"
    alias -g ':G'="| rg"
elif (( $+commands[ripgrep] )); then
    alias grep="ripgrep"
    alias -g ':G'="| ripgrep"
else
    alias -g ':G'="| grep"
fi

# 'find' -> 'fd' (Simple, fast, user-friendly)
(( $+commands[fd] )) && alias find="fd"

# 'diff' -> 'delta' (Syntax highlighted diffs)
(( $+commands[delta] )) && alias diff="delta"

# Eza as ls
if (( $+commands[eza] )); then
    alias ls='eza --icons --git --color=always'
    alias ll='eza --icons --git -labF'
    alias la='eza --icons --git -a'
    alias llm='eza --icons --git -labF --sort=modified'
    alias lt="eza --tree --level=2 --icons --git --all --group-directories-first"
else
    # Native Fallback
    if [[ "$detected_os" == "Darwin" ]]; then
        alias ls="ls -G"           # macOS color flag
        alias ll="ls -laG"
    else
        alias ls="ls --color=auto" # Linux color flag
        alias ll="ls -la --color=auto"
    fi
fi

# Network & Process

alias ip="curl ipinfo.io/ip"           # Get Public IP
alias ping='ping -c 5'                 # Stop after 5 pings
alias fastping='ping -c 100 -s 2'     # Stress test
alias gping="ping -c 5 google.com"     # Connectivity check

# Process Listing (ps)
alias p="ps -f"
alias paux='ps aux | grep'

# Memory/CPU Sorting (Handles flag differences between macOS/Linux)
if [[ "$detected_os" == "Linux" ]]; then
    alias psmem='ps auxf | sort -nr -k 4'
    alias pscpu='ps auxf | sort -nr -k 3'
else
    alias psmem='ps aux | sort -nr -k 4'  # macOS lacks 'f' forest view in aux
    alias pscpu='ps aux | sort -nr -k 3'
fi

alias killl='killall -q'

# docker
alias dk='docker'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"' # Cleaner PS
alias dpa='docker ps -a'                      # Show all containers
alias di='docker images'                      # List images
alias dl='docker logs -f'                     # Follow logs: dl <container_name>

# Remove all stopped containers, unused networks, and dangling images
alias dprune='docker system prune -a --volumes'

# Stop and remove ALL containers (Careful!)
alias dstopall='docker stop $(docker ps -aq) && docker rm $(docker ps -aq)'

# Delete all "dangling" images (the ones labeled <none>)
alias dclean-i='docker rmi $(docker images -f "dangling=true" -q)'

# Enter a running container's shell (Usage: dex <name>)
alias dex='docker exec -it'

# Quick restart
alias dr='docker restart'

# Get the IP address of a container
alias dip="docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"

alias dco='docker compose'
alias dcup='docker compose up -d'
alias dcdn='docker compose down'
alias dcl='docker compose logs -f'
alias dcb='docker compose build'


#nvim as vim
alias vim="nvim"

#abrir yazi en la carpeta de libros
alias li="yazi ~/ce/Libros"

#make yay manage only aur
alias yay="yay --aur"

#Zsh spellchecking false positives
alias tmuxp="nocorrect tmuxp"
#alias <command>="nocorrect <command>"

##############
# END OF FILE
##############


# Auto-Compile .zshrc for next time
if [[ ~/.zshrc -nt ~/.zshrc.zwc ]]; then
  zcompile ~/.zshrc
fi

# Profiler (uncomment to enable)
if [ $PROFILING_MODE -ne 0 ]; then
    zprof
    local zsh_end_time=$(( EPOCHREALTIME * 1000 ))
    printf "Shell init time: %.0f ms\n" $(( zsh_end_time - zsh_start_time ))
fi
