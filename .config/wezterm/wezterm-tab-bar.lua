local wezterm = require 'wezterm'

local PANE_ICON = wezterm.nerdfonts.md_dock_window

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
  local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

  return current_dir == HOME_DIR and "." or string.gsub(current_dir.file_path, "(.*[/\\])(.*)", "%2")
end

local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  return get_current_working_dir(tab_info)
end


wezterm.on('update-right-status', function(window, pane)
  local workspace = window:active_workspace()
  local workspace_name = workspace:match("([^/\\]+)$") or workspace

  window:set_left_status(wezterm.format {
    { Text = ' ' },
    { Text = wezterm.nerdfonts.cod_terminal_tmux },
    { Text = "  " },
    { Text = string.upper(workspace_name) },
    { Text = " " },
  })
end)

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local edge_background = nil
    local background = nil
    local foreground = '#888'

    if tab.is_active then
      background = nil
      foreground = '#8287FD'
    elseif hover then
      background = nil
      foreground = '#909090'
    end

    local title = tab_title(tab)
    -- local title = get_current_working_dir(tab)

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Foreground = { Color = foreground } },
      { Text = ' ' },
      { Text = PANE_ICON },
      { Text = ' ' },
      { Text = title },
      { Text = ' ' },
    }
  end
)
