#!/bin/sh

PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;34m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - %b%{\e[0;34m%}%B[%b%{\e[1;37m%}%~%{\e[0;34m%}%B]%b%{\e[0m%} - %{\e[0;34m%}%B[%b%{\e[0;33m%}%!%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─%B[%{\e[1;35m%}$%{\e[0;34m%}%B]%{\e[0m%}%b '
RPROMPT='[%*]'
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

HISTFILE=~/.zsh_history
setopt appendhistory

# Options
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')
HYPHEN_INSENSITIVE="true"
unsetopt BEEP

# completions
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors



# Plugins
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zsh-users/zsh-syntax-highlighting"
plug "hlissner/zsh-autopair"



# Aliases
alias ls='ls --color=auto'
alias la='ls -a'
alias nv=nvim
alias reb='shutdown -r now'
alias shut='shutdown -P now'
alias ..='cd ..'
alias ...='cd ../..'
alias ran='ranger'
alias lg='lazygit'
alias mkd='mkdir'



# Exports
HISTSIZE=1000000
SAVEHIST=1000000
PATH=$PATH:~/.local/share/nvim/mason/bin/
MSYS=winsymlinks:nativestrict
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"
export QT_QPA_PLATFORMTHEME=qt5ct



# Vim mode
bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.



# Key-bindings
bindkey -s '^O' 'ranger^M'
bindkey "^[[3~" delete-char		# Delete key.
autoload edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line
