local M = {}

local function format_buffer(bufnr)
	local filetype = vim.bo[bufnr].filetype

	vim.lsp.buf.format({
		async = true,
		bufnr = bufnr,
		filter = function(client)
			if filetype == 'go' or filetype == 'gomod' or filetype == 'gowork' or filetype == 'gotmpl' then
				return client.name == 'gopls'
			end

			if filetype == 'python' then
				return client.name == 'null-ls'
			end

			if
				filetype == 'javascript'
				or filetype == 'javascriptreact'
				or filetype == 'typescript'
				or filetype == 'typescriptreact'
				or filetype == 'vue'
				or filetype == 'css'
				or filetype == 'scss'
				or filetype == 'less'
				or filetype == 'html'
				or filetype == 'json'
				or filetype == 'yaml'
				or filetype == 'markdown'
			then
				return client.name == 'null-ls'
			end

			return client.name ~= 'null-ls'
		end,
	})
end

function M.setup(_, bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, {
			buffer = bufnr,
			noremap = true,
			silent = true,
			desc = desc,
		})
	end

	map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', 'Hover')
	map('n', 'gf', function()
		format_buffer(bufnr)
	end, 'Format buffer')
	map('n', 'ga', '<cmd>Lspsaga code_action<CR>', 'Code action')
	map('n', 'gR', '<cmd>Lspsaga rename<CR>', 'Rename symbol')
	map('n', 'gs', '<cmd>Lspsaga finder<CR>', 'LSP finder')
	map('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', 'Peek definition')
	map('n', 'gt', vim.lsp.buf.type_definition, 'Go to type definition')
	map('n', 'gT', '<cmd>Lspsaga peek_type_definition<CR>', 'Peek type definition')
	map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next diagnostic')
	map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Prev diagnostic')
	map('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<CR>', 'Line diagnostics')
	map('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', 'Go to definition')
	map('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', 'Implementations')
	map('n', 'gr', '<cmd>Lspsaga finder ref<CR>', 'References')
	map('n', '<leader>o', '<cmd>Lspsaga outline<CR>', 'Outline')
end

return M
