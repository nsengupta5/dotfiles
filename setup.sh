#!/bin/bash

cd ~/dotfiles || return

ln -s ~/dotfiles/.bash_aliases ~/.bash_aliases
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
