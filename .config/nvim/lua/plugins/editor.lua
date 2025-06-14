return {
	{
		-- Plugin: goto-preview
		-- URL: https://github.com/rmagatti/goto-preview
		-- Description: Provides preview functionality for definitions, declarations, implementations, type definitions, and references.
		"rmagatti/goto-preview",
		event = "BufEnter", -- Load the plugin when a buffer is entered
		config = true, -- Enable default configuration
		keys = {
			{
				"gpd",
				"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
				noremap = true, -- Do not allow remapping
				desc = "goto preview definition", -- Description for the keybinding
			},
			{
				"gpD",
				"<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
				noremap = true,
				desc = "goto preview declaration",
			},
			{
				"gpi",
				"<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
				noremap = true,
				desc = "goto preview implementation",
			},
			{
				"gpy",
				"<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
				noremap = true,
				desc = "goto preview type definition",
			},
			{
				"gpr",
				"<cmd>lua require('goto-preview').goto_preview_references()<CR>",
				noremap = true,
				desc = "goto preview references",
			},
			{
				"gP",
				"<cmd>lua require('goto-preview').close_all_win()<CR>",
				noremap = true,
				desc = "close all preview windows",
			},
		},
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
}
-- nvim-ts-autotag: Using the legacy setup opts! Please migrate to the new setup options layout as this will eventually have its support removed in 1.0.0!
