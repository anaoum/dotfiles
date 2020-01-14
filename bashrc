#! bash

[ -z "$PS1" ] && return

if [ -r /usr/local/share/bash-completion/bash_completion ]; then
    BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
    source /usr/local/share/bash-completion/bash_completion
elif [ -r /usr/share/bash-completion/bash_completion ]; then
    BASH_COMPLETION_COMPAT_DIR="/etc/bash_completion.d"
    source /usr/share/bash-completion/bash_completion
fi

VIRTUAL_ENV_DISABLE_PROMPT=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM=auto

source ~/.gitprompt

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
    elif [ -n "$CONDA_PREFIX" ]; then
        __ve_prompt="($(basename "$CONDA_PREFIX"))"
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

HISTIGNORE='&:[ ]*'
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTFILE="$HOME/.state/bash_history"

source ~/.aliases
