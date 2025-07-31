return {
	"rest-nvim/rest.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "http")
		end,
	},
	init = function()
		vim.api.nvim_set_keymap("n", "<leader>re", ":Rest env<CR>", { noremap = true, silent = true })
		-- Set keymap for :Rest run
		vim.api.nvim_set_keymap("n", "<leader>rr", ":Rest run<CR>", { noremap = true, silent = true })
	end,
}
