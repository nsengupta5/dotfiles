#!/bin/bash

cd ~/dotfiles || return

ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/config ~/.ssh/config
ln -s ~/dotfiles/awesome/rc.lua ~/.config/awesome/rc.lua
ln -s ~/dotfiles/awesome/screenshot.lua ~/.config/awesome/screenshot.lua
ln -s ~/dotfiles/awesome/themes/onedark/ ~/.config/awesome/themes/
ln -s ~/dotfiles/.xinitrc ~/.xinitrc
ln -s ~/dotfiles/.Xresources ~/.Xresources
ln -s ~/dotfiles/.Xmodmap ~/.Xmodmap
ln -s ~/dotfiles/locker ~/.config/awesome/locker
ln -s ~/dotfiles/smartlock ~/.config/awesome/smartlock
ln -s ~/dotfiles/config.rasi ~/.config/rofi/config.rasi
ln -s ~/dotfiles/id_ed25519 ~/.ssh/id_ed25519
ln -s ~/dotfiles/id_ed25519.pub ~/.ssh/id_ed25519.pub
ln -s ~/dotfiles/id_rsa ~/.ssh/id_rsa
ln -s ~/dotfiles/id_rsa.pub ~/.ssh/id_rsa.pub
ln -s ~/dotfiles/authorized_keys ~/.ssh/authorized_keys
ln -s ~/dotfiles/clean ~/bin/clean
ln -s ~/dotfiles/update ~/bin/update
ln -s ~/dotfiles/allcolors ~/bin/allcolors
