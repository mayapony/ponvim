return {
	"folke/flash.nvim",
	event = "BufReadPost",
	opts = {
		modes = {
			char = {
				jump_labels = true,
				multi_line = false,
			},
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "o", "x" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Flash Treesitter Search",
		},
	},
}
