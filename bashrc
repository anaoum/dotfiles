#! bash

[ -z "$PS1" ] && return

VIRTUAL_ENV_DISABLE_PROMPT=1
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWUPSTREAM=auto

if [ -r /usr/local/share/bash-completion/bash_completion ]; then
    export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
    source /usr/local/share/bash-completion/bash_completion
elif [ -r /usr/share/bash-completion/bash_completion ]; then
    export BASH_COMPLETION_COMPAT_DIR="/etc/bash_completion.d"
    source /usr/share/bash-completion/bash_completion
fi

function preexec {
    [ -n "$COMP_LINE" ] && return
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return
    history -a
    __start_time=$SECONDS
}
trap 'preexec' DEBUG

function precmd {
    __exit_status="$?"
    if [ "$__exit_status" -ne "0" ]; then
        __exit_status=" {$(tput setaf 5)$__exit_status$(tput sgr0)}"
    else
        __exit_status=""
    fi
    (( __total_time = SECONDS - __start_time ))
    if [ -n "$__start_time" -a $__total_time -ge 1 ]; then
        [ $__total_time -ge 10 ] && echo -ne '\a'
        __total_time=" ($(tput setaf 6)${__total_time}s$(tput sgr0))"
    else
        __total_time=""
    fi
    unset __start_time
    if [ -n "$VIRTUAL_ENV" ]; then
        __ve_prompt="($(basename "$VIRTUAL_ENV"))"
    else
        __ve_prompt=""
    fi
    if [ -x "$(command -v direnv)" ]; then
        eval "$(direnv export bash)"
    fi
    echo -e "\033]0;${HOSTNAME%%.*}: ${PWD/#$HOME/\~}\007"
    __git_ps1 '$(tput setaf 2)\u@\h$(tput sgr0):$(tput setaf 4)\w$(tput sgr0)' '$__total_time$__exit_status\n$__ve_prompt\$ ' ' [%s]'
}
PROMPT_COMMAND=precmd

HISTIGNORE='&:[ ]*' # Ignores duplicate liness and lines that start with a space
HISTFILESIZE=1000000
HISTSIZE=100000
HISTFILE="$HOME/.state/bash_history"

# Disable macOS session history
if [ "$TERM_PROGRAM" = "Apple_Terminal" -a ! -e "$HOME/.bash_sessions_disable" ]; then
    touch "$HOME/.bash_sessions_disable"
fi

if [ -x "$(command -v dircolors)" ]; then
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
fi

alias l='ls -lh'
alias la='ls -lah'
alias lsq='ls --quoting=escape'
alias grep='grep --color=auto'
alias less='/usr/share/vim/vim*/macros/less.sh'
alias lr='list-repos'
alias whatismyip='wget http://ipinfo.io/ip -qO -'
alias duh='du -d1 . | sort -rn | numfmt --from-unit=1024 --to=iec-i --suffix=B'
