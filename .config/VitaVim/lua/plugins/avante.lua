return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false,
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"zbirenbaum/copilot.lua",
				config = function()
					require("copilot").setup({})
				end
			},
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante", "codecompanion", "AvanteInput" },
					code = {
						position = "right",
					},
				},
				ft = { "markdown", "Avante", "codecompanion", "AvanteInput" },
			},
		},
		opts = {
			provider = "copilot",
			providers = {
				copilot = {
					endpoint = "https://api.githubcopilot.com",
					model = "gpt-4o-2024-11-20",
					proxy = nil,
					allow_insecure = false, -- Allow insecure server connections
					timeout = 30000,
					extra_request_body = {
						temperature = 0.75,
						max_tokens = 20480,
					},
				},
				input = {
					provider = "snacks",
					provider_opts = {
						-- Additional snacks.input options
						title = "Avante Input",
						icon = " ",
					},
				},
				auto_suggestions_provide = "",
			},
		},
		build = "make",
		init = function()
			require("copilot").setup({})
		end,
	},
}
