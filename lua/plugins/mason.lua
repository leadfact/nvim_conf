local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local lsp_util = require("lspconfig.util")

-- Guard against async diagnostic publishers racing with wiped buffers.
if not vim.g._diagnostic_set_ignores_invalid_buf then
	local diagnostic_set = vim.diagnostic.set

	vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
		if type(bufnr) == "number" and bufnr > 0 and not vim.api.nvim_buf_is_valid(bufnr) then
			return
		end

		return diagnostic_set(namespace, bufnr, diagnostics, opts)
	end

	vim.g._diagnostic_set_ignores_invalid_buf = true
end

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
		"gopls", -- LSP for Go
		"templ", -- LSP for Templ templates
	},
	handlers = {
		-- Default handler - setup every needed language server in lspconfig
		function(server_name)
			lspconfig[server_name].setup {}
		end,
		["templ"] = function()
			lspconfig.templ.setup({
				filetypes = { "templ" },
				root_dir = lsp_util.root_pattern("go.mod", ".git"),
			})
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
