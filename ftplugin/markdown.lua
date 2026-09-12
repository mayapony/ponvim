-- 长行（如宽表格）默认横向滚动，<leader>tw 切换回 wrap
vim.opt_local.wrap = false

-- toggle markdown checkbox: - [ ] <-> - [x]
vim.keymap.set("n", "<leader>mt", function()
	local line = vim.api.nvim_get_current_line()
	local new = line:gsub("^(%s*[-*+] )%[ %]", "%1[x]")
	if new == line then
		new = line:gsub("^(%s*[-*+] )%[[xX]%]", "%1[ ]")
	end
	vim.api.nvim_set_current_line(new)
end, { buffer = true, desc = "Toggle checkbox" })
