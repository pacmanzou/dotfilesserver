#!/usr/bin/bash
# ~/.bashrc
export PATH="/usr/bin:$PATH"
export EDITOR=nvim
export VISUAL=nvim
alias r='ranger'
alias la='ls -la'
alias ll='ls -l'

if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    SESSION_NAME="PSERVER"
    tmux attach-session -t $SESSION_NAME || tmux new-session -s $SESSION_NAME
fi
