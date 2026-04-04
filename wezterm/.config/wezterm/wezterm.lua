local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- basic configs
config.color_scheme = 'OneDark (base16)'
config.window_decorations = 'RESIZE'
config.font = wezterm.font 'Iosevka Nerd Font'
config.font_size = 20
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.max_fps = 120
config.window_background_opacity = 1.0
config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.5,
}

-- plugins
local bar = wezterm.plugin.require('https://github.com/adriankarlen/bar.wezterm')
bar.apply_to_config(config, {
	position = 'top',
})

local workspace_switcher = wezterm.plugin.require('https://github.com/MLFlexer/smart_workspace_switcher.wezterm')
workspace_switcher.zoxide_path = '/opt/homebrew/bin/zoxide'

-- keys
config.keys = {
	{ key = ' ', mods = 'ALT', action = act.QuickSelectArgs },
	{ key = 'x', mods = 'ALT', action = act.ActivateCopyMode },
	{ key = 'm', mods = 'ALT', action = act.TogglePaneZoomState },
	{ key = 'n', mods = 'ALT', action = act.SplitHorizontal },
	{ key = 'q', mods = 'ALT', action = act.CloseCurrentPane { confirm = true }, },
	{ key = 'o', mods = 'ALT', action = act.PaneSelect },
	{ key = 'f', mods = 'ALT', action = act.Search('CurrentSelectionOrEmptyString') },
	{ key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
	{ key = 's', mods = 'ALT', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },
	{ key = 's', mods = 'ALT|SHIFT', action = workspace_switcher.switch_workspace() },
	{ key = 'n', mods = 'ALT|SHIFT', action = act.SplitVertical },
	{ key = 'l', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },
	{ key = 'h', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
	{ key = 'k', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
	{ key = 'j', mods = 'ALT|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },
	{ key = 'j', mods = 'ALT', action = act.ActivatePaneDirection('Down') },
	{ key = 'k', mods = 'ALT', action = act.ActivatePaneDirection('Up') },
	{
		key = 'h',
		mods = 'ALT',
		action = wezterm.action_callback(function(window, pane)
			local tab = window:mux_window():active_tab()
			if tab:get_pane_direction('Left') ~= nil then
				window:perform_action(act.ActivatePaneDirection('Left'), pane)
			else
				window:perform_action(act.ActivateTabRelative(-1), pane)
			end
		end),
	},
	{
		key = 'l',
		mods = 'ALT',
		action = wezterm.action_callback(function(window, pane)
			local tab = window:mux_window():active_tab()
			if tab:get_pane_direction('Right') ~= nil then
				window:perform_action(act.ActivatePaneDirection('Right'), pane)
			else
				window:perform_action(act.ActivateTabRelative(1), pane)
			end
		end)
	},
}

return config
