-- UI Plugins
return {
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require('plugins/lualine')
		end,
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup {}
		end,
	},

	-- Neo-tree файловый менеджер
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require('plugins/neotree')
		end,
	},

	-- Indent blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require('plugins/indentline')
		end,
	}
}
