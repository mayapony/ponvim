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
			'Wansmer/treesj',
			dependencies = { 'nvim-treesitter/nvim-treesitter' },
			config = function()
				require('treesj').setup({ --[[ your config ]] })
				vim.keymap.set('n', '<leader>j', require('treesj').toggle)
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				local configs = require("nvim-treesitter.configs")
				configs.setup({
					ensure_installed = {
						"c",
						"html",
						"javascript",
						"json",
						"python",
						"tsx",
						"typescript",
						"vim",
						"yaml",
						"vue",
						"toml",
						"cpp",
					},
					sync_install = false,
					highlight = { enable = false },
					indent = { enable = false },
				})
			end
		},
		{
			"echasnovski/mini.surround",
			opts = {
				mappings = {
					add = "gsa",
					delete = "gsd",
					find = "gsf",
					find_left = "gsF",
					highlight = "gsh",
					replace = "gsr",
					update_n_lines = "gsn",
				},
			},
		},
		{
			"folke/flash.nvim",
			event = "VeryLazy",
			opts = {
				modes = {
					char = {
						jump_labels = true
					}
				}
			},
			-- stylua: ignore
			keys = {
				{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
				{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			},
		}
	}
end

return M
