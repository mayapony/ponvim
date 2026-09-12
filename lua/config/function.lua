local M = {
	-- toggle lazygit
	toggle_lazygit = function()
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
		lazygit:toggle()
	end,

	-- toggle line number
	toggle_line = function()
		if vim.b.lnstatus == nil then
			vim.b.lnstatus = "number"
		end

		if vim.b.lnstatus == "number" then
			vim.o.number = false
			vim.o.relativenumber = false
			vim.b.lnstatus = "nonumber"
		else
			vim.o.number = true
			vim.o.relativenumber = true
			vim.b.lnstatus = "number"
		end
	end,
}

-- reload neovim config
M.reload_config = function()
	local hls_status = vim.v.hlsearch
	for name, _ in pairs(package.loaded) do
		if name:match("^cnull") then
			package.loaded[name] = nil
		end
	end

	dofile(vim.env.MYVIMRC)
	if hls_status == 0 then
		vim.opt.hlsearch = false
	end
end

return M
