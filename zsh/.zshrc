autoload -Uz compinit
compinit

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.config/emacs/bin" ]; then
    PATH="$HOME/.config/emacs/bin:$PATH"
fi

if [ -d "$HOME/.qlot/bin" ]; then
    PATH="$HOME/.qlot/bin:$PATH"
fi

if [ -d "/opt/homebrew/bin" ]; then
    PATH="/opt/homebrew/bin:$PATH"
fi

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

PROMPT="%~ 🔮 "

source <(fzf --zsh)

alias ls='ls -G'
alias ll='ls -lah'
alias python='python3'
alias s='ssh'
alias saa='eval "$(ssh-agent -s)"'
alias ska='eval "$(ssh-agent -k)"'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias ff='fastfetch'
alias lsblk-full='lsblk -o name,mountpoint,fstype,label,size,uuid'
alias dnf-list-fuzzy='dnf list | fzf'
alias dnf-info-fuzzy='dnf info $(dnf list | fzf)'
alias szrc='source $HOME/.zshrc'
alias t='tmux'

export VISUAL=emacs;
export EDITOR=emacs;

export PROJECT_DIR="$HOME/work/projects"
cdp() {
    cd "$(find $PROJECT_DIR -maxdepth 1 | fzf)"
}

rfe() {
    rg --color=always --line-number --no-heading --smart-case "${*:-}" |
        fzf --ansi \
            --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --delimiter : \
            --preview 'bat --color=always {1} --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
            --bind 'enter:become(emacsclient {1})'
}

rfv() {
    rg --color=always --line-number --no-heading --smart-case "${*:-}" |
        fzf --ansi \
            --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --delimiter : \
            --preview 'bat --color=always {1} --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
            --bind 'enter:become(nvim {1} +{2})'
}

tn() {
    echo "Session name: "
    read  name
    tmux new-session -s "$name"
}

ts() {
    if test -z "$TMUX"; then
        tmux attach -t "$(tmux ls | awk -F ':' '{print $1}' | fzf)"
    else
        tmux switch -t "$(tmux ls | awk -F ':' '{print $1}' | fzf)"
    fi
}

tk() {
    tmux kill-session -t "$(tmux ls | awk -F ':' '{print $1}' | fzf)"
}

zellij-sessions () {
    ZJ_SESSIONS=$(zellij list-sessions)
    NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -l)

    if [ "${NO_SESSIONS}" -ge 2 ]; then
        zellij attach "$(echo "${ZJ_SESSIONS}" | fzf --ansi | awk '{print $1}')"
    else
        zellij attach -c
    fi
}
