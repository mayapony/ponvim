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

-- check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
M.open_diagnostic_if_not_float = function()
	-- get the windows in a tabpage
	for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
		-- if have other floating window then return
		if vim.api.nvim_win_get_config(winid).zindex then
			return
		end
	end
	-- else show diagnostics float
	vim.diagnostic.open_float(0, {
		scope = "cursor",
		focusable = false,
		close_events = {
			"CursorMoved",
			"CursorMovedI",
			"BufHidden",
			"InsertCharPre",
			"WinLeave",
		},
	})
end

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
