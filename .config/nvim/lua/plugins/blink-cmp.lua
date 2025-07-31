local trigger_snippets_character = ";"

return {
	"saghen/blink.cmp",
	dependencies = {
		{ "L3MON4D3/LuaSnip", version = "v2.*" },
		{
			"supermaven-inc/supermaven-nvim",
			opts = {},
		},
		{
			"huijiro/blink-cmp-supermaven",
		},
	},
	version = "1.*",
	opts = {
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
					-- border = border_chars,
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
		snippets = { preset = "luasnip" },
		sources = {
			providers = {
				dadbod = {
					name = "Dadbod",
					module = "vim_dadbod_completion.blink",
				},
				lazydev = {
					name = "lazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				supermaven = {
					name = "supermaven",
					module = "blink-cmp-supermaven",
					async = true,
				},
			},
			per_filetype = { sql = { "dadbod" } },
			default = { "lazydev", "lsp", "supermaven", "snippets", "path", "buffer" },
		},
	},
	opts_extend = { "sources.default" },
}
