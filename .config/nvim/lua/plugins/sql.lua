return {
	'kristijanhusak/vim-dadbod-ui',
	dependencies = {
		{ 'tpope/vim-dadbod',                     lazy = true },
		{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
	},
	cmd = {
		'DBUI',
		'DBUIToggle',
		'DBUIAddConnection',
		'DBUIFindBuffer',
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_execute_on_save = 0
	end,
	config = function()
		-- CSV export function for fixed-width dbout files
		local function export_to_csv()
			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			local csv_lines = {}
			local column_positions = {}
			local header_line = nil
			local separator_line = nil

			-- Find header and separator lines
			for i, line in ipairs(lines) do
				if line:match("%S") and not header_line then
					header_line = line
				elseif line:match("^%-+") and header_line then
					separator_line = line
					break
				end
			end

			if not header_line or not separator_line then
				vim.notify("Could not find table header and separator in dbout file", vim.log.levels.WARN)
				return
			end

			-- Extract column positions from separator line
			local start_pos = 1
			for i = 1, #separator_line do
				local char = separator_line:sub(i, i)
				if char == ' ' and i > start_pos then
					-- End of current column
					table.insert(column_positions, { start_pos, i - 1 })
					-- Find start of next column
					local next_start = i
					while next_start <= #separator_line and separator_line:sub(next_start, next_start) == ' ' do
						next_start = next_start + 1
					end
					start_pos = next_start
				end
			end
			-- Add the last column
			if start_pos <= #separator_line then
				table.insert(column_positions, { start_pos, #separator_line })
			end

			-- Function to extract column values using positions
			local function extract_columns(line)
				local columns = {}
				for _, pos in ipairs(column_positions) do
					local start_col, end_col = pos[1], pos[2]
					local value = ""
					if start_col <= #line then
						end_col = math.min(end_col, #line)
						value = line:sub(start_col, end_col):gsub("^%s+", ""):gsub("%s+$", "")
					end

					-- Escape quotes and handle commas for CSV
					value = value:gsub('"', '""')
					if value:match(",") or value:match('"') or value:match("\n") then
						value = '"' .. value .. '"'
					end
					table.insert(columns, value)
				end
				return columns
			end

			-- Extract header columns
			local header_columns = extract_columns(header_line)
			if #header_columns > 0 then
				table.insert(csv_lines, table.concat(header_columns, ","))
			end

			-- Process data lines (skip header and separator)
			local data_start = 3 -- Assuming line 1 is header, line 2 is separator
			for i = data_start, #lines do
				local line = lines[i]
				if line:match("%S") then -- Skip empty lines
					local data_columns = extract_columns(line)
					if #data_columns > 0 then
						table.insert(csv_lines, table.concat(data_columns, ","))
					end
				end
			end

			if #csv_lines <= 1 then -- Only header, no data
				vim.notify("No data rows found to export", vim.log.levels.WARN)
				return
			end

			-- Prompt for filename
			local filename = vim.fn.input("Export to CSV file: ", "query_results.csv")
			if filename == "" then
				return
			end

			-- Write to file
			local file = io.open(filename, "w")
			if not file then
				vim.notify("Could not create file: " .. filename, vim.log.levels.ERROR)
				return
			end

			for _, csv_line in ipairs(csv_lines) do
				file:write(csv_line .. "\n")
			end
			file:close()

			vim.notify("Exported " .. (#csv_lines - 1) .. " data rows (+ header) to " .. filename, vim.log.levels.INFO)
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "sql",
			callback = function()
				vim.bo.omnifunc = "vim_dadbod_completion#omni"
			end,
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "sql",
			callback = function()
				vim.keymap.set({ 'v', 'n' }, '<leader>rr', '<Plug>(DBUI_ExecuteQuery)<CR>', { buffer = true })
				-- vim.keymap.set('n', '<leader>re', export_to_csv, { buffer = true, desc = 'Export results to CSV' })
			end,
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dbout",
			callback = function()
				vim.keymap.set('n', '<leader>re', export_to_csv, { buffer = true, desc = 'Export results to CSV' })
			end
		})
	end,
}
