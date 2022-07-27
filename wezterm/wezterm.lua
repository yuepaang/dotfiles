local wezterm = require("wezterm")

return {
	default_prog = { "zsh", "-l", "-c", "tmux attach || tmux" },
	font = wezterm.font_with_fallback({ "PragmataPro Mono Liga", "Hack Nerd Font" }),
	font_size = 18,
	colors = {
		tab_bar = {
			active_tab = {
				bg_color = "#24283b",
				fg_color = "#c0caf5",
			},
		},
	},
    color_scheme = "Dracula",
	-- color_scheme = "DoomOne",
	-- color_scheme = "tokyonight",
	window_frame = {
		font_size = 16.0,
	},
	window_padding = {
		left = 5,
		right = 5,
		top = 0,
		bottom = 0,
	},
	foreground_text_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.2,
	},
	use_ime = true, -- fixed chinese input
	-- default_cwd = wezterm.home_dir .. '/Documents/workspace',
	keys = {
		{ key = "l", mods = "CMD", action = "ShowLauncher" },
		{ key = "w", mods = "CMD", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
	},
}
