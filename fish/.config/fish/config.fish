set -g fish_greeting ""

set -x PATH "$HOME/.cargo/bin" $PATH
set -x PATH "$HOME/.local/bin" $PATH

set -gx EDITOR hx
set -gx STARSHIP_CONFIG "$HOME/.config/starship/config.toml"

set -Ux FZF_DEFAULT_OPTS \
    "--color=bg+:#073642,bg:#002b36,spinner:#2aa198,hl:#268bd2" \
    "--color=fg:#839496,header:#268bd2,info:#b58900,pointer:#2aa198" \
    "--color=marker:#2aa198,fg+:#eee8d5,prompt:#b58900,hl+:#268bd2"

alias ls="eza"

bind \cz 'fg 2>/dev/null; commandline -f repaint'

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function b
    bit list | fzf | awk '{ print $1 }' | xargs -I {} bit open {}
end

if test -f $HOME/.local.fish
    source $HOME/.local.fish
end

fzf --fish | source
starship init fish | source
zoxide init --cmd cd fish | source
