is_zen_mode_enabled = false
local border_rect = {
	"🭽",
	"▔",
	"🭾",
	"▕",
	"🭿",
	"▁",
	"🭼",
	"▏",
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		ui = {},
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		indent = {
			enabled = true,
		},
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 2000,
			filter = function(n)
				local filtered_messages = {
					['Defining diagnostic signs with :sign-define or sign_define() is deprecated. Run ":checkhealth vim.deprecated" for more information'] = true,
					["No information available"] = true,
					["No results for **diagnostics**"] = true,
				}

				return not filtered_messages[n.msg]
			end,
		},
		picker = {
			transform = function(item)
				if not item.file then
					return item
				end
				if item.file:match("lazyvim/lua/config/keymaps%.lua") then
					item.score_add = (item.score_add or 0) - 30
				end
				return item
			end,
			debug = {
				scores = false, -- show scores in the list
			},
			layout = {
				preset = "ivy",
				layout = {
					position = "bottom",
				},
				cycle = false,
			},
			layouts = {
				-- ivy = {
				-- 	layout = {
				-- 		box = "vertical",
				-- 		backdrop = false,
				-- 		row = -1,
				-- 		width = 0,
				-- 		height = 0.5,
				-- 		border = "top",
				-- 		title = " {title} {live} {flags}",
				-- 		title_pos = "left",
				-- 		{ win = "input", height = 1, border = "bottom" },
				-- 		{
				-- 			box = "horizontal",
				-- 			{ win = "list", border = "none" },
				-- 			{ win = "preview", title = "{preview}", width = 0.5, border = "left" },
				-- 		},
				-- 	},
				-- },
				dropdown = {
					layout = {
						backdrop = false,
						row = 1,
						width = 0.4,
						min_width = 80,
						height = 0.8,
						-- { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }
						border = border_rect,
						box = "vertical",
						{
							win = "preview",
							title = "{preview}",
							height = 0.4,
							border = "none",
							"hpad",
						},
						{
							box = "vertical",
							border = "top",
							title = "{title} {live} {flags}",
							title_pos = "center",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
						},
					},
				},
				vertical = {
					layout = {
						backdrop = false,
						width = 0.8,
						min_width = 80,
						height = 0.8,
						min_height = 30,
						box = "vertical",
						border = "single",
						title = "{title} {live} {flags}",
						title_pos = "center",
						{ win = "input", height = 1, border = "bottom" },
						{ win = "list", border = "none" },
						{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
					},
				},
			},
			matcher = {
				frecency = true,
			},
			win = {
				input = {
					keys = {
						-- to close the picker on ESC instead of going to normal mode,
						-- add the following keymap to your config
						["<Esc>"] = { "close", mode = { "n" } },
						-- I'm used to scrolling like this in LazyGit
						-- ['J'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
						-- ['K'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
						-- ['H'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
						-- ['L'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
					},
				},
			},
		},
		quickfile = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		styles = {
			notification = {},
		},
	},
	keys = {
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.files({
					finder = "files",
					format = "file",
					hidden = true,
					show_empty = true,
					supports_live = true,
					matcher = { fuzzy = true, frecency = true },
					-- In case you want to override the layout for this keymap
					layout = "dropdown",
				})
			end,
			desc = "Find Files",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep({ matcher = { fuzzy = true } })
			end,
			desc = "Grep",
		},
		{
			"<leader>z",
			function()
				is_zen_mode_enabled = not is_zen_mode_enabled
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<leader>gb",
			function()
				Snacks.git.blame_line()
			end,
			desc = "Git Blame Line",
		},
		{
			"<leader>gf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit Current File History",
		},
		{
			"<leader>sl",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit Log (cwd)",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<c-/>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
		{
			"<c-_>",
			function()
				Snacks.terminal()
			end,
			desc = "which_key_ignore",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>tc",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		-- {
		-- 	"<leader>N",
		-- 	desc = "Neovim News",
		-- 	function()
		-- 		Snacks.win({
		-- 			file = vim.api.nvim_get_runtime_file("~/code/notes/hci.md", false)[1],
		-- 			width = 0.6,
		-- 			height = 0.6,
		-- 			wo = {
		-- 				spell = false,
		-- 				wrap = false,
		-- 				signcolumn = "yes",
		-- 				statuscolumn = " ",
		-- 				conceallevel = 3,
		-- 			},
		-- 		})
		-- 	end,
		-- },
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesActionRename",
			callback = function(event)
				Snacks.rename.on_rename_file(event.data.from, event.data.to)
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.indent():map("<leader>ug")
				Snacks.toggle.dim():map("<leader>uD")
			end,
		})
	end,
}
