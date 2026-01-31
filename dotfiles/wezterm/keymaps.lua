local wezterm = require("wezterm")

-- This is the module table that we will export
local module = {}

-- key bindings
-- use a leader like tmux/ vim
function module.apply_to_config(config)
	local act = wezterm.action

	config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1500 }
	config.keys = {
		{
			key = "c",
			mods = "LEADER",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "v",
			mods = "LEADER",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "s",
			mods = "LEADER",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "H",
			mods = "LEADER",
			action = act.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "J",
			mods = "LEADER",
			action = act.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "K",
			mods = "LEADER",
			action = act.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "L",
			mods = "LEADER",
			action = act.AdjustPaneSize({ "Right", 5 }),
		},
		{
			key = "n",
			mods = "LEADER",
			action = act.ActivateTabRelative(1),
		},
		{
			key = "b",
			mods = "LEADER",
			action = act.ActivateTabRelative(-1),
		},
		{
			key = "0",
			mods = "LEADER",
			action = act.ActivateTab(0),
		},
		{
			key = "9",
			mods = "LEADER",
			action = act.ActivateTab(-1),
		},
		{
			key = "1",
			mods = "LEADER",
			action = act.ActivateTab(1),
		},
		{
			key = "2",
			mods = "LEADER",
			action = act.ActivateTab(2),
		},
		{
			key = "3",
			mods = "LEADER",
			action = act.ActivateTab(3),
		},
		{
			key = "4",
			mods = "LEADER",
			action = act.ActivateTab(4),
		},
		{
			key = "h",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "z",
			mods = "LEADER",
			action = act.TogglePaneZoomState,
		},
		{
			key = "[",
			mods = "LEADER",
			action = act.ActivateCopyMode,
		},
	}
end

return module
