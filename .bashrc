#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
fc-match 'Fira Code Medium Nerd Font Complete Mono.ttf'

clear
PATH=$PATH:~/.local/share/nvim/mason/bin/
MSYS=winsymlinks:nativestrict

alias la='ls -a'
alias nv=nvim
alias reb='shutdown -r now'
alias shut='shutdown -P now'
alias ..='cd ..'
alias ...='cd ../..'
alias ran='ranger'
