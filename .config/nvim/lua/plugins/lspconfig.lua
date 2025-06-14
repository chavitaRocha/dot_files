return {
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		-- { 'j-hui/fidget.nvim', opts = {} },
		-- 'hrsh7th/cmp-nvim-lsp',
		"Hoffs/omnisharp-extended-lsp.nvim",
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end
				map("gd", Snacks.picker.lsp_definitions, "[G]oto [D]efinition")
				map("gr", Snacks.picker.lsp_references, "[G]oto [R]eferences")
				map("gi", Snacks.picker.lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", Snacks.picker.lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", Snacks.picker.lsp_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", Snacks.picker.lsp_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				local client = vim.lsp.get_client_by_id(event.data.client_id)

				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})

					if client and client.supports_method("textDocument/implementation") then
						if client.name == "omnisharp" then
							map("gd", require("omnisharp_extended").lsp_definition, "[G]oto [D]efinition")
							map(
								"<leader>D",
								require("omnisharp_extended").lsp_type_definition,
								"[G]oto Type [D]efinition"
							)
							map("gr", require("omnisharp_extended").lsp_references, "[G]oto [R]eferences")
							map("gi", require("omnisharp_extended").lsp_implementation, "[G]oto [I]Implementation")
						end
					end

					vim.diagnostic.config({
						virtual_text = false,
					})
				end
			end,
		})

		-- local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
		local capabilities = require("blink.cmp").get_lsp_capabilities({
			textDocument = { completion = { completionItem = { snippetSupport = false } } },
		})

		local servers = {
			zls = {},
			jsonls = {},
			-- omnisharp = {},
			csharp_ls = {},
			typos_lsp = {},
			biome = {},
			emmet_language_server = {},
			tailwindcss = {
				root_dir = function(fname)
					local util = require("lspconfig.util")
					local workspace = util.root_pattern(
						"tailwind.config.js",
						"tailwind.config.cjs",
						"tailwind.config.mjs",
						"tailwind.config.ts",
						"postcss.config.js",
						"postcss.config.cjs",
						"postcss.config.mjs",
						"postcss.config.ts"
					)(fname) or util.root_pattern("index.css")(fname) or vim.fs.dirname(
						vim.fs.find(".git", { path = startpath, upward = true })[1]
					)
					return workspace
				end,
			},
			vtsls = {
				settings = {
					typescript = {
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = false },
							propertyDeclarationTypes = { enabled = false },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = false },
						},
					},
					vtsls = {
						organizeImports = true,
						semantic_tokens = true,
						removeUnusedImports = true,
					},
				},
			},
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				gofumpt = true,
				settings = {
					gopls = {
						hints = {
							assignVariableTypes = false,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = false,
						},
					},
				},
			},
			eslint = {
				filetypes = { "javascript", "typescript", "typescriptreact" },
				root_dir = require("lspconfig").util.root_pattern(
					"eslint.config.js",
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.yaml",
					".eslintrc.yml",
					".eslintrc.json",
					".eslintrc.jsonc",
					".eslintrc.toml"
				),
			},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			},
		}
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"omnisharp",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}

-- How can I setup mason-lspconfig to have hover floating window with borders?
