local wezterm = require 'wezterm'
local nav = require 'wezterm-nav'
local tab_bar = require 'wezterm-tab-bar'

local config = wezterm.config_builder()
local scheme = wezterm.get_builtin_color_schemes()['Catppuccin Latte']
scheme.background = '#FFFFFF'

local function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end

config.color_schemes = {
  ["Catppuccin Latte"] = scheme,
}
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- print the workspace name at the upper right
wezterm.on("update-right-status", function(window, pane)
  window:set_right_status(window:active_workspace())
end)
-- load plugin
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
-- set path to zoxide
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"

wezterm.on("gui-startup", function(cmd)
  local dotfiles_path = wezterm.home_dir .. "/code/smart/hci"
  local tab, build_pane, window = wezterm.mux.spawn_window({
    workspace = "hci",
    cwd = dotfiles_path,
    args = args,
  })
  wezterm.mux.set_active_workspace("hci")
end)

config.window_background_opacity = 0.9
config.macos_window_background_blur = 20
config.window_decorations = 'RESIZE'
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.9,
}
config.window_padding = {
  left = 0,
  right = 0,
  top = 5,
  bottom = 0,
}

config.font_size = 16
config.line_height = 1.2
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
config.key_tables = {
  copy_mode = {
    {
      key = 'y',
      mods = 'NONE',
      action = wezterm.action.Multiple {
        wezterm.action.CopyTo 'PrimarySelection',
        wezterm.action.ClearSelection,
        wezterm.action.CopyMode { 'ClearSelectionMode' },
      },
    },
  },
}
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
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  {
    key = 'l',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SwitchWorkspaceRelative(-1),
  },
  {
    key = 'h',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SwitchWorkspaceRelative(1),
  },
  {
    key = 'm',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for workspace',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          wezterm.mux.rename_workspace(
            wezterm.mux.get_active_workspace(),
            line
          )
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
