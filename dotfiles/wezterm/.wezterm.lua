-- Pull in the wezterm API
local wezterm = require 'wezterm'

local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 16

config.enable_tab_bar = true

config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

-- colorscheme
config.color_scheme = 'Nord (base16)'
config.default_cursor_style = 'SteadyBar'

-- config.color_scheme = 'Night Owl (Gogh)'
-- config.color_scheme = 'Raycast_Dark'
--
-- josean coolnight colorscheme:
-- config.colors = {
--  foreground = "#CBE0F0",
-- 	background = "#011423",
-- 	cursor_bg = "#47FF9C",
-- 	cursor_border = "#47FF9C",
-- 	cursor_fg = "#011423",
-- 	selection_bg = "#033259",
-- 	selection_fg = "#CBE0F0",
-- 	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- 	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }

-- wezterm.on('update-right-status', function(window, pane)
--   window:set_left_status 'left'
--   window:set_right_status 'right'
-- end)

config.show_tabs_in_tab_bar = true

-- key bindings
-- use a leader like tmux/ vim
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1500 }
config.keys = {
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'v',
    mods = 'LEADER',
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = 's',
    mods = 'LEADER',
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = act.ActivateTabRelative(1),
  },
  {
    key = 'b',
    mods = 'LEADER',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = act.ActivatePaneDirection "Left",
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ActivatePaneDirection "Right",
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = act.ActivatePaneDirection "Down",
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = act.ActivatePaneDirection "Up",
  },
  {
    key = 'z',
    mods = 'LEADER',
    action = act.TogglePaneZoomState,
  },
}

-- and finally, return the configuration to wezterm
return config
