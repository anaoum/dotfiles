#! sh

umask 077
sudo () {
    ( umask 022; command sudo "$@" )
}

__export_unique () {
    old=`eval echo '$'$1`
    new=`printf %s "$old" | awk -v RS=: '!a[$0]++' | paste -s -d: -`
    export $1="$new"
    unset old new
}

MANPATH="/usr/share/man:$MANPATH"
MANPATH="/opt/share/man:$MANPATH"
MANPATH="/usr/local/share/man:$MANPATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/libressl/share/man:$MANPATH"

PATH="/sbin:$PATH"
PATH="/bin:$PATH"
PATH="/usr/sbin:$PATH"
PATH="/usr/bin:$PATH"
PATH="/opt/sbin:$PATH"
PATH="/opt/bin:$PATH"
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
PATH="/usr/local/opt/libressl/bin:$PATH"
PATH="$HOME/.bin:$PATH"
PATH="$HOME/bin:$PATH"

GOPATH="$HOME/gocode:$GOPATH"
PATH="$HOME/gocode/bin:$PATH"

__export_unique MANPATH
__export_unique PATH
__export_unique GOPATH

export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export LESS="-F -X -g -i -M -R -w"
export LESSHISTFILE="$HOME/.state/less_history"
export PYTHONSTARTUP="$HOME/.pythonrc.py"

if [ -n "$BASH_VERSION" ]; then
    . "$HOME/.bashrc"
fi