local M = {}

local web_filetypes = {
	javascript = true,
	javascriptreact = true,
	typescript = true,
	typescriptreact = true,
	vue = true,
	css = true,
	scss = true,
	less = true,
	html = true,
	json = true,
	yaml = true,
	markdown = true,
}

local save_enabled_filetypes = {
	go = true,
	gomod = true,
	gowork = true,
	gotmpl = true,
	templ = true,
	python = true,
	javascript = true,
	javascriptreact = true,
	typescript = true,
	typescriptreact = true,
	vue = true,
	css = true,
	scss = true,
	less = true,
	html = true,
	json = true,
	yaml = true,
	markdown = true,
}

function M.client_allowed(filetype, client_name)
	if filetype == 'go' or filetype == 'gomod' or filetype == 'gowork' or filetype == 'gotmpl' or filetype == 'templ' then
		return client_name == 'gopls' or client_name == 'templ'
	end

	if filetype == 'python' then
		return client_name == 'null-ls'
	end

	if web_filetypes[filetype] then
		return client_name == 'null-ls'
	end

	return client_name ~= 'null-ls'
end

function M.format(bufnr, async)
	local filetype = vim.bo[bufnr].filetype

	vim.lsp.buf.format({
		async = async,
		bufnr = bufnr,
		timeout_ms = 3000,
		filter = function(client)
			return M.client_allowed(filetype, client.name)
		end,
	})
end

function M.setup_on_save(client, bufnr)
	if not client:supports_method('textDocument/formatting') then
		return
	end

	local filetype = vim.bo[bufnr].filetype
	if not save_enabled_filetypes[filetype] then
		return
	end

	if not M.client_allowed(filetype, client.name) then
		return
	end

	local group = vim.api.nvim_create_augroup('LspFormatOnSave', { clear = false })
	vim.api.nvim_clear_autocmds({
		group = group,
		buffer = bufnr,
	})
	vim.api.nvim_create_autocmd('BufWritePre', {
		group = group,
		buffer = bufnr,
		callback = function()
			M.format(bufnr, false)
		end,
	})
end

return M
