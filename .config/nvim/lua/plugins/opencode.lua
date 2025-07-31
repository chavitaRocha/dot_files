return {
	'NickvanDyke/opencode.nvim',
	dependencies = {
		'folke/snacks.nvim',
		{
			-- Optional blink.cmp integration for context placeholders
			'saghen/blink.cmp',
			opts = {
				sources = {
					providers = {
						opencode = {
							module = 'opencode.cmp.blink',
						},
					},
					per_filetype = {
						opencode_ask = { 'opencode', 'buffer' },
					},
				},
			},
		},
	},
	---@type opencode.Config
	opts = {
	},
	-- stylua: ignore
	keys = {
		{ '<leader>ot', function() require('opencode').toggle() end,            desc = 'Toggle embedded opencode', },
		{ '<leader>oa', function() require('opencode').ask() end,               desc = 'Ask opencode',                 mode = 'n', },
		{ '<leader>oa', function() require('opencode').ask('@selection: ') end, desc = 'Ask opencode about selection', mode = 'v', },
		{ '<leader>op', function() require('opencode').select_prompt() end,     desc = 'Select opencode prompt',       mode = { 'n', 'v', }, },
		{ '<leader>on', function() require('opencode').create_session() end,    desc = 'New session', },
	},
}
