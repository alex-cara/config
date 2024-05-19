#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

export PATH=$PATH:~/.cargo/bin/
export PATH="$HOME/.scripts:$PATH"

export EDITOR=nvim
alias nvim='nvim --listen /tmp/nvim-server.pipe'
alias vim=nvim
alias n=nvim
alias ru_repl=evcxr

eval "$(starship init bash)"
