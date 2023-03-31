#!/usr/bin/env bash

function __zsh__() {
    ln -sfv "$(pwd)/.zshrc" "$HOME/.zshrc"
}

function __tmux__() {
    ln -sfv "$(pwd)/.tmux.conf" "$HOME/.tmux.conf"
}

function __git__() {
    ln -sfv "$(pwd)/git/.gitconfig" "$HOME/.gitconfig"
    ln -sfv "$(pwd)/git/.gitignore_global" "$HOME/.gitignore_global"
}

function __vim__() {
    ln -sfv "$(pwd)/.vimrc" "$HOME/.vimrc"
}

function __vscode__() {
    VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
    if [ ! -d "$VSCODE_USER_DIR" ]; then
        mkdir -p "$VSCODE_USER_DIR"
    fi
    ln -sfv "$(pwd)/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
}

if [ -z "$1" ]; then
    DOTFILES=(
        zsh
        tmux
        git
        vim
        vscode
    )
else
    DOTFILES="$@"
fi

for i in $DOTFILES; do
    if type -t "__${i}__" | grep function &> /dev/null; then
        echo "Linking ${i} dotfiles..."
        eval "__${i}__"
    else
        echo "${i} dotfiles not found"
    fi
done
