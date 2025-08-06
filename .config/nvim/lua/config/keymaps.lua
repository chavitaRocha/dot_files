vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("t", "<C-w>h", "<C-\\><C-n> <C-w>h", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n> <C-w>l", { desc = "Exit terminal mode" })
vim.keymap.set("t", "<leader><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "j", "gj", {})
vim.keymap.set("n", "k", "gk", {})

-- vim.keymap.set("i", "jj", "<Esc>", {})
vim.keymap.set("i", "jk", "<cmd>echo 'Use ESC or C-c instead'<CR>", {})

vim.keymap.set("i", "<C-c>", "<Esc>", {})
vim.keymap.set("n", "<C-c>", "<Esc>", {})

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "G", "Gzz")

vim.keymap.set("n", "%", "%zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })

-- save buffers
vim.keymap.set("n", "<C-s>", "<cmd>:wa<CR>", { desc = "Save buffer" })
vim.keymap.set("i", "<C-s>", "<ESC><cmd>:w<CR>", {})

-- close
vim.keymap.set("n", "<leader>x", "<cmd>:x<CR>", { desc = "Close Neovim" })
vim.keymap.set("n", "<leader>q", "<cmd>:q<CR>", { desc = "Close buffer" })
-- TEST: testing the next command to close
vim.keymap.set("n", "<leader>dd", "<cmd>:q<CR>", { desc = "Close buffer" })

-- lsp
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

-- check if this works on ghostty
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

local enableInlayHints = false

vim.keymap.set("n", "<leader>th", function()
	enableInlayHints = not enableInlayHints
	vim.lsp.inlay_hint.enable(enableInlayHints)
end, { desc = "[T]oggle Inlay [H]ints" })

vim.keymap.set("n", "<leader>y", function()
	local last_yank = vim.fn.getreg('"') -- Get the last yank register
	vim.fn.system("pbcopy", last_yank)  -- Send to macOS clipboard
	print("Yanked text copied to clipboard!")
end, { desc = "Send last yank to macOS clipboard" })

vim.keymap.set("v", "Y", '"+y', { desc = "Yank to system clipboard" })
-- vim.keymap.set("n", "<leader>y", '"+yy', { desc = "Yank line to system clipboard" })

vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Save and quit", silent = true })
vim.keymap.set("n", "<leader>w", ":x<CR>", { desc = "Save and quit", silent = true })

vim.keymap.set("n", "<leader>h", "<cmd>vertical resize -10<CR>", { desc = "Resize pane left", silent = true })
vim.keymap.set("n", "<leader>j", "<cmd>resize +10<CR>", { desc = "Resize pane down", silent = true })
-- vim.keymap.set("n", "<leader>k", "<cmd>resize -10<CR>", { desc = "Resize pane up" })
vim.keymap.set("n", "<leader>l", "<cmd>vertical resize +10<CR>", { desc = "Resize pane right" })

function extractExhaustiveDeps(diagnostics)
	local deps = {}
	for _, diag in ipairs(diagnostics) do
		if
				diag.source == "biome"
				and diag.user_data
				and diag.user_data.lsp
				and diag.user_data.lsp.code == "lint/correctness/useExhaustiveDependencies"
		then
			local msg = diag.user_data.lsp.message or ""
			-- capture the last “word” in the message
			local name = msg:match("([^%s]+)$")
			if name then
				table.insert(deps, name)
			end
		end
	end
	-- join with comma+space
	return table.concat(deps, ", ")
end

-- Function to return diagnostics under the cursor
function diags_under_cursor()
	-- get current buffer and cursor position
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor = vim.api.nvim_win_get_cursor(0) -- { line, col }
	local lnum = cursor[1] - 1                   -- 0‑indexed

	-- fetch diagnostics on that line
	local diags = vim.diagnostic.get(bufnr, { lnum = lnum })

	local toCopy = extractExhaustiveDeps(diags)
	vim.fn.setreg('"', toCopy)
	print("Copied to register: " .. toCopy)
end

-- Example: print them out
-- Map it to <leader>yr (yank deps → register)
vim.keymap.set("n", "<leader>fu", diags_under_cursor, { desc = "Yank React hook dependencies into register" })
