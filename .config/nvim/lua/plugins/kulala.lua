return {
	"mistweaverco/kulala.nvim",
	keys = {
	},
	ft = { "http", "rest" },
	opts = {
		-- global_keymaps = false,
		-- global_keymaps_prefix = "<leader>R",
		-- kulala_keymaps_prefix = "",
		global_keymaps = {
			["Send request"] = { -- sets global mapping
				"<leader>rr",
				function() require("kulala").run() end,
				mode = { "n", "v" }, -- optional mode, default is n
				desc = "Send request" -- optional description, otherwise inferred from the key
			},
			["Send all requests"] = {
				"<leader>ra",
				function() require("kulala").run_all() end,
				mode = { "n", "v" },
				ft = "http", -- sets mapping for *.http files only
			},
		},
		ui = {
			icons = {
				inlay = {
					loading = "󱦟",
					done = "",
					error = "",
				},
				lualine = "󱣻",
				textHighlight = "WarningMsg", -- highlight group for request elapsed time
			},
		}
	},
}
