local function get_db_url(env)
	local env_var = "DB_" .. string.upper(env) .. "_URL"
	local db_url = os.getenv(env_var)
	if db_url == nil then
		print("env_var is nil")
	end
	return db_url
end

return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		{ "ellisonleao/dotenv.nvim", lazy = false, opts = { enable_on_load = true, verbose = false } },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	config = function()
		-- sqlcmd
		-- kinit srocha@homecityice.local
		-- kinit
		-- sqlcmd -E -S dev-sql-01

		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.dbs = {
			{ name = "___DEV___", url = get_db_url("DEV") },
			{ name = "__STAGE__", url = get_db_url("STG") },
		}
	end,
	keys = {
		{ "<leader>dd", "<cmd>DBUIToggle<cr>" },
		{ "<leader>dr", "<Plug>(DBUI_ExecuteQuery)" },
	},
}
