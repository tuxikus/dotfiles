local wezterm = require 'wezterm'
local io = require 'io'
local os = require 'os'

local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = 'Modus-Operandi'
config.default_prog = { '/opt/homebrew/bin/fish', '-l' }

config.window_frame = {
	font = wezterm.font 'Iosevka Nerd Font',
	font_size = 20,
}

config.font_size = 20
config.window_decorations = 'RESIZE'
config.font = wezterm.font 'Iosevka Nerd Font'
config.font_size = 20
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.max_fps = 120
config.animation_fps = 120
config.window_background_opacity = 1.0
config.inactive_pane_hsb = {
	saturation = 0.5,
	brightness = 0.5,
}

wezterm.on('update-right-status', function(window, pane)
	local palette = window:effective_config().resolved_palette
	local bg = wezterm.color.parse(palette.background)
	local fg = palette.foreground

	local overrides = window:get_config_overrides() or {}

	overrides.colors = {
		tab_bar = {
       background = bg,
       active_tab = {
               bg_color = bg:lighten(0.2),
               fg_color = fg,
               intensity = 'Bold',
               underline = 'Single',
               italic = false,
               strikethrough = false,
       },
       inactive_tab = {
               bg_color = bg,
               fg_color = fg,
       },
       inactive_tab_hover = {
               bg_color = bg,
               fg_color = fg,
               italic = true,
       },
       new_tab = {
               bg_color = bg,
               fg_color = fg,
       },
       new_tab_hover = {
               bg_color = fg,
               fg_color = bg,
               italic = true,
       },
		},
	}

	window:set_config_overrides(overrides)

  local date = wezterm.strftime('%H:%M')
  local workspace = window:active_workspace()
  local project = workspace:match("([^/]+)$")
	window:set_right_status(wezterm.format({{Text = '[' .. project .. '] ' .. ' [' .. date .. ']'}}))
end)

local workspace_switcher = wezterm.plugin.require('https://github.com/MLFlexer/smart_workspace_switcher.wezterm')
workspace_switcher.zoxide_path = '/opt/homebrew/bin/zoxide'

-- open scrollback in hx -- TODO: $EDITOR
wezterm.on('trigger-hx-with-scrollback', function(window, pane)
  -- Retrieve the text from the pane
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

  -- Create a temporary file to pass to vim
  local name = os.tmpname()
  local f = io.open(name, 'w+')
  f:write(text)
  f:flush()
  f:close()

  -- Open a new window running hx and tell it to open the file
  window:perform_action(
    act.SpawnCommandInNewTab {
      args = { '/opt/homebrew/bin/hx', name },
    },
    pane
  )

  -- Wait "enough" time for vim to read the file before we remove it.
  -- The window creation and process spawn are asynchronous wrt. running
  -- this script and are not awaitable, so we just pick a number.
  --
  -- Note: We don't strictly need to remove this file, but it is nice
  -- to avoid cluttering up the temporary directory.
  wezterm.sleep_ms(1000)
  os.remove(name)
end)


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
	{
	  key = 'e',
	  mods = 'ALT',
	  action = act.EmitEvent 'trigger-hx-with-scrollback',
  },
}

return config
