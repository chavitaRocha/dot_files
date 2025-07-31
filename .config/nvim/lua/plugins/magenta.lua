return {
	"dlants/magenta.nvim",
	lazy = false,
	enabled = false,
	build = "npm install --frozen-lockfile",
	opts = {
		profiles = {
			{
				name = "claude-3-7",
				provider = "anthropic",
				model = "claude-3-7-sonnet-latest",
				apiKeyEnvVar = "ANTHROPIC_API_KEY",
			},
			-- {
			--   name = "gpt-4o",
			--   provider = "openai",
			--   model = "gpt-4o",
			--   apiKeyEnvVar = "OPENAI_API_KEY"
			-- }
		},
	},
}
