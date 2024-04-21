local opt = vim.opt
local M = {}
local function augroup(name)
	return vim.api.nvim_create_augroup("maya_" .. name, { clear = true })
end

function M.configure()
	-- settings
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	opt.clipboard = "unnamedplus"
	opt.ignorecase = true
	opt.smartcase = true

	-- Highlight on yank
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = augroup("highlight_yank"),
		callback = function()
			vim.highlight.on_yank()
		end,
	})

	require("vscode.keymaps")
	-- vim.cmd([[source ~/.config/nvim/lua/vscode/insert.vim]])
	-- vim.cmd([[source ~/.config/nvim/lua/vscode/scrolling.vim]])
	-- vim.cmd([[source ~/.config/nvim/lua/vscode/tab.vim]])
	-- vim.cmd([[source ~/.config/nvim/lua/vscode/fold.vim]])
	-- vim.cmd([[source ~/.config/nvim/lua/vscode/window.vim]])
end

function M.packages()
	return {
		{
			"kylechui/nvim-surround",
			version = "*",
			config = function()
				require("nvim-surround").setup({})
			end,
		},
		{
			"ggandor/flit.nvim",
			keys = function()
				local ret = {}
				for _, key in ipairs({ "f", "F", "t", "T" }) do
					ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
				end
				return ret
			end,
			opts = { labeled_modes = "nx" },
		},
		{
			"ggandor/leap.nvim",
			config = function()
				require("leap").add_default_mappings()
			end,
		},
	}
end

return M
