local wezterm = require 'wezterm'

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local PANE_ICON = wezterm.nerdfonts.md_dock_window

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

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

wezterm.on('update-right-status', function(window, pane)
  -- window:set_left_status(" " .. wezterm.nerdfonts.cod_terminal .. window:active_workspace() .. " ")
  window:set_left_status(wezterm.format {
    { Text = ' ' },
    { Text = wezterm.nerdfonts.cod_terminal_tmux },
    { Text = "  " },
    { Text = string.upper(window:active_workspace()) },
    { Text = " " },
  })
  window:set_right_status(wezterm.format {
    { Text = ' ' },
  })
end)

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local edge_background = 'transparent'
    local background = '#1b1032'
    local foreground = '#808080'

    if tab.is_active then
      background = '#2b2042'
      foreground = '#8287FD'
    elseif hover then
      background = '#3b3052'
      foreground = '#909090'
    end

    local edge_foreground = background

    local title = tab_title(tab)

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = foreground } },
      { Text = ' ' },
      { Text = PANE_ICON },
      { Text = ' ' },
      -- { Background = { Color = background } },
      -- { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_ARROW },
    }
  end
)
