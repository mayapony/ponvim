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

	local prompt = table.concat({
		"你是 git commit message 生成器。只输出 commit message，不要解释、代码块、引号或 markdown 标记。",
		"",
		"格式：",
		"<type>(<scope>): <subject>",
		"",
		"- <body 要点>",
		"",
		"规则：",
		"1. type 只能是 feat|fix|refactor|perf|docs|style|test|build|ci|chore|revert。",
		"2. scope 必填，取改动最集中的模块/目录名（小写单词）；无法判断时用 core。",
		"3. subject 用中文，动词开头，不超过 50 字符，不加句号。",
		"4. body 仅当改动包含多件不相关的事时才输出：空一行后每行以 \"- \" 开头，每行一句中文，最多 5 行；否则不要 body。",
		"5. 不要列出文件名、diff 内容或测试计划。",
		"",
		"示例：",
		"fix(lsp): 修复重命名时越界访问",
		"",
		"示例（多项改动）：",
		"refactor(ui): 拆分状态栏渲染逻辑",
		"",
		"- 抽出 render_section 便于复用",
		"- 移除重复的高亮计算",
		"",
		"diff 如下：",
		"",
	}, "\n") .. diff

	local bufnr = vim.api.nvim_get_current_buf()
	vim.g.ai_commit_status = "AI 生成 commit…"
	vim.cmd.redrawstatus()

	vim.system({
		"pi",
		"-p",
		"--no-tools",
		"--no-session",
		"--thinking",
		"off",
		"--no-context-files",
		"--no-skills",
		"--no-extensions",
		"--no-prompt-templates",
		prompt,
	}, { text = true }, function(res)
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
