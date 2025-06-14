-- lazy.nvim
return {
	"folke/noice.nvim",
	enabled = false,
	event = "VeryLazy",
	opts = {
		cmdline = {
			view = "cmdline_popup",
			auto_complete = false,
		},
		views = {
			cmdline_popup = {
				position = {
					row = 0.3,
					col = 0.5,
				},
				size = {
					width = 60,
					height = "auto",
				},
				border = {
					style = "rounded",
				},
				-- additional options might be needed depending on the plugin version
			},
		},
		lsp = {
			hover = {
				enabled = true,
				silent = false,
			},
		},
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = true, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
}
