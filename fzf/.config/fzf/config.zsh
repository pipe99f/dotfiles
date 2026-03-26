export FZF_DEFAULT_COMMAND='fd --type f'
# export FZF_DEFAULT_OPTS='--cycle --info=inline --reverse --bind ctrl-z:ignore,tab:down,shift-tab:up --tabstop=1 --no-sort'
export FZF_DEFAULT_OPTS=" \
--cycle --info=inline --reverse --bind ctrl-z:ignore,tab:down,shift-tab:up --tabstop=1 --no-sort \
--color=bg+:#363a4f,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

#conda environments
# fzf-conda-activate () {
#     choice=(
#         $(
#             conda env list |
#             sed 's/\*/ /;1,2d' |
#             xargs -I {} bash -c '
#                 name_path=( {} );
#                 py_version=( $(${name_path[1]}/bin/python --version) );
#                 echo ${name_path[0]} ${py_version[1]} ${name_path[1]}
#             ' |
#             column -t |
#             fzf --layout=reverse \
#                 --info=inline \
#                 --border=rounded \
#                 --height=40 \
#                 --preview-window="right:30%" \
#                 --preview-label=" conda tree leaves " \
#                 --preview=$'
#                     conda tree -p {3} leaves |
#                     perl -F\'[^\\w-_]\' -lae \'print for grep /./, @F;\' |
#                     sort
#                 '
#         )
#     )
#     [[ -n "$choice" ]] && conda activate "$choice"
# }

#open file in nvim
# alias fe="fd --type f --follow --hidden --exclude .git | fzf --preview 'bat --color=always {1}' --border |sed -r 's|[[:blank:]]|\\\ |g'| xargs -r nvim"
# This one doesn't have the problem with spaces in file names
alias fe="fd --type f --follow --hidden --exclude .git | fzf --preview 'bat --color=always {}' --bind 'enter:execute(nvim {})+accept'"


alias pacmansearch="pacman -Slq | fzf --multi --preview 'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk \"{print \$2}\")' | xargs -ro sudo pacman -S"

#find file that contains the argument string
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v 'HEAD') &&
  branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(echo "$branches" | wc -l) )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fkill - kill processes - list only the ones you can kill
fkill() {
    local pid
    pid=$(ps -u $USER -o pid,stat,start,time,command | fzf --header='[kill:process]' --tail=10 --layout=reverse | awk '{print $1}')
    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -9
    fi
}
