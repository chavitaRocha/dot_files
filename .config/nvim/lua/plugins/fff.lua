return {
	"dmtrKovalenko/fff.nvim",
	build = "cargo build --release",
	opts = {
		layout = {
			height = 0.8,
			width = 0.8,
			prompt_position = 'top', -- or 'top'
			preview_position = 'right', -- or 'left', 'right', 'top', 'bottom'
			preview_size = 0.5,
		}
	},
	keys = {
		{
			"<leader>sf",             -- try it if you didn't it is a banger keybinding for a picker
			function()
				require("fff").find_files() -- or find_in_git_root() if you only want git files
			end,
			desc = "Open file picker",
		},
	},
}
