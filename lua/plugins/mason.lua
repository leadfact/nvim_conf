local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

mason_lspconfig.setup({
	ensure_installed = {
		"lua_ls", -- LSP for Lua language
		"ts_ls", -- LSP for Typescript and Javascript (renamed from tsserver)
		"emmet_ls", -- LSP for Emmet (Vue, HTML, CSS)
		"pyright", -- LSP for Python
		"volar", -- LSP for Vue
		"gopls", -- LSP for Go
	},
	handlers = {
		-- Default handler - setup every needed language server in lspconfig
		function(server_name)
			lspconfig[server_name].setup {}
		end,
	}
})

-- none-ls для форматирования и диагностики
local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.diagnostics.golangci_lint,
	},
})

local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = ''
	})
end
sign({ name = 'DiagnosticSignError', text = '✘' })
sign({ name = 'DiagnosticSignWarn', text = '▲' })
sign({ name = 'DiagnosticSignHint', text = '⚑' })
sign({ name = 'DiagnosticSignInfo', text = '' })
