return {
  'cbochs/grapple.nvim',
  enabled = true,
  branch = 'main',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', lazy = true },
  },
  opts = {
    scope = 'cwd', -- also try out "git_branch"
    -- scope = "git", -- also try out "git_branch"
    style = 'basename',
  },
  evet = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  command = function(path)
    vim.cmd('e ' .. path)
  end,
  keys = {
    {
      'mm',
      function()
        require('grapple').tag()
        vim.notify('Tagged', vim.log.levels.INFO)
      end,
      desc = 'Grapple toggle tag',
    },
    { 'md', '<cmd>Grapple untag<cr>', desc = 'Grapple toggle tag' },
    { 'ml', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple toggle tags' },
    -- { '<leader>K', '<cmd>Grapple toggle_scopes<cr>', desc = 'Grapple toggle scopes' },
    { '<S-l>', '<cmd>Grapple cycle forward<cr>', desc = 'Grapple cycle forward' },
    { '<S-h>', '<cmd>Grapple cycle backward<cr>', desc = 'Grapple cycle backward' },
    { '<leader>1', '<cmd>Grapple select index=1<cr>', desc = 'Grapple select 1' },
    { '<leader>2', '<cmd>Grapple select index=2<cr>', desc = 'Grapple select 2' },
    { '<leader>3', '<cmd>Grapple select index=3<cr>', desc = 'Grapple select 3' },
    { '<leader>4', '<cmd>Grapple select index=3<cr>', desc = 'Grapple select 4' },
  },
}
