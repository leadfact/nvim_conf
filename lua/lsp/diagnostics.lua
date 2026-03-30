local M = {}

function M.setup()
	local signs = {
		Error = '✘',
		Warn = '▲',
		Hint = '⚑',
		Info = '',
	}

	for severity, icon in pairs(signs) do
		local name = 'DiagnosticSign' .. severity
		vim.fn.sign_define(name, {
			texthl = name,
			text = icon,
			numhl = '',
		})
	end

	vim.diagnostic.config({
		severity_sort = true,
		update_in_insert = false,
		underline = true,
		virtual_text = false,
		float = {
			border = 'rounded',
			source = 'if_many',
		},
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = signs.Error,
				[vim.diagnostic.severity.WARN] = signs.Warn,
				[vim.diagnostic.severity.HINT] = signs.Hint,
				[vim.diagnostic.severity.INFO] = signs.Info,
			},
		},
	})
end

return M
