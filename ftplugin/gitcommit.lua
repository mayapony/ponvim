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
	local msg = vim.fn.system("pi -p --no-tools --no-session " .. vim.fn.shellescape(prompt))
	if vim.v.shell_error ~= 0 then
		vim.notify("pi 调用失败：" .. vim.trim(msg), vim.log.levels.ERROR)
		return
	end

	vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(vim.trim(msg), "\n"))
end

vim.keymap.set({ "n", "i" }, "<C-g>", ai_commit, { buffer = 0, desc = "AI commit message" })
