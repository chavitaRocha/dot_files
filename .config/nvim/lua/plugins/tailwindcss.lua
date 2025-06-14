return {
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"neovim/nvim-lspconfig",
		},
		enabled = true,
		opts = {
			server = {
				override = false,
				settings = {
					includeLanguages = {
						templ = "html",
					},
				},
				on_attach = function(client, bufnr) end,
			},
			document_color = {
				enabled = true,
				kind = "background",
				inline_symbol = "󱓻 ",
				debounce = 200,
			},
			conceal = {
				enabled = true,
				min_length = nil,
				symbol = "󱏿",
				highlight = {
					fg = "#38BDF8",
				},
			},
			cmp = {
				highlight = "background",
			},
			-- telescope = {
			-- 	utilities = {
			-- 		callback = function(name, class) end,
			-- 	},
			-- },
			extension = {
				queries = {},
				patterns = {
					javascript = { "*.js", "*.jsx", "*.ts", "*.tsx" },
				},
			},
		},
	},
	{
		"js-everts/cmp-tailwind-colors",
		opts = {},
		config = function()
			require("cmp-tailwind-colors").setup({
				enable_alpha = true, -- requires pumblend > 0.
				format = function(itemColor)
					return {
						fg = itemColor,
						bg = nil, -- or nil if you dont want a background color
						text = "󱓻", -- or use an icon
					}
				end,
			})
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		opts = function()
			local hi = require("mini.hipatterns")
			return {
				-- custom LazyVim option to enable the tailwind integration
				tailwind = {
					enabled = true,
					ft = {
						"astro",
						"lua",
						"css",
						"heex",
						"html",
						"html-eex",
						"javascript",
						"javascriptreact",
						"rust",
						"svelte",
						"typescript",
						"typescriptreact",
						"vue",
						"conf",
					},
					-- full: the whole css class will be highlighted
					-- compact: only the color will be highlighted
					style = "full",
				},
				highlighters = {
					hex_color = hi.gen_highlighter.hex_color({ priority = 2000 }),
					shorthand = {
						pattern = "()#%x%x%x()%f[^%x%w]",
						group = function(_, _, data)
							---@type string
							local match = data.full_match
							local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
							local hex_color = "#" .. r .. r .. g .. g .. b .. b

							return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
						end,
						extmark_opts = { priority = 2000 },
					},
				},
			}
		end,
	},

	-- {
	--   'razak17/tailwind-fold.nvim',
	--   opts = {
	--     enable = true,
	--     ft = {
	--       'html',
	--       'svelte',
	--       'astro',
	--       'vue',
	--       'tsx',
	--       'php',
	--       'blade',
	--       'eruby',
	--       'templ',
	--     },
	--   },
	--   dependencies = { 'nvim-treesitter/nvim-treesitter' },
	--   ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'blade', 'templ', 'tpl' },
	-- },
	-- {
	--   'norcalli/nvim-colorizer.lua',
	--   enabled = true,
	--   opts = {},
	--   config = function()
	--     require('colorizer').setup {
	--       'javascript', -- Highlight all files, but customize some others.
	--       '!vim', -- Exclude vim from highlighting.
	--       -- Exclusion Only makes sense if '*' is specified!
	--     }
	--   end,
	-- },
	-- {
	--   'echasnovski/mini.hipatterns',
	--   enabled = false,
	--   recommended = true,
	--   desc = 'Highlight colors in your code. Also includes Tailwind CSS support.',
	--   opts = function()
	--     local hi = require 'mini.hipatterns'
	--     return {
	--       -- custom LazyVim option to enable the tailwind integration
	--       tailwind = {
	--         enabled = true,
	--         ft = {
	--           'astro',
	--           'lua',
	--           'css',
	--           'heex',
	--           'html',
	--           'html-eex',
	--           'javascript',
	--           'javascriptreact',
	--           'rust',
	--           'svelte',
	--           'typescript',
	--           'typescriptreact',
	--           'vue',
	--         },
	--         -- full: the whole css class will be highlighted
	--         -- compact: only the color will be highlighted
	--         style = 'full',
	--       },
	--       highlighters = {
	--         hex_color = hi.gen_highlighter.hex_color { priority = 2000 },
	--         shorthand = {
	--           pattern = '()#%x%x%x()%f[^%x%w]',
	--           group = function(_, _, data)
	--             ---@type string
	--             local match = data.full_match
	--             local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
	--             local hex_color = '#' .. r .. r .. g .. g .. b .. b
	--
	--             return MiniHipatterns.compute_hex_color_group(hex_color, 'bg')
	--           end,
	--           extmark_opts = { priority = 2000 },
	--         },
	--       },
	--     }
	--   end,
	--   config = function(_, opts)
	--     if type(opts.tailwind) == 'table' and opts.tailwind.enabled then
	--       -- reset hl groups when colorscheme changes
	--       vim.api.nvim_create_autocmd('ColorScheme', {
	--         callback = function()
	--           M.hl = {}
	--         end,
	--       })
	--       opts.highlighters.tailwind = {
	--         pattern = function()
	--           if not vim.tbl_contains(opts.tailwind.ft, vim.bo.filetype) then
	--             return
	--           end
	--           if opts.tailwind.style == 'full' then
	--             return '%f[%w:-]()[%w:-]+%-[a-z%-]+%-%d+()%f[^%w:-]'
	--           elseif opts.tailwind.style == 'compact' then
	--             return '%f[%w:-][%w:-]+%-()[a-z%-]+%-%d+()%f[^%w:-]'
	--           end
	--         end,
	--         group = function(_, _, m)
	--           ---@type string
	--           local match = m.full_match
	--           ---@type string, number
	--           local color, shade = match:match '[%w-]+%-([a-z%-]+)%-(%d+)'
	--           shade = tonumber(shade)
	--           local bg = vim.tbl_get(M.colors, color, shade)
	--           if bg then
	--             local hl = 'MiniHipatternsTailwind' .. color .. shade
	--             if not M.hl[hl] then
	--               M.hl[hl] = true
	--               local bg_shade = shade == 500 and 950 or shade < 500 and 900 or 100
	--               local fg = vim.tbl_get(M.colors, color, bg_shade)
	--               vim.api.nvim_set_hl(0, hl, { bg = '#' .. bg, fg = '#' .. fg })
	--             end
	--             return hl
	--           end
	--         end,
	--         extmark_opts = { priority = 2000 },
	--       }
	--     end
	--     require('mini.hipatterns').setup(opts)
	--   end,
	-- },
}
