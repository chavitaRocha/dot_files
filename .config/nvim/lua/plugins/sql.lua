return {
	'kristijanhusak/vim-dadbod-ui',
	dependencies = {
		{ 'tpope/vim-dadbod',                     lazy = true },
		{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
	},
	cmd = {
		'DBUI',
		'DBUIToggle',
		'DBUIAddConnection',
		'DBUIFindBuffer',
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
	end,
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "sql",
			callback = function()
				vim.bo.omnifunc = "vim_dadbod_completion#omni"
			end,
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "sql",
			callback = function()
				vim.keymap.set({ 'v', 'n' }, '<leader>rr', '<Plug>(DBUI_ExecuteQuery)', { buffer = true })
			end,
		})
	end,
}
