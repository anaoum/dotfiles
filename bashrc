#! bash

[ -z "$PS1" ] && return

if [ -r /usr/local/share/bash-completion/bash_completion ]; then
    export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
    source /usr/local/share/bash-completion/bash_completion
elif [ -r /usr/share/bash-completion/bash_completion ]; then
    export BASH_COMPLETION_COMPAT_DIR="/etc/bash_completion.d"
    source /usr/share/bash-completion/bash_completion
fi

function __preexec_invoke_exec {
    [ -n "$COMP_LINE" ] && return
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return
    history -a
    __start_time=$SECONDS
}
trap '__preexec_invoke_exec' DEBUG

function __prompt_command {
    __exit_status_saved="$?"
    if [ -n "$__start_time" ]; then
        __total_time=$(($SECONDS - $__start_time))
        if [ $__total_time -ge 10 ]; then
            echo -ne '\a'
        elif [ $__total_time -lt 1 ]; then
            unset __total_time
        fi
        unset __start_time
    fi
    if [ -x "$(command -v direnv)" ]; then
        eval "$(direnv export bash)"
    fi
    echo -e "\033]0;${HOSTNAME%%.*}: ${PWD/#$HOME/\~}\007"
}
PROMPT_COMMAND='__prompt_command'

PS1='$(tput setaf 2)\u@\h$(tput sgr0):$(tput setaf 4)\w$(tput sgr0)$(__git_ps1_colored " [%s]")$(__end_time)$(__exit_status)\n$(__ve_prompt)\$ ';

function __end_time {
    if [ -n "$__total_time" ]; then
        echo " $(tput setaf 6)(${__total_time}s)$(tput sgr0)"
    fi
}

function __exit_status {
    if [ "$__exit_status_saved" -ne "0" ]; then
        echo " $(tput setaf 5){$__exit_status_saved}$(tput sgr0)"
    fi
}

VIRTUAL_ENV_DISABLE_PROMPT=1
function __ve_prompt {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "($(basename "$VIRTUAL_ENV"))"
    fi
}

HISTIGNORE='&:[ ]*' # Ignores duplicate liness and lines that start with a space
HISTFILESIZE=1000000
HISTSIZE=100000
HISTFILE="$HOME/.state/bash_history"

# Disable macOS session history
if [ ! -e "$HOME/.bash_sessions_disable" ]; then
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
