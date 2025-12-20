-- Editing Plugins
return {
	-- Treesitter для подсветки синтаксиса
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require('plugins/treesitter')
		end,
	},

	-- Комментатор
	{
		"numToStr/Comment.nvim",
		config = function()
			require('plugins/comment')
		end,
	},

	-- Nvim surround
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup {}
		end,
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup {}
		end,
	},
}
