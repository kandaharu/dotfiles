#!/bin/bash

# Vim の各種作業用フォルダを作る
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/snippets

# 設定ファイル用フォルダを作る
mkdir -p ~/.config/nvim/

# lua 用設定(luaの方を使う場合はこっち)

## init.lua をコピー
rm -fv ~/.config/nvim/init.lua
ln -s ~/.dotfiles/vim/init.lua ~/.config/nvim/init.lua

## lua の各設定ファイルをコピー
rm -rfv ~/.config/nvim/lua/
mkdir -p ~/.config/nvim/lua/
ls -1 ~/.dotfiles/vim/lua | xargs -IFILE ln -s ~/.dotfiles/vim/lua/FILE ~/.config/nvim/lua/FILE

# Vim Script 用設定(Vim script の方を使う場合はこっちコメントアウトして使って)

# # init.vim をコピー
# rm -fv ~/.config/nvim/init.vim
# ln -s ~/.dotfiles/vim/init.vim ~/.config/nvim/init.vim
#
# # Vim script の各設定ファイルをコピー
# rm -rfv ~/.config/nvim/dein/
# mkdir -p ~/.config/nvim/dein/rc
# ls -1 ~/.dotfiles/vim/dein/rc | xargs -IFILE ln -s ~/.dotfiles/vim/dein/rc/FILE ~/.config/nvim/dein/rc/FILE
