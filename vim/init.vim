"---------------------------------------------------------------------------
" kandaharu's init.vim
"
" 使用前提
" ・.vim 直下に swap, backup, undo, snippets ディレクトリを作成しておく
"---------------------------------------------------------------------------

"----------------------------------------------------------------------------
" 起動・環境設定
"----------------------------------------------------------------------------
let $DOTVIM=expand('~/.vim')
let $DEINDIR=expand('~/.config/nvim/dein')

"Spaceをリーダーに
let mapleader = "\<Space>"


"----------------------------------------------------------------------------
" プラグイン管理 (dein)
"----------------------------------------------------------------------------
if &compatible
  set nocompatible
endif

let s:dein_dir = $DEINDIR
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  " execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
    call dein#load_toml(s:dein_dir . '/rc/dein.toml', {'lazy': 0})
    call dein#load_toml(s:dein_dir . '/rc/lazy_dein.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"----------------------------------------------------------------------------
" 入力・操作設定
"----------------------------------------------------------------------------
"マウスで選択できるようにする
set mouse=a
"クリップボードをOSと連携
set clipboard=unnamedplus
"ビープ音をならさない（視覚ベルと合わせて抑止）
set vb t_vb=
set visualbell
set noerrorbells
"Tabで補完できるようにする（wildmenu が有効なら便利）
set wildchar=<Tab>
"変更中のファイルでも、保存しないで他のファイルを表示
set hidden
"バックスペースを押したときに上の行末に移動する
set backspace=2
"自動インデント
set autoindent
set smartindent
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
"タブの代わりにスペースを用いる
set expandtab
"タブ幅の設定
set tabstop=2
set softtabstop=2
set shiftwidth=2

" 自動的に現在編集中のファイルのカレントディレクトリに移動
augroup grlcd
  autocmd!
  autocmd BufEnter * execute ":silent! lcd" . expand("%:p:h")
augroup END

"----------------------------------------------------------------------------
" 表示設定
"----------------------------------------------------------------------------
"シンタックスを表示（構文ハイライト）
syntax on
"行番号を表示
set number
"入力中のコマンドをステータスに表示
set showcmd
"現在のカーソル位置を表示
set ruler
"折り返ししない
set nowrap
"折りたたみを有効にする（無効化中）
"set foldmethod=syntax
"起動時のメッセージを表示しない
set shortmess+=I
"括弧の対応表示
set showmatch
"Tab文字や、EOFを表示
set list
"tab文字やEOLを表示（lcs: listchars 設定）
set lcs=tab:^\ ,eol:<,extends:>
"vim-gitgutterのカーソルのちらつきをなくす
set signcolumn=yes
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

" エンコードをUTF-8に
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
" LF, CR, CRLF（改行コードの優先順）
set ffs=unix,mac,dos

" 全角スペース, 行末半角スペースの色変え
if has("syntax")
  syntax on
  function! ActivateInvisibleIndicator()
    "全角スペースを表示（全角空白：U+3000）
    syntax match InvisibleJISX0208Space "　" display containedin=ALL
    highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=#666688
    "行末の半角スペースを表示
    syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
    highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=#888866
  endf
  augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
  augroup END
endif

" UTF-8の□や○でカーソル位置がずれないようにする
set fillchars=vert:\|,fold:-,eob:\~
if exists('&ambiwidth')
  set ambiwidth=double
endif

"----------------------------------------------------------------------------
" 検索・補完
"----------------------------------------------------------------------------
"検索結果文字列のハイライトを有効にする
set hlsearch
"大文字小文字を区別なく検索する
set ignorecase
"検索文字に大文字が含まれている場合は区別して検索する
set smartcase
"インクリメンタルサーチ
set incsearch

"vimgrep の cw 自動補完
au QuickfixCmdPost vimgrep cw

"----------------------------------------------------------------------------
" 保存・ファイル管理
"----------------------------------------------------------------------------
"編集されたら読み直す
set autoread
"バックアップファイルを作るディレクトリ
set backupdir=$DOTVIM/backup
"スワップファイル用のディレクトリ
set directory=$DOTVIM/swap
"undo用のディレクトリ
set undodir=$DOTVIM/undo
"外部で変更があったら自動で再読み込みする
autocmd FocusGained,BufEnter * checktime

"----------------------------------------------------------------------------
" ファイルタイプ / 言語設定
"----------------------------------------------------------------------------
" Slim
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim

" Coffee Script
autocmd BufNewFile,BufRead *.coffee.erb setlocal filetype=coffee

"----------------------------------------------------------------------------
" キーマッピング
"----------------------------------------------------------------------------
"USキーボード対応
noremap ; :

"保存
inoremap <C-s> <ESC>:w
noremap  <C-s> <ESC>:w

"表示行単位で移動
noremap j gj
noremap k gk
noremap <DOWN> gj
noremap <UP> gk

"Windowをscreenっぽく
noremap <C-w><C-c>  :vnew<CR>
noremap <C-w>c      :vnew<CR>
noremap <C-w><C-v>  :vnew<CR>
noremap <C-w>v      :vnew<CR>
noremap <C-w><C-s>  :new<CR>
noremap <C-w>s      :new<CR>
"コピー
vnoremap <C-c> "*y
"貼り付け
vnoremap <C-x> "*d<ESC>
"切り取り
inoremap <C-v> <ESC>"*pa
vnoremap <C-v> d"*P
cnoremap <C-v> <C-R>*
"全選択
inoremap <C-a> <ESC>gg0vG$
cnoremap <C-a> <ESC>gg0vG$
vnoremap <C-a> <ESC>gg0vG$
nnoremap <C-a> <ESC>gg0vG$

"各種コマンドをリーダーに再配置
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>1 :q!<CR>
nnoremap <Leader>2 :wq!<CR>
nnoremap <Leader>3 :qall!<CR>
nnoremap <Leader>c :vnew<CR>
nnoremap <Leader>s :new<CR>
nnoremap <Leader>v :vnew<CR>
nnoremap <Leader>h <C-w><C-h>
nnoremap <Leader>j <C-w><C-j>
nnoremap <Leader>k <C-w><C-k>
nnoremap <Leader>l <C-w><C-l>
nnoremap <Leader>tt :tabe<CR>
nnoremap <Leader>tc :tabe<CR>
nnoremap <Leader>tv :tabe<CR>
nnoremap <Leader>th gT<CR>
nnoremap <Leader>tl gt<C-l>
nnoremap <Leader>a <ESC>gg0vG$
nnoremap <Leader>nw :set nowrap<CR>
nnoremap <Leader>mw :set wrap<CR>
nnoremap <Leader>np :set nopaste<CR>
nnoremap <Leader>mp :set paste<CR>

"----------------------------------------------------------------------------
" オートコレクト
"----------------------------------------------------------------------------
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap { {}<LEFT>
"inoremap < <><LEFT>
"inoremap ' ''<LEFT>
"inoremap ` ``<LEFT>
"inoremap " ""<LEFT>
"ビジュアルモードで選択した範囲を囲む
vnoremap ( "zc(<C-r>z)<ESC>
vnoremap { "zc{<C-r>z}<ESC>
vnoremap [ "zc[<C-r>z]<ESC>
vnoremap " "zc"<C-r>z"<ESC>
vnoremap ' "zc'<C-r>z'<ESC>


