local wezterm = require 'wezterm'
local ui = require 'ui'
local keys = require 'keys'

local config = wezterm.config_builder()

local workspace_switcher = wezterm.plugin.require('https://github.com/MLFlexer/smart_workspace_switcher.wezterm')
workspace_switcher.zoxide_path = '/opt/homebrew/bin/zoxide'

ui.setup_ui(config)
keys.setup_keys(config, workspace_switcher)

return config
