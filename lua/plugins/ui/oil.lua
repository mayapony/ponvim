return {
	"stevearc/oil.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>ee",
			function()
				require("oil").toggle_float()
			end,
			desc = "[E]xplore",
		},
		{
			"<leader>er",
			function()
				require("oil").toggle_float(vim.fs.root(0, { ".git" }) or vim.fn.getcwd())
			end,
			desc = "[E]xplore [R]oot",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		default_file_explorer = true,
		float = {
			padding = 2,
			max_width = 80,
			max_height = 0.8,
			border = "rounded",
		},
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name)
				return name == ".git" or name == "node_modules"
			end,
		},
	},
}
