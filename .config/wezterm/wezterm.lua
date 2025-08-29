local w = require 'wezterm'
local nav = require 'wezterm-nav'

local config = w.config_builder()

config.color_scheme = 'Catppuccin Latte'
config.window_background_opacity = 0.7
config.macos_window_background_blur = 20
config.window_decorations = 'RESIZE'
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.9,
}
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.font_size = 16
config.font = w.font('Maple Mono NF', { weight = "Regular" })
-- config.freetype_load_target = 'HorizontalLcd'

config.use_fancy_tab_bar = false

config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.anti_alias_custom_block_glyphs = true


config.keys = {
  -- move between split panes
  nav.split_nav('move', 'h'),
  nav.split_nav('move', 'j'),
  nav.split_nav('move', 'k'),
  nav.split_nav('move', 'l'),
  -- resize panes
  nav.split_nav('resize', 'h'),
  nav.split_nav('resize', 'j'),
  nav.split_nav('resize', 'k'),
  nav.split_nav('resize', 'l'),
  -- Copy
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = w.action.CopyTo 'Clipboard',
  },
  -- Paste
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = w.action.PasteFrom 'Clipboard',
  },
  -- Split horizontal (CMD+d)
  {
    key = 'd',
    mods = 'CMD',
    action = w.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Split vertical (CMD+SHIFT+d)
  {
    key = 'd',
    mods = 'CMD|SHIFT',
    action = w.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Close current pane (CMD+SHIFT+x)
  {
    key = 'x',
    mods = 'CMD|SHIFT',
    action = w.action.CloseCurrentPane { confirm = true },
  },
}

return config
