local M = {}
local format = require('lsp.format')

function M.setup(client, bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, {
			buffer = bufnr,
			noremap = true,
			silent = true,
			desc = desc,
		})
	end

	format.setup_on_save(client, bufnr)

	map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', 'Hover')
	map('n', 'gf', function()
		format.format(bufnr, true)
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

	if client and client:supports_method('textDocument/inlayHint') then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

return M
