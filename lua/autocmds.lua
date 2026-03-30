local api = vim.api

api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
	pattern = '*',
	command = 'checktime',
})

api.nvim_create_autocmd('BufEnter', {
	pattern = '*',
	command = 'set fo-=c fo-=r fo-=o',
})

api.nvim_create_autocmd('BufReadPost', {
	pattern = '*',
	callback = function()
		local line = vim.fn.line([['"]])
		if line > 1 and line <= vim.fn.line('$') then
			vim.cmd([[normal! g'"]])
		end
	end,
})

api.nvim_create_autocmd('TextYankPost', {
	group = api.nvim_create_augroup('YankHighlight', { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			higroup = 'IncSearch',
			timeout = 700,
		})
	end,
})
