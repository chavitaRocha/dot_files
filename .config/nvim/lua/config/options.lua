vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
vim.g.have_nerd_font = true

vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.number = true
vim.opt.nu = true
vim.opt.rnu = true

vim.opt.mouse = "a"
vim.opt.showmode = false

vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 999
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.conceallevel = 0

vim.g.conceallevel = 0
vim.g.vim_json_syntax_conceal = 0
vim.g.vim_json_conceal = 0

vim.opt.swapfile = false

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- vim.opt.hlsearch = false
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = false

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

vim.opt.cursorline = true
vim.opt.background = "light"

-- vim.opt.guicursor = {
--   'n-v-c:block', -- Normal, Visual, and Command-line mode: block cursor
--   'i-ci-ve:ver25', -- Insert and Command-line Insert mode: vertical bar cursor
--   'r-cr:hor20', -- Replace mode: horizontal underscore cursor
-- }

-- vim.cmd([[
--   set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20
-- ]])

-- let &t_SI = "\<Esc>[6 q"
-- let &t_SR = "\<Esc>[4 q"
-- let &t_EI = "\<Esc>[2 q"

-- vim.opt.guicursor = "n-v-c:block-blinkwait700-blinkoff400-blinkon250"
vim.o.guicursor = "n-v-c:block-blinkwait700-blinkoff400-blinkon250,i:ver25-blinkwait700-blinkoff400-blinkon250"

vim.filetype.add({
	filename = {
		["config"] = "bash", -- Replace "json" if Ghostty uses a different syntax
	},
})

-- snacks
vim.g.snacks_animate = false
vim.opt.cpoptions:append("+")

-- don't insert comment on new line
vim.opt.formatoptions:remove({ "r", "o" })
