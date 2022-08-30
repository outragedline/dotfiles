#!/bin/bash

sudo pacman -Syu neovim nodejs-lts-gallium python3 python-pip ripgrep fd lua fzf gcc  npm tree-sitter lua-language-server git jdk17-openjdk maven

pip install wheel pynvim autopep8 flake8

git clone https://github.com/outragedline/nvim ~/.config/nvim

git clone https://github.com/microsoft/java-debug ~/.config/nvim/java-debug
cd ~/.config/nvim/java-debug
./mvnw clean install

git clone https://github.com/microsoft/vscode-java-test.git ~/.config/nvim/vscode-java-test
cd ~/.config/nvim/vscode-java-test
npm install
npm run build-plugin
