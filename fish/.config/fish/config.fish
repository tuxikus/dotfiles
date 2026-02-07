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

abbr -ag gco "git checkout"
abbr -ag gcof "git checkout (tv --inline git-branch)"
abbr -ag ga "git add"
abbr -ag gaa "git add --all"
abbr -ag gs "git status"
abbr -ag gc "git commit"
abbr -ag gca "git commit --amend"
abbr -ag --set-cursor="%" gcm "git commit -m '%'"
abbr -ag gfa "git fetch --all"
abbr -ag gp "git push"
abbr -ag gpf "git push --force-with-lease"
abbr -ag gl "git log"
abbr -ag glo "git log --oneline"

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

# fzf --fish | source
# sk --shell fish | source
tv init fish | source
starship init fish | source
zoxide init --cmd cd fish | source
