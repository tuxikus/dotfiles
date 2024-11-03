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

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

alias python='python3'
alias s='ssh'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias ff='fastfetch'
alias t='tmux new-session -A -s local'

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
