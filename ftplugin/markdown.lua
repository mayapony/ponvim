vim.opt_local.wrap = true

-- toggle markdown checkbox: - [ ] <-> - [x]
vim.keymap.set("n", "<leader>mt", function()
	local line = vim.api.nvim_get_current_line()
	local new = line:gsub("^(%s*[-*+] )%[ %]", "%1[x]")
	if new == line then
		new = line:gsub("^(%s*[-*+] )%[[xX]%]", "%1[ ]")
	end
	vim.api.nvim_set_current_line(new)
end, { buffer = true, desc = "Toggle checkbox" })
