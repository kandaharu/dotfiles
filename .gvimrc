"---------------------------------------------------------------------------
" kandaharu's .gvimrc
"---------------------------------------------------------------------------

"——————————————————————————
" OSごとのフォルダ設定
"——————————————————————————
if has('win32') || has('win64')
  "ウィンドウを最大化して起動
  autocmd GUIEnter * simalt ~x
  "カラースキーム設定
  colorscheme torte
else
  "ウィンドウを適当な大きさにして起動
  au GUIEnter * winsize 255 80
  "カラースキーム設定
  colorscheme molokai
  set guioptions+=T
endif

"——————————————————————————
" 基本的な設定
"——————————————————————————
"GUIオプション
set guioptions=+F

"——————————————————————————
" 表示
"——————————————————————————
hi clear CursorLine
set cursorline
" アンダーラインを引く(color terminal)
highlight CursorLine cterm=NONE ctermbg=black
" アンダーラインを引く(gui)
highlight CursorLine gui=NONE guibg=#333333
"フォントの設定
set guifont=Ricty:h14
