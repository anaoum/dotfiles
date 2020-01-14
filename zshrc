#! zsh

source ~/.profile

bindkey -e
bindkey "^[[3~" delete-char

autoload -Uz compinit
compinit -d ~/.state/zcompdump
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

VIRTUAL_ENV_DISABLE_PROMPT=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM=auto

source ~/.gitprompt

function preexec {
    __start_time=$SECONDS
}

function precmd {
    unset psvar
    (( __total_time = SECONDS - __start_time ))
    if [ -n "$__start_time" -a $__total_time -ge 1 ]; then
        [ $__total_time -ge 10 ] && echo -ne '\a'
        psvar[1]=$__total_time
    fi
    unset __start_time __total_time
    if [ -n "$VIRTUAL_ENV" ]; then
        psvar[2]="($(basename "$VIRTUAL_ENV"))"
    elif [ -n "$CONDA_PREFIX" ]; then
        psvar[2]="($(basename "$CONDA_PREFIX"))"
    fi
    if [ -x "$(command -v direnv)" ]; then
        eval "$(direnv export zsh)"
    fi
    echo -e "\033]0;${HOST%%.*}: ${PWD/#$HOME/~}\007"
    __git_ps1 '%F{green}%n@%m%f:%F{blue}%~%f' '%(?.. {%F{magenta}%?%f})%(1V. (%F{cyan}%1vs%f).)'$'\n''%2v%# ' ' [%s]'
}

setopt histignorealldups histignorespace incappendhistory
SAVEHIST=1000000
HISTSIZE=1000000
HISTFILE=~/.state/zsh_history

source ~/.aliases
