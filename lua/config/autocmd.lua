-- local cmp = require("cmp")
--
-- local default_cmp_sources = cmp.config.sources({
-- 	{ name = "nvim_lsp", keyword_length = 2 },
-- 	{ name = "luasnip",  keyword_length = 2 },
-- 	{ name = "buffer",   keyword_length = 2 },
-- 	{ name = "path",     keyword_length = 2 },
-- 	{ name = "nvim_lua", keyword_length = 2 },
-- })

local function augroup(name)
	return vim.api.nvim_create_augroup("maya_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function()
		-- event
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
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
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- change kitty background color
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local filePath = "/tmp/mykitty"
		if vim.fn.filereadable(filePath) == 1 then
			local color = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg#")
			os.execute("kitty @ --to unix:" .. filePath .. " set-colors background=" .. color)
		end
	end,
})

-- auto format on save
-- source: https://github.com/neovim/nvim-lspconfig/issues/1792
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- local bufIsBig = function(bufnr)
-- 	local max_filesize = 100 * 1024 -- 100 KB
-- 	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
-- 	if ok and stats and stats.size > max_filesize then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end
--
-- vim.api.nvim_create_autocmd("BufReadPre", {
-- 	callback = function(t)
-- 		local sources = default_cmp_sources
-- 		if not bufIsBig(t.buf) then
-- 			sources[#sources + 1] = { name = "treesitter", group_index = 2 }
-- 		end
-- 		cmp.setup.buffer({
-- 			sources = sources,
-- 		})
-- 	end,
-- })
