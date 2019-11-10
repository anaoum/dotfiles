#! bash

source "$HOME/.bash/all"

if [ -z "$PS1" ]; then
    source "$HOME/.bash/script"
else
    source "$HOME/.bash/interactive"
fi

if shopt -q login_shell; then
    source "$HOME/.bash/login"
fi
