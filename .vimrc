"---------------------------------------------------------------------------
" kandaharu's .vimrc
"---------------------------------------------------------------------------

"---------------------------------------------------------------------------
" メモ
"
" 使用前提
" ・.vim or vimfile 直下にswap,backup,undo,snippetsディレクトリを作成しておく
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
" set clipboard=+unnamed
"ビープ音をならさない
set vb t_vb=
"Tabで補完できるようにする
set wildchar=<Tab>
"変更中のファイルでも、保存しないで他のファイルを表示
set hidden
" 自動的に現在編集中のファイルのカレントディレクトリに移動
augroup grlcd
  autocmd!
  autocmd BufEnter * execute ":silent! lcd" . expand("%:p:h")
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
set whichwrap=b,s,h,l,<,>,[,],,~
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
"undo用のディレクトリ
set undodir=$DOTVIM/undo

"——————————————————————————
" マッピング
"——————————————————————————
"保存
inoremap <C-s> <ESC>:w
noremap  <C-s> <ESC>:w
"表示行単位で移動
noremap j gj
noremap k gk
noremap <DOWN> gj
noremap <UP> gk
"タブをscreenrcっぽくする
noremap <C-t><C-c>  :tabe<CR>
noremap <C-t>c      :tabe<CR>
noremap <C-t><C-2>  :new<CR>
noremap <C-t>2      :new<CR>
noremap <C-t><C-j>  <C-w><C-j>
noremap <C-t>j      <C-w><C-j>
noremap <C-t><C-k>  <C-w><C-k>
noremap <C-t>k      <C-w><C-k>
noremap <C-t>2      :new<CR>
noremap <C-t><C-h>  gT
noremap <C-t>h      gT
noremap <C-t><C-l>  gt
noremap <C-t>l      gt
"ついでにWindowのほうもscreenっぽく
noremap <C-w><C-c>  :vnew<CR>
noremap <C-w>c      :vnew<CR>
noremap <C-w><C-v>  :new<CR>
noremap <C-w>v      :new<CR>
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
"整形
"noremap <C-S-f> <ESC>gg=G

"Spaceをリーダーに
let mapleader = "\<Space>"

"各種コマンドをリーダーに再配置
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>c :vnew<CR>
nnoremap <Leader>s :vnew<CR>
nnoremap <Leader>v :new<CR>
nnoremap <Leader>h <C-w><C-h>
nnoremap <Leader>j <C-w><C-j>
nnoremap <Leader>k <C-w><C-k>
nnoremap <Leader>l <C-w><C-l>
nnoremap <Leader>tc :tabe<CR>
nnoremap <Leader>ts :tabe<CR>
nnoremap <Leader>th :gT<CR>
nnoremap <Leader>tl :gt<C-l>
nnoremap <Leader>e <ESC>:NERDTreeToggle<CR>
nnoremap <Leader>f <ESC>:VimFilerCurrentDir -split -simple<CR>
nnoremap <Leader>a <ESC>gg0vG$

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

"Let NeoBundle manage NeoBundle
call neobundle#begin($BUNDLEDIR)
  NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

"== Vim
"NeoBundle 'Shougo/vim-vcs.git'
"NeoBundle 'Shougo/vinarise.git'
NeoBundle 'tpope/vim-fugitive'

NeoBundle 'bling/vim-airline'
let s:bundle = neobundle#get('vim-airline')
function! s:bundle.hooks.on_source(bundle)
  let g:airline#extensions#tabline#enabled = 1
endfunction
unlet s:bundle

"=== ColorScheme
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tomasr/molokai'

"=== Unite
NeoBundleLazy 'Shougo/unite.vim' , {
\   'autoload' : { 'commands' : [ 'Unite' ] }
\ }
NeoBundle 'Shougo/neomru.vim'
let s:bundle = neobundle#get('unite.vim')
function! s:bundle.hooks.on_source(bundle)
  "インサートモードで開始しない
  let g:unite_enable_start_insert = 0
  "bookmarkだけホームディレクトリに保存
  let g:unite_source_bookmark_directory = $HOME . '/.unite/bookmark'"
  "file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
  let g:unite_source_file_mru_filename_format = ''

  "uniteを開いている間のキーマッピング
  augroup vimrc
    autocmd FileType unite call s:unite_my_settings()
  augroup END

  function! s:unite_my_settings()
    autocmd FileType vimfiler call unite#custom_default_action('directory', 'lcd')
    "ESCでuniteを終了
    nmap <buffer> <ESC> <Plug>(unite_exit)
    "入力モードのときjjでノーマルモードに移動
    imap <buffer> jj <Plug>(unite_insert_leave)
    "sでsplit
    nnoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
    inoremap <silent><buffer><expr> s unite#smart_map('s', unite#do_action('split'))
    "vでvsplit
    nnoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
    inoremap <silent><buffer><expr> v unite#smart_map('v', unite#do_action('vsplit'))
    "fでvimfiler
    nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
    inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  endfunction
endfunction
unlet s:bundle

"unite prefix key.
nnoremap [unite] <NOP>
nmap <C-h> [unite]
nmap [unite]h     <ESC>:CdCurrent<CR>
nmap [unite]<C-h> <ESC>:CdCurrent<CR>
nmap [unite]u     <ESC>:Unite file_mru buffer file<CR>
nmap [unite]<C-u> <ESC>:Unite file_mru buffer file<CR>
nmap [unite]y     <ESC>:Unite history/yank<CR>
nmap [unite]<C-y> <ESC>:Unite history/yank<CR>
nmap [unite]b     <ESC>:Unite bookmark<CR>
nmap [unite]<C-b> <ESC>:Unite bookmark<CR>

"=== VimFiler
NeoBundle 'Shougo/vimfiler', {
\   'autoload' : { 'commands' : [ 'VimFiler', 'VimFilerSimple',  'VimFilerExplorer',  'VimFilerCurrentDir', 'VimFilerBufferDir' ] },
\   'depends': [ 'Shougo/unite.vim' ],
\ }
let s:bundle = neobundle#get('vimfiler')
function! s:bundle.hooks.on_source(bundle)
endfunction
unlet s:bundle
nmap [unite]f     <ESC>:VimFilerCurrentDir -split -simple<CR>
nmap [unite]<C-f> <ESC>:VimFilerCurrentDir -split -simple<CR>
nmap [unite]j     <ESC>:VimFilerCurrentDir -simple<CR>
nmap [unite]<C-j> <ESC>:VimFilerCurrentDir -simple<CR>

"=== コメントアウト
NeoBundle 'tomtom/tcomment_vim'
let s:bundle = neobundle#get('tcomment_vim')
function! s:bundle.hooks.on_source(bundle)
  let g:tcommentMapLeader1 = '<C-/>'
  let g:tcommentMapLeader2 = '<Leader>'
  let g:tcommentMapLeaderOp1 = 'gc'
  let g:tcommentMapLeaderOp2 = 'gC'
endfunction
unlet s:bundle

"=== neocomplecache
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/neocomplcache.git'

"=== NeoComplete
" NeoBundle 'Shougo/neocomplete.git'
" let g:acp_enableAtStartup = 0
" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_smart_case = 1
" if !exists('g:neocomplete#force_omni_input_patterns')
"   let g:neocomplete#force_omni_input_patterns = {}
" endif
" let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

"=== Rsense
NeoBundle 'marcus/rsense'
let g:rsenseHome = '/usr/local/bin/rsense'
let g:rsenseUseOmniFunc = 1
NeoBundle 'supermomonga/neocomplete-rsense.vim'

"=== Git
NeoBundleLazy 'gregsexton/gitv', {
\   'autoload' : { 'commands' : [ 'Gitv', 'Gitv!' ] }
\ }
let s:bundle = neobundle#get('gitv')
function! s:bundle.hooks.on_source(bundle)
  highlight diffAdded guifg=#00bf00
  highlight diffRemoved guifg=#bf0000
endfunction
unlet s:bundle

nnoremap [gitv] <NOP>
nmap <C-g> [gitv]
nmap [gitv]b      <ESC>:Gitv<CR>
nmap [gitv]<C-b>  <ESC>:Gitv<CR>
nmap [gitv]f      <ESC>:Gitv!<CR>
nmap [gitv]<C-f>  <ESC>:Gitv!<CR>

"=== Ruby/Rails
NeoBundleLazy 'romanvbabenko/rails.vim'
" ドキュメント参照
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'

" 自動で閉じる
NeoBundle 'tpope/vim-endwise'

" Ruby static code analyzer.
NeoBundle 'scrooloose/syntastic'
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_eruby_checkers = ['rubocop']
let g:syntastic_mode_map = { 'mode': 'passive',
    \ 'active_filetypes': ['ruby'] }

"=== Markdown
" NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'kannokanno/previm'
let g:previm_open_cmd = 'open -a Firefox'


"=== HTML/CSS/JavaScript/Sass
" NeoBundle 'taichouchou2/html5.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'taichouchou2/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'

"=== CoffeeScript
"syntax + 自動compile
NeoBundle 'kchmck/vim-coffee-script'
"js BDDツール
NeoBundle 'claco/jasmine.vim'
"indentの深さに色を付ける
NeoBundle 'nathanaelkane/vim-indent-guides'

"=== NERDTree
NeoBundleLazy 'scrooloose/nerdtree', {
\   'autoload' : { 'commands' : [ 'NerdTreeToggle' ] }
\ }

let s:bundle = neobundle#get('nerdtree')
function! s:bundle.hooks.on_source(bundle)
  "引数なしでvimを開いたらNERDTreeを起動、引数ありならNERDTreeは起動しない、引数で渡されたファイルを開く。
  ""autocmd vimenter * if !argc() | NERDTree | endif
  "他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  "NERDTreeShowHidden 隠しファイルを表示する
  "let g:NERDTreeShowHidden=1
endfunction
unlet s:bundle
nmap <C-e> <ESC>:NERDTreeToggle<CR>

"ファイル形式を検出する
filetype on
"ファイル形式別インデントのロードをオンにする
filetype indent on
"ファイルタイププラグインを有効にする
filetype plugin on
syntax on

NeoBundleCheck
