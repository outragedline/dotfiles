# Setting the links with GNU stow

Install GNU stow in arch linux
```
sudo pacman -S stow
```

Now copy and paste this in the terminal
```
git clone https://github.com/outragedline/dotfiles ~/.dotfiles/
cd ~/.dotfiles/
MSYS=winsymlinks:nativestrict
stow .
```
