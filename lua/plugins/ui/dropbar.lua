return {
	"Bekaboo/dropbar.nvim",
	-- optional, but required for fuzzy finder support
	event = "VeryLazy",
	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
	},
	opts = {},
	keys = {
		{
			"<leader>fd",
			function()
				require("dropbar.api").pick()
			end,
			desc = "[F]ind [D]ropbar pick",
		},
	},
}
