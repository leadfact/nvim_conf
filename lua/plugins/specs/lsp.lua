-- LSP Configuration
return {
	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Mason для установки LSP серверов
			{
				"williamboman/mason.nvim",
				config = true,
			},
			{
				"williamboman/mason-lspconfig.nvim",
			},
			-- none-ls для форматирования (замена устаревшего null-ls)
			{
				"nvimtools/none-ls.nvim",
			},
			{
				"jay-babu/mason-null-ls.nvim",
			},
		},
		config = function()
			require('plugins/mason')
		end,
	},

	-- Trouble - меню для отображения проблем LSP
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("trouble").setup {}
		end,
	},

	-- Улучшенный UI для LSP
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("plugins/lspsaga")
		end,
	},

	-- Автодополнение
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lua",
		},
		config = function()
			require('plugins/cmp')
		end,
	},

	-- Иконки для автодополнения
	{
		"onsails/lspkind-nvim",
		config = function()
			require('plugins/lspkind')
		end,
	},
}
