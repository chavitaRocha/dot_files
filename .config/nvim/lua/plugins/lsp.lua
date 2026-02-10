return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = {},
			config = function()
				require("mason").setup({
					registries = {
						"github:mason-org/mason-registry",
						"github:Crashdummyy/mason-registry",
					},
				})
			end
		},
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"Hoffs/omnisharp-extended-lsp.nvim",
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		local status, _ = pcall(require, "blink.cmp")
		if not status then
			print("Blink Cmp is require")
			return
		end

		local capabilities = require("blink.cmp").get_lsp_capabilities({
			textDocument = { completion = { completionItem = { snippetSupport = false } } },
		})

		local servers = {
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
						removeUnusedImports = false,
					},
				},
			},
			-- eslint = {},
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
			lua_ls = {},
			csharp_ls = {},
			-- roslyn = {
			-- 	settings = {
			-- 		["csharp|inlay_hints"] = {
			-- 			csharp_enable_inlay_hints_for_implicit_object_creation = true,
			-- 			csharp_enable_inlay_hints_for_implicit_variable_types = true,
			-- 		},
			-- 		["csharp|code_lens"] = {
			-- 			dotnet_enable_references_code_lens = true,
			-- 		},
			-- 		["csharp|formatting"] = {
			-- 			dotnet_organize_imports_on_format = true,
			-- 		},
			-- 	},
			-- },
			-- omnisharp = {
			-- 	settings = {
			-- 		FormattingOptions = {
			-- 			OrganizeImports = true,
			-- 			EnableEditorConfigSupport = true,
			-- 		},
			-- 		MsBuild = {},
			-- 		RenameOptions = {},
			-- 		RoslynExtensionsOptions = {
			-- 			enableDecompilationSupport = true,
			-- 		},
			-- 		Sdk = {
			-- 			IncludePrereleases = true,
			-- 		},
			-- 	},
			-- },
			jsonls = {
				settings = {
					json = {
						format = { enable = true },
						validate = { enable = true },
					},
				},
			},
			cssls = {},
			typos_lsp = {},
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
				classFunctions = {
					"cva",
					"cx",
				},
			},
			biome = {},
		}

		local ensure_installed = vim.tbl_keys(servers or {})

		require("mason-lspconfig").setup({
			ensure_installed = ensure_installed,
			automatic_installation = false,
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
