#!/bin/sh

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%b'
PROMPT=$'%F{%(#.blue.green)}┌──(%B%F{%(#.red.blue)}%n@%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}] [%B%F{reset}%  ${vcs_info_msg_0_}%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '

# Options
setopt appendhistory
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
# Install the plugin manager with the command bellow
# sh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh)
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-autosuggestions"



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
alias py='python'



# Exports
HISTSIZE=1000000
SAVEHIST=1000000
PATH=$PATH:~/.local/share/nvim/mason/bin/:~/bin/
MSYS=winsymlinks:nativestrict
HISTFILE=~/.zsh_history
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
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
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
autoload edit-command-line; zle -N edit-command-line
bindkey '^E' edit-command-line
