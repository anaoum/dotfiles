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

source ~/.bin/git-prompt.sh

function preexec {
    __start_time=$SECONDS
}

function precmd {
    (( psvar[1] = SECONDS - __start_time ))
    if [ -n "$__start_time" -a $psvar[1] -ge 1 ]; then
        [ $psvar[1] -ge 10 ] && echo -ne '\a'
    else
        psvar[1]=()
    fi
    unset __start_time
    if [ -n "$VIRTUAL_ENV" ]; then
        psvar[2]="($(basename "$VIRTUAL_ENV"))"
    else
        psvar[2]=()
    fi
    if [ -x "$(command -v direnv)" ]; then
        eval "$(direnv export zsh)"
    fi
    echo -e "\033]0;${HOST%%.*}: ${PWD/#$HOME/~}\007"
    __git_ps1 '%F{green}%n@%m%f:%F{blue}%~%f' '%(?.. {%F{magenta}%?%f})%(1V. (%F{cyan}%1vs%f).)'$'\n''%2v%# ' ' [%s]'
}

setopt histignorealldups histignorespace incappendhistory
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.state/zsh_history

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
