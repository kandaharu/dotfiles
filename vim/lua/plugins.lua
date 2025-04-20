vim.cmd('runtime! filetype.lua')
vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')

-- lazy.nvimのセットアップ
local lazypath = vim.fn.stdpath('config') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

  -----------------------------------
  -- 表示に関するプラグイン
  -----------------------------------

  -- カラースキーム (Molokai)
  {
    'tomasr/molokai',
    lazy = false,
    priority = 1000, -- カラースキームを優先的にロード
    config = function()
      vim.cmd('colorscheme molokai')
    end,
  },

  -----------------------------------
  -- ファイラー
  -----------------------------------

  -- Fuzzy Finder (fzf)
  {
    'junegunn/fzf',
    build = './install --bin',
  },

  -- fzf 用の Vim インターフェース
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' },
    config = function()
      vim.keymap.set('n', '<Leader>rr', ':GFiles<CR>')
      vim.keymap.set('n', '<Leader>f', ':GFiles<CR>')
      vim.keymap.set('n', '<Leader>rf', ':Files<CR>')
      vim.keymap.set('n', '<Leader>rh', ':History<CR>')
      vim.keymap.set('n', '<Leader>g', ':GFiles?<CR>')
      vim.keymap.set('n', '<Leader>rg', ':GFiles?<CR>')
      vim.keymap.set('n', '<Leader>rb', ':Buffers<CR>')
      vim.keymap.set('n', '<Leader>rc', ':History:<CR>')
      vim.keymap.set('n', '<Leader>rs', ':History/<CR>')
    end,
  },

  -- ファイラー (Defx)
  {
    'Shougo/defx.nvim',
    config = function()
      vim.keymap.set('n', '<Leader>e', ':Defx -auto-cd -toggle -resume -columns=mark:indent:icon:filename:type:size:time -split=vertical -winwidth=35<CR>')
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'defx',
        callback = function()
          local opts = { buffer = true, silent = true, expr = true }
          vim.keymap.set('n', '<CR>', "defx#is_directory() ? defx#do_action('open_directory') : defx#do_action('multi', ['drop', 'quit'])", opts)
          vim.keymap.set('n', 's', "defx#do_action('open', 'vsplit')", opts)
          vim.keymap.set('n', 'o', "defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('multi', ['drop', 'quit'])", opts)
          vim.keymap.set('n', 'O', "defx#do_action('open_tree_recursive')", opts)
          vim.keymap.set('n', '~', "defx#do_action('cd')", opts)
          vim.keymap.set('n', 'H', "defx#do_action('change_vim_cwd')", opts)
          vim.keymap.set('n', 'h', "defx#do_action('cd', ['..'])", opts)
          vim.keymap.set('n', 'j', "line('.') == line('$') ? 'gg' : 'j'", opts)
          vim.keymap.set('n', 'k', "line('.') == 1 ? 'G' : 'k'", opts)
          vim.keymap.set('n', 'l', "defx#is_directory() ? defx#do_action('open') : defx#do_action('multi', ['drop', 'quit'])", opts)
          vim.keymap.set('n', 'r', "defx#do_action('redraw')", opts)
          vim.keymap.set('n', 'q', "defx#do_action('quit')", opts)
          vim.keymap.set('n', 'ST', "defx#do_action('toggle_sort', 'time')", opts)
          vim.keymap.set('n', 'SS', "defx#do_action('toggle_sort', 'size')", opts)
          vim.keymap.set('n', 'I', "defx#do_action('toggle_ignored_files')", opts)
          vim.keymap.set('n', 'yy', "defx#do_action('yank_path')", opts)
          vim.keymap.set('n', 'Y', "defx#do_action('copy')", opts)
          vim.keymap.set('n', 'X', "defx#do_action('move')", opts)
          vim.keymap.set('n', 'P', "defx#do_action('paste')", opts)
          vim.keymap.set('n', 'DD', "defx#do_action('remove')", opts)
          vim.keymap.set('n', 'R', "defx#do_action('rename')", opts)
          vim.keymap.set('n', 'F', "defx#do_action('new_directory')", opts)
          vim.keymap.set('n', 'N', "defx#do_action('new_file')", opts)
          vim.keymap.set('n', 'M', "defx#do_action('new_multiple_files')", opts)
          vim.keymap.set('n', '<Space>', "defx#do_action('toggle_select') . 'j'", opts)
          vim.keymap.set('n', '*', "defx#do_action('toggle_select_all')", opts)
          vim.keymap.set('n', 'i', "defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')", opts)
          vim.keymap.set('n', '!', "defx#do_action('execute_command')", opts)
          vim.keymap.set('n', ';', "defx#do_action('repeat')", opts)
          vim.keymap.set('n', 'x', "defx#do_action('execute_system')", opts)
          vim.keymap.set('n', '<C-g>', "defx#do_action('print')", opts)
        end,
      })
    end,
  },

  -----------------------------------
  -- エディタの見た目を改善するプラグイン
  -----------------------------------

  -- インデントガイドを表示
  {
    'Yggdroot/indentLine',
    config = function()
      vim.g.indentLine_enabled = 1
      vim.g.indentLine_char = '|'
      vim.opt.list = true
      vim.cmd('highlight IndentLine guifg=#2A2A2A ctermfg=236')
    end,
  },

  -- ステータスライン (Lightline)
  {
    'itchyny/lightline.vim',
    config = function()
      vim.g.lightline = { colorscheme = 'molokai' }
      vim.opt.laststatus = 2
      vim.opt.showmode = false
    end,
  },

  -- 高度なシンタックスハイライトとインデント
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          -- ベース言語
          'lua', 'python', 'javascript', 'typescript', 'tsx', 'go', 'ruby', 'java',
          -- Web / Framework
          'html', 'css', 'vue', 'json', 'scss',
          -- Template
          'slim', 'pug',
          -- Config / Infra
          'toml', 'yaml', 'terraform', 'make', 'nginx', 'git_config', 'git_rebase',
          -- Git 系
          'gitignore', 'gitcommit', 'gitattributes',
          -- ドキュメント・データ形式
          'markdown', 'markdown_inline', 'csv', 'tsv',
          -- 正規表現 / 通信
          'regex', 'http',
          -- SQL 系
          'sql',
          -- シェル系
          'bash',
          -- Diff
          'diff',
        },

        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -----------------------------------
  -- Git 関連プラグイン
  -----------------------------------

  -- Git の差分を表示
  {
    'airblade/vim-gitgutter',
    event = 'CmdlineEnter',
    config = function()
      vim.g.gitgutter_enabled = 1
      local debounce = vim.schedule_wrap(function()
        vim.cmd('GitGutter')
      end)
      vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
        callback = debounce,
      })
    end,
  },

  -- Git 操作を簡単にする
  {
    'tpope/vim-fugitive',
    event = 'CmdlineEnter',
    config = function()
      if vim.fn.isdirectory('.git') == 1 then
        vim.keymap.set('n', '<Leader>gs', ':Git status<CR>')
        vim.keymap.set('n', '<Leader>gb', ':Git blame<CR>')
        vim.keymap.set('n', '<Leader>gd', ':Gdiffsplit<CR>')
        vim.keymap.set('n', '<Leader>gps', ':Gpush<CR>')
        vim.keymap.set('n', '<Leader>gpl', ':Gpull<CR>')
      end
    end,
  },

  -----------------------------------
  -- その他の便利プラグイン
  -----------------------------------

  -- 行末の余分なスペースを強調表示
  {
    'bronson/vim-trailing-whitespace',
    config = function()
      vim.g.extra_whitespace_ignored_filetypes = { 'defx' }
    end,
  },

  -- コメントアウトを簡単にする
  {
    'tomtom/tcomment_vim',
    config = function()
      vim.g.tcomment_mapleader1 = '<C-/>'
      vim.g.tcomment_opleader1 = 'gc'
      vim.g.tcomment_opleader2 = 'gC'
    end,
  },

  -- 検索結果の件数を表示
  {
    'osyo-manga/vim-anzu',
  },

  -- f 検索を強化
  {
    'rhysd/clever-f.vim',
  },

  -----------------------------------
  -- AI コーディング支援
  -----------------------------------

  -- GitHub Copilot
  {
    'github/copilot.vim',
    event = 'InsertEnter',
    config = function()
      vim.g.copilot_filetypes = {
        gitcommit = true,
        markdown = true,
        yaml = true,
        toml = true,
        lua = true,
        python = true,
        ruby = true,
        javascript = true,
        plaintext = false,
      }
    end,
  },
})
