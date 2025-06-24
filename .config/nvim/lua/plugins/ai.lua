local prompts = {
	Explain = "Please explain how the following code works.", -- Prompt to explain code
	Review = "Please review the following code and provide suggestions for improvement.", -- Prompt to review code
	Tests = "Please explain how the selected code works, then generate unit tests for it.", -- Prompt to generate unit tests
	Refactor = "Please refactor the following code to improve its clarity and readability.", -- Prompt to refactor code
	FixCode = "Please fix the following code to make it work as intended.", -- Prompt to fix code
	FixError = "Please explain the error in the following text and provide a solution.", -- Prompt to fix errors
	BetterNamings = "Please provide better names for the following variables and functions.", -- Prompt to suggest better names
	Documentation = "Please provide documentation for the following code.", -- Prompt to generate documentation
	JsDocs = "Please provide JsDocs for the following code.", -- Prompt to generate JsDocs
	DocumentationForGithub = "Please provide documentation for the following code ready for GitHub using markdown.", -- Prompt to generate GitHub documentation
	CreateAPost = "Please provide documentation for the following code to post it in social media, like Linkedin, it has be deep, well explained and easy to understand. Also do it in a fun and engaging way.", -- Prompt to create a social media post
	Summarize = "Please summarize the following text.", -- Prompt to summarize text
	Spelling = "Please correct any grammar and spelling errors in the following text.", -- Prompt to correct spelling and grammar
	Wording = "Please improve the grammar and wording of the following text.", -- Prompt to improve wording
	Concise = "Please rewrite the following text to make it more concise.", -- Prompt to make text concise
}

return {
	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	enbladed = false,
	-- 	lazy = false,
	-- 	version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
	-- 	opts = {
	-- 		-- add any opts here
	-- 		provider = "copilot",
	-- 		auto_suggestions_provide = "copilot",
	-- 		copilot = {
	-- 			endpoint = "https://api.githubcopilot.com",
	-- 			model = "gpt-4o-2024-08-06",
	-- 			proxy = nil, -- [protocol://]host[:port] Use this proxy
	-- 			allow_insecure = false, -- Allow insecure server connections
	-- 			timeout = 30000, -- Timeout in milliseconds
	-- 			temperature = 0,
	-- 			max_tokens = 4096,
	-- 		},
	-- 	},
	-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- 	build = "make",
	-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- 	dependencies = {
	-- 		"stevearc/dressing.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		--- The below dependencies are optional,
	-- 		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
	-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
	-- 		{
	-- 			-- support for image pasting
	-- 			"HakonHarnes/img-clip.nvim",
	-- 			event = "VeryLazy",
	-- 			opts = {
	-- 				-- recommended settings
	-- 				default = {
	-- 					embed_image_as_base64 = false,
	-- 					prompt_for_file_name = false,
	-- 					drag_and_drop = {
	-- 						insert_mode = true,
	-- 					},
	-- 					-- required for Windows users
	-- 					use_absolute_path = true,
	-- 				},
	-- 			},
	-- 		},
	-- 		{
	-- 			-- Make sure to set this up properly if you have lazy=true
	-- 			"MeanderingProgrammer/render-markdown.nvim",
	-- 			opts = {
	-- 				file_types = { "markdown", "Avante" },
	-- 			},
	-- 			ft = { "markdown", "Avante" },
	-- 		},
	-- 	},
	-- 	init = function()
	-- 		require("copilot").setup({})
	-- 	end,
	-- },
	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	opts = {
	-- 		prompts = prompts,
	-- 		system_prompt = "This is my prompt",
	-- 		model = "gpt-4o",
	-- 		answer_header = "  Chavita   ",
	-- 		window = {
	-- 			layout = "float",
	-- 		},
	-- 	},
	-- },
}
