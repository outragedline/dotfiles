#!/bin/sh
# Hyprland basic packages
yay -S hyprland xdg-desktop-portal-hyprland-git grimblast-git waybar-hyprland-git hyprpaper-git rofi-lbonn-wayland-git pavucontrol nwg-look-bin alacritty grim slurp hyprpicker-git ttf-jetbrains-mono-nerd pipewire pipewire-pulse wireplumber wl-clipboard pamixer dunst libnotify blueberry ripdrag brightnessctl hyprland-workspaces gammastep

# Theme
yay -S catppuccin-gtk-theme-mocha

# Neovim
yay -S neovim nodejs-lts-hydrogen python3 python-pip ripgrep fd lua gcc npm unzip tidy wget lldb clang python-pynvim
sudo npm i -g neovim

# Other important applications
yay -S zathura zathura-cb zathura-pdf-poppler qbittorrent ranger udisks2 telegram-desktop ungoogled-chromium-bin chromium-extension-web-store mpv viewnior htop thunderbird zsh lazygit stow github-cli 
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh)
