local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Catppuccin Latte'
config.window_background_opacity = 0.7
config.macos_window_background_blur = 20

config.font_size = 16
config.font = wezterm.font('Maple Mono NF', { weight = "Light" })
config.freetype_load_target = 'HorizontalLcd'

config.use_fancy_tab_bar = false

config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.anti_alias_custom_block_glyphs = true

return config
