function rfe
    set args $argv
    if test (count $args) -eq 0
        set args "."
    end

    rg --color=always --line-number --no-heading --smart-case $args |
        fzf --ansi \
            --color "hl:-1:underline,hl+:-1:underline:reverse" \
            --delimiter : \
            --preview 'bat --color=always {1} --highlight-line {2}' \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
            --bind 'enter:become(emacsclient {1})'
end
