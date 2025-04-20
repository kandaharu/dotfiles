-----------------------------------------------------------------------------
-- ファイルタイプ設定
-----------------------------------------------------------------------------
-- Slim
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.slim',
  command = 'setlocal filetype=slim'
})

-- Coffee Script
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.coffee.erb',
  command = 'setlocal filetype=coffee'
})
