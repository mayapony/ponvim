local function augroup(name)
	return vim.api.nvim_create_augroup("vscode_" .. name, { clear = true })
end

-- 复制时高亮
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.hl.on_yank()
	end,
})
