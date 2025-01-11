-- Pull in the wezterm API
local wezterm = require("wezterm")

local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Macchiato (Gogh)"

-- Transparency
config.window_background_opacity = 0.7

-- Hide top bar
config.hide_tab_bar_if_only_one_tab = true

-- Padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Font
config.font = wezterm.font("RobotoMono Nerd Font")
config.font_size = 14

-- tmux
config.leader = { key = "b", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = {
	{
		mods = "LEADER",
		key = "c",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		mods = "LEADER",
		key = "x",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		mods = "LEADER",
		key = "b",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		mods = "LEADER",
		key = "n",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		mods = "LEADER",
		key = "v",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "h",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		mods = "LEADER",
		key = "j",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		mods = "LEADER",
		key = "k",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		mods = "LEADER",
		key = "l",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		mods = "LEADER",
		key = "LeftArrow",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		mods = "LEADER",
		key = "RightArrow",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		mods = "LEADER",
		key = "DownArrow",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		mods = "LEADER",
		key = "UpArrow",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	-- {
	-- 	key = "w",
	-- 	mods = "ALT",
	-- 	action = wezterm.action_callback(function(win, pane)
	-- 		resurrect.save_state(resurrect.workspace_state.get_workspace_state())
	-- 	end),
	-- },
	-- {
	-- 	key = "W",
	-- 	mods = "ALT",
	-- 	action = resurrect.window_state.save_window_action(),
	-- },
	-- {
	-- 	key = "T",
	-- 	mods = "ALT",
	-- 	action = resurrect.tab_state.save_tab_action(),
	-- },
	-- {
	-- 	key = "s",
	-- 	mods = "ALT",
	-- 	action = wezterm.action_callback(function(win, pane)
	-- 		resurrect.save_state(resurrect.workspace_state.get_workspace_state())
	-- 		resurrect.window_state.save_window_action()
	-- 	end),
	-- },
	-- {
	-- 	key = "r",
	-- 	mods = "ALT",
	-- 	action = wezterm.action_callback(function(win, pane)
	-- 		resurrect.fuzzy_load(win, pane, function(id, label)
	-- 			local type = string.match(id, "^([^/]+)") -- match before '/'
	-- 			id = string.match(id, "([^/]+)$") -- match after '/'
	-- 			id = string.match(id, "(.+)%..+$") -- remove file extention
	-- 			local opts = {
	-- 				relative = true,
	-- 				restore_text = true,
	-- 				on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	-- 			}
	-- 			if type == "workspace" then
	-- 				local state = resurrect.load_state(id, "workspace")
	-- 				resurrect.workspace_state.restore_workspace(state, opts)
	-- 			elseif type == "window" then
	-- 				local state = resurrect.load_state(id, "window")
	-- 				resurrect.window_state.restore_window(pane:window(), state, opts)
	-- 			elseif type == "tab" then
	-- 				local state = resurrect.load_state(id, "tab")
	-- 				resurrect.tab_state.restore_tab(pane:tab(), state, opts)
	-- 			end
	-- 		end)
	-- 	end),
	-- },
}
--
-- for i = 0, 9 do
-- 	-- leader + number to activate that tab
-- 	table.insert(config.keys, {
-- 		key = tostring(i),
-- 		mods = "LEADER",
-- 		action = wezterm.action.ActivateTab(i),
-- 	})
-- end
--
-- -- tab bar
-- config.hide_tab_bar_if_only_one_tab = false
-- config.tab_bar_at_bottom = true
-- config.use_fancy_tab_bar = false
-- config.tab_and_split_indices_are_zero_based = true
--
-- -- tmux status
-- wezterm.on("update-right-status", function(window, _)
-- 	local SOLID_LEFT_ARROW = ""
-- 	local ARROW_FOREGROUND = { Foreground = { Color = "#c6a0f6" } }
-- 	local prefix = ""
--
-- 	if window:leader_is_active() then
-- 		prefix = " " .. utf8.char(0x1f30a) -- ocean wave
-- 		SOLID_LEFT_ARROW = utf8.char(0xe0b2)
-- 	end
--
-- 	if window:active_tab():tab_id() ~= 0 then
-- 		ARROW_FOREGROUND = { Foreground = { Color = "#1e2030" } }
-- 	end -- arrow color based on if tab is first pane
--
-- 	window:set_left_status(wezterm.format({
-- 		{ Background = { Color = "#b7bdf8" } },
-- 		{ Text = prefix },
-- 		ARROW_FOREGROUND,
-- 		{ Text = SOLID_LEFT_ARROW },
-- 	}))
-- end)

-- -- PLUGINS
--
-- -- Resurrect
-- -- loads the state whenever I create a new workspace
-- wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
-- 	local workspace_state = resurrect.workspace_state
--
-- 	workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
-- 		window = window,
-- 		relative = true,
-- 		restore_text = true,
-- 		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
-- 	})
-- end)
--
-- -- Saves the state whenever I select a workspace
-- wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
-- 	local workspace_state = resurrect.workspace_state
-- 	resurrect.save_state(workspace_state.get_workspace_state())
-- end)
--
-- wezterm.on("gui-startup", resurrect.resurrect_on_gui_startup)
--
-- -- Smart Workspace Switcher
-- workspace_switcher.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
