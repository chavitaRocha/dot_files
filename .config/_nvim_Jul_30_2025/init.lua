require("options")
require("keymaps")
require("command")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	change_detection = { enabled = false },
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- vim.cmd.colorscheme("catppuccin-frappe")
-- vim.api.nvim_set_hl(0, "Visual", { bg = "#3E4451" })

-- vim.api.nvim_set_hl(0, "SnacksIndentBlank", { fg = "#FF5733" })
-- vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#FF5733" })
-- vim.api.nvim_set_hl(0, "SnacksIndentIndent", { fg = "#FF5733" })
-- vim.api.nvim_set_hl(0, "NonText", { bg = "#f3f3f3", fg = "#FF5733" })
--
-- vim.cmd([[hi SnacksIndentBlank guibg='#FF5733']]) -- Example: Set indent guide color to light gray

-- NonText       xxx guifg=#737994

-- vim.api.nvim_set_hl(0, "SnacksIndent", { guifg = "#ff0000", guibg = "#000000", gui = "bold" })
--
--

vim.cmd([[
  highlight MiniSnippetsPlaceholder gui=NONE
]])
