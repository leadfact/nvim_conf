-- Language-specific plugins
return {
	-- Go support
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
		},
		config = function()
			require('go').setup {}
		end,
		event = { "CmdlineEnter" },
		ft = { "go", 'gomod' },
		build = ':lua require("go.install").update_all_sync()',
	},

	-- VimTeX для LaTeX
	{
		"lervag/vimtex",
		ft = "tex",
		config = function()
			vim.g.vimtex_view_method = 'zathura'
			vim.g.vimtex_view_general_viewer = 'evince'
			vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@texd]]
			vim.g.vimtex_compiler_method = 'latexrun'
			vim.g.vimtex_compiler_latexmk_engines = {
				_ = '-xelatex'
			}
		end,
	},
}
