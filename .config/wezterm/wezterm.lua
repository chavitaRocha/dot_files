local w = require 'wezterm'

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
  -- this is set by the plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == 'true'
end

-- if you *ARE* lazy-loading smart-splits.nvim (not recommended)
-- you have to use this instead, but note that this will not work
-- in all cases (e.g. over an SSH connection). Also note that
-- `pane:get_foreground_process_name()` can have high and highly variable
-- latency, so the other implementation of `is_vim()` will be more
-- performant as well.
local function is_vim(pane)
  -- This gsub is equivalent to POSIX basename(3)
  -- Given "/foo/bar" returns "bar"
  -- Given "c:\\foo\\bar" returns "bar"
  local process_name = string.gsub(pane:get_foreground_process_name(), '(.*[/\\])(.*)', '%2')
  return process_name == 'nvim' or process_name == 'vim'
end

local direction_keys = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = w.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

local config = w.config_builder()

config.color_scheme = 'Catppuccin Latte'
config.window_background_opacity = 0.7
config.macos_window_background_blur = 20
config.window_decorations = 'NONE'

config.font_size = 16
config.font = w.font('Maple Mono NF', { weight = "Light" })
config.freetype_load_target = 'HorizontalLcd'

config.use_fancy_tab_bar = false

config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.anti_alias_custom_block_glyphs = true

config.keys = {
  -- move between split panes
  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),
  -- resize panes
  split_nav('resize', 'h'),
  split_nav('resize', 'j'),
  split_nav('resize', 'k'),
  split_nav('resize', 'l'),
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
