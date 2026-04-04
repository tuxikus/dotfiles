autoload -Uz compinit; compinit
bindkey -v

export SSH_AUTH_SOCK="~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
export EDITOR="nvim"
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.go/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
PATH="/opt/homebrew/opt/rustup/bin:$PATH"
export path

alias vim="nvim"
alias sz="source ~/.zshrc"
alias ls="list-files"
alias ll="list-files"
alias lg="lazygit"

nubo() {
    local func=$1
    shift
    nu -c "source ~/.local/bin/nubo.nu; $func $@"
}

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=$'%f'
COLOR_GIT=$'%F{197}'
COLOR_DIR=$'%F{39}'
COLOR_ARR=$'%F{141}'
NEWLINE=$'\n'
setopt PROMPT_SUBST
export PROMPT='${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_ARR} ${NEWLINE}❯${COLOR_DEF} '

source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
eval "$(mise activate zsh)"
