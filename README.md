# kandaharu's Dotfiles

## 🚀 Overview

このリポジトリは、kandaharu が普段使っている開発環境の構成を管理するための `.dotfiles` セットです。
Neovim、WezTerm、Zsh など、モダンかつ快適な CLI 環境を目指して設計されています。

## 📦 Included Components

- Neovim: Lua + Lazy.nvim
- WezTerm: タブ・ペイン設定、カラースキームなど
- Zsh + Prezto: fzf連携、各種alias・関数付き
- Git設定:詳細なaliasと表示設定

## 🛠️ Setup

```bash
git clone --recursive https://github.com/yu-takahas/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

💡 install.sh により、各種設定ファイルへのシンボリックリンクが自動作成されます。


🧩 Directory Structure

.dotfiles/
├── home/
│   ├── .gitconfig
│   ├── .gitignore
│   └── config/wezterm.lua
├── vim/
│   ├── init.lua (Neovim Lua)
│   ├── init.vim (Vim script)
│   ├── install.sh
│   ├── lua/
│   │   ├── plugins.lua
│   │   ├── settings.lua
│   │   ├── keymaps.lua
│   │   └── filetypes.lua
│   └── dein/rc/*.toml
├── zsh/
│   ├── zprofile
│   ├── zshenv
│   └── zshrc
└── install.sh

