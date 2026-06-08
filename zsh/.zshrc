autoload -Uz compinit; compinit
bindkey -v

setopt HIST_IGNORE_SPACE

export EDITOR="hx"
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
export KEYTIMEOUT=1

PATH="$HOME/.local/bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.go/bin:$PATH"
export path

alias sz="source ~/.zshrc"
alias g="gitui"

if [ -f "$HOME/.work.env" ]
then
  source "$HOME/.work.env"
fi

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

function nubo() {
  local func=$1
  shift
  nu -c "source ~/.local/bin/nubo.nu; $func $@"
}

function zle-keymap-select {
  case $KEYMAP in
    vicmd)
      echo -ne '\e[1 q'
      ;;
    main|viins)
      echo -ne '\e[5 q'
      ;;
  esac
}

zle -N zle-keymap-select

function zle-line-init {
  echo -ne '\e[5 q'
}

zle -N zle-line-init

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
