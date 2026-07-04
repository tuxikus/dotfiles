#!/usr/bin/env bash

mkdir ~/.emacs.d
stow -t "$HOME" emacs
stow -t "$HOME" aerospace
stow -t "$HOME" zsh
