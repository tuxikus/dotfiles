local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Hardcore'

config.window_background_opacity = 0.8

config.use_fancy_tab_bar = false

config.font = wezterm.font 'Ubuntu Mono'
config.font_size = 20.0

config.launch_menu = {
  { args = { 'emacs' }, },
  { args = { 'firefox' }, },
  { args = { 'top' }, },
  { args = { 'btop' }, },
  { label = 'Bash', args = { 'bash', '-l' }, },
}

local act = wezterm.action

wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

config.keys = {
  { key = 'x', mods = 'ALT', action = act.ShowLauncher },
  { key = 't', mods = 'CTRL', action = act.ShowTabNavigator },
  { key = 'w', mods = 'CTRL', action = act.ActivateKeyTable { name = 'pane_mode', one_shot = true, }, },
}

config.key_tables = {
  pane_mode = {
    { key = 'n', action = act.SplitVertical { domain="CurrentPaneDomain" } },

    { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
    { key = 'h', action = act.ActivatePaneDirection 'Left' },

    { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
    { key = 'l', action = act.ActivatePaneDirection 'Right' },

    { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
    { key = 'k', action = act.ActivatePaneDirection 'Up' },

    { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
    { key = 'j', action = act.ActivatePaneDirection 'Down' },

    { key = 'Escape', action = 'PopKeyTable' },
  },
}

return config
