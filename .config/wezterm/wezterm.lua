local wezterm = require 'wezterm'
local nav = require 'wezterm-nav'
local tab_bar = require 'wezterm-tab-bar'

local config = wezterm.config_builder()

local function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- print the workspace name at the upper right
wezterm.on("update-right-status", function(window, pane)
  window:set_right_status(window:active_workspace())
end)
-- load plugin
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
-- set path to zoxide
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"
-- keymaps
-- table.insert(keys, { key = "s", mods = "CTRL|SHIFT", action = workspace_switcher.switch_workspace() })
-- table.insert(keys, { key = "t", mods = "CTRL|SHIFT", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) })
-- table.insert(keys, { key = "[", mods = "CTRL|SHIFT", action = act.SwitchWorkspaceRelative(1) })
-- table.insert(keys, { key = "]", mods = "CTRL|SHIFT", action = act.SwitchWorkspaceRelative(-1) })

config.window_background_opacity = 0.93
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
-- config.font = wezterm.font 'JetBrains Mono'
config.font = wezterm.font_with_fallback {
  {
    family = 'JetBrains Mono',
    weight = 'Medium',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  },
  { family = 'Terminus', weight = 'Bold' },
  'Noto Color Emoji',
}
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
config.show_new_tab_button_in_tab_bar = false

config.colors = {
  split = 'transparent',
  tab_bar = {
    background = "transparent",
    active_tab = {
      bg_color = "transparent",
      fg_color = "#555",
    }
  }
}


config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 5000 }
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
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = 't',
    mods = 'CTRL',
    action = workspace_switcher.switch_workspace()
  },
  {
    key = ',',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  -- Copy
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CopyTo 'Clipboard',
  },
  -- Paste
  {
    key = 'v',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  -- Split horizontal (CMD+d)
  {
    key = 'd',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  -- Split vertical (CMD+SHIFT+d)
  {
    key = 'd',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- Close current pane (CMD+w)
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
}


return config
