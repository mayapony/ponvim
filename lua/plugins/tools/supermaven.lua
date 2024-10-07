return {
	"supermaven-inc/supermaven-nvim",
	event = "VeryLazy",
	enabled = false,
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-g>",
			},
			ignore_filetypes = { ["neo-tree"] = true },
		})
	end,
}
