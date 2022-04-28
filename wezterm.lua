local wezterm = require("wezterm")
local utils = require("wez_utils")

---------------------------------------------------------------
--- keybinds
---------------------------------------------------------------
local default_keybinds = {
  -- コピペ
  { key = "c", mods = "CTRL", action = wezterm.action({ CopyTo = "Clipboard" }) },
  { key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },

  -- フォントサイズ
  { key = "=", mods = "CTRL", action = "ResetFontSize" },
  { key = "+", mods = "CTRL|SHIFT", action = "IncreaseFontSize" },
  { key = "-", mods = "CTRL", action = "DecreaseFontSize" },

  -- ページ操作
  { key = "b", mods = "CTRL", action = wezterm.action({ ScrollByPage = -1 }) },
  { key = "f", mods = "CTRL", action = wezterm.action({ ScrollByPage = 1 }) },

  -- タプ起動
  { key = "k", mods = "ALT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
  -- タブ終了
  { key = "x", mods = "ALT", action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },
  -- タブ移動
  { key = "o", mods = "ALT|SHIFT", action = wezterm.action({ ActivateTabRelative = -1 }) },
  { key = "o", mods = "ALT", action = wezterm.action({ ActivateTabRelative = 1 }) },

  -- tmuxキーバインド
  { key = "a", mods = "CTRL", action = wezterm.action({ EmitEvent = "toggle-tmux-keybinds" }) },

  { key = "e", mods = "ALT", action = wezterm.action({ EmitEvent = "trigger-nvim-with-scrollback" }) },

  -- 設定再読み込み
  { key = "r", mods = "ALT", action = "ReloadConfiguration" },
}

local tmux_keybinds = {
  -- ペイン操作
	{ key = "-", mods = "ALT", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "\\", mods = "ALT", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
  { key = "j", mods = "ALT", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
	{ key = "h", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "k", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "j", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "h", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }) },
	{ key = "l", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }) },
	{ key = "k", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }) },
	{ key = "j", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }) },

	{ key = "k", mods = "ALT|CTRL", action = "ActivateCopyMode" },
	{ key = "j", mods = "ALT|CTRL", action = wezterm.action({ PasteFrom = "PrimarySelection" }) },
	{ key = "Enter", mods = "ALT", action = "QuickSelect" },
}

local function create_keybinds()
	return utils.merge_lists(default_keybinds, tmux_keybinds)
end

---------------------------------------------------------------
--- wezterm on
---------------------------------------------------------------
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local user_title = tab.active_pane.user_vars.panetitle
	if user_title ~= nil and #user_title > 0 then
		return {
			{ Text = tab.tab_index + 1 .. ":" .. user_title },
		}
	end

	local title = wezterm.truncate_right(utils.basename(tab.active_pane.foreground_process_name), max_width)
	if title == "" then
		-- local uri = utils.convert_home_dir(tab.active_pane.current_working_dir)
		-- local basename = utils.basename(uri)
		-- if basename == "" then
		-- 	basename = uri
		-- end
		-- title = wezterm.truncate_right(basename, max_width)
		local dir = string.gsub(tab.active_pane.title, "(.*[: ])(.*)", "%2")
		title = wezterm.truncate_right(dir, max_width)
	end
	return {
		{ Text = tab.tab_index + 1 .. ":" .. title },
	}
end)

--local function display_ime_on_right_status(window, pane)
--	local compose = window:composition_status()
--	if compose then
--		compose = "COMPOSING: " .. compose
--	end
--	window:set_right_status(compose)
--end

wezterm.on("toggle-tmux-keybinds", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.95
		overrides.keys = default_keybinds
	else
		overrides.window_background_opacity = nil
		overrides.keys = utils.merge_lists(default_keybinds, tmux_keybinds)
	end
	window:set_config_overrides(overrides)
end)

local io = require("io")
local os = require("os")

wezterm.on("trigger-nvim-with-scrollback", function(window, pane)
	local scrollback = pane:get_lines_as_text()
	local name = os.tmpname()
	local f = io.open(name, "w+")
	f:write(scrollback)
	f:flush()
	f:close()
	window:perform_action(
		wezterm.action({ SpawnCommandInNewTab = {
			args = { "nvim", name },
		} }),
		pane
	)
	wezterm.sleep_ms(1000)
	os.remove(name)
end)

---------------------------------------------------------------
--- load local_config
---------------------------------------------------------------
-- Write settings you don't want to make public, such as ssh_domains
local function load_local_config()
	local ok, _ = pcall(require, "local")
	if not ok then
		return {}
	end
	return require("local").setup()
end
local local_config = load_local_config()

---------------------------------------------------------------
--- Config
---------------------------------------------------------------
local config = {
  font=wezterm.font('SauceCodePro Nerd Font', {weight="Bold", stretch='Normal', style='Normal'}),
  use_ime = true, -- これがないとIMEが動かない
  font_size = 14,
  color_scheme = "OneHalfDark", -- テーマ：https://wezfurlong.org/wezterm/colorschemes/index.html
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
	selection_word_boundary = " \t\n{}[]()\"'`,;:",
	window_padding = {
		left = 5,
		right = 5,
		top = 0,
		bottom = 0,
	},
	tab_bar_at_bottom = true,
	disable_default_key_bindings = true,
	enable_csi_u_key_encoding = true,
	keys = create_keybinds(),
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "NONE",
			action = wezterm.action({ CompleteSelection = "PrimarySelection" }),
		},
		{
			event = { Up = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = wezterm.action({ CompleteSelection = "Clipboard" }),
		},
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = "OpenLinkAtMouseCursor",
		},
	},
	-- animation_fps = 10,
	-- enable_wayland = true,
}

return utils.merge_tables(config, local_config)
