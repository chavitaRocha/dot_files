return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>x', '<cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>', desc = 'Document Diagnostics' },
    { 'gr', '<cmd>Trouble lsp_references focus=true<CR>', desc = '[G]oto [R]eferences' },
    { '<leader>gd', '<cmd>Trouble lsp_definition focus=true<CR>', desc = '[G]oto [D]efinition' },
  },
  opts = {
    modes = {
      diagnostics = {
        auto_open = false,
        auto_close = true,
      },
    },
    auto_jump = true,
    keys = {
      ['<esc>'] = 'close',
      ['<cr>'] = 'jump_close',
    },
  },
}
