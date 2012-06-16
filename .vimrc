"---------------------------------------------------------------------------
" kandaharu's .vimrc
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" メモ {{{
"
" 使用前提
" ・.vim or vimfile 直下にswap,backup,snippetsディレクトリを作成しておく
" }}}
""---------------------------------------------------------------------------
" OSごとのフォルダ設定
if has('unix')
  let $DOTVIM=expand('~/.vim')
else
  let $DOTVIM=expand('~/vimfiles')
endif

"――――――――――――――――――――――――――
" 基本的な設定
"――――――――――――――――――――――――――
"カラースキーム設定
"colorscheme torte
"vi 互換モードをオフにする
set nocompatible
"マウスで選択できるようにする
set mouse=a
"クリップボードをWindowsと連携
set clipboard=+unnamed
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
set wildchar=<Tab>
"変更中のファイルでも、保存しないで他のファイルを表示
set hidden
".txtファイルで自動的に日本語入力ON
"au BufNewFile,BufRead *.txt set iminsert=2

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
"折り返ししない
set wrap! = nowrap
"折りたたみを有効にする
set foldmethod=syntax
"起動時のメッセージを表示しない
set shortmess+=I
"括弧の対応表示
set showmatch
"Tab文字や、EOFを表示
set list
"tab文字やEOLを表示
set lcs=tab:^\ ,eol:<,extends:>
"カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

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

"――――――――――――――――――――――――――
" 操作
"――――――――――――――――――――――――――
"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
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
"貼り付けモードのオンオフ
set pastetoggle=<F12>

"――――――――――――――――――――――――――
" 検索
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
" 保存
"――――――――――――――――――――――――――
"編集されたら読み直す
set autoread
"バックアップファイルを作るディレクトリ
set backupdir=~/$DOTVIM/backup
"スワップファイル用のディレクトリ
set directory=~/$DOTVIM/swap

"――――――――――――――――――――――――――
" マッピング
"――――――――――――――――――――――――――
"保存
inoremap <C-S> <ESC>:w
noremap <C-S> <ESC>:w
"表示行単位で移動
noremap j gj
noremap k gk
noremap <DOWN> gj
noremap <UP> gk
"コピー
vnoremap <C-C> "*y
"貼り付け
vnoremap <C-X> "*d<ESC>
"切り取り
inoremap <C-V> <ESC>"*pa
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
inoremap < <><LEFT>
"ビジュアルモードで選択した範囲を囲む
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>


"――――――――――――――――――――――――――
" プラグイン
"――――――――――――――――――――――――――
"NERDTree
nmap <C-e> :NERDTreeToggle<CR>
"引数なしでvimを開いたらNERDTreeを起動、
"引数ありならNERDTreeは起動しない、引数で渡されたファイルを開く。
"How can I open a NERDTree automatically when vim starts up if no files were specified?
autocmd vimenter * if !argc() | NERDTree | endif
"他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
"How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"NERDTreeShowHidden 隠しファイルを表示するか？
"f コマンドの設定値
"0 : 隠しファイルを表示しない。
"1 : 隠しファイルを表示する。
let g:NERDTreeShowHidden=1
