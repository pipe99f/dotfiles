-- Pull in the wezterm API
local wezterm = require("wezterm")

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

-- and finally, return the configuration to wezterm
return config
