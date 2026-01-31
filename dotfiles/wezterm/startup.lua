local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
	local project_dir = "/Users/ryan/luminary/platform/server"

	-- tab, pane, window
	local _, config_pane, window = mux.spawn_window({
		workspace = "development",
	})

	config_pane:split({
		cwd = "/Users/ryan/.config",
		direction = "Left",
	})

	local notes_pane = config_pane:split({
		cwd = "/Users/ryan/luminary/notes",
		direction = "Right",
		size = 0.75,
	})

	notes_pane:split({
		cwd = "/Users/ryan/luminary/notes",
		direction = "Top",
	})

	-- tab, pane, window
	local _, platform_pane, _ = window:spawn_tab({
		cwd = project_dir,
	})

	local platform_pane_right = platform_pane:split({
		cwd = project_dir,
		direction = "Right",
		size = 0.6,
	})

	platform_pane_right:split({
		direction = "Top",
	})

	window:spawn_tab({
		cwd = project_dir .. "/pkg",
	})
	window:gui_window():maximize()
end)
