local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lsp_util = require("lspconfig.util")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local on_attach = require("lsp.on_attach").setup

local capabilities = cmp_nvim_lsp.default_capabilities()
local servers = { "lua_ls", "ts_ls", "emmet_ls", "pyright", "gopls", "templ" }

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
	automatic_enable = false,
})

for _, server_name in ipairs(servers) do
	vim.lsp.config(server_name, {
		capabilities = capabilities,
		on_attach = on_attach,
	})
end

vim.lsp.config("gopls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		gopls = {
			completeUnimported = true,
			gofumpt = true,
			linksInHover = true,
			staticcheck = true,
			usePlaceholders = true,
		},
	},
})

vim.lsp.config("templ", {
	capabilities = capabilities,
	filetypes = { "templ" },
	on_attach = on_attach,
	root_dir = lsp_util.root_pattern("go.mod", ".git"),
})

vim.lsp.enable(servers)

-- none-ls для форматирования и диагностики
local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.black.with({
			filetypes = { "python" },
		}),
		null_ls.builtins.formatting.prettier.with({
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"yaml",
				"markdown",
			},
		}),
		null_ls.builtins.diagnostics.golangci_lint.with({
			filetypes = { "go" },
		}),
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
