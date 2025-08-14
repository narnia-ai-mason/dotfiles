#!/usr/bin/bash

export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

alias ls='ls -G'
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias vi='nvim'
alias vim='nvim'

[[ $- == *i* ]] &&
  source -- "$HOME/.local/share/blesh/ble.sh" --attach=none --rcfile "$HOME/.blerc"

[[ ! ${BLE_VERSION-} ]] || ble-attach

eval "$(starship init bash)"

. "$HOME/.local/bin/env"

source <(fzf --bash)
