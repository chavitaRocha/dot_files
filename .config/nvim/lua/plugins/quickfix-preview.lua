return {
	"elanmed/quickfix-preview.nvim",
	enabled = false,
	config = function()
		vim.g.quickfix_preview = {
			-- defaults:
			open_preview_win_opts = {
				style = "minimal",
				split = "right",
				width = math.floor(vim.o.columns / 2),
			},
			preview_win_opts = {
				cursorline = true,
				number = true,
			}
		}

		vim.api.nvim_create_autocmd({ "FileType", }, {
			pattern = "qf",
			callback = function()
				vim.keymap.set("n", "t", "<Plug>QuickfixPreviewToggle", { buffer = true, })
			end,
		})
	end
}
