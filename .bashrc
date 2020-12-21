#!/usr/bin/bash
# ~/.bashrc
export PATH="/usr/bin:$PATH"
alias r='ranger'
alias la='ls -la'
alias ll='ls -l'
alias qtdq='sudo pacman -Rns $(pacman -Qtdq)'

if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then                                                                                                  │
    SESSION_NAME="SERVER"                                                                                                                                │
    tmux attach-session -t $SESSION_NAME || tmux new-session -s $SESSION_NAME
fi
