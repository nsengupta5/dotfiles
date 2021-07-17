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
