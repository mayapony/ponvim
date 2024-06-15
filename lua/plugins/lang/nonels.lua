return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPost" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"davidmh/cspell.nvim",
	},
	config = function()
		-- require("config.autocmd").setup_nullls()
	end,
}
