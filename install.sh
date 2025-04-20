#!/bin/bash

rm -fv ~/.gitconfig
rm -fv ~/.gitignore
ln -s ~/.dotfiles/home/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/home/.gitignore ~/.gitignore

ln -s ~/.dotfiles/home/.screenrc ~/.screenrc
ln -s ~/.dotfiles/home/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/home/.tmux-powerlinerc ~/.tmux-powerlinerc
