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
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

config.font_size = 16
config.font = w.font 'JetBrains Mono'
-- config.font = w.font('Maple Mono NF', { weight = "Regular" })
-- config.freetype_load_target = 'HorizontalLcd'

config.use_fancy_tab_bar = false

config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.anti_alias_custom_block_glyphs = true

-- Pane border settings to fix alignment
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.pane_focus_follows_mouse = false

config.colors = {
  split = 'transparent',
}

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

w.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    if tab.is_active then
      return {
        { Background = { Color = 'blue' } },
        { Text = ' ' .. title .. ' ' },
      }
    end
    if tab.is_last_active then
      -- Green color and append '*' to previously active tab.
      return {
        { Background = { Color = 'green' } },
        { Text = ' ' .. title .. '*' },
      }
    end
    return title
  end
)

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
  -- Close current pane (CMD+w)
  {
    key = 'w',
    mods = 'CMD',
    action = w.action.CloseCurrentPane { confirm = false },
  },
}

return config
