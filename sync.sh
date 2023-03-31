#!/usr/bin/env bash

# Brewfile
if which brew &> /dev/null; then
    brew bundle dump --force
fi

# VSCode Extensions
if which code &> /dev/null; then
    code --list-extensions \
        > vscode/extensions.txt
fi

# Global NPM packages
if which npm &> /dev/null; then
    npm ls  --json --global --depth=0 \
        | jq --raw-output '.dependencies | del(.npm) | keys[]' \
        > npm.txt
fi

# PIP packages
if which pip3 && which jq &> /dev/null; then
    pip3 list --format json --not-required \
        | jq --raw-output 'map(.name) - ["pip", "wheel", "setuptools"] | .[]' \
        > pip.txt
fi
