local M = {}

local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
	return vim.api.nvim_create_augroup("maya_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"toggleterm",
		"telescope",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
		"neo-tree",
		"oil",
		"git",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "close with q" })
	end,
})

-- check if a floating dialog exists and if not
-- then check for diagnostics under the cursor
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	group = augroup("lsp_diagnostics_hold"),
	pattern = "*",
	command = "lua require('config.function').open_diagnostic_if_not_float()",
})

-- Persistent Folds
autocmd("BufWinLeave", {
	pattern = "*.*",
	callback = function()
		vim.cmd.mkview()
	end,
	group = augroup("Persistent Folds"),
})

autocmd("BufWinEnter", {
	pattern = "*.*",
	callback = function()
		vim.cmd.loadview({ mods = { emsg_silent = true } })
	end,
	group = augroup("Persistent Folds"),
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
	group = augroup("Auto Create Dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Auto disable folding for some filetypes
autocmd("FileType", {
	pattern = { "neo-tree" },
	callback = function()
		require("ufo").detach()
		vim.opt_local.foldenable = false
	end,
})

-- Disable diagnostics in node_modules (0 is current buffer only)
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*/node_modules/*",
	command = "lua vim.diagnostic.disable(0)",
})

M.setup_nullls = function()
	-- Enable spell checking for certain file types
	vim.api.nvim_create_autocmd({
			"BufRead",
			"BufNewFile",
		},
		{
			pattern = { "*.txt", "*.md", "*.tex" },
			callback = function()
				local null_ls = require("null-ls")
				local cspell = require("cspell")

				-- Enable spell checking for certain file types
				null_ls.setup({
					sources = {
						cspell.diagnostics,
						cspell.code_actions,
					},
				})
			end
		})
end

return M
