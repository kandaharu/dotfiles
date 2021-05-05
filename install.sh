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
cp -v ~/.dotfiles/vim/dein/rc/dein.toml          /mnt/c/home/vimfiles/dein/rc/dein.toml
cp -v ~/.dotfiles/vim/dein/rc/lazy_dein.toml     /mnt/c/home/vimfiles/dein/rc/lazy_dein.toml
cp -v ~/.dotfiles/vim/dein/rc/win_dein.toml      /mnt/c/home/vimfiles/dein/rc/win_dein.toml
cp -v ~/.dotfiles/vim/dein/rc/win_lazy_dein.toml /mnt/c/home/vimfiles/dein/rc/win_lazy_dein.toml
cp -v ~/.dotfiles/vim/dein/rc/wsl_dein.toml      /mnt/c/home/vimfiles/dein/rc/wsl_dein.toml
cp -v ~/.dotfiles/vim/dein/rc/wsl_lazy_dein.toml /mnt/c/home/vimfiles/dein/rc/wsl_lazy_dein.toml
cp -v ~/.dotfiles/vim/init.vim                   /mnt/c/home/_vimrc
cp -v ~/.dotfiles/vim/_gvimrc                    /mnt/c/home/_gvimrc

