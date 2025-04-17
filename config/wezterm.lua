local wezterm = require('wezterm')
local act = wezterm.action
local config = wezterm.config_builder()

-- ############################################################################
-- 基本設定
-- ############################################################################

-- 設定の自動リロード
config.automatically_reload_config = true
-- フォントサイズ
config.font_size = 15
-- フォント
config.font = wezterm.font('Myrica M')

-- ############################################################################
-- スクロール設定
-- ############################################################################

-- スクロールバーの表示
config.enable_scroll_bar = true
-- スクロールバッファの行数
config.scrollback_lines = 100000
-- 入力時に自動的に下にスクロール
config.scroll_to_bottom_on_input = true

-- ############################################################################
-- マウス操作設定
-- ############################################################################

-- マウスホイールでタブをスクロール
config.mouse_wheel_scrolls_tabs = true
-- マウスで選択したテキストをクリップボードにコピー
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection('Clipboard'),
  },
  -- マウスでペインを選択
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = wezterm.action.CompleteSelection('PrimarySelection'),
  },
}

-- ############################################################################
-- 通知設定
-- ############################################################################

-- ベル音を無効化
config.audible_bell = "Disabled"
-- 通知を有効化
config.enable_wayland = true
-- 通知の処理方法を設定
config.notification_handling = "AlwaysShow"

-- ############################################################################
-- パフォーマンス設定
-- ############################################################################

-- GPUアクセラレーションを有効化
config.front_end = "WebGpu"
-- フレームレートの制限
config.max_fps = 60

-- ############################################################################
-- ウィンドウ設定
-- ############################################################################

-- ウィンドウの装飾を非表示
config.window_decorations = "TITLE | RESIZE"
-- ウィンドウの透明度
config.window_background_opacity = 0.95

-- ############################################################################
-- タブ設定
-- ############################################################################

-- タブが1つの時はタブバーを非表示
config.hide_tab_bar_if_only_one_tab = true
-- タブバーを下部に配置
config.tab_bar_at_bottom = true

-- ############################################################################
-- 表示設定
-- ############################################################################

-- カラースキーム
config.color_scheme = 'Molokai'
-- カーソルスタイル
config.default_cursor_style = "BlinkingBar"
-- カーソルのブリンク速度（ミリ秒）
config.cursor_blink_rate = 500

-- ############################################################################
-- キーバインド設定
-- ############################################################################

config.keys = {
  -- タブ操作
  -- 新規タブ作成
  {
    key = 't',
    mods = 'CTRL',
    action = wezterm.action.SpawnTab('CurrentPaneDomain'),
  },
  -- ペイン操作
  -- 垂直分割（上下）
  {
    key = 'UpArrow',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'DownArrow',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'k',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'j',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- 水平分割（左右）
  {
    key = 'LeftArrow',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'RightArrow',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'h',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'l',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- ペイン間移動
  -- 上へ移動
  {
    key = 'UpArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection('Up'),
  },
  {
    key = 'k',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection('Up'),
  },
  -- 下へ移動
  {
    key = 'DownArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection('Down'),
  },
  {
    key = 'j',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection('Down'),
  },
  -- 左へ移動
  {
    key = 'LeftArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection('Left'),
  },
  {
    key = 'h',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection('Left'),
  },
  -- 右へ移動
  {
    key = 'RightArrow',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection('Right'),
  },
  {
    key = 'l',
    mods = 'CMD',
    action = wezterm.action.ActivatePaneDirection('Right'),
  },

  -- ペインサイズ変更
  -- 上に大きく
  {
    key = 'UpArrow',
    mods = 'CMD|CTRL',
    action = act.AdjustPaneSize { 'Up', 2 },
  },
  {
    key = 'k',
    mods = 'CMD|CTRL',
    action = act.AdjustPaneSize { 'Up', 2 },
  },
  -- 下に大きく
  {
    key = 'DownArrow',
    mods = 'CMD|CTRL',
    action = act.AdjustPaneSize { 'Down', 2 },
  },
  {
    key = 'j',
    mods = 'CMD|CTRL',
    action = act.AdjustPaneSize { 'Down', 2 },
  },
  -- 左に大きく
  {
    key = 'LeftArrow',
    mods = 'CMD|CTRL',
    action = act.AdjustPaneSize { 'Left', 2 },
  },
  {
    key = 'h',
    mods = 'CMD|CTRL',
    action = act.AdjustPaneSize { 'Left', 2 },
  },
  -- 右に大きく
  {
    key = 'RightArrow',
    mods = 'CMD|CTRL',
    action = act.AdjustPaneSize { 'Right', 2 },
  },
  {
    key = 'l',
    mods = 'CMD|CTRL',
    action = act.AdjustPaneSize { 'Right', 2 },
  },
}

return config
