return {
	{
		"echasnovski/mini.surround",
		event = "VeryLazy",
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
		"Wansmer/treesj",
		keys = { { "<leader>cj", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},
}
