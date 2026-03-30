require("gitsigns").setup({
	current_line_blame = false,
	current_line_blame_opts = {
		delay = 300,
		ignore_whitespace = false,
	},
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})
