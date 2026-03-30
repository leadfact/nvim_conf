-- Additional Tools
return {
	-- Russian keyboard support
	{
		"powerman/vim-plugin-ruscmd",
	},
	{
		"junegunn/fzf",
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins/gitsigns")
		end,
	},
	{
		"shumphrey/fugitive-gitlab.vim",
	},
	{
		"github/copilot.vim",
	},
}
