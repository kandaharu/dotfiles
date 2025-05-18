-----------------------------------------------------------------------------
-- キーマッピング
-----------------------------------------------------------------------------
-- Spaceをリーダーに
vim.g.mapleader = ' '
vim.keymap.set('', '<Space>', '<Nop>', { noremap = true, silent = true })

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- USキーボード対応
vim.cmd('map ; :')

-- 保存
map('i', '<C-s>', '<ESC>:w<CR>')
map('n', '<C-s>', ':w<CR>')

-- 表示行単位で移動
map('n', 'j', 'gj')
map('n', 'k', 'gk')
map('n', '<DOWN>', 'gj')
map('n', '<UP>', 'gk')

-- タブをscreenrcっぽくする
map('n', '<C-t><C-c>', ':tabe<CR>')
map('n', '<C-t>c', ':tabe<CR>')
map('n', '<C-t><C-2>', ':new<CR>')
map('n', '<C-t>2', ':new<CR>')
map('n', '<C-t><C-j>', '<C-w><C-j>')
map('n', '<C-t>j', '<C-w><C-j>')
map('n', '<C-t><C-k>', '<C-w><C-k>')
map('n', '<C-t>k', '<C-w><C-k>')
map('n', '<C-t><C-h>', 'gT')
map('n', '<C-t>h', 'gT')
map('n', '<C-t><C-l>', 'gt')
map('n', '<C-t>l', 'gt')

-- ウィンドウ操作をscreenっぽく
map('n', '<C-w><C-c>', ':vnew<CR>')
map('n', '<C-w>c', ':vnew<CR>')
map('n', '<C-w><C-v>', ':vnew<CR>')
map('n', '<C-w>v', ':vnew<CR>')
map('n', '<C-w><C-s>', ':new<CR>')
map('n', '<C-w>s', ':new<CR>')

-- コピー、貼り付け、切り取り
map('v', '<C-c>', '"*y')
map('v', '<C-x>', '"*d<ESC>')
map('i', '<C-v>', '<ESC>"*pa')
map('v', '<C-v>', 'd"*P')
map('c', '<C-v>', '<C-R>*', { noremap = false })

-- 全選択
map('i', '<C-a>', '<ESC>gg0vG$')
map('c', '<C-a>', '<ESC>gg0vG$')
map('v', '<C-a>', '<ESC>gg0vG$')
map('n', '<C-a>', '<ESC>gg0vG$')

-- リーダーキーのマッピング
map('n', '<Leader>q', ':q<CR>', { noremap = false })
map('n', '<Leader>w', ':w<CR>', { noremap = false })
map('n', '<Leader>`', ':q!<CR>', { noremap = false })
map('n', '<Leader>1', ':q!<CR>', { noremap = false })
map('n', '<Leader>2', ':wq!<CR>', { noremap = false })
map('n', '<Leader>3', ':qall!<CR>', { noremap = false })
map('n', '<Leader>c', ':vnew<CR>', { noremap = false })
map('n', '<Leader>s', ':new<CR>', { noremap = false })
map('n', '<Leader>v', ':vnew<CR>', { noremap = false })
map('n', '<Leader>h', '<C-w><C-h>')
map('n', '<Leader>j', '<C-w><C-j>')
map('n', '<Leader>k', '<C-w><C-k>')
map('n', '<Leader>l', '<C-w><C-l>')
map('n', '<Leader>tt', ':tabe<CR>', { noremap = false })
map('n', '<Leader>tc', ':tabe<CR>', { noremap = false })
map('n', '<Leader>tv', ':tabe<CR>', { noremap = false })
map('n', '<Leader>th', 'gT<CR>', { noremap = false })
map('n', '<Leader>tl', 'gt<C-l>', { noremap = false })
map('n', '<Leader>a', '<ESC>gg0vG$')
map('n', '<Leader>nw', ':set nowrap<CR>', { noremap = false })
map('n', '<Leader>mw', ':set wrap<CR>', { noremap = false })
map('n', '<Leader>np', ':set nopaste<CR>', { noremap = false })
map('n', '<Leader>mp', ':set paste<CR>', { noremap = false })

-----------------------------------------------------------------------------
-- ビジュアルモードでの囲み文字設定
-----------------------------------------------------------------------------
map('v', '(', '"zc(<C-r>z)<ESC>', { noremap = false })
map('v', '{', '"zc{<C-r>z}<ESC>', { noremap = false })
map('v', '[', '"zc[<C-r>z]<ESC>', { noremap = false })
map('v', '"', '"zc"<C-r>z"<ESC>', { noremap = false })
map('v', "'", '"zc\'<C-r>z\'<ESC>', { noremap = false })
