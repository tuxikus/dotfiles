-- from: https://www.statox.fr/posts/2025/12/wezterm_neovim_synced_colorscheme/
local wezterm = require 'wezterm'

local module = {}

local dark_colorscheme = 'OneDark (base16)'
local light_colorscheme = 'One Light (base16)'

local colorscheme_file_path = '/tmp/colorscheme'

module.default_colorscheme_mode = "light"

function create_colorscheme_file()
    local file = io.open(colorscheme_file_path, "w")
    file:write(module.default_colorscheme_mode)
    file:close()
end

function read_colorscheme_file()
    local file = io.open(colorscheme_file_path, "r")
    content = file:read()
    file:close()
    return content
end

function init_colorscheme()
    local success, content = pcall(read_colorscheme_file)

    if not success then
        wezterm.log_info('Could not read file content, using default')
        create_colorscheme_file()
        content = module.default_colorscheme_mode
    end

    if not (content == "light" or content == "dark") then
        wezterm.log_info('Invalid mode in file, using default', content)
        content = module.default_colorscheme_mode
    end

    if content == "light" then
        return light_colorscheme
    end

    return dark_colorscheme
end
module.init_colorscheme = init_colorscheme

function module.toggle_colorscheme(window, pane, config)
    local success, content = pcall(read_colorscheme_file)

    local new_value = content == "light" and "dark" or "light"
    local file = io.open(colorscheme_file_path, "w")
    if file then
        file:write(new_value)
        file:close()
    end

    wezterm.reload_configuration()
end

return module
