#! sh

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
export LSCOLORS='exgxfxdxcxdxdxxbadacbc'
export LS_COLORS='di=34:ln=36:so=35:pi=33:ex=32:bd=33:cd=33:su=41:sg=43;30:tw=42;30:ow=42;34'
export TERM='xterm-256color'

if [ -S "$SSH_AUTH_SOCK" ] && [ ! -L "$SSH_AUTH_SOCK" ]; then
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.state/ssh_auth_sock"
    export SSH_AUTH_SOCK="$HOME/.state/ssh_auth_sock"
fi

"$HOME/.bin/pbcopy" --server

if [ -n "$BASH_VERSION" ]; then
    . "$HOME/.bashrc"
fi

if [ -r "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
fi
