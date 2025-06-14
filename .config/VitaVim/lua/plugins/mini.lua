return {
	"echasnovski/mini.nvim",
	lazy = false,
	keys = {
		{
			"-",
			":lua require('mini.files').open(vim.api.nvim_buf_get_name(0), true)<CR>",
			desc = "[-] Mini Files",
			mode = "n",
			silent = true,
		}, -- test if this works
	},
	config = function()
		require("mini.surround").setup()
		require("mini.icons").setup()

		-- local gen_loader = require("mini.snippets").gen_loader
		-- require("mini.snippets").setup({
		-- 	snippets = {
		-- 		gen_loader.from_file("~/.config/nvim/snippets/global.json"),
		-- 		gen_loader.from_file("~/.config/nvim/snippets/cs.json"),
		-- 		gen_loader.from_lang(),
		-- 	},
		-- 	mappings = {
		-- 		stop = "<Esc>",
		-- 	},
		-- })

		require("mini.files").setup({
			mappings = {
				close = "<Esc>",
				go_in = "l",
				go_in_plus = "<Enter>",
				go_out = "h",
				go_out_plus = "H",
				mark_goto = "'",
				mark_set = "m",
				reset = "<BS>",
				reveal_cwd = ".",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
			-- General options
			options = {
				permanent_delete = true,
				use_as_default_explorer = true,
			},
			-- Customization of explorer windows
			preview = {},
			windows = {
				max_number = math.huge,
				preview = false,
				width_focus = 50,
				width_nofocus = 15,
				width_preview = 50,
			},
		})

		local statusline = require("mini.statusline")
		statusline.setup({
			content = {
				active = function()
					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
					local git = MiniStatusline.section_git({ trunc_width = 40 })
					local diff = MiniStatusline.section_diff({ trunc_width = 75 })
					local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
					local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
					-- local filename = MiniStatusline.section_filename { trunc_width = 140 }
					local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
					local location = MiniStatusline.section_location({ trunc_width = 75 })
					local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

					-- Function to get the number of selected lines in visual mode
					local function selected_lines()
						local mode = vim.fn.mode()
						if mode == "v" or mode == "V" or mode == "" then
							local start_line = vim.fn.line("v")
							local end_line = vim.fn.line(".")
							local selected_rows = math.abs(end_line - start_line) + 1
							return string.format("Sel: %d", selected_rows)
						end
						return ""
					end

					local filepath = vim.api.nvim_buf_get_name(0)
					local filename = vim.fn.fnamemodify(filepath, ":t") -- ':t' extracts the tail (filename)

					-- Add Grapple statusline information
					local grapple = require("grapple").statusline()
					local grapple_section = grapple ~= "" and "󰓹 " .. grapple or ""

					return MiniStatusline.combine_groups({
						{ hl = mode_hl, strings = { mode } },
						-- { hl = "MiniStatuslineDevinfo", strings = { git } },
						{ hl = "MiniStatuslineFilename", strings = { git } },
						"%<", -- Mark general truncate point
						{ hl = "MiniStatusLineGrapple", strings = { grapple_section } },
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						"%=", -- End left alignment
						-- { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
						{ hl = mode_hl, strings = { search, location, selected_lines() } },
					})
				end,
				inactive = nil,
			},
			use_icons = vim.g.have_nerd_font,
		})
	end,
}
