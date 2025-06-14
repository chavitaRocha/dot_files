local is_transparent = true
local light_theme = "dawnfox"
local dark_theme = "catppuccin-frappe"
local bg_terminal = "#F5F0E7"
-- local bg_terminal = "#F5F0E7"
-- local cursor_line = "#EAE5DF"
-- local cursor_line_kanagawa_paper = "#D1D0C4"
-- local search_kanagawa_paper = "#bcbbb0"

-- local is_dark = true
return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = is_transparent,
		},
	},
	{
		"folke/tokyonight.nvim",
		enabled = true,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				-- style = is_dark and 'night' or 'day',
				transparent = is_transparent,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					-- keywords = { italic = true },
					-- functions = { italic = true },
					-- strings = { italic = true },
					-- variables = { italic = true },
				},
				on_colors = function(colors)
					colors.hint = colors.orange
					colors.error = "#ff0000"
				end,
				on_highlights = function(highlights, colors)
					local background = vim.api.nvim_get_option_value("background", {})
					if background == "light" then
						highlights.LspReferenceRead = { bg = "#D0D3E0" }
						highlights.LspReferenceWrite = { bg = "#D0D3E0" }
						-- highlights.CursorLine = { bg = "#EAE5DF" }
					end
				end,
			})
		end,
		init = function()
			-- vim.cmd.colorscheme(light_theme)
			-- if is_dark then
			-- 	vim.opt.background = "dark"
			-- else
			-- 	vim.opt.background = "light"
			-- end
		end,
	},
	{
		"f-person/auto-dark-mode.nvim",
		opts = {
			set_dark_mode = function()
				vim.api.nvim_set_option_value("background", "dark", {})
				vim.cmd.colorscheme(dark_theme)
				vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#505467" })
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value("background", "light", {})
				vim.cmd.colorscheme(light_theme)
				-- vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#dcdce0" })
				-- vim.api.nvim_set_hl(0, "CursorLine", { bg = cursor_line })
				-- vim.api.nvim_set_hl(0, "StatusLine", { bg = cursor_line })
				-- vim.api.nvim_set_hl(0, "MiniFilesNormal", { bg = bg_terminal })
				-- vim.api.nvim_set_hl(0, "MiniFilesTitle", { bg = bg_terminal })
				-- vim.api.nvim_set_hl(0, "MiniFilesBorder", { bg = cursor_line })
				-- vim.api.nvim_set_hl(0, "MiniFilesTitleFocused", { bg = cursor_line })
				vim.api.nvim_set_hl(0, "InclineNormal", { link = "StatusLine" })
				-- vim.api.nvim_set_hl(0, "InclineNormalNC", { bg = cursor_line })
				-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg_terminal })
				-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#dcd8cf" })
				-- vim.api.nvim_set_hl(0, "FloatFooter", { bg = "#dcd8cf" })
				-- vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#dcd8cf" })

				-- vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = cursor_line_kanagawa_paper })
				-- vim.api.nvim_set_hl(0, "CurSearch", { bg = search_kanagawa_paper })
				-- vim.api.nvim_set_hl(0, "Search", { bg = search_kanagawa_paper })

				-- 	InclineNormal = { guibg = "#484B5A", guifg = "#a9b1d6" },
				-- 	InclineNormalNC = { guibg = "none", guifg = "#a9b1d6" },
			end,
			update_interval = 2000,
			fallback = "light",
		},
		init = function()
			if vim.api.nvim_get_option_value("background", {}) == "dark" then
				vim.cmd.colorscheme(dark_theme)
			else
				vim.cmd.colorscheme(light_theme)
			end
		end,
	},
	{
		"sainnhe/edge",
		lazy = false,
		priority = 1000,
		config = function()
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					if vim.api.nvim_get_option_value("background", {}) == "dark" then
						-- vim.api.nvim_set_hl(0, "Visual", { bg = "#3E4451" }) -- Replace #3E4451 with your desired color
					else
						-- vim.api.nvim_set_hl(0, "Visual", { bg = cursor_line_kanagawa_paper }) -- Replace #3E4451 with your desired color
						-- vim.api.nvim_set_hl(
						-- 	0,
						-- 	"SnacksPickerListCursorLine",
						-- 	{ fg = "#608E32", bg = cursor_line_kanagawa_paper }
						-- )
					end
				end,
			})
			vim.g.edge_enable_italic = true
			vim.g.edge_transparent_background = is_transparent and 1 or 0
			-- vim.cmd.colorscheme("edge")
		end,
	},
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = is_transparent,
			dim_inactive = true,
			colors = {
				theme = {
					canvas = {
						ui = {
							border = "#f5ecdc",
							float = {
								bg = bg_terminal,
								bg_border = "#f5ecdc",
							},
						},
					},
				},
			},
		},
	},
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		opts = {
			options = {
				transparent = is_transparent,
				styles = {
					comments = "italic",
					keywords = "bold",
				},
			},
		},
	},
	{
		"idr4n/github-monochrome.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
