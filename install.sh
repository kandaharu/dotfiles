#!/bin/bash

ln -s ~/.dotfiles/home/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/home/.gitignore ~/.gitignore
ln -s ~/.dotfiles/home/.vimrc ~/.vimrc

ln -s ~/.dotfiles/home/.screenrc ~/.screenrc
ln -s ~/.dotfiles/home/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/home/.tmux-powerlinerc ~/.tmux-powerlinerc

mkdir -p ~/.config/nvim/
ln -s ~/.dotfiles/vim/init.vim ~/.config/nvim/init.vim

# シンボリックリンクを張ろうと思ったらうまくいかなかったので都度コピーする
mkdir -p /mnt/c/home/vimfiles/dein/rc/
ln -s ~/.dotfiles/vim/dein/rc/dein.toml          ~/.config/nvim/dein/rc/dein.toml
ln -s ~/.dotfiles/vim/dein/rc/lazy_dein.toml     ~/.config/nvim/dein/rc/lazy_dein.toml
ln -s ~/.dotfiles/vim/dein/rc/win_dein.toml      ~/.config/nvim/dein/rc/win_dein.toml
ln -s ~/.dotfiles/vim/dein/rc/win_lazy_dein.toml ~/.config/nvim/dein/rc/win_lazy_dein.toml
ln -s ~/.dotfiles/vim/dein/rc/wsl_dein.toml      ~/.config/nvim/dein/rc/wsl_dein.toml
ln -s ~/.dotfiles/vim/dein/rc/wsl_lazy_dein.toml ~/.config/nvim/dein/rc/wsl_lazy_dein.toml

