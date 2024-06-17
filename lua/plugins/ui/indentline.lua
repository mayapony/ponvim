return {
	"shellRaining/hlchunk.nvim",
	-- event = { "BufRead" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				use_treesitter = true,
				notify = true, -- notify if some situation(like disable chunk mod double time)
				exclude_filetypes = {
					aerial = true,
					dashboard = true,
					Trouble = true,
					["neo-tree"] = true,
					["neo-tree-popup"] = true,
					gitconfig = true,
					harpoon = true,
					[""] = true,
					dropbar_menu = true,
				},
				support_filetypes = {
					"*.lua",
					"*.js",
					"*.jsx",
					"*.ts",
					"*.tsx",
					"*.json",
				},
				chars = {
					horizontal_line = "─",
					vertical_line = "│",
					left_top = "╭",
					left_bottom = "╰",
					right_arrow = ">",
				},
				style = {
					{ fg = vim.fn.synIDattr(vim.fn.hlID("IndentlineStyle"), "fg", "gui") },
				},
			},

			indent = {
				enable = false,
			},

			line_num = {
				enable = false,
			},
			blank = {
				enable = false,
			},
		})
	end,
}
