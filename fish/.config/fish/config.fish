if status is-interactive
   # Commands to run in interactive sessions can go here
   set -U fish_greeting ""
   fzf --fish | source
end

if test -d $HOME/.local/bin
   fish_add_path $HOME/.local/bin
end

if test -d $HOME/.config/emacs/bin
   fish_add_path $HOME/.config/emacs/bin
end

if test -d $HOME/.qlot/bin
   fish_add_path $HOME/.qlot/bin
end

if test -d /opt/homebrew/bin
   fish_add_path /opt/homebrew/bin
end

alias s="ssh"
