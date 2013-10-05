"---------------------------------------------------------------------------
" kandaharu's .vimrc
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" メモ
"
" 使用前提
" ・.vim or vimfile 直下にswap,backup,snippetsディレクトリを作成しておく
""---------------------------------------------------------------------------

"——————————————————————————
" OSごとのフォルダ設定
"——————————————————————————
if has('win32') || has('win64')
  let $DOTVIM=expand('~/vimfiles')
  let $BUNDLEDIR=expand('~/vimfiles/bundle')
else
  let $DOTVIM=expand('~/.vim')
  let $BUNDLEDIR=expand('~/.vim/bundle')
endif

"——————————————————————————
" 基本的な設定
"——————————————————————————
"マウスで選択できるようにする
set mouse=a
"vi 互換モードをオフにする
set nocompatible
"クリップボードをOSと連携
set clipboard=+unnamed
"ビープ音をならさない
set vb t_vb=
"Tabで補完できるようにする
set wildchar=<Tab>
"変更中のファイルでも、保存しないで他のファイルを表示
set hidden
" 自動的に現在編集中のファイルのカレントディレクトリに移動
augroup grlcd
  autocmd!
  "autocmd BufEnter * lcd %:p:h
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
" UTF-8の□や○でカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
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
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap { {}<LEFT>
inoremap < <><LEFT>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>
"ビジュアルモードで選択した範囲を囲む
vnoremap ( "zdi(<C-r>z)<ESC>
vnoremap { "zdi{<C-r>z}<ESC>
vnoremap [ "zdi[<C-r>z]<ESC>
vnoremap " "zdi"<C-r>z"<ESC>
vnoremap ' "zdi'<C-r>z'<ESC>

"——————————————————————————
" プラグイン
"——————————————————————————
"= NeoBundle
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=$BUNDLEDIR/neobundle.vim
endif

call neobundle#rc($BUNDLEDIR)
"Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

"== Vim
"NeoBundle 'Shougo/neocomplcache.git'
"NeoBundle 'Shougo/vim-vcs.git'
"NeoBundle 'Shougo/vimshell.git'
"NeoBundle 'Shougo/vinarise.git'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'bling/vim-airline'

"=== ColorScheme
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tomasr/molokai'

"=== Unite
NeoBundleLazy 'Shougo/unite.vim' , {
\   'autoload' : { 'commands' : [ 'Unite' ] }
\ }
"let s:bundle = neobundle#get('unite.vim')
"function! s:bundle.hooks.on_source(bundle)
"  " ココにunite.vimの設定とか記述する。
"endfunction
"unlet s:bundle

nmap <C-h>u <ESC>:Unite file_mru file buffer<CR>
nmap <C-h><C-u> <ESC>:Unite file_mru file buffer<CR>

"=== VimFiler
NeoBundle 'Shougo/vimfiler', {
\   'autoload' : { 'commands' : [ 'VimFiler', 'VimFilerSimple',  'VimFilerCurrentDir', 'VimFilerBufferDir' ] },
\   'depends': [ 'Shougo/unite.vim' ],
\ }
"let s:bundle = neobundle#get('vimfiler')
"function! s:bundle.hooks.on_source(bundle)
"  " ココにvimfilerの設定とか記述する。
"endfunction
"unlet s:bundle
nmap <C-h>f <ESC>:VimFilerSimple<CR>
nmap <C-h><C-f> <ESC>:VimFilerSimple<CR>

"=== Git
NeoBundleLazy 'gregsexton/gitv', {
\   'autoload' : { 'commands' : [ 'Gitv', 'Gitv!' ] }
\ }
nmap <C-h>gb <ESC>:Gitv<CR>
nmap <C-h><C-g><C-b> <ESC>:Gitv<CR>
nmap <C-h>gf <ESC>:Gitv!<CR>
nmap <C-h><C-g><C-f> <ESC>:Gitv!<CR>

"=== Ruby/Rails
NeoBundle 'romanvbabenko/rails.vim'

"=== CoffeeScript
"syntax + 自動compile
NeoBundle 'kchmck/vim-coffee-script'
"js BDDツール
NeoBundle 'claco/jasmine.vim'
"indentの深さに色を付ける
NeoBundle 'nathanaelkane/vim-indent-guides'

"=== NERDTree
"NeoBundleLazy 'scrooloose/nerdtree', {
"\ 'autoload' : { 'commands' : ['NerdTreeToggle'] }
"}
"let s:bundle = neobundle#get('nerdtree')
"function! s:bundle.hooks.on_source(bundle)
"   引数なしでvimを開いたらNERDTreeを起動、引数ありならNERDTreeは起動しない、引数で渡されたファイルを開く。
"   autocmd vimenter * if !argc() | NERDTree | endif
"   他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
"   autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"   "NERDTreeShowHidden 隠しファイルを表示する
"   "let g:NERDTreeShowHidden=1
"endfunction
"unlet s:bundle
"nmap <C-e> <ESC>:NERDTreeToggle<CR>

"ファイル形式を検出する
filetype on
"ファイル形式別インデントのロードをオンにする
filetype indent on
"ファイルタイププラグインを有効にする
filetype plugin on
syntax on

NeoBundleCheck
