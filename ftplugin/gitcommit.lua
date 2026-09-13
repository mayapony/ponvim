-- AI 生成 commit message（调用 pi agent CLI）
local function ai_commit()
	local diff = vim.fn.system("git diff --staged --no-color")
	if vim.v.shell_error ~= 0 or diff == "" then
		diff = vim.fn.system("git diff --no-color")
	end
	if diff == "" then
		vim.notify("没有可提交的改动", vim.log.levels.WARN)
		return
	end

	local prompt = "你是 git commit message 生成器。只输出 conventional commit message"
		.. "（type(scope): subject 用中文 + 可选 body），不要任何解释、不要代码块、不要引号。diff 如下：\n\n"
		.. diff

	local bufnr = vim.api.nvim_get_current_buf()
	vim.g.ai_commit_status = "AI 生成 commit…"
	vim.cmd.redrawstatus()

	vim.system({ "pi", "-p", "--no-tools", "--no-session", prompt }, { text = true }, function(res)
		vim.schedule(function()
			vim.g.ai_commit_status = nil
			vim.cmd.redrawstatus()
			if not vim.api.nvim_buf_is_valid(bufnr) then
				return
			end
			if res.code ~= 0 then
				vim.notify("pi 调用失败：" .. vim.trim(res.stderr or res.stdout or ""), vim.log.levels.ERROR)
				return
			end
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.split(vim.trim(res.stdout), "\n"))
		end)
	end)
end

vim.keymap.set({ "n", "i" }, "<C-g>", ai_commit, { buffer = 0, desc = "AI commit message" })
