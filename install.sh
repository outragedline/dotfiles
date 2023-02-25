#!/bin/bash

sudo pacman -Syu neovim nodejs-lts-gallium python3 python-pip ripgrep fd lua fzf gcc npm

pip install wheel pynvim 

git clone https://github.com/outragedline/nvim ~/.config/nvim
