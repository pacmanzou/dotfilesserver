# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    SESSION_NAME="pserver"
    tmux attach-session -t $SESSION_NAME || tmux new-session -s $SESSION_NAME
fi

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias d='docker'
alias s='systemctl'
alias r='ranger'
alias h='htop'
alias e='exit'
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions