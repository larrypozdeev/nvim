return {
	-- Autocompletion setup
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				{
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
		},
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"nvim-lua/plenary.nvim", -- required for Minuet
		-- Copilot integration
		-- {
		-- 	enabled = false,
		-- 	"zbirenbaum/copilot-cmp",
		-- 	dependencies = { "zbirenbaum/copilot.lua" },
		-- 	config = function()
		-- 		require("copilot").setup({
		-- 			suggestion = { enabled = false }, -- Disable Copilot's inline suggestions
		-- 			panel = { enabled = false },
		-- 		})
		-- 		require("copilot_cmp").setup()
		-- 	end,
		-- },
		{
			"milanglacier/minuet-ai.nvim",
			config = function()
				require("minuet").setup({
					provider = "openai_fim_compatible",
					throttle = 5,
					debounce = 5,
					n_completions = 1,
					context_window = 16384,
					provider_options = {
						openai_fim_compatible = {
							api_key = "TERM",
							model = "codellama:code",
							-- Minuet talks to Ollama's OpenAI-compatible endpoint
							end_point = "http://127.0.0.1:11434/v1/completions",
							name = "Ollama",
							stream = true,
							optional = {
								stop = { "<EOT>" }, -- Stop token for CodeLlama
								max_tokens = 56,
								top_p = 0.9,
							},
						},
					},
				})
			end,
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		luasnip.config.setup({})

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete({}),
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			experimental = {
				ghost_text = true,
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "minuet" },
				-- { name = "copilot" }, -- Add Copilot as a source
			}),
		})
	end,
}
