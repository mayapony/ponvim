local M = {}
local function map(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

function M.initNvim()
	-- lazy
	vim.keymap.set("n", "<leader><leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

	-- Move to window using the <ctrl> hjkl keys
	map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
	map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
	map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
	map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

	-- floating terminal
	map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
	vim.cmd([[map <C-t> <Nop>]])
end

function M.initVscode()
	map(
		"n",
		"<leader>uC",
		[[<cmd>call VSCodeNotify('workbench.action.selectTheme')<cr>]],
		{ desc = "Change colorscheme" }
	)
	-- find
	map("n", "<leader>fp", [[<cmd>call VSCodeNotify('workbench.action.openRecent')<cr>]], { desc = "find project" })

	-- undo & redo
	map("n", "u", [[<cmd>call VSCodeNotify('undo')<cr>]], { desc = "undo" })
	map("n", "<C-r>", [[<Cmd>call VSCodeNotify('redo')<CR>]], { desc = "redo" })

	-- code action
	map("n", "<leader>cr", [[<cmd>call VSCodeNotify('editor.action.rename')<cr>]], { desc = "Rename Variable" })

	-- Better Navigation
	map({ "n", "x" }, "<C-j>", [[<cmd>call VSCodeNotify('workbench.action.navigateDown')<cr>]], {})
	map({ "n", "x" }, "<C-k>", [[<cmd>call VSCodeNotify('workbench.action.navigateUp')<cr>]], {})
	map({ "n", "x" }, "<C-l>", [[<cmd>call VSCodeNotify('workbench.action.navigateRight')<cr>]], {})
	map({ "n", "x" }, "<C-h>", [[<cmd>call VSCodeNotify('workbench.action.navigateLeft')<cr>]], {})
end

return M
