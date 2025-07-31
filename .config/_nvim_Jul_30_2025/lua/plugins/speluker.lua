return {
  'kamykn/spelunker.vim',
  lazy = false,
  config = function()
    vim.api.nvim_command 'highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#f67468'
  end,
}
