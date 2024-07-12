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

#run starship theme
eval "$(starship init zsh)"

# Plugins
# zinit ice depth=1
# zinit light jeffreytse/zsh-vi-mode # it is too slow
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# snippets plugins
zinit snippet OMZP::aws
zinit snippet OMZP::command-not-found
zinit snippet OMZP::copypath
zinit snippet OMZP::copyfile
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::vi-mode

# Load completions
autoload -U compinit && compinit
# Improves performance of compinit
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${s.:.)LS_COLORS}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

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

#default programs
# export MAIL:thunderbird

#GTK THEME
export GTK_THEME=Adwaita-One-Dark
export XDG_CURRENT_DESKTOP=sway

#QT
export QT_QPA_PLATFORMTHEME=qt6ct

#Spellchecking
setopt correct
# export SPROMPT="Correct %R to %r? [Yes, No, Abort, Edit] "
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? [Yes, No, Abort, Edit] "

#Required by tmuxp
export DISABLE_AUTO_TITLE="true"

# Atuin
eval "$(atuin init zsh --disable-up-arrow)"

# FZF
source <(fzf --zsh)
source $HOME/.config/fzf/config.zsh

# PATH
export PATH=$PATH:$HOME/dotfiles/scripts/scripts
export PATH=$PATH:$HOME/.config/emacs/bin

# Source functions file
source $HOME/dotfiles/scripts/scripts/functions.zsh

# Zoxide (replaces cd)
eval "$(zoxide init --cmd cd zsh)"

# Zsh-syntax-highlighting theme
source $HOME/dotfiles/scripts/scripts/catppuccin_macchiato-zsh-syntax-highlighting.zsh


# Aliases

# alias ll='ls -alF'
# alias la='ls -A'
alias ls='exa --icons --git'
alias ll='exa --icons --git -labF'
alias la='exa --icons --git -a'
alias llm='exa --icons --git -labF --sort=modified'

#nvim as vim
alias vim="nvim"
alias vi="nvim"

#abrir yazi en la carpeta de libros
alias li="yazi ~/ce/Libros"

#make yay manage only aur
alias yay="yay --aur"

#Zsh spellchecking false positives
alias tmuxp="nocorrect tmuxp"
#alias <command>="nocorrect <command>"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/pipe99f/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/pipe99f/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/pipe99f/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/pipe99f/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

