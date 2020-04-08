# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    SESSION_NAME="pserver"
    tmux attach-session -t $SESSION_NAME || tmux new-session -s $SESSION_NAME
fi

export NVIM_PYTHON_LOG_FILE=/tmp/log
export NVIM_PYTHON_LOG_LEVEL=DEBUG

alias f='fish'
alias r='ranger'
alias sr='sudo -E ranger'
alias h='htop'
alias l='lazygit'
alias e='exit'
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
