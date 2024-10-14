bind 'set bell-style none'

[[ $- != *i* ]] && return

export VISUAL=emacs;
export EDITOR=emacs;
export STARSHIP_CONFIG=$HOME/.config/starship/starhip.toml
export GOPATH=$HOME/.local/go

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$GOPATH/bin" ]; then
    PATH="$GOPATH/bin:$PATH"
fi

if [ -d "$HOME/.config/emacs/bin" ]; then
    PATH="$HOME/.config/emacs/bin:$PATH"
fi

if [ -d "$HOME/.qlot/bin" ]; then
    PATH="$HOME/.qlot/bin:$PATH"
fi

PS1='[\u@\h \W]\$ '

alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias ff='fastfetch'
alias lsblk-full='lsblk -o name,mountpoint,fstype,label,size,uuid'
