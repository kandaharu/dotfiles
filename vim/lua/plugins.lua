vim.cmd("runtime! filetype.lua")
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

-- lazy.nvimのセットアップ
local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  -- 表示に関するプラグイン
  {
    "tomasr/molokai",
    lazy = false,
    priority = 1000, -- カラースキームを優先的にロード
    config = function()
      vim.cmd("colorscheme molokai")
    end,
  },

  -- ファイラー
  {
    "junegunn/fzf",
    build = "./install --bin",
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    config = function()
      vim.keymap.set("n", "<Leader>rr", ":GFiles<CR>")
      vim.keymap.set("n", "<Leader>f", ":GFiles<CR>")
      vim.keymap.set("n", "<Leader>rf", ":Files<CR>")
      vim.keymap.set("n", "<Leader>rh", ":History<CR>")
      vim.keymap.set("n", "<Leader>g", ":GFiles?<CR>")
      vim.keymap.set("n", "<Leader>rg", ":GFiles?<CR>")
      vim.keymap.set("n", "<Leader>rb", ":Buffers<CR>")
      vim.keymap.set("n", "<Leader>rc", ":History:<CR>")
      vim.keymap.set("n", "<Leader>rs", ":History/<CR>")
    end,
  },

  -- エディタに関するプラグイン
  {
    "Yggdroot/indentLine",
    config = function()
      vim.g.indentLine_enabled = 1
      vim.g.indentLine_char = "|"
      vim.opt.list = true
      vim.opt.listchars = "tab:>-,trail:-"
      vim.cmd("highlight IndentLine guifg=#2A2A2A ctermfg=236")
    end,
  },

  -- ステータスライン
  {
    "itchyny/lightline.vim",
    config = function()
      vim.g.lightline = { colorscheme = "molokai" }
      vim.opt.laststatus = 2
      vim.opt.showmode = false
    end,
  },

  -- シンタックス
  {
    "kchmck/vim-coffee-script",
    ft = { "coffee" },
  },
  {
    "slim-template/vim-slim",
    ft = { "slim" },
  },

  -- Defx
  {
    "Shougo/defx.nvim",
    config = function()
      vim.keymap.set("n", "<Leader>e", ":Defx -auto-cd -toggle -resume -columns=mark:indent:icon:filename:type:size:time -split=vertical -winwidth=35<CR>")
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "defx",
        callback = function()
          local opts = { buffer = true, silent = true, expr = true }
          vim.keymap.set("n", "<CR>", "defx#is_directory() ? defx#do_action('open_directory') : defx#do_action('multi', ['drop', 'quit'])", opts)
          vim.keymap.set("n", "s", "defx#do_action('open', 'vsplit')", opts)
          vim.keymap.set("n", "o", "defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('multi', ['drop', 'quit'])", opts)
          vim.keymap.set("n", "O", "defx#do_action('open_tree_recursive')", opts)
          vim.keymap.set("n", "~", "defx#do_action('cd')", opts)
          vim.keymap.set("n", "H", "defx#do_action('change_vim_cwd')", opts)
          vim.keymap.set("n", "h", "defx#do_action('cd', ['..'])", opts)
          vim.keymap.set("n", "j", "line('.') == line('$') ? 'gg' : 'j'", opts)
          vim.keymap.set("n", "k", "line('.') == 1 ? 'G' : 'k'", opts)
          vim.keymap.set("n", "l", "defx#is_directory() ? defx#do_action('open') : defx#do_action('multi', ['drop', 'quit'])", opts)
          vim.keymap.set("n", "r", "defx#do_action('redraw')", opts)
          vim.keymap.set("n", "q", "defx#do_action('quit')", opts)
          vim.keymap.set("n", "ST", "defx#do_action('toggle_sort', 'time')", opts)
          vim.keymap.set("n", "SS", "defx#do_action('toggle_sort', 'size')", opts)
          vim.keymap.set("n", "I", "defx#do_action('toggle_ignored_files')", opts)
          vim.keymap.set("n", "yy", "defx#do_action('yank_path')", opts)
          vim.keymap.set("n", "Y", "defx#do_action('copy')", opts)
          vim.keymap.set("n", "X", "defx#do_action('move')", opts)
          vim.keymap.set("n", "P", "defx#do_action('paste')", opts)
          vim.keymap.set("n", "DD", "defx#do_action('remove')", opts)
          vim.keymap.set("n", "R", "defx#do_action('rename')", opts)
          vim.keymap.set("n", "F", "defx#do_action('new_directory')", opts)
          vim.keymap.set("n", "N", "defx#do_action('new_file')", opts)
          vim.keymap.set("n", "M", "defx#do_action('new_multiple_files')", opts)
          vim.keymap.set("n", "<Space>", "defx#do_action('toggle_select') . 'j'", opts)
          vim.keymap.set("n", "*", "defx#do_action('toggle_select_all')", opts)
          vim.keymap.set("n", "i", "defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')", opts)
          vim.keymap.set("n", "!", "defx#do_action('execute_command')", opts)
          vim.keymap.set("n", ";", "defx#do_action('repeat')", opts)
          vim.keymap.set("n", "x", "defx#do_action('execute_system')", opts)
          vim.keymap.set("n", "<C-g>", "defx#do_action('print')", opts)
        end,
      })
    end,
  },

  -- GitGutter
  {
    "airblade/vim-gitgutter",
    event = "BufRead",
    config = function()
      vim.g.gitgutter_enabled = 1
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
        callback = function()
          vim.cmd("GitGutter")
        end,
      })
    end,
  },

  -- Fugitive
  {
    "tpope/vim-fugitive",
    event = "BufReadPre",
    config = function()
      vim.keymap.set("n", "<Leader>gs", ":Git status<CR>")
      vim.keymap.set("n", "<Leader>gb", ":Git blame<CR>")
      vim.keymap.set("n", "<Leader>gd", ":Gdiffsplit<CR>")
      vim.keymap.set("n", "<Leader>gps", ":Gpush<CR>")
      vim.keymap.set("n", "<Leader>gpl", ":Gpull<CR>")
    end,
  },

  -- TOML Syntax
  {
    "cespare/vim-toml",
    ft = { "toml" },
  },

  -- Kotlin Syntax
  {
    "udalov/kotlin-vim",
    ft = { "kotlin" },
  },

  -- Terraform Syntax
  {
    "hashivim/vim-terraform",
    ft = { "terraform" },
  },

  -- Trailing Whitespace
  {
    "bronson/vim-trailing-whitespace",
    config = function()
      vim.g.extra_whitespace_ignored_filetypes = { "defx" }
    end,
  },

  -- Commenting
  {
    "tomtom/tcomment_vim",
    config = function()
      vim.g.tcomment_mapleader1 = "<C-/>"
      vim.g.tcomment_opleader1 = "gc"
      vim.g.tcomment_opleader2 = "gC"
    end,
  },

  -- Search Result Count
  {
    "osyo-manga/vim-anzu",
  },

  -- Enhanced f Search
  {
    "rhysd/clever-f.vim",
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_filetypes = {
        gitcommit = true,
        markdown = true,
        yaml = true,
        toml = true,
        plaintext = false,
      }
    end,
  },
})