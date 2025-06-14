-- Configure global floating window border style
vim.opt.winblend = 0 -- Transparency level (0 = opaque, 100 = transparent)
vim.g.floating_window_border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}

-- Apply this border style to floating windows by default
local original_open_float = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or vim.g.floating_window_border
	return original_open_float(contents, syntax, opts, ...)
end

return {
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{
		"shortcuts/no-neck-pain.nvim",
		version = "*",
		lazy = false,
		opts = {
			width = 160,
		},
		keys = {
			{ "<leader>dm", "<cmd>NoNeckPain<CR>", desc = "Active distraction free mode", mode = "n" },
		},
	},
	{
		"alexghergh/nvim-tmux-navigation",
		opts = {
			disable_when_zoomed = true, -- defaults to false
			keybindings = {
				left = "<C-h>",
				down = "<C-j>",
				up = "<C-k>",
				right = "<C-l>",
				last_active = "<C-\\>",
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		opts = {
			delay = 0,
			icons = {
				mappings = vim.g.have_nerd_font,
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},

			spec = {
				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"b0o/incline.nvim", -- show file name
		event = "BufReadPre",
		priority = 1200,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
		config = function()
			require("incline").setup({
				highlight = {
					-- groups = {
					-- 	InclineNormal = { link = "StatusLine" },
					-- 	-- InclineNormalNC = { guibg = "none", guifg = "#a9b1d6" },
					-- },
				},
				window = {
					placement = {
						vertical = "top",
						horizontal = "right",
					},
					margin = { vertical = 0, horizontal = 1 },
				},
				hide = { cursorline = true },
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[*]" .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)

					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},
	{
		"mg979/vim-visual-multi",
		lazy = false,
	},
	{
		"cbochs/grapple.nvim",
		enabled = true,
		branch = "main",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
		opts = {
			scope = "cwd",
			style = "basename",
			icons = false,
		},
		evet = { "BufReadPost", "BufNewFile" },
		cmd = "Grapple",
		command = function(path)
			vim.cmd("e " .. path)
		end,
		keys = {
			{
				"mm",
				function()
					require("grapple").tag()
					vim.notify("Tagged", vim.log.levels.INFO)
				end,
				desc = "Grapple toggle tag",
			},
			{ "md", "<cmd>Grapple untag<cr>", desc = "Grapple toggle tag" },
			{ "ml", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple toggle tags" },
			{ "<S-l>", "<cmd>Grapple cycle forward<cr>", desc = "Grapple cycle forward" },
			{ "<S-h>", "<cmd>Grapple cycle backward<cr>", desc = "Grapple cycle backward" },
		},
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				per_filetype = {
					["html"] = {
						enable_close = false,
					},
				},
			})
		end,
	},
	{
		"Chaitanyabsprip/fastaction.nvim",
		opts = {},
	},
	{
		"j-hui/fidget.nvim", -- show lsp progress
		opts = {
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},
}
