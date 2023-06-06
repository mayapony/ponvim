local M = {}
local function augroup(name)
	return vim.api.nvim_create_augroup("maya_" .. name, { clear = true })
end

function M.configure()
	-- settings
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	local options = require("utils.options")
	local option = options.scope.option

	options.set(option, "clipboard", "unnamedplus")
	options.set(option, "ignorecase", true)
	options.set(option, "smartcase", true)

	-- Highlight on yank
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = augroup("highlight_yank"),
		callback = function()
			vim.highlight.on_yank()
		end,
	})

	-- mappings
	local keymaps = require("utils.keymaps")

	keymaps.register("n", {
		["<C-b><C-s>"] = [[<cmd>call VSCodeNotify('workbench.action.files.save')<cr>]],
		["gi"] = [[<cmd>call VSCodeNotify('editor.action.goToImplementation')<cr>]],
		["gn"] = [[<cmd>call VSCodeNotify('editor.action.marker.next')<cr>]],
		["gp"] = [[<cmd>call VSCodeNotify('editor.action.marker.prev')<cr>]],
		["gr"] = [[<cmd>call VSCodeNotify('editor.action.rename')<cr>]],
		["gx"] = [[<cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<cr>]],
		["<leader>."] = [[<cmd>call VSCodeNotify('workbench.action.quickOpen')<cr>]],
		["<leader>qo"] = [[<cmd>call VSCodeNotify('workbench.action.closeOtherEditors')<cr>]],
		["<leader>qa"] = [[<cmd>call VSCodeNotify('workbench.action.closeAllEditors')<cr>]],
		["<leader>qq"] = [[<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<cr>]],
	})
end

function M.packages()
	return {
		{
			"phaazon/hop.nvim",
			name = "hop",
			branch = "v2",
			config = function()
				require("hop").setup({
					keys = "etovxqpdygfblzhckisuran",
					quit_key = "<SPC>",
					case_insensitive = true,
					multi_windows = true,
				})
				local hop = require("hop")
				local directions = require("hop.hint").HintDirection
				vim.keymap.set("", "f", function()
					hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
				end, { remap = true })
				vim.keymap.set("", "F", function()
					hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
				end, { remap = true })
				vim.keymap.set("", "t", function()
					hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
				end, { remap = true })
				vim.keymap.set("", "T", function()
					hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
				end, { remap = true })
				vim.keymap.set("", "s", "<cmd>HopChar2<cr>", { remap = true })
				vim.keymap.set("n", "<leader><leader>j", "<cmd>HopLine<cr>", {})
			end,
		},
		{
			"kylechui/nvim-surround",
			version = "*",
			config = function()
				require("nvim-surround").setup({})
			end,
		},
	}
end

return M
