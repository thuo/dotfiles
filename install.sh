#!/usr/bin/env bash

function __homebrew__() {
    if ! brew --version &> /dev/null; then
        echo "Installing Homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    brew bundle
}

function __oh-my-zsh__() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    ZSH_AUTOSUGGESTIONS_DIR="$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    if [ ! -d "$ZSH_AUTOSUGGESTIONS_DIR" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_AUTOSUGGESTIONS_DIR
    fi
}

function __tmux__() {
    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$TPM_DIR" ]; then
        echo "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    fi
    sh ./link.sh tmux
    sh "$TPM_DIR/bin/install_plugins"
}

function __atom__() {
    apm install --packages-file atom/packages.txt
}

function __vscode__() {
    while read line; do code --install-extension "$line"; done < vscode/extensions.txt
}

function __npm__() {
    while read line; do npm i -g "$line"; done < npm.txt
}

function __pip__() {
    pip3 install --upgrade -r pip.txt
}

if [ -z "$1" ]; then
    DOTFILES=(
        homebrew
        oh-my-zsh
        tmux
        atom
        vscode
        npm
        pip
    )
else
    DOTFILES="$@"
fi

for i in $DOTFILES; do
    if type "__${i}__" &> /dev/null; then
        echo "Installing ${i} dotfiles..."
        eval "__${i}__"
    else
        echo "${i} dotfiles not found"
    fi
done
