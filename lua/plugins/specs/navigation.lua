-- Navigation and Search
return {
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"ahmedkhalf/project.nvim",
		},
		config = function()
			require("telescope").setup {}
		end,
	},
}
