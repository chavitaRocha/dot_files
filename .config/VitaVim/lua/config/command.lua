vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Close float window with <Esc>
vim.api.nvim_create_autocmd("WinEnter", {
	pattern = "*",
	callback = function()
		if vim.api.nvim_win_get_config(0).relative ~= "" then
			-- if not is_zen_mode_enabled then
			-- 	vim.keymap.set("n", "<Esc>", "<cmd>close<CR>")
			-- end
		else
			vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
		end
	end,
})

vim.api.nvim_create_autocmd("VimLeave", {
	pattern = "*",
	command = "silent !echo -ne '\\e[5 q'",
})

vim.api.nvim_create_user_command("Readonly", function()
	local project_path = vim.fn.getcwd() -- Get the current working directory
	vim.api.nvim_create_autocmd("BufReadPost", {
		pattern = project_path .. "/**/*",
		callback = function()
			vim.bo.readonly = true
			vim.bo.modifiable = false
		end,
	})
	print("Readonly mode enabled for project: " .. project_path)
end, {})

-- auto-remove unused imports when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.tsx", "*.ts" },
	callback = function()
		-- vim.lsp.buf.code_action({
		-- 	apply = true,
		-- 	context = {
		-- 		only = { "source.removeUnused.ts" },
		-- 		diagnostics = {},
		-- 	},
		-- })
	end,
})

local map_split = function(buf_id, lhs, direction)
	local rhs = function()
		-- Make new window and set it as target
		local cur_target = MiniFiles.get_explorer_state().target_window
		local new_target = vim.api.nvim_win_call(cur_target, function()
			vim.cmd(direction .. " split")
			return vim.api.nvim_get_current_win()
		end)

		MiniFiles.set_target_window(new_target)

		-- This intentionally doesn't act on file under cursor in favor of
		-- explicit "go in" action (`l` / `L`). To immediately open file,
		-- add appropriate `MiniFiles.go_in()` call instead of this comment.
	end

	-- Adding `desc` will result into `show_help` entries
	local desc = "Split " .. direction
	vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		-- Tweak keys to your liking
		map_split(buf_id, "<C-s>", "belowright horizontal")
		map_split(buf_id, "<C-v>", "belowright vertical")
		-- map_split(buf_id, "<C-t>", "tab")
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesActionRename",
	callback = function(event)
		-- close mini.files window
		MiniFiles.close()
		Snacks.rename.on_rename_file(event.data.from, event.data.to)
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.cmd("wincmd L") -- Open help in a vertical split
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Close fastaction.nvim floating window with Escape
vim.api.nvim_create_autocmd("FileType", {
	pattern = "fastaction",
	callback = function(event)
		local buf = event.buf
		vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", {
			buffer = buf,
			desc = "Close fastaction window",
			nowait = true,
		})
	end,
})

-- Additional fallback for floating windows that might not set filetype correctly
vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function(event)
		local buf = event.buf
		local win = vim.api.nvim_get_current_win()
		
		-- Check if this is a floating window
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then
			local buf_name = vim.api.nvim_buf_get_name(buf)
			local buf_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
			
			-- Check if it's fastaction by buffer name, filetype, or content
			if buf_name:match("fastaction") or 
			   vim.bo[buf].filetype == "fastaction" or
			   (buf_lines[1] and buf_lines[1]:match("Code actions:")) then
				vim.keymap.set("n", "<Esc>", "<cmd>close<CR>", {
					buffer = buf,
					desc = "Close fastaction window",
					nowait = true,
				})
			end
		end
	end,
})
