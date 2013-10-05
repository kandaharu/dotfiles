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
"hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black
