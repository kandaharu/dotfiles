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


  -- Slim ファイルのシンタックスハイライト
  {
    'slim-template/vim-slim',
    ft = 'slim',
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
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    event = 'VeryLazy',
    config = function()
      require('ts_context_commentstring').setup({})

      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),

        -- マッピングはデフォルトの `gcc`, `gc` 系だけ有効に
        mappings = {
          basic = true,   -- `gcc`, `gc` など
          extra = false,  -- `gco`, `gcO`, `gcA` を無効化
        },
      })
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

  -----------------------------------
  -- 高度なシンタックスハイライトとインデント
  -----------------------------------

  -- Treesitter 本体
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'lua', 'python', 'javascript', 'typescript', 'tsx', 'go', 'ruby', 'java',
          'html', 'css', 'vue', 'json', 'scss', 'markdown', 'bash', 'yaml', 'toml',
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })
    end,
  },

  -- Treesitter コンテキスト表示
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup({
        enable = true, -- 有効化
        max_lines = 3, -- 表示する最大行数
        trim_scope = 'outer', -- 長すぎる場合に外側をトリム
      })
    end,
  },

  -- 自動タグ補完
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },


  -- textobjects で操作性の向上
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- 次の対象に自動ジャンプ

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
        },
      })
    end,
  },


  -----------------------------------
  -- LSP
  -----------------------------------

  -- CMP
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',      -- LSP 用の補完ソース
      'hrsh7th/cmp-buffer',        -- バッファ内の単語から補完
      'hrsh7th/cmp-path',          -- パス補完
      'L3MON4D3/LuaSnip',          -- スニペットエンジン
      'saadparwaiz1/cmp_luasnip',  -- LuaSnip用の補完ソース
      'onsails/lspkind.nvim',      -- アイコン付きの補完UI
    },
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      -- スニペットの展開方法を定義
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- キーマッピング（挙動は VSCode ライク）
        mapping = cmp.mapping.preset.insert({
          ['<Tab>']     = cmp.mapping.select_next_item(),
          ['<S-Tab>']   = cmp.mapping.select_prev_item(),
          ['<CR>']      = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),

        -- 補完候補のソース定義（上から順に優先）
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),

        -- 補完メニューの見た目（アイコン表示など）
        formatting = {
          format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
          }),
        },
      })
    end,
  },

  -- LSP関係
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- LSP インストーラー
      require('mason').setup()

      -- 自動で指定サーバーをインストール
      require('mason-lspconfig').setup({
        ensure_installed = {
          'tsserver',
          'volar',
          'ruby_lsp',
          'marksman',
          'jsonls',
          'yamlls',
        },
      })

      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- LSP 起動時の共通設定
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }

        -- 定義ジャンプ
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

        -- 参照一覧
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

        -- ホバー表示
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

        -- リネーム
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)

        -- コードアクション
        vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
      end

      -- サーバーごとの設定（必要に応じてオプション追加）
      local servers = {
        tsserver = {},
        volar = {
          filetypes = { 'typescript', 'javascript', 'vue' },
        },
        ruby_lsp = {},
        marksman = {},
        jsonls = {},
        yamlls = {},
      }

      for name, config in pairs(servers) do
        config.on_attach = on_attach
        config.capabilities = capabilities
        lspconfig[name].setup(config)
      end
    end,
  },
})
