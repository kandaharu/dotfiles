"――――――――――――――――――――――――――
" 基本的な設定
"――――――――――――――――――――――――――
"カラースキーム設定
colorscheme torte
"vi 互換モードをオフにする
set nocompatible
"マウスで選択できるようにする
set mouse=a
"クリップボードをWindowsと連携
set clipboard=unnamed
"ファイル形式を検出する
filetype on
"ファイル形式別インデントのロードをオンにする
filetype indent on
"ファイルタイププラグインを有効にする
filetype plugin on
"ビープ音をならさない
set vb t_vb=
"GUIオプション
set guioptions=F
"Tabで補完できるようにする
"set wildchar=<Tab>
"VI互換をオフ
set nocompatible
"変更中のファイルでも、保存しないで他のファイルを表示
set hidden
".txtファイルで自動的に日本語入力ON
au BufNewFile,BufRead *.txt set iminsert=2


"――――――――――――――――――――――――――
" 表示
"――――――――――――――――――――――――――
"シンタックスを表示
syntax on
"ウィンドウを最大化して起動
au GUIEnter * simalt ~x
"行番号を表示
set number
"入力中のコマンドをステータスに表示
set showcmd
"現在のカーソル位置を表示
set ruler
"バックスペースを押したときに上の行末に移動する
set backspace=2
"折り返ししない
"set wrap! = nowrap
"折りたたみを有効にする
set foldmethod=syntax
"起動時のメッセージを表示しない
set shortmess+=I
"括弧の対応表示
set showmatch
"自動インデント
set autoindent
"自動インデント
set smartindent
"autoindent時に挿入されるタブの幅
set shiftwidth=2
"タブ幅の設定
set tabstop=2
"Tab文字や、EOFを表示
set list
"tab文字やEOLを表示
set lcs=tab:^\ ,eol:<,extends:>
"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする。
set smarttab
" {{{
" 全角スペース, 行末半角スペースの色変え
if has("syntax")
  syntax on
  function! ActivateInvisibleIndicator()
    "全角スペースを表示
    syntax match InvisibleJISX0208Space "　" display containedin=ALL
    highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=#6666ff
    "行末の半角スペースを表示
    syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
    highlight InvisibleTrailedSpace term=underline ctermbg=red guibg=#ff6666
  endf
  augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
  augroup ENDendif
endif
" }}}

"――――――――――――――――――――――――――
" 検索設定
"――――――――――――――――――――――――――
"検索結果文字列のハイライトを有効にする
set hlsearch
"大文字小文字を区別なく検索する
set ignorecase
"検索文字に大文字が含まれている場合は区別して検索する
set smartcase
"インクリメンタルサーチ
set incsearch

"――――――――――――――――――――――――――
" 操作
"――――――――――――――――――――――――――
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"表示行単位で移動
noremap j gj
noremap k gk
noremap <DOWN> gj
noremap <UP> gk
"コピー
vnoremap <C-C> "*y
"貼り付け
inoremap <C-V> <ESC>"*pa
"切り取り
vnoremap <C-X> "*d<ESC>
vnoremap <C-V> d"*P
cnoremap <C-V> <C-R>*
"全選択
inoremap <C-A> <ESC>gg0vG$
cnoremap <C-A> <ESC>gg0vG$
vnoremap <C-A> <ESC>gg0vG$
"整形
noremap <C-S-f> <ESC>gg=G

"――――――――――――――――――――――――――
" オートコレクト
"――――――――――――――――――――――――――
" 括弧が入力されたときに自動的に閉じ括弧を入力する
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap { {}<LEFT>
"ビジュアルモードで選択した範囲を囲む
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>


"――――――――――――――――――――――――――
" 保存
"――――――――――――――――――――――――――
"保存
inoremap <C-S> <ESC>:w
noremap <C-S> <ESC>:w
"編集されたら読み直す
set autoread
"バックアップファイルを作るディレクトリ
set backupdir=$HOME/.vimfiles/backup
"スワップファイル用のディレクトリ
set directory=$HOME/.vimfiles/swap
