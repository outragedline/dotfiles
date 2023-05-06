#!/bin/sh
# Hyprland basic packages
yay -S hyprland xdg-desktop-portal-hyprland-git grimblast-git waybar-hyprland-git hyprpaper-git rofi-lbonn-wayland-git pavucontrol nwg-look-bin alacritty grim slurp hyprpicker-git

# Neovim
yay -S neovim nodejs-lts-hydrogen python3 python-pip ripgrep fd lua gcc npm

pip install wheel pynvim 

# Other important applications
yay -S zathura zathura-cb zathura-pdf-poppler qbittorrent ranger udisks2 telegram-desktop ungoogled-chromium-bin mpv viewnior htop thunderbird zsh
