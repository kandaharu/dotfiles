-----------------------------------------------------------------------------
-- 基本的な設定
-----------------------------------------------------------------------------
-- マウスで選択できるようにする
vim.opt.mouse = 'a'
-- クリップボードをOSと連携
vim.opt.clipboard = 'unnamedplus'
-- ビープ音をならさない
vim.opt.visualbell = true
vim.opt.errorbells = false
-- Tabで補完できるようにする
vim.opt.wildchar = vim.fn.char2nr('\t')
-- 変更中のファイルでも、保存しないで他のファイルを表示
vim.opt.hidden = true
-- 自動的に現在編集中のファイルのカレントディレクトリに移動
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    vim.cmd('silent! lcd ' .. vim.fn.expand('%:p:h'))
  end
})
-- GUI環境でのみフォント設定を適用
if vim.fn.has('gui_running') == 1 then
  vim.opt.guifont = 'Myrica M:h16'
end

-----------------------------------------------------------------------------
-- 表示
-----------------------------------------------------------------------------
-- シンタックスを表示
vim.opt.syntax = 'on'
-- 行番号を表示
vim.opt.number = true
-- 入力中のコマンドをステータスに表示
vim.opt.showcmd = true
-- 現在のカーソル位置を表示
vim.opt.ruler = true
-- 折り返ししない
vim.opt.wrap = false
-- 起動時のメッセージを表示しない
vim.opt.shortmess:append('I')
-- 括弧の対応表示
vim.opt.showmatch = true
-- Tab文字や、EOFを表示
vim.opt.list = true
vim.opt.listchars = { tab = '^\\', eol = '<', extends = '>' }
-- vim-gitgutterのカーソルのちらつきをなくす
vim.opt.signcolumn = 'yes'
-- カレントウィンドウにのみ罫線を引く
local cursorline_group = vim.api.nvim_create_augroup('CursorLine', { clear = true })
vim.api.nvim_create_autocmd('WinLeave', {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = false
  end
})
vim.api.nvim_create_autocmd({'WinEnter', 'BufRead'}, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = true
  end
})

-- エンコードをUTF-8に
vim.opt.fileencodings = {'utf-8', 'cp932', 'euc-jp', 'iso-2022-jp'}
-- LF, CRLF
vim.opt.fileformats = {'unix', 'dos'}
-- 全角スペース, 行末半角スペースの色変え
local invisible_spaces_group = vim.api.nvim_create_augroup('InvisibleSpaces', { clear = true })
vim.api.nvim_create_autocmd({'BufNew', 'BufRead'}, {
  group = invisible_spaces_group,
  callback = function()
    -- 全角スペースを表示
    vim.fn.matchadd('InvisibleJISX0208Space', '　')
    -- 行末の半角スペースを表示
    vim.fn.matchadd('InvisibleTrailedSpace', [[\s\+$]])
  end
})

-- 全角スペースと行末スペースの色設定
vim.api.nvim_set_hl(0, 'InvisibleJISX0208Space', { bg = '#666688' })
vim.api.nvim_set_hl(0, 'InvisibleTrailedSpace', { bg = '#888866' })

-- UTF-8の□や○でカーソル位置がずれないようにする
vim.opt.fillchars = {
  vert = '|',
  fold = '-',
  eob = '~'
}
vim.opt.ambiwidth = 'double'

-- 対応する括弧やブレースを表示
vim.opt.showmatch = true
vim.opt.matchtime = 1

-----------------------------------------------------------------------------
-- 操作
-----------------------------------------------------------------------------
-- バックスペースを押したときに上の行末に移動する
vim.opt.backspace = { 'indent', 'eol', 'start' }
-- 自動インデント
vim.opt.autoindent = true
vim.opt.smartindent = true
-- 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
vim.opt.smarttab = true
-- タブの代わりにスペースを用いる
vim.opt.expandtab = true
-- タブ幅の設定
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-----------------------------------------------------------------------------
-- 検索
-----------------------------------------------------------------------------
-- 検索結果文字列のハイライトを有効にする
vim.opt.hlsearch = true
-- 大文字小文字を区別なく検索する
vim.opt.ignorecase = true
-- 検索文字に大文字が含まれている場合は区別して検索する
vim.opt.smartcase = true
-- インクリメンタルサーチ
vim.opt.incsearch = true
-- vimgrep の cw 自動補完
vim.api.nvim_create_autocmd('QuickfixCmdPost', {
  pattern = 'vimgrep',
  command = 'cwindow'
})

-----------------------------------------------------------------------------
-- 保存
-----------------------------------------------------------------------------
-- 編集されたら読み直す
vim.opt.autoread = true
-- バックアップファイルを作るディレクトリ
vim.opt.backupdir = vim.g.dotvim .. '/backup'
-- スワップファイル用のディレクトリ
vim.opt.directory = vim.g.dotvim .. '/swap'
-- undo用のディレクトリ
vim.opt.undodir = vim.g.dotvim .. '/undo'

-----------------------------------------------------------------------------
-- Luaを早くする
-----------------------------------------------------------------------------
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0