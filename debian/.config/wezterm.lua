-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.hide_tab_bar_if_only_one_tab = true
config.automatically_reload_config = true
config.color_scheme = "iTerm2 Dark Background"

config.use_fancy_tab_bar = true

config.window_background_opacity = 0.98
config.window_frame = {
	--font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Regular", stretch = "Normal", style = "Normal" }),
	font_size = 13,
}
config.line_height = 1
config.font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Medium", stretch = "Normal", style = "Normal" })
config.font_size = 15.1
config.font_rules = {
	{
		intensity = "Bold",
		font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Bold", stretch = "Normal", style = "Normal" }),
	},
}
config.bold_brightens_ansi_colors = true

config.use_dead_keys = false
config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false

config.initial_cols = 120
config.initial_rows = 30

-- and finally, return the configuration to wezterm
return config
