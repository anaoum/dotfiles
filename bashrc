#! bash

"$HOME/.bin/pbcopy" --server

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

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=auto
function __git_ps1_colored {
    local git_status="$(__git_ps1 "$1")"
    if [ -n "$git_status" ]; then
        if [[ $git_status =~ [*]  ]]; then
            git_status="$(tput setaf 1)$git_status$(tput sgr0)"
        elif [[ $git_status =~ [%\<\>$+] ]]; then
            git_status="$(tput setaf 3)$git_status$(tput sgr0)"
        else
            git_status="$(tput setaf 2)$git_status$(tput sgr0)"
        fi
    fi
    echo "$git_status"
}

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

if type dircolors &> /dev/null; then
    alias ls='ls --color=auto'
    export LS_COLORS='di=34:ln=36:so=35:pi=33:ex=32:bd=33:cd=33:su=41:sg=43;30:tw=42;30:ow=42;34'
else
    alias ls='ls -G'
    export LSCOLORS='exgxfxdxcxdxdxxbadacbc'
fi

function list-repos {
    mkdir -p "$HOME/repos"
    find "$HOME/repos" -mindepth 1 -maxdepth 1 -not -name '.*' | while read file; do
        if [ -d "$file" ]; then
            (
                cd "$file"
                git_status=$(__git_ps1_colored "%s")
                if [ -z "$git_status" ]; then
                    git_status="$(tput setaf 1)untracked$(tput sgr0)"
                fi
                echo "$file/	$git_status"
            ) &
        else
            echo "$file	$(tput setaf 1)untracked$(tput sgr0)"
        fi
    done | sed "s#$HOME/repos/##" | sort | column -t -s $'\t'
}

alias l='ls -lh'
alias la='ls -lah'
alias lsq='ls --quoting=escape'
alias grep='grep --color=auto'
alias less='/usr/share/vim/vim*/macros/less.sh'
alias lr='list-repos'
alias whatismyip='wget http://ipinfo.io/ip -qO -'
alias duh='du -d1 . | sort -rn | numfmt --from-unit=1024 --to=iec-i --suffix=B'
