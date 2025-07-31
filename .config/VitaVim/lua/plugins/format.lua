return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = true,
		format_on_save = {
			timeout_ms = 800,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			javascript = { "biome", "prettier", stop_after_first = true },
			typescript = { "biome", "prettier", stop_after_first = true },
			typescriptreact = { "biome", "prettier", stop_after_first = true },
			lua = { "stylua" },
			json = { "jq", "biome", "prettier", stop_after_first = true },
			-- cs = { "csharpier", stop_after_first = true },
		},
		formatters = {
			csharpier = {
				command = "csharpier",
				args = { "format", "$FILENAME", "--log-level", "none", "--write-stdout", "--no-cache" },
			},
			biome = {
			}
		},
	},
}
