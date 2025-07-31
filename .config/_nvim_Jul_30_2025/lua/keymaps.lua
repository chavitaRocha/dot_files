-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>x', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quickfi[x] list' })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "j", "gj", {})
vim.keymap.set("n", "k", "gk", {})

vim.keymap.set("i", "jj", "<Esc>", {})
vim.keymap.set("i", "jk", "<Esc>", {})

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

-- save buffers
vim.keymap.set("n", "<C-s>", "<cmd>:wa<CR>", { desc = "Save buffer" })
vim.keymap.set("i", "<C-s>", "<ESC><cmd>:w<CR>", {})

-- close
vim.keymap.set("n", "<C-q>", "<cmd>:q<CR>", { desc = "Close buffer" })

-- lsp
vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
-- vim.keymap.set("n", "<leader>tc", function()
-- 	vim.cmd("silent !toggleTheme")
-- 	vim.cmd("silent luafile ~/.config/VitaVim/init.lua")
-- end, { desc = "Toggle [C]olorscheme" })

-- vim.keymap.set("t", "<C-_>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- check if this works on ghostty
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

local enableInlayHints = false

vim.keymap.set("n", "<leader>th", function()
	enableInlayHints = not enableInlayHints
	vim.lsp.inlay_hint.enable(enableInlayHints)
end, { desc = "[T]oggle Inlay [H]ints" })

vim.keymap.set("n", "<leader>y", function()
	local last_yank = vim.fn.getreg('"') -- Get the last yank register
	vim.fn.system("pbcopy", last_yank) -- Send to macOS clipboard
	print("Yanked text copied to clipboard!")
end, { desc = "Send last yank to macOS clipboard" })

vim.keymap.set("v", "Y", '"+y', { desc = "Yank to system clipboard" })
-- vim.keymap.set("n", "<leader>y", '"+yy', { desc = "Yank line to system clipboard" })

vim.keymap.set("n", "<leader>q", ":x<CR>", { desc = "Save and quit", silent = true })
