local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Mocha",
	font_size = 16.0,
	keys = {
		-- Sane pane shortcuts
		{ key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "_", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
		--
		-- Resize panes
		{ key = "LeftArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
		{ key = "RightArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
		{ key = "UpArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
		{ key = "DownArrow", mods = "CTRL|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },

		-- Close pane
		{ key = "x", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	},
}
