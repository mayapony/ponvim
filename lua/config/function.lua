------------------------------------------------------------
-- Buffer deletion (替代 nvim-bufdel，保持窗口布局)
------------------------------------------------------------
-- 下一个 listed buffer（按编号循环，等价 nvim-bufdel 的 next = "tabs"）
local function next_buffer(bufnr)
	local bufs, idx = {}, 1
	for i, info in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
		if info.bufnr == bufnr then
			idx = i
		end
		bufs[#bufs + 1] = info.bufnr
	end
	if #bufs == 0 then
		return nil
	end
	if idx == #bufs and #bufs > 1 then
		return bufs[#bufs - 1]
	end
	return bufs[idx % #bufs + 1]
end

-- 把指定窗口的 buffer 全部换成 buf
local function set_windows(wins, buf)
	for _, win in ipairs(wins) do
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_set_buf(win, buf)
		end
	end
end

-- 先摘掉显示该 buffer 的所有窗口再删，避免 nvim 顺手关掉窗口
local function delete_buffer(bufnr, force)
	if vim.fn.buflisted(bufnr) == 0 then
		return
	end
	if not force and vim.bo[bufnr].modified then
		vim.notify(
			("buffer %s 有未保存修改，已保留"):format(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")),
			vim.log.levels.WARN
		)
		return
	end
	local target = next_buffer(bufnr)
	if not target then
		return
	end
	local wins = vim.fn.win_findbuf(bufnr)
	set_windows(wins, target)
	local ok = pcall(vim.api.nvim_buf_delete, bufnr, {
		force = force or vim.bo[bufnr].buftype == "terminal",
	})
	if not ok then
		set_windows(wins, bufnr) -- 删除被拒绝（有未保存修改），回滚布局
	end
end

local M = {
	-- 删除当前 buffer，保持窗口布局
	bufdel = function()
		local bufnr = vim.api.nvim_get_current_buf()
		-- 只剩一个 listed buffer 时先开个空 buffer 顶上，避免退出 nvim
		if #vim.fn.getbufinfo({ buflisted = 1 }) < 2 then
			vim.cmd("enew")
		end
		delete_buffer(bufnr, false)
	end,

	-- 删除除当前外的所有 listed buffer
	bufdel_others = function()
		local cur = vim.api.nvim_get_current_buf()
		local others = {}
		for _, info in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
			if info.bufnr ~= cur then
				others[#others + 1] = info.bufnr
			end
		end
		-- 先把窗口都收到当前 buffer，删完布局就只剩当前 buffer
		for _, bufnr in ipairs(others) do
			set_windows(vim.fn.win_findbuf(bufnr), cur)
		end
		for _, bufnr in ipairs(others) do
			pcall(vim.api.nvim_buf_delete, bufnr, {
				force = vim.bo[bufnr].buftype == "terminal",
			})
		end
	end,

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
