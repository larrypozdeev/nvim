vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use({
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			vim.cmd('colorscheme rose-pine')
		end
	})

	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup {
				icons = false,
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end
	})

	use { 'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end, }
	use("nvim-treesitter/playground")
	use {
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } }
	}
	use("theprimeagen/refactoring.nvim")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use("nvim-treesitter/nvim-treesitter-context");


	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' },
			{ 'williamboman/mason.nvim' },
			{ 'williamboman/mason-lspconfig.nvim' },

			-- debugging
			{ 'mfussenegger/nvim-dap' },
			{ 'jay-babu/mason-nvim-dap.nvim' },
			{ 'theHamsta/nvim-dap-virtual-text' },
			{ 'rcarriga/nvim-dap-ui' },
			{ 'Pocco81/DAPInstall.nvim' },

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-nvim-lua' },

			-- Snippets
			{ 'L3MON4D3/LuaSnip' },
			{ 'rafamadriz/friendly-snippets' },
		}
	}

	use { 'echasnovski/mini.nvim',
		config = function()
			require('mini.surround').setup {}
			require('mini.pairs').setup {}
			require('mini.cursorword').setup {
				config = {
					delay = 0,
				}
			}
		end
	}
	use("tpope/vim-sleuth")

	use { "lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup {}
		end
	}
	use("kyazdani42/nvim-web-devicons")
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
	use("folke/zen-mode.nvim")
	use("github/copilot.vim")
	use("eandrju/cellular-automaton.nvim")
	use("laytan/cloak.nvim")
end)
