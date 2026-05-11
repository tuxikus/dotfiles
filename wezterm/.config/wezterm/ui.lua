local wezterm = require 'wezterm'
local colorscheme = require 'colorscheme'

local module = {}

function module.setup_ui(config)
	config.font_size = 20
	config.color_scheme = colorscheme.init_colorscheme()
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
	config.window_frame = {
		font = wezterm.font 'Iosevka Nerd Font',
		font_size = 20,
	}
end

local function segments_for_right_status(window)
	return {
		window:active_workspace(),
		wezterm.strftime('%H:%M'),
	}
end

-- tab bar
wezterm.on('update-status', function(window, _)
	local segments = segments_for_right_status(window)
	local color_scheme = window:effective_config().resolved_palette
	local bg = wezterm.color.parse(color_scheme.background)
	local fg = color_scheme.foreground

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

	local elements = {}

	for i, seg in ipairs(segments) do
		local is_first = i == 1

		if is_first then
			table.insert(elements, { Background = { Color = 'none' } })
		end
		table.insert(elements, { Text = ' [' .. seg .. '] ' })
	end

	window:set_right_status(wezterm.format(elements))
end)


return module
