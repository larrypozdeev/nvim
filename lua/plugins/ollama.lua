return {
	"nomnivore/ollama.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	-- All the user commands added by the plugin
	cmd = { "Ollama", "OllamaModel"},

	keys = {
		-- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
		{
			"<leader>io",
			":<c-u>lua require('ollama').prompt()<cr>",
			desc = "[O]llama: open prompt menu",
			mode = { "n", "v" },
		},

		-- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
		{
			"<leader>ig",
			":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
			desc = "Ollama: [G]enerate code",
			mode = { "n", "v" },
		},
	},

	---@type Ollama.Config
	opts = {
		model = "gpt-oss:20b",
		url = "http://127.0.0.1:11434",
	},
}
