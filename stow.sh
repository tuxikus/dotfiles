#!/usr/bin/env bash

set -e

usage () {
    echo "usage: ./stow.sh [macos|linux]"
}

stow_macos() {
    mkdir ~/.emacs.d
    stow -t "$HOME" emacs
    stow -t "$HOME" aerospace
    stow -t "$HOME" zsh
}

stow_linux() {}

if [[ "$#" -ne 1 ]]; then
    usage
    exit 1
fi

case $1 in
    "macos")
	echo "stowing for macos..."
	stow_macos
	;;
    "linux")
	echo "stowing for linux"
	;;
    *)
	usage
	;;
esac
