local status, _ = pcall(require, "luasnip")

if not status then
	print("Missing luasnip")
	return
end

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/VitaVim/snippets/" } })
