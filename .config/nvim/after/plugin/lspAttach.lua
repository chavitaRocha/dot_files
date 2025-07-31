vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
		map("<leader>fa", '<cmd>lua require("fastaction").code_action()<CR>', "[F]ast [A]ction", { "n", "x" }) -- NOTE: test instead of default
		map("<leader>rn", vim.lsp.buf.rename, "[R]ename", { "n" })
		map("gi", vim.lsp.buf.implementation, "[G]o to [I]mplementation", { "n", "x" })
		-- go to definition in new split
		vim.keymap.set("n", "<leader>gd", function()
			local current_win = vim.api.nvim_get_current_win()
			vim.cmd("vsplit")
			vim.lsp.buf.definition()
			vim.api.nvim_set_current_win(current_win)
			vim.cmd("wincmd l") -- Move to the new split
		end, { noremap = true, silent = true, desc = "Go to definition in vertical split" })

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client == nil then
			return
		end

		if client.name == "biome" then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("BiomeFixAll", { clear = true }),
				buffer = bufnr,
				callback = function()
					-- Request 'source.fixAll.biome' code action before saving
					-- This typically includes format, lint fixes, and organizeImports
					vim.lsp.buf.code_action({
						context = {
							only = { "source.fixAll.biome" },
							diagnostics = {}, -- Pass diagnostics if needed for context
						},
						apply = true, -- Automatically apply the action
					})
				end,
			})
		end

		if client.name == "omnisharp" then
			local status, omnisharp_extended = pcall(require, "omnisharp_extended")
			if not status then
				return
			end

			vim.keymap.set(
				"n",
				"gd",
				omnisharp_extended.lsp_definition,
				{ noremap = true, desc = "[G]o to [D]efinition c#" }
			)
		end
	end,
})

vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰞋",
		},
	},
})
