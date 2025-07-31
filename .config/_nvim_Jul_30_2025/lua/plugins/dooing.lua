return {
	"atiladefreitas/dooing",
	config = function()
		require("dooing").setup({
			window = {
				width = 70, -- Width of the floating window
				height = 30, -- Height of the floating window
				border = "rounded", -- Border style
				position = "center", -- Window position: 'right', 'left', 'top', 'bottom', 'center',
				-- 'top-right', 'top-left', 'bottom-right', 'bottom-left'
				padding = {
					top = 1,
					bottom = 1,
					left = 2,
					right = 2,
				},
			},
		})
	end,
}
