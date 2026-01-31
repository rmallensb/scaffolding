--
-- Pull in the wezterm API
--
local wezterm = require("wezterm")

--
-- This will hold the configuration.
--
local config = wezterm.config_builder()

--
-- This is where you actually apply your config choices
--
-- config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 16

config.enable_tab_bar = true

config.window_decorations = "RESIZE"

config.scrollback_lines = 50000

config.default_cursor_style = "SteadyBar"

-- colorscheme
config.color_scheme = "Nord (base16)"

config.window_background_opacity = 0.9
config.macos_window_background_blur = 30

--
-- josean coolnight colorscheme:
--
config.colors = {
  foreground = "#CBE0F0",
  background = "#011423",
  cursor_bg = "#47FF9C",
  cursor_border = "#47FF9C",
  cursor_fg = "#011423",
  selection_bg = "#033259",
  selection_fg = "#CBE0F0",
  ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
  brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

-- wezterm.on('update-right-status', function(window, pane)
--   window:set_left_status 'left'
--   window:set_right_status 'right'
-- end)

config.show_tabs_in_tab_bar = true

--
-- custom key bindings
--
local keymaps = require("keymaps")
keymaps.apply_to_config(config)

-- local mux = wezterm.mux

-- create a default window and maximize it on startup
-- wezterm.on("gui-startup", function(cmd)
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	window:gui_window():maximize()
-- end)
require("startup")

-- and finally, return the configuration to wezterm
return config
