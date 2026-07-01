set fish_greeting ""

fish_vi_key_bindings

set -x EDITOR hx
set -x VISUAL hx
set -x JOURNAL_DIR "$HOME/icloud/personal/journal"

fish_add_path -p \
    "$HOME/.local/bin" \
    "$HOME/.cargo/bin" \
    "$HOME/.go/bin"

function fish_prompt
    set -g __fish_git_prompt_showupstream auto
    string join '' -- (set_color blue) (prompt_pwd) (set_color red) (fish_git_prompt) \n (set_color magenta) '> ' (set_color --reset)
end

abbr -a -- src "source ~/.config/fish/config.fish"
abbr -a -- fd "fd -c never -H --exclude .git"

abbr -a --position anywhere -- @config ~/.config/

abbr -a -- cdg 'cd (git rev-parse --show-toplevel)'
abbr -a --command git -- s status
abbr -a --command git -- sw switch
abbr -a --command git -- aa 'add --all'
abbr -a --command git -- fa 'fetch --all'
abbr -a --command git -- c commit
abbr -a --command git -- ca 'commit --amend'
abbr -a --set-cursor='%' --command git -- cm 'commit -m "%"'
abbr -a --command git -- ri 'rebase -i'
abbr -a --command git -- l 'log --stat'
abbr -a --command git -- lo 'log --pretty=format:"%Cgreen%h%Creset - %Cblue%an%Creset @ %ar : %s"'
abbr -a --command git -- stats 'shortlog -s -n --all --no-merges'
abbr -a --command git -- co checkout
abbr -a --command git -- cb 'checkout -b'
abbr -a --command git -- ba 'branch -a'
abbr -a --command git -- pf 'push --force-with-lease'
abbr -a --command git -- pt 'push --tags'
abbr -a --command git -- pl pull

abbr -a -- gcc "gcc -Wall -Wextra"
abbr -a -- macosldd "otool -L"

function repo-url -d "Open the current repo and branch on the website"
    set url (git config --get remote.origin.url | sed 's/:/\//' | sed 's/git@/https:\/\//' | sed 's/\.git//')
    set branch (git rev-parse --abbrev-ref HEAD)
    switch $url
        case "*bitbucket"
            echo "$url/branch/$branch"
        case "*"
            echo "$url/tree/$branch"
    end
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end

source ~/.work.fish

fzf --fish | source
zoxide init --cmd cd fish | source
mise activate fish | source
