return {
	"NeogitOrg/neogit",
	cmd = { "Neogit" },
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
	},
	config = function()
		require("neogit").setup({
			integrations = {
				diffview = true,
			},
		})
	end,
	keys = {
		{
			"<leader>gg",
			"<cmd>Neogit<cr>",
			desc = "Open Neogit",
		},
		{
			"<leader>gdh",
			"<cmd>DiffviewFileHistory<cr>",
			desc = "[G]it [D]iff File [H]istory",
		},
		{
			"<leader>gdc",
			"<cmd>DiffviewClose<cr>",
			desc = "[G]it [D]iff [C]lose",
		},
	},
}
