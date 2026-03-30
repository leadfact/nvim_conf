local M = {}

function M.copy_abs_path_with_line()
	local file = vim.fn.expand("%:p")
	local line = vim.fn.line(".")
	vim.fn.setreg("+", string.format("%s:%d", file, line))
end

function M.copy_repo_relative_path()
	local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
	local file = vim.fn.expand("%:p")
	local rel = file

	if root ~= nil and root ~= "" and file:sub(1, #root) == root then
		rel = file:sub(#root + 2)
	end

	vim.fn.setreg("+", rel)
end

function M.copy_remote_url()
	local out = vim.fn.execute("silent .GBrowse!")
	out = out:gsub("%s+$", "")
	vim.fn.setreg("+", out)
end

return M
