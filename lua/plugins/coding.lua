return {
	{
		event = "VeryLazy",
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({ enable_check_bracket_line = false })
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		event = "BufReadPost",
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"Wansmer/treesj",
		keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},
}
