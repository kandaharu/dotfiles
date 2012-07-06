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
if has('win32') || has('win64')
  let $DOTVIM=expand('~/vimfiles')
else
  let $DOTVIM=expand('~/.vim')
endif

"——————————————————————————
" 基本的な設定
"——————————————————————————
"Windows特有の設定
if has('win32') || has('win64')
  "カラースキーム設定
  "colorscheme torte
  "マウスで選択できるようにする
  set mouse=a
  "ウィンドウを最大化して起動
  au GUIEnter * simalt ~x
end
"vi 互換モードをオフにする
set nocompatible
"クリップボードをOSと連携
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
" 自動的に現在編集中のファイルのカレントディレクトリに移動
augroup grlcd
  autocmd!
  autocmd BufEnter * lcd %:p:h
augroup END

"——————————————————————————
" 表示
"——————————————————————————
"シンタックスを表示
syntax on
"行番号を表示
set number
"入力中のコマンドをステータスに表示
set showcmd
"現在のカーソル位置を表示
set ruler
"折り返ししない
set wrap! = nowrap
"折りたたみを有効にする
"set foldmethod=syntax
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
" エンコードをUTF-8に
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
" LF, CR, CRLF
set ffs=unix,mac,dos

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

"——————————————————————————
" 操作
"——————————————————————————
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
set pastetoggle=<F3>


"——————————————————————————
" 検索
"——————————————————————————
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

"——————————————————————————
" 保存
"——————————————————————————
"編集されたら読み直す
set autoread
"バックアップファイルを作るディレクトリ
set backupdir=$DOTVIM/backup
"スワップファイル用のディレクトリ
set directory=$DOTVIM/swap

"——————————————————————————
" マッピング
"——————————————————————————
"保存
inoremap <C-s> <ESC>:w
noremap <C-s> <ESC>:w
"表示行単位で移動
noremap j gj
noremap k gk
noremap <DOWN> gj
noremap <UP> gk
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
"整形
"noremap <C-S-f> <ESC>gg=G

"——————————————————————————
" オートコレクト
"——————————————————————————
" 括弧が入力されたときに自動的に閉じ括弧を入力する
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap { {}<LEFT>
inoremap < <><LEFT>
"ビジュアルモードで選択した範囲を囲む
vnoremap ( "zdi(<C-r>z)<ESC>
vnoremap { "zdi{<C-r>z}<ESC>
vnoremap [ "zdi[<C-r>z]<ESC>
vnoremap " "zdi"<C-r>z"<ESC>
vnoremap ' "zdi'<C-r>z'<ESC>


"——————————————————————————
" プラグイン
"——————————————————————————
"NERDTree
nmap <C-e> <ESC>:NERDTreeToggle<CR>
"引数なしでvimを開いたらNERDTreeを起動、引数ありならNERDTreeは起動しない、引数で渡されたファイルを開く。
autocmd vimenter * if !argc() | NERDTree | endif
"他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"NERDTreeShowHidden 隠しファイルを表示する
let g:NERDTreeShowHidden=1
