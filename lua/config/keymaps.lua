-- local function map(mode, lhs, rhs, opts)
-- 	local keys = require("lazy.core.handler").handlers.keys
-- 	---@cast keys LazyKeysHandler
-- 	-- do not create the keymap if a lazy keys handler exists
-- 	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
-- 		opts = opts or {}
-- 		opts.silent = opts.silent ~= false
-- 		vim.keymap.set(mode, lhs, rhs, opts)
-- 	end
-- end

-- lazy
vim.keymap.set("n", "<leader><leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- Move to window using the <ctrl> hjkl keys
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
