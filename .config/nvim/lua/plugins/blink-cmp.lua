local border_chars = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

local trigger_snippets_character = ";"

return {
	"saghen/blink.cmp",
	dependencies = "echasnovski/mini.snippets",
	version = "1.*",
	opts = {
		cmdline = {
			enabled = false,
		},
		fuzzy = {
			sorts = {
				"exact",
				"score",
				"sort_text",
			},
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
				window = {
					border = border_chars,
				},
			},
		},
		keymap = {
			preset = "default",
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-e>"] = {
				function(cmp)
					cmp.show()
				end,
			},
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		snippets = { preset = "mini_snippets" },
		sources = {
			providers = {
				dadbod = {
					name = "Dadbod",
					module = "vim_dadbod_completion.blink",
				},
				snippets = {
					name = "snippets",
					enabled = true,
					max_items = 15,
					min_keyword_length = 2,
					module = "blink.cmp.sources.snippets",
					score_offset = 85, -- the higher the number, the higher the priority
					should_show_items = function()
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
						-- NOTE: remember that `trigger_text` is modified at the top of the file
						return before_cursor:match(trigger_snippets_character .. "%w*$") ~= nil
					end,
					transform_items = function(_, items)
						local line = vim.api.nvim_get_current_line()
						local col = vim.api.nvim_win_get_cursor(0)[2]
						local before_cursor = line:sub(1, col)
						local start_pos, end_pos = before_cursor:find(
							trigger_snippets_character .. "[^" .. trigger_snippets_character .. "]*$"
						)
						if start_pos then
							for _, item in ipairs(items) do
								if not item.trigger_text_modified then
									---@diagnostic disable-next-line: inject-field
									item.trigger_text_modified = true
									item.textEdit = {
										newText = item.insertText or item.label,
										range = {
											start = { line = vim.fn.line(".") - 1, character = start_pos - 1 },
											["end"] = { line = vim.fn.line(".") - 1, character = end_pos },
										},
									}
								end
							end
						end
						return items
					end,
				},
				lazydev = {
					name = "lazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
			per_filetype = { sql = { "dadbod" } },
			default = { "lazydev", "lsp", "snippets", "path", "buffer" },
		},
	},
	opts_extend = { "sources.default" },
}
